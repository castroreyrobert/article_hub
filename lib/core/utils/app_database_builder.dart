
import 'package:article_hub/data/data_sources/local/app_database.dart';

Future<AppDatabase> getDatabaseBuilder() async {

  final builder = await $FloorAppDatabase.databaseBuilder("app_db.db").build();

  return builder;
}