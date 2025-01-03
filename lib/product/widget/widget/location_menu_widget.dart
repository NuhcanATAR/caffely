import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/service/city_district_service/city_district_service.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LocationMenuWidget extends StatefulWidget {
  const LocationMenuWidget({
    super.key,
    required this.onCityChanged,
    required this.onDistrictChanged,
    this.selectedCity,
    this.selectedDistrict,
  });

  final ValueChanged<String?> onCityChanged;
  final ValueChanged<String?> onDistrictChanged;
  final String? selectedCity;
  final String? selectedDistrict;

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
    selectCity = widget.selectedCity;
    selectDistrict = widget.selectedDistrict;

    getCityDistrictApi();
  }

  @override
  void didUpdateWidget(covariant LocationMenuWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedCity != oldWidget.selectedCity) {
      setState(() {
        selectCity = widget.selectedCity;
        selectDistrict = null;
      });
    }

    if (widget.selectedDistrict != oldWidget.selectedDistrict) {
      setState(() {
        selectDistrict = widget.selectedDistrict;
      });
    }
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
      Logger().e('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return cityDistricts != null
        ? Column(
            children: <Widget>[
              // city
              Column(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: BodyMediumBlackText(
                        text: AppLocalizations.of(context)!.location_menu_city,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: BaseUtility.paddingNormalValue,
                        vertical: BaseUtility.paddingSmallValue,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          BaseUtility.radiusCircularMediumValue,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          BaseUtility.radiusCircularMediumValue,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          BaseUtility.radiusCircularMediumValue,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          BaseUtility.radiusCircularMediumValue,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    icon: AppIcons.arrowDropDown.toSvgImg(
                      Colors.black,
                      BaseUtility.iconNormalSize,
                      BaseUtility.iconNormalSize,
                    ),
                    value: selectCity, // Seçili şehir
                    onChanged: (String? value) {
                      setState(() {
                        selectCity = value;
                        selectDistrict =
                            null; // Şehir değiştiğinde ilçeyi sıfırla
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
                ],
              ),
              // district
              Column(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: BaseUtility.vertical(
                        BaseUtility.paddingSmallValue,
                      ),
                      child: BodyMediumBlackText(
                        text: AppLocalizations.of(context)!
                            .location_menu_district,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: BaseUtility.paddingNormalValue,
                        vertical: BaseUtility.paddingSmallValue,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          BaseUtility.radiusCircularMediumValue,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          BaseUtility.radiusCircularMediumValue,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          BaseUtility.radiusCircularMediumValue,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          BaseUtility.radiusCircularMediumValue,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    icon: AppIcons.arrowDropDown.toSvgImg(
                      Colors.black,
                      BaseUtility.iconNormalSize,
                      BaseUtility.iconNormalSize,
                    ),
                    value: selectDistrict, // Seçili ilçe
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
                ],
              ),
            ],
          )
        : const SizedBox();
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
