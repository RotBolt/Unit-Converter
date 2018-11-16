import 'package:flutter/material.dart';
import 'category_route.dart';

void main() => runApp(UnitConverterApp());

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Unit Converter",
      theme: ThemeData(
          fontFamily: 'Raleway',
          textTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: Colors.black, displayColor: Colors.grey[500]),
          primaryColor: Colors.grey[500],
          textSelectionColor: Colors.green[500]),
      home: CategoryRoute(),
    );
  }
}
