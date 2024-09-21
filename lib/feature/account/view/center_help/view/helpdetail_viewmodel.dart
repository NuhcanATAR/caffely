import 'package:caffely/feature/account/view/center_help/view/helpdetail_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/core/exception/service_exception/service_exceptions.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class HelpDetailViewModel extends BaseState<HelpdetailView> {
  Future<void> whatsAppOpen() async {
    if (!await launchUrl(
      Uri.parse('https://wa.me/+905349881069'),
    )) {
      throw ServiceException(
        'Could not launch phone number',
      );
    }
  }
}
