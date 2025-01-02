import 'package:caffely/feature/account/view/qr_code/qr_code_view.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/auth_control.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/user_model/user_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:flutter/material.dart';

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({
    super.key,
    required this.getUserFromFireStore,
    required this.dynamicViewExtensions,
  });

  final Function(String authId) getUserFromFireStore;
  final DynamicViewExtensions dynamicViewExtensions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dynamicViewExtensions.maxWidth(context),
      child: FutureBuilder(
        future: getUserFromFireStore(FirebaseService().authID!),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasError) {
            return const SizedBox();
          }

          if (snapshot.hasData) {
            final userModel = snapshot.data!;
            return Padding(
              padding: BaseUtility.vertical(
                BaseUtility.paddingNormalValue,
              ),
              child: Row(
                children: <Widget>[
                  // profile image
                  buildProfileImageWidget(
                    context,
                    userModel,
                  ),
                  // body
                  buildBodyWidget(
                    context,
                    userModel,
                  ),
                  // qr code
                  IconButton(
                    onPressed: () {
                      CodeNoahNavigatorRouter.push(
                        context,
                        const AccountQrCodeView(),
                      );
                    },
                    icon: const Icon(
                      Icons.qr_code_outlined,
                      color: Colors.black,
                      size: BaseUtility.iconNormalSize,
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
  }

  // profile image
  Widget buildProfileImageWidget(BuildContext context, UserModel userModel) =>
      SizedBox(
        width: 50,
        height: 50,
        child: Container(
          alignment: Alignment.center,
          decoration:
              userModel.authStatus == AuthControl.emailPasswordAuth.valueAuth
                  ? BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(
                        BaseUtility.radiusCircularHighValue,
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
                        BaseUtility.radiusCircularHighValue,
                      ),
                    ),
          child: userModel.authStatus == AuthControl.emailPasswordAuth.valueAuth
              ? AppIcons.userOutline.toSvgImg(
                  Colors.white,
                  BaseUtility.iconNormalSize,
                  BaseUtility.iconNormalSize,
                )
              : const SizedBox(),
        ),
      );

  // body
  Widget buildBodyWidget(BuildContext context, UserModel userModel) => Expanded(
        child: Padding(
          padding: BaseUtility.horizontal(
            BaseUtility.paddingNormalValue,
          ),
          child: Column(
            children: <Widget>[
              // name surname
              SizedBox(
                width: dynamicViewExtensions.maxWidth(context),
                child: Padding(
                  padding: BaseUtility.vertical(
                    BaseUtility.paddingSmallValue,
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
                  padding: BaseUtility.vertical(
                    BaseUtility.paddingSmallValue,
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
      );
}
