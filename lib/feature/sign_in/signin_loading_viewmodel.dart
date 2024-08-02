import 'package:caffely/feature/sign_in/signin_loading_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SignInLoadingViewmodel extends BaseState<SignInLoadingView> {
  @override
  void initState() {
    super.initState();
    setUserId();
  }

  void setUserId() {
    SharedPreferences.getInstance().then((valuePrefs) {
      valuePrefs.setString('user_id', FirebaseService().authID.toString());
    });
    logger.i('Oturum ID Kaydedildi!');
  }
}
