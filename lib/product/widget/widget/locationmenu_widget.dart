import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/service/citydistrict_service/citydistrict_service.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LocationMenuWidget extends StatefulWidget {
  const LocationMenuWidget({
    super.key,
    required this.onCityChanged,
    required this.onDistrictChanged,
  });

  final ValueChanged<String?> onCityChanged;
  final ValueChanged<String?> onDistrictChanged;

  @override
  State<LocationMenuWidget> createState() => _LocationMenuWidgetState();
}

class _LocationMenuWidgetState extends State<LocationMenuWidget> {
  Map<String, List<String>>? cityDistricts;
  String? selectCity;
  String? selectDistrict;

  @override
  void initState() {
    super.initState();
    getCityDistrictApi();
  }

  Future<void> getCityDistrictApi() async {
    final serviceApi =
        CityDistrictService('https://turkiyeapi.dev/api/v1/provinces');
    try {
      final allCityDistrictsList = await serviceApi.fetchAllCityDistricts();
      setState(() {
        cityDistricts = allCityDistrictsList;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // City Dropdown
        Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: BodyMediumBlackText(
                    text: 'Şehir',
                    textAlign: TextAlign.left,
                  )),
            ),
            Container(
              margin: MarginSizedsUtility.bottom(
                MarginSizedsUtility.smallMarginValue,
              ),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: PaddingSizedsUtility.normalPaddingValue,
                    vertical: PaddingSizedsUtility.smallPaddingValue,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      RadiusUtility.circularMediumValue,
                    ),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      RadiusUtility.circularMediumValue,
                    ),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      RadiusUtility.circularMediumValue,
                    ),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      RadiusUtility.circularMediumValue,
                    ),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                icon: AppIcons.arrowDropDown.toSvgImg(
                  Colors.black,
                  IconSizedsUtility.normalSize,
                  IconSizedsUtility.normalSize,
                ),
                value: selectCity,
                validator: (value) => value == null ? "Zorunlu Alan" : null,
                hint: const BodyMediumBlackText(
                  text: 'Şehir',
                  textAlign: TextAlign.left,
                ),
                onChanged: (String? value) {
                  setState(() {
                    selectCity = value;
                    selectDistrict = null;
                  });
                  widget.onCityChanged(value);
                },
                items: cityDistricts?.keys.map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: BodyMediumBlackBoldText(
                      text: city,
                      textAlign: TextAlign.left,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),

        // District Dropdown
        Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: PaddingSizedsUtility.vertical(
                  PaddingSizedsUtility.smallPaddingValue,
                ),
                child: const BodyMediumBlackText(
                  text: 'İlçe',
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Container(
              margin: MarginSizedsUtility.bottom(
                MarginSizedsUtility.smallMarginValue,
              ),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: PaddingSizedsUtility.normalPaddingValue,
                    vertical: PaddingSizedsUtility.smallPaddingValue,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      RadiusUtility.circularMediumValue,
                    ),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      RadiusUtility.circularMediumValue,
                    ),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      RadiusUtility.circularMediumValue,
                    ),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      RadiusUtility.circularMediumValue,
                    ),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                icon: AppIcons.arrowDropDown.toSvgImg(
                  Colors.black,
                  IconSizedsUtility.normalSize,
                  IconSizedsUtility.normalSize,
                ),
                hint: const BodyMediumBlackText(
                  text: 'İlçe',
                  textAlign: TextAlign.left,
                ),
                value: selectDistrict,
                validator: (value) => value == null ? "Zorunlu Alan" : null,
                onChanged: (String? value) {
                  setState(() {
                    selectDistrict = value;
                  });
                  widget.onDistrictChanged(value);
                },
                items: selectCity == null
                    ? []
                    : cityDistricts![selectCity]!.map((String district) {
                        return DropdownMenuItem<String>(
                          value: district,
                          child: BodyMediumBlackBoldText(
                            text: district,
                            textAlign: TextAlign.left,
                          ),
                        );
                      }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MainUserCityModel {
  final String cityName;
  final List<MainUserDistrict> subDistrictList;

  MainUserCityModel(this.cityName, this.subDistrictList);
}

class MainUserDistrict {
  final String districtName;

  MainUserDistrict(this.districtName);
}
