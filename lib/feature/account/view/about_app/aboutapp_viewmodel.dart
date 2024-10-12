import 'package:caffely/feature/account/view/about_app/aboutapp_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/core/exception/service_exception/service_exceptions.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class AboutAppViewModel extends BaseState<AboutAppView> {
  late String title = AppLocalizations.of(context)!.account_aboutapp_title;
  late String explanation =
      AppLocalizations.of(context)!.account_aboutapp_subtitle;

  late String githubUrl = 'https://github.com/NuhcanATAR';
  late String linkedinUrl =
      'https://www.linkedin.com/in/nuhcan-atar-371276208/';

  Future<void> linkOpen(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw ServiceException('Could not launch url: $url');
    }
  }
}
