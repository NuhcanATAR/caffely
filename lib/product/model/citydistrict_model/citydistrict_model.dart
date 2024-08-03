// ignore_for_file: avoid_dynamic_calls

class CityDistricts {
  String? _status;
  List<Data>? _data;

  CityDistricts({String? status, List<Data>? data}) {
    if (status != null) {
      _status = status;
    }
    if (data != null) {
      _data = data;
    }
  }

  CityDistricts.fromJson(Map<String, dynamic> json) {
    _status = json['status'] as String?;
    if (json['data'] != null) {
      _data = <Data>[];

      json['data'].forEach((v) {
        _data!.add(Data.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = _status;
    if (_data != null) {
      data['data'] = _data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? _id;
  String? _name;
  List<Districts>? _districts;

  Data({int? id, String? name, List<Districts>? districts}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (districts != null) {
      _districts = districts;
    }
  }

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'] as int?;
    _name = json['name'] as String?;
    if (json['districts'] != null) {
      _districts = <Districts>[];
      json['districts'].forEach((v) {
        _districts!.add(Districts.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    if (_districts != null) {
      data['districts'] = _districts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Districts {
  int? _id;
  String? _name;

  Districts({int? id, String? name}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
  }

  Districts.fromJson(Map<String, dynamic> json) {
    _id = json['id'] as int?;
    _name = json['name'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    return data;
  }
}
