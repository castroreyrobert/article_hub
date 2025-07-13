import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:article_hub/core/utils/list_string_type_converter.dart';
import 'package:article_hub/data/data_sources/local/products/product_dao.dart';
import 'package:floor/floor.dart';

import '../../models/products/product_model.dart';

part 'app_database.g.dart';

@TypeConverters([ListStringConverter])
@Database(version: 1, entities: [ProductModel])
abstract class AppDatabase extends FloorDatabase {
  ProductDao get productDao;
}