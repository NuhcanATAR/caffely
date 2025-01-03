import 'package:caffely/feature/account/account_viewmodel.dart';
import 'package:caffely/feature/account/view/about_app/about_app_view.dart';
import 'package:caffely/feature/account/view/campain_discounts/campain_discounts_view.dart';
import 'package:caffely/feature/account/view/center_help/center_help_view.dart';
import 'package:caffely/feature/account/view/langue/langue_view.dart';
import 'package:caffely/feature/account/view/notification/notification_view.dart';
import 'package:caffely/feature/account/view/personal_information/personal_information_view.dart';
import 'package:caffely/feature/account/view/saved_adress/saved_dadress_view.dart';
import 'package:caffely/feature/account/view/security/security_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/logo.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/model/langue_model/langue_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/menu_card.dart';
import 'package:caffely/product/widget/widget/profile_card_widget.dart';
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
          padding: BaseUtility.all(
            BaseUtility.paddingSmallValue,
          ),
          child: AppLogoConstants.appLogoNoBackgroundColorPrimary.toImg,
        ),
        title: BodyMediumBlackBoldText(
          text: AppLocalizations.of(context)!.account_appbar,
          textAlign: TextAlign.left,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refreshUserInformation,
        child: Padding(
          padding: BaseUtility.all(
            BaseUtility.paddingNormalValue,
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
  Widget get buildUserCardWidget => ProfileCardWidget(
        getUserFromFireStore: getUserFromFireStore,
        dynamicViewExtensions: dynamicViewExtensions,
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
            menuText: AppLocalizations.of(context)!.account_save_adress_menu,
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
            menuText:
                AppLocalizations.of(context)!.account_campaign_discaoun_menu,
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
              padding: BaseUtility.vertical(
                BaseUtility.paddingMediumValue,
              ),
              child: BodyMediumBlackText(
                text: AppLocalizations.of(context)!.account_menu_group_title,
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
            menuText:
                AppLocalizations.of(context)!.account_personal_information_menu,
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
            menuText: AppLocalizations.of(context)!.account_notification_menu,
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
            menuText: AppLocalizations.of(context)!.account_security_menu,
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
            menuText: AppLocalizations.of(context)!.account_langue_menu,
            menuIcon: AppIcons.worldOutline,
            isArrowBtn: true,
            children: <Widget>[
              BodyMediumBlackText(
                text:
                    ' ${languageProvider.selectedLanguage == 'en' ? AppLocalizations.of(context)!.account_langue_en_menu : AppLocalizations.of(context)!.account_langue_tr_menu}',
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
              padding: BaseUtility.vertical(
                BaseUtility.paddingMediumValue,
              ),
              child: BodyMediumBlackText(
                text: AppLocalizations.of(context)!
                    .account_menu_group_second_title,
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
            menuText: AppLocalizations.of(context)!.account_help_menu,
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
            menuText: AppLocalizations.of(context)!.account_about_menu,
            menuIcon: AppIcons.infoOutline,
          ),
          // logout
          CustomMenuCardWidget(
            func: signOut,
            dynamicViewExtensions: dynamicViewExtensions,
            menuText: AppLocalizations.of(context)!.account_exit_menu,
            menuIcon: AppIcons.logoutOutline,
          ),
        ],
      );
}
