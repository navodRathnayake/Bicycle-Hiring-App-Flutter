library sqlflite_helper;

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteHelper {
  static const databaseName = 'bicycle_app.db';
  static Database? _database;
  static final SqfliteHelper instance = SqfliteHelper._init();
  SqfliteHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(databaseName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    try {
      await db.execute(
          'create table Users (token TEXT NOT NULL, userName TEXT NOT NULL, password TEXT NOT NULL, status TEXT NOT NULL, key TEXT NOT NULL, image TEXT NOT NULL)');
      await db.insert('Users', {
        'key': '1',
        'image': 'initial-image',
        'token': 'initial-token',
        'userName': 'initial-userName',
        'password': 'initial-password',
        'status': 'initial'
      });
      debugPrint('db has created');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<int> close() async {
    try {
      final db = await instance.database;
      await db.close();
      debugPrint('DB has closed');
      return 1;
    } catch (e) {
      debugPrint(e.toString());
    }
    return 0;
  }

  Future<Map<String, Object?>> readUserData() async {
    try {
      final db = await instance.database;
      final result = await db.query(
        'Users',
        columns: ['token', 'userName', 'password', 'status', 'key', 'image'],
        where: 'key=?',
        whereArgs: ['1'],
      );
      return result[0];
    } catch (e) {
      debugPrint(e.toString());
    }
    return {};
  }

  Future<String> readBearerToken() async {
    try {
      final db = await instance.database;
      final result = await db.query(
        'Users',
        columns: ['token'],
        where: 'key=?',
        whereArgs: ['1'],
      );
      return result[0]['token'].toString();
    } catch (e) {
      debugPrint(e.toString());
    }
    return 'null';
  }

  Future<int> updateMode({
    required String token,
    required String userName,
    required String password,
    required String status,
    required String image,
  }) async {
    try {
      final db = await instance.database;
      await db.rawUpdate(
          'UPDATE Users SET token = ?, userName = ?, password = ?, status = ?, image = ?  WHERE key = ?',
          [token, userName, password, status, image, '1']);
      return 1;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  Future<int> updateLogout({
    required String token,
    required String userName,
    required String password,
    required String status,
    required String image,
  }) async {
    try {
      final db = await instance.database;
      await db.rawUpdate(
          'UPDATE Users SET token = ?, userName = ?, password = ?, status = ?, image = ?  WHERE key = ?',
          [
            'initial-token',
            'initial-userName',
            'initial-password',
            'logout',
            'initial-image',
            '1'
          ]);
      return 1;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }
}
