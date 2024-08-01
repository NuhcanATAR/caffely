// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'package:caffely/product/core/exception/service_exception/service_exceptions.dart';
import 'package:http/http.dart' as http;

class CityDistrictService {
  final String apiUrl;

  CityDistrictService(this.apiUrl);

  Future<Map<String, List<String>>> fetchAllCityDistricts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return parseData(jsonData);
    } else {
      throw ServiceException('Şehir ve İlçe Yüklenemedi!');
    }
  }

  Map<String, List<String>> parseData(dynamic jsonData) {
    Map<String, dynamic> dataMap;
    if (jsonData is List) {
      // If the jsonData variable returns a list, we take the initial data and convert it to a map variable.
      dataMap = (jsonData as dynamic).first as Map<String, dynamic>;
    } else {
      // If the json data is a direct map variable, we use it directly.
      dataMap = jsonData as Map<String, dynamic>;
    }

    final List<dynamic> data = dataMap['data'] as List<dynamic>;
    final Map<String, List<String>> cityDistricts = {};
    for (final province in data) {
      final String provinceName = province['name'] as String;
      final List<dynamic> districtNames =
          extractDistricts(province['districts'] as List<dynamic>);
      cityDistricts[provinceName] = districtNames as List<String>;
    }
    return cityDistricts;
  }

  List<String> extractDistricts(List<dynamic> districtData) {
    return districtData.map((district) => district['name'].toString()).toList();
  }
}
