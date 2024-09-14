import 'package:caffely/feature/account/view/saved_adress/bloc/cubit.dart';
import 'package:caffely/feature/account/view/saved_adress/bloc/state.dart';
import 'package:caffely/feature/account/view/saved_adress/savedadress_viewmodel.dart';
import 'package:caffely/feature/account/view/saved_adress/view/savedadress_create/savedadress_create_view.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/adresscard_widget.dart';
import 'package:caffely/product/widget/widget/response_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedAdressView extends StatefulWidget {
  const SavedAdressView({super.key});

  @override
  State<SavedAdressView> createState() => _SavedAdressViewState();
}

class _SavedAdressViewState extends SavedAdressViewModel {
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
          text: 'Kayıtlı Adresler',
          textAlign: TextAlign.left,
        ),
        actions: [
          Padding(
            padding: PaddingSizedsUtility.horizontal(
              PaddingSizedsUtility.normalPaddingValue,
            ),
            child: IconButton(
              onPressed: () {
                CodeNoahNavigatorRouter.push(
                  context,
                  const SavedadressCreateView(),
                );
              },
              icon: AppIcons.add.toSvgImg(
                Colors.black,
                IconSizedsUtility.normalSize,
                IconSizedsUtility.normalSize,
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<SavedAdressBloc, SavedAdressState>(
        listener: savedAdressDeleteListenerBloc,
        builder: (context, state) {
          if (state is SavedAdressLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SavedAdressLoaded) {
            return state.savedAdress.isEmpty
                ? const CustomResponseWidget(
                    img: AppImages.notFound,
                    title: 'Kayıtlı Adres Bulunmuyor.',
                    subTitle:
                        'Henüz yeni bir kayıtlı adresiniz bulunmuyor, hemen yeni bi adres oluşturaiblirsiniz.',
                  )
                : ListView.builder(
                    itemCount: state.savedAdress.length,
                    itemBuilder: (context, index) {
                      final adressModel = state.savedAdress[index];
                      return AdressCardWidget(
                        dynamicViewExtensions: dynamicViewExtensions,
                        adressModel: adressModel,
                      );
                    },
                  );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
