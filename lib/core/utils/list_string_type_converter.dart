import 'dart:convert';
import 'package:floor/floor.dart';

class ListStringConverter extends TypeConverter<List<String>?, String?> {
  @override
  List<String>? decode(String? databaseValue) {
    if (databaseValue == null) {
      return null;
    }
    final List<dynamic> jsonData = json.decode(databaseValue);
    return jsonData.map((item) => item as String).toList();
  }

  @override
  String? encode(List<String>? value) {
    if (value == null) {
      return null;
    }
    return json.encode(value);
  }
}