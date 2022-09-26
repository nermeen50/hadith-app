import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hadith_app/core/local_api/local_consumer.dart';

class LocalService implements ApiConsumer {
  @override
  Future<void> readJson(String path) async {
    try {
      final response = await rootBundle.loadString(path);
      final data = await json.decode(response);
      return data;
    } catch (error) {
      throw Exception(error);
    }
  }
}
