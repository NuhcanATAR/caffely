import 'package:caffely/feature/account/view/notification/notification_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/mixin/notification_mixin.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class NotificationViewModel extends BaseState<NotificationView>
    with NotificationMixin {
  bool notificationEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final status = await Permission.notification.status;
    setState(() {
      notificationEnabled = status.isGranted;
    });
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();
    setState(() {
      notificationEnabled = status.isGranted;
      if (notificationEnabled == false) {
        openAppSettings();
      }
    });
  }
}
