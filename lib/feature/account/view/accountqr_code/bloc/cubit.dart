// ignore_for_file: invalid_use_of_visible_for_testing_member, deprecated_member_use

import 'dart:io';

import 'package:caffely/feature/account/view/accountqr_code/bloc/event.dart';
import 'package:caffely/feature/account/view/accountqr_code/bloc/state.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/qrcode_model/qrcode_model.dart';
import 'package:caffely/product/model/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeCubit extends Bloc<QrCodeEvent, QrCodeState> {
  QrCodeCubit() : super(QrCodeState()) {
    on<QrCodeCreateEvent>(qrCodeCreate);
  }

  Future<void> checkUserQrCode() async {
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
          emit(
            QrCodeNotExistState(
              'Caffely QR Kod ile indirimli kahve alın!',
              'Hesabınıza tanımlı bir qr kod oluşturun ve Caffely şubelerinden alacağınız kahvelerde indirim kazanma şansı yakalyın.',
            ),
          );
        }
      } else {
        emit(
          QrCodeNotExistState(
            'Caffely QR Kod ile indirimli kahve alın!',
            'Hesabınıza tanımlı bir qr kod oluşturun ve Caffely şubelerinden alacağınız kahvelerde indirim kazanma şansı yakalyın.',
          ),
        );
      }
    } catch (e) {
      emit(
        QrCodeErrorState(
          'Caffely QR Kod, Hata Oluştu',
          'Caffely QR Kod oluşturma/gösterme esnasında bir hata oluştu, lütfen daha sonra tekrar deneyiniz.',
        ),
      );
      Logger().e(e);
    }
  }

  Future<void> qrCodeCreate(
    QrCodeCreateEvent event,
    Emitter<QrCodeState> emit,
  ) async {
    try {
      emit(QrCodeLoadingState());

      final String authId = FirebaseService().authID!;

      final qrImgFile = await generateQrCode(authId);

      final qrCodeUrl = await uploadQrCodeToStorage(qrImgFile, authId);

      await FirebaseCollectionReferances.qr_code.collectRef.doc(authId).set({
        'id': authId,
        'qrcode_url': qrCodeUrl,
      });

      await FirebaseCollectionReferances.users.collectRef.doc(authId).update({
        'qrcode_id': authId,
      });

      emit(QrCodeExistState(qrCodeUrl));
    } catch (e) {
      emit(
        QrCodeErrorState(
          'QR Kod Oluşturma Hatası ',
          'QR Kod oluşturma esnasında bir hata oluştu, lütfen daha sonra tekrar deneyiniz.',
        ),
      );
    }
  }

  Future<File> generateQrCode(String data) async {
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
      throw Exception('Geçersiz QR kod verisi.');
    }
  }

  Future<String> uploadQrCodeToStorage(File qrImgFile, String authId) async {
    try {
      final storageReference = FirebaseStorage.instance.ref().child(
            'qr_codes/$authId.png',
          );

      final uploadTask = storageReference.putFile(qrImgFile);
      final snapshot = await uploadTask.whenComplete(() {});

      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception('QR kod Firebase Storage\'a yüklenemedi.');
    }
  }
}
