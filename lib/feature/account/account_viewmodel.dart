import 'package:caffely/feature/account/account_view.dart';
import 'package:caffely/feature/sign_in/signin_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../product/model/user_model/user_model.dart';

abstract class AccountViewModel extends BaseState<AccountView> {
  late Future<UserModel> userFutureGet;
  Future<void> signOut() async {
    await FirebaseService().authService.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("remember_me", false);
    if (!mounted) return;
    CodeNoahNavigatorRouter.pushAndRemoveUntil(
      context,
      const SignInView(),
    );
  }

  Future<void> refreshUserInformation() async {
    final userId = FirebaseService().authID;
    setState(() {
      userFutureGet = getUserFromFireStore(userId!);
    });
  }
}
