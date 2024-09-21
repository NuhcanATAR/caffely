import 'package:caffely/feature/account/account_viewmodel.dart';
import 'package:caffely/feature/account/view/about_app/aboutapp_view.dart';
import 'package:caffely/feature/account/view/accountqr_code/accountqrcode_view.dart';
import 'package:caffely/feature/account/view/campain_discounts/campaindiscounts_view.dart';
import 'package:caffely/feature/account/view/center_help/centerhelp_view.dart';
import 'package:caffely/feature/account/view/langue/langue_view.dart';
import 'package:caffely/feature/account/view/notification/notification_view.dart';
import 'package:caffely/feature/account/view/personal_information/personalinformation_view.dart';
import 'package:caffely/feature/account/view/saved_adress/savedadress_view.dart';
import 'package:caffely/feature/account/view/security/security_view.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/logo.dart';
import 'package:caffely/product/core/base/helper/auth_control.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/langue_model/langue_model.dart';
import 'package:caffely/product/model/user_model/user_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:caffely/product/widget/widget/menu_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends AccountViewModel {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: Padding(
          padding: PaddingSizedsUtility.all(
            PaddingSizedsUtility.smallPaddingValue,
          ),
          child: AppLogoConstants.appLogoNoBackgroundColorPrimary.toImg,
        ),
        title: const BodyMediumBlackBoldText(
          text: 'Profil',
          textAlign: TextAlign.left,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refreshUserInformation,
        child: Padding(
          padding: PaddingSizedsUtility.all(
            PaddingSizedsUtility.normalPaddingValue,
          ),
          child: ListView(
            children: <Widget>[
              // user card
              buildUserCardWidget,
              // menu group one
              buildMenuGroupOneWidget,
              // menu group second
              buildMenuGroupSecondWidget(
                languageProvider,
                context,
              ),
              // menu group third
              buildMenuGroupThirdWidget,
            ],
          ),
        ),
      ),
    );
  }

  // user card
  Widget get buildUserCardWidget => SizedBox(
        width: dynamicViewExtensions.maxWidth(context),
        child: FutureBuilder(
          future: getUserFromFireStore(FirebaseService().authID.toString()),
          builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
            if (snapshot.hasError) {
              return const SizedBox();
            }

            if (snapshot.hasData) {
              final userModel = snapshot.data!;
              return Padding(
                padding: PaddingSizedsUtility.vertical(
                  PaddingSizedsUtility.normalPaddingValue,
                ),
                child: Row(
                  children: <Widget>[
                    // profile image
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: userModel.authStatus ==
                                AuthControl.emailPasswordAuth.valueAuth
                            ? BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(
                                  RadiusUtility.circularHighValue,
                                ),
                              )
                            : BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    userModel.profileImage,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(
                                  RadiusUtility.circularHighValue,
                                ),
                              ),
                        child: userModel.authStatus ==
                                AuthControl.emailPasswordAuth.valueAuth
                            ? AppIcons.userOutline.toSvgImg(
                                Colors.white,
                                IconSizedsUtility.normalSize,
                                IconSizedsUtility.normalSize,
                              )
                            : const SizedBox(),
                      ),
                    ),
                    // body
                    Expanded(
                      child: Padding(
                        padding: PaddingSizedsUtility.horizontal(
                          PaddingSizedsUtility.normalPaddingValue,
                        ),
                        child: Column(
                          children: <Widget>[
                            // name surname
                            SizedBox(
                              width: dynamicViewExtensions.maxWidth(context),
                              child: Padding(
                                padding: PaddingSizedsUtility.vertical(
                                  PaddingSizedsUtility.smallPaddingValue,
                                ),
                                child: TitleMediumBlackBoldText(
                                  text: userModel.nameSurname,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            // email
                            SizedBox(
                              width: dynamicViewExtensions.maxWidth(context),
                              child: Padding(
                                padding: PaddingSizedsUtility.vertical(
                                  PaddingSizedsUtility.smallPaddingValue,
                                ),
                                child: BodyMediumBlackText(
                                  text: userModel.email,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // qr code
                    IconButton(
                      onPressed: () {
                        CodeNoahNavigatorRouter.push(
                          context,
                          const AccountQrCodeView(),
                        );
                      },
                      icon: Icon(
                        Icons.qr_code_outlined,
                        color: Colors.black,
                        size: IconSizedsUtility.normalSize,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      );

  // menu group one
  Widget get buildMenuGroupOneWidget => Column(
        children: <Widget>[
          // save adress
          CustomMenuCardWidget(
            func: () {
              CodeNoahNavigatorRouter.push(
                context,
                const SavedAdressView(),
              );
            },
            dynamicViewExtensions: dynamicViewExtensions,
            menuText: 'Kayıtlı Adresler',
            menuIcon: AppIcons.locationOutline,
          ),
          // voucher discounts
          CustomMenuCardWidget(
            func: () {
              CodeNoahNavigatorRouter.push(
                context,
                const CampainDiscountsView(),
              );
            },
            dynamicViewExtensions: dynamicViewExtensions,
            menuText: 'Kampanya ve İndirimler',
            menuIcon: AppIcons.giftOutline,
          ),
        ],
      );

  // menu group second
  Widget buildMenuGroupSecondWidget(
    LanguageProvider languageProvider,
    BuildContext context,
  ) =>
      Column(
        children: <Widget>[
          // general
          SizedBox(
            width: dynamicViewExtensions.maxWidth(context),
            child: Padding(
              padding: PaddingSizedsUtility.vertical(
                PaddingSizedsUtility.mediumPaddingValue,
              ),
              child: const BodyMediumBlackText(
                text: 'Genel',
                textAlign: TextAlign.left,
              ),
            ),
          ),
          // personal info
          CustomMenuCardWidget(
            func: () {
              CodeNoahNavigatorRouter.push(
                context,
                const PersonalInformationView(),
              );
            },
            dynamicViewExtensions: dynamicViewExtensions,
            menuText: 'Kişisel Bilgiler',
            menuIcon: AppIcons.userOutline,
          ),
          // notification
          CustomMenuCardWidget(
            func: () {
              CodeNoahNavigatorRouter.push(
                context,
                const NotificationView(),
              );
            },
            dynamicViewExtensions: dynamicViewExtensions,
            menuText: 'Bildirimler',
            menuIcon: AppIcons.notificationOutline,
          ),
          // security
          CustomMenuCardWidget(
            func: () {
              CodeNoahNavigatorRouter.push(
                context,
                const SecurityView(),
              );
            },
            dynamicViewExtensions: dynamicViewExtensions,
            menuText: 'Güvenlik',
            menuIcon: AppIcons.securityOutline,
          ),
          // langue
          CustomMenuRowCardWidget(
            func: () {
              CodeNoahNavigatorRouter.push(
                context,
                const LangueView(),
              );
            },
            dynamicViewExtensions: dynamicViewExtensions,
            menuText: 'Dil',
            menuIcon: AppIcons.worldOutline,
            isArrowBtn: true,
            children: <Widget>[
              BodyMediumBlackText(
                text:
                    ' ${languageProvider.selectedLanguage == 'en' ? 'English (EN)' : 'Turkish (TR)'}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          // // dark mode
          // CustomMenuRowCardWidget(
          //   func: () {},
          //   dynamicViewExtensions: dynamicViewExtensions,
          //   menuText: 'Tema Modu',
          //   menuIcon: AppIcons.sunOutline,
          //   isArrowBtn: false,
          //   children: <Widget>[
          //     Switch(
          //       value: true,
          //       onChanged: (value) {},
          //     ),
          //   ],
          // ),
        ],
      );

  // menu group third
  Widget get buildMenuGroupThirdWidget => Column(
        children: <Widget>[
          // other settings
          SizedBox(
            width: dynamicViewExtensions.maxWidth(context),
            child: Padding(
              padding: PaddingSizedsUtility.vertical(
                PaddingSizedsUtility.mediumPaddingValue,
              ),
              child: const BodyMediumBlackText(
                text: 'Diğer Ayarlar',
                textAlign: TextAlign.left,
              ),
            ),
          ),
          // help center
          CustomMenuCardWidget(
            func: () {
              CodeNoahNavigatorRouter.push(
                context,
                const CenterHelpView(),
              );
            },
            dynamicViewExtensions: dynamicViewExtensions,
            menuText: 'Yardım Merkezi',
            menuIcon: AppIcons.fileOutline,
          ),
          // about caffely
          CustomMenuCardWidget(
            func: () {
              CodeNoahNavigatorRouter.push(
                context,
                const AboutAppView(),
              );
            },
            dynamicViewExtensions: dynamicViewExtensions,
            menuText: 'Caffely Hakkında',
            menuIcon: AppIcons.infoOutline,
          ),
          // logout
          CustomMenuCardWidget(
            func: signOut,
            dynamicViewExtensions: dynamicViewExtensions,
            menuText: 'Çıkış yap',
            menuIcon: AppIcons.logoutOutline,
          ),
        ],
      );
}
