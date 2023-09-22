import 'package:app_exercise/components/user.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class MyDataBase {
  Database? _database;

  Future<void> open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'exercise.db');

    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Users (id INTEGER PRIMARY KEY, name TEXT, lastName TEXT, age INTEGER, gender TEXT)');
      //, dob TEXT, hn TEXT, password TEXT, note TEXT, minHr INTEGER, maxHr INTEGER, duration INTEGER)
    });

    _database = database;

    if (kDebugMode) {
      print('init database');
    }
  }

  Future<void> writeUser(User user) async {
    await _database?.transaction((txn) async {
      int id = await txn.rawInsert(
          'INSERT INTO Users(name, lastName, age, gender) VALUES("${user.name}", "${user.lastName}", ${user.age}, "${user.gender}" )');
          print(id);
      //dob, hn, password, note, minHr, maxHr, duration
      //"${user.dob}", "${user.hn}", "${user.password}", "${user.note}", ${user.minHr}, ${user.maxHr}, ${user.duration}
      if (kDebugMode) {
        print('write id : $id');
      }
    });
  }

  Future<List<User>> queryUser() async {
    List<Map> list = await _database!.rawQuery('SELECT * FROM Users');
    List<User> users = list.map((e) {
      var map = e as Map<String, dynamic>;
      return User.fromMap(map);
    }).toList();

    return users;
  }

  Future<User> getUser(name) async {
    List<Map> list =
        await _database!.rawQuery('SELECT * FROM Users WHERE name=$name');

    var map = list.last as Map<String, dynamic>;

    User user = User.fromMap(map);

    return user;
  }

  Future<void> deleteUser(User user) async {
    var count = await _database!
        .rawDelete('DELETE FROM Users WHERE name = ?', [(user.name)]);
    assert(count == 1);
  }
}
