import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:penny_track/data/dto/records/record.dart';

class DBHelper {
  static const _databaseName = "pennytrack.db";
  static const _databaseVersion = 1;

  static const columnId = '_id';

  ///Records Table
  static const table = 'records';

  static const columnRecordAccount = 'record_account';
  static const columnRecordAmount = 'record_amount';
  static const columnRecordCreatedAt = 'record_created_at';
  static const columnRecordNotes = 'record_notes';
  static const columnRecordType = 'record_type';

  ///Add new table constants below

  // make this a singleton class
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId TEXT PRIMARY KEY,
            $columnRecordAccount TEXT NOT NULL,
            $columnRecordAmount TEXT NOT NULL,
            $columnRecordCreatedAt TEXT NOT NULL,
            $columnRecordNotes TEXT NOT NULL,
            $columnRecordType TEXT NOT NULL
          )
          ''');
  }

  // Future<bool> userExists(String user) async {
  //   Database db = await instance.database;

  //   final res =
  //       await db.rawQuery("SELECT * FROM $table WHERE username = '$user'");

  //   if (res.isNotEmpty) {
  //     return true;
  //   }
  //   return false;
  // }

  // Future<User> getUser(String user, String password) async {
  //   Database db = await instance.database;

  //   final res = await db.rawQuery(
  //       "SELECT * FROM $table WHERE username = '$user' AND password = '$password'");

  //   if (res.isNotEmpty) {
  //     User user = User.fromMap(res[0]);
  //     return user;
  //   }
  //   return User('', '');
  // }
  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insertRecords(Record row) async {
    Database db = await instance.database;
    return await db.insert(
      table,
      row.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Record>> getRecords() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> result = await db.query(table);

    //Convert the list of maps into Records
    return List.generate(
      result.length,
      (i) => Record.fromJson(result[i]),
    );
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  // Future<int> queryRowCount() async {
  //   Database db = await instance.database;
  //   return Sqflite.firstIntValue(
  //       await db.rawQuery('SELECT COUNT(*) FROM $table'));
  // }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> updateRecords(Record row) async {
    Database db = await instance.database;
    String id = row.id;
    return await db.update(
      table,
      row.toJson(),
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> deleteRecords(String id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
