// ignore_for_file: avoid_dynamic_calls

import 'package:caffely/feature/account/view/center_help/bloc/cubit.dart';
import 'package:caffely/feature/account/view/center_help/bloc/state.dart';
import 'package:caffely/feature/account/view/center_help/centerhelp_viewmodel.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/model/centerhelp_model/centerhelp_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/centerhelpcard_widget.dart';
import 'package:caffely/product/widget/widget/response_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CenterHelpView extends StatefulWidget {
  const CenterHelpView({super.key});

  @override
  State<CenterHelpView> createState() => _CenterHelpViewState();
}

class _CenterHelpViewState extends CenterHelpViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: AppIcons.arrowLeft.toSvgImg(
            Colors.black,
            IconSizedsUtility.normalSize,
            IconSizedsUtility.normalSize,
          ),
        ),
        title: const BodyMediumBlackText(
          text: 'Yardım Merkezi',
          textAlign: TextAlign.left,
        ),
      ),
      body: BlocBuilder<CenterHelpBloc, CenterHelpState>(
        builder: (context, state) {
          if (state is CenterHelpLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CenterHelpLoadedState) {
            return Padding(
              padding: PaddingSizedsUtility.all(
                PaddingSizedsUtility.normalPaddingValue,
              ),
              child: state.centerHelps.isEmpty
                  ? const CustomResponseWidget(
                      img: AppImages.notFound,
                      title: 'Yardım Merkezinde Henüz Birşey yok',
                      subTitle:
                          'Görünüşe göre yardım merkezinde henüz yeni birşey yok, daha sonra tekrar kontrol edebilirsiniz.',
                    )
                  : buildListWidget(
                      state,
                      state.centerHelps,
                    ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  // list widget
  ListView buildListWidget(
    CenterHelpState state,
    List<CenterHelpModel> centerHelps,
  ) =>
      ListView.builder(
        itemCount: state.centerHelps.length,
        itemBuilder: (context, index) {
          final helpModel = state.centerHelps[index];
          return CenterHelpCardWidget(
            helpModel: helpModel,
          );
        },
      );
}
