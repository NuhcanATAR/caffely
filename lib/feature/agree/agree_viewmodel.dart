import 'dart:io';

import 'package:caffely/feature/agree/agree_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

abstract class AgreeViewModel extends BaseState<AgreeView> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    fromAsset('assets/pdf/caffely_agree.pdf', 'caffely_agree.pdf').then((f) {
      setState(() {
        localPath = f.path;
      });
    });
  }

  Future<File> fromAsset(String asset, String filename) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final File file = File('${dir.path}/$filename');
      final data = await rootBundle.load(asset);
      final bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      return file;
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
  }
}
