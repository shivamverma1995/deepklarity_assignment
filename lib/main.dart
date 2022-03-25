import 'dart:io';

import 'package:deepklarity_assignment/model/productListModel.dart';
import 'package:deepklarity_assignment/second_page.dart';
import 'package:deepklarity_assignment/view/wait_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      title: "DeepKlarity Assignment",
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DeepKlarity Assignment"),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return WaitDialog();
                  });
              loadJSONIntoDatabase().then((_) {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return SecondPage();
                }));
              });
            },
            child: Text("Click Here"),
          ),
        ));
  }

  Future<void> loadJSONIntoDatabase() async {
    String str = await rootBundle.loadString('assets/Products.txt');
    ProductListModel productListModel = ProductListModel.fromJson(str);
    List<Product> products = productListModel.products;
    Future<Database> database = initDB();
    for (int i = 0; i < products.length; i++) {
      insertProductIntoDB(database, products[i]);
    }
  }
}
