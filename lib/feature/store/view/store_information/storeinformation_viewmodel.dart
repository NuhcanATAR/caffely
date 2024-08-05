import 'package:caffely/feature/store/view/store_information/storeinformation_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';

abstract class StoreInformationViewModel
    extends BaseState<StoreInformationView> {
  late DateTime openDateTime = widget.storeModel.openingTime!.toDate();
  late DateTime closeDateTime = widget.storeModel.closingTime!.toDate();
}
