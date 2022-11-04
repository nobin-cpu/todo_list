import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/models/contacts.dart';

class DBHelper {
  static Future<Database> initDB() async {
    var dbpath = await getDatabasesPath();
    String path = join(dbpath, 'database.db');
    return openDatabase(path, version: 1, onCreate: _oncreate);
  }

  static Future _oncreate(Database db, int version) async {
    final sql =
        '''CREATE TABLE contacts(id INTEGER PRIMARY KEY,name TEXT,address TEXT)''';
    await db.execute(sql);
  }

  static Future<int> openContact(Contacts contacts) async {
    Database db = await DBHelper.initDB();
    return await db.insert('contacts', contacts.toJson());
  }

  static Future<List<Contacts>> readContacts() async {
    Database db = await DBHelper.initDB();
    var contacts = await db.query('contacts', orderBy: 'name');
    List<Contacts> contactList = contacts.isNotEmpty
        ? contacts.map((details) => Contacts.fromJson(details)).toList()
        : [];
    return contactList;
  }

  static Future<int> updateContacts(Contacts contact) async {
    Database db = await DBHelper.initDB();
    //update the existing contact
    //according to its id
    return await db.update('contacts', contact.toJson(),
        where: 'id = ?', whereArgs: [contact.id]);
  }

  //build delete function
  static Future<int> deleteContacts(int id) async {
    Database db = await DBHelper.initDB();
    return await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }
}
