import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'initial_table_queries.dart';

Future<Database> openDb() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  final database = openDatabase(
    join(await getDatabasesPath(), 'flights_logger_database.db'),
    onCreate: (db, version) {
      for (final query in initialTableQueries) {
        db.execute(query);
      }
      print('[db]: initialTableQueries executed');
    },
    version: 1,
  );

  return database;
}

Future<Database> database = openDb();
