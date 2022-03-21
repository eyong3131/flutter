import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      return await _initDatabase();
    }
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "minhs.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE employee (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            firstname TEXT NOT NULL,
            lastname TEXT NOT NULL,
            middlename TEXT NOT NULL,
            image TEXT NOT NULL,
            position TEXT NOT NULL,
            email TEXT NOT NULL,
            hash TEXT NOT NULL
             )
          ''');

    await db.execute('''
          CREATE TABLE empdtr (
            id TEXT NOT NULL,
            date TEXT NOT NULL,
            time TEXT NOT NULL,
            status TEXT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE settings (
            site  TEXT NOT NULL,
            interval TEXT NOT NULL,
            apiurl TEXT NOT NULL,
            username TEXT NOT NULL,
            password TEXT NOT NULL )
          ''');

    print('create login');

    await db.execute('''
          CREATE TABLE login (
            username  TEXT NOT NULL,
            password TEXT NOT NULL,
            pincode TEXT NOT NULL
          )
          ''');
  }
}
