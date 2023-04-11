import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:project_final/Modals/product_modal/productModalClass.dart';
import 'package:project_final/views/res.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../Modals/productDB.dart';
import '../Modals/productDB.dart';

class DBHelper {
  DBHelper._();

  static final dbHelper = DBHelper._();

  final String databaseName = "food9.db";
  final String tableName = "pizza3";
  final String colId = "Id";
  final String colName = "Name";
  final String colDetails = "Details";
  final String colCategory = "Category";
  final String colPrice = "Price";
  final String colQuantity = "Quantity";
  final String colImage = "Image";

  Database? database;

  Future<void> initDB() async {
    String df = await getDatabasesPath();
    String dm = await getDatabasesPath();
    String dbpath = await getDatabasesPath();
    String path = join(df, databaseName);

    database = await openDatabase(path, version: 1,
        onCreate: (Database database, int version) async {
      await database.execute(
          "CREATE TABLE IF NOT EXISTS $tableName($colId INTEGER, $colName TEXT, $colCategory TEXT, $colDetails TEXT, $colQuantity INTEGER, $colPrice INTEGER, $colImage TEXT);");
    });
  }

  Future<void> insertRecord() async {
    initDB();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isInserted = prefs.getBool('tableName5') ?? false;

    if (isInserted == false) {
      for (int i = 0; i < AllProducts.length; i++) {
        products data = AllProducts[i];
        String query =
            "INSERT INTO $tableName($colId,$colName, $colCategory, $colDetails, $colQuantity, $colPrice, $colImage) VALUES(?, ?, ?, ?, ?, ?, ?);";
        List args = [
          data.id,
          data.name,
          data.category,
          data.description,
          data.quantity,
          data.price,
          data.image,
        ];
        await database!.rawInsert(query, args);
      }
      prefs.setBool('tableName5', true);
      print('--------------------------');
      print('record Inserted');
      print('--------------------------');
    }
  }

  Future<List<productDB>> getAllRecode() async {
    await insertRecord();
    String query = "SELECT * FROM $tableName";

    List<Map<String, dynamic>> data = await database!.rawQuery(query);
    List<productDB> allData =
        data.map((e) => productDB.fromMap(data: e)).toList();
    return allData;
  }

  Future<void> updateRecord({required int id, required int quantity}) async {
    await initDB();

    int? a = await database?.rawUpdate(
        "Update $tableName SET $colQuantity= ? WHERE $colId = ?",
        [quantity, id]);
  }
}
