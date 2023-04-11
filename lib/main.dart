import 'package:flutter/material.dart';

import 'views/homePage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
    ),
    home: MyApp(),
  ));
}
