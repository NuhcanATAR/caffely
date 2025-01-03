import 'package:caffely/feature/account/view/qr_code/qr_code_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';

import 'bloc/cubit.dart';

abstract class AccountQrCodeViewModel extends BaseState<AccountQrCodeView> {
  late QrCodeCubit qrCodeCubit;

  @override
  void initState() {
    super.initState();
    qrCodeCubit = QrCodeCubit();
    qrCodeCubit.checkUserQrCode(context);
  }

  @override
  void dispose() {
    qrCodeCubit.close();
    super.dispose();
  }
}
