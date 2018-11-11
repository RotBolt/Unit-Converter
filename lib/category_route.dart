import 'package:flutter/material.dart';
import 'category.dart';

final _backgroundColor = Colors.green[100];

class CategoryRoute extends StatelessWidget {
  static const _categoriesNames = [
    "Length",
    "Area",
    "Volume",
    "Mass",
    "Time",
    "Digital Storage",
    "Energy",
    "Currency"
  ];

  static const _categoriesColors = [
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];
  ListView _buildCategories(List<Widget> categories) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => categories[index],
      itemCount: categories.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = <Category>[];

    for (int i = 0; i < _categoriesNames.length; i++) {
      categories.add(Category(
        color: _categoriesColors[i],
        text: _categoriesNames[i],
        icon: Icons.cake,
      ));
    }
    final listView = Container(
      color: _backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: _buildCategories(categories),
    );

    final appBar = AppBar(
      elevation: 0.0,
      title: Text(
        "Unit Converter",
        style: TextStyle(color: Colors.black, fontSize: 30.0),
      ),
      centerTitle: true,
      backgroundColor: _backgroundColor,
    );

    return Scaffold(
      appBar: appBar,
      body: listView,
    );
  }
}
