// ignore_for_file: deprecated_member_use, use_build_context_synchronously, invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:caffely/feature/account/view/qr_code/bloc/event.dart';
import 'package:caffely/feature/account/view/qr_code/bloc/state.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/helper/logger.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/qrcode_model/qrcode_model.dart';
import 'package:caffely/product/model/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeCubit extends Bloc<QrCodeEvent, QrCodeState> {
  QrCodeCubit() : super(QrCodeState()) {
    on<QrCodeCreateEvent>(qrCodeCreate);
  }

  Future<void> checkUserQrCode(BuildContext context) async {
    try {
      emit(QrCodeLoadingState());
      final DocumentSnapshot documentUser = await FirebaseCollectionReferances
          .users.collectRef
          .doc(FirebaseService().authID)
          .get();

      if (documentUser.exists) {
        final userModel =
            UserModel.fromJson(documentUser.data() as Map<String, dynamic>);

        if (userModel.qrCodeId.isNotEmpty) {
          final DocumentSnapshot documentQrCode =
              await FirebaseCollectionReferances.qr_code.collectRef
                  .doc(FirebaseService().authID)
                  .get();
          final qrCodeModel = QrCodeModel.fromJson(
            documentQrCode.data() as Map<String, dynamic>,
          );

          final qrCodeUrl = qrCodeModel.qrCode;
          emit(QrCodeExistState(qrCodeUrl));
        } else {
          if (!context.mounted) return;
          emit(
            QrCodeNotExistState(
              AppLocalizations.of(context)!.account_qrcode_not_exist_title,
              AppLocalizations.of(context)!.account_qrcode_not_exist_subtitle,
            ),
          );
        }
      } else {
        if (!context.mounted) return;
        emit(
          QrCodeNotExistState(
            AppLocalizations.of(context)!.account_qrcode_not_exist_subtitle,
            AppLocalizations.of(context)!.account_qrcode_not_exist_subtitle,
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      emit(
        QrCodeErrorState(
          AppLocalizations.of(context)!.account_qrcode_error_subtitle,
          AppLocalizations.of(context)!.account_qrcode_error_subtitle_second,
        ),
      );
      CustomLoggerPrint().printWarningLog(e.toString());
    }
  }

  Future<void> qrCodeCreate(
    QrCodeCreateEvent event,
    Emitter<QrCodeState> emit,
  ) async {
    try {
      emit(QrCodeLoadingState());

      final String authId = FirebaseService().authID!;

      final qrImgFile = await generateQrCode(authId, event.context);

      final qrCodeUrl =
          await uploadQrCodeToStorage(qrImgFile, authId, event.context);

      await FirebaseCollectionReferances.qr_code.collectRef.doc(authId).set({
        'id': authId,
        'qrcode_url': qrCodeUrl,
      });

      await FirebaseCollectionReferances.users.collectRef.doc(authId).update({
        'qrcode_id': authId,
      });

      emit(QrCodeExistState(qrCodeUrl));
    } catch (e) {
      if (!event.context.mounted) return;
      emit(
        QrCodeErrorState(
          AppLocalizations.of(event.context)!.account_qrcode_error_subtitle,
          AppLocalizations.of(event.context)!
              .account_qrcode_error_subtitle_second,
        ),
      );
    }
  }

  Future<File> generateQrCode(String data, BuildContext context) async {
    final qrValidationResult = QrValidator.validate(
      data: data,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );

    if (qrValidationResult.status == QrValidationStatus.valid) {
      final qrCode = qrValidationResult.qrCode!;
      final painter = QrPainter.withQr(
        qr: qrCode,
        color: const Color(0xFF000000),
        gapless: true,
      );

      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/$data.png';
      final file = File(imagePath);

      await painter.toImageData(300).then((byteData) async {
        await file.writeAsBytes(byteData!.buffer.asUint8List());
      });

      return file;
    } else {
      throw Exception(
        AppLocalizations.of(context)!.account_qrcode_error_subtitle,
      );
    }
  }

  Future<String> uploadQrCodeToStorage(
    File qrImgFile,
    String authId,
    BuildContext context,
  ) async {
    try {
      final storageReference = FirebaseStorage.instance.ref().child(
            'qr_codes/$authId.png',
          );

      final uploadTask = storageReference.putFile(qrImgFile);
      final snapshot = await uploadTask.whenComplete(() {});

      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception(
        AppLocalizations.of(context)!.account_qrcode_error_subtitle,
      );
    }
  }
}
