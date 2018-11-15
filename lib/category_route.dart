import 'package:flutter/material.dart';
import 'package:unit_converter/backdrop.dart';
import 'package:unit_converter/category_tile.dart';
import 'package:unit_converter/unit_converter.dart';
import 'category.dart';
import 'unit.dart';

final _backgroundColor = Colors.green[100];

class CategoryRoute extends StatefulWidget {
  @override
  _CategoryRouteState createState() => _CategoryRouteState();
}

class _CategoryRouteState extends State<CategoryRoute> {
  final _categories = <Category>[];
  Category _defaultCategory;
  Category _currentCategory;
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

  static const _baseColors = <ColorSwatch>[
    ColorSwatch(0xFF6AB7A8, {
      'highlight': Color(0xFF6AB7A8),
      'splash': Color(0xFF0ABC9B),
    }),
    ColorSwatch(0xFFFFD28E, {
      'highlight': Color(0xFFFFD28E),
      'splash': Color(0xFFFFA41C),
    }),
    ColorSwatch(0xFFFFB7DE, {
      'highlight': Color(0xFFFFB7DE),
      'splash': Color(0xFFF94CBF),
    }),
    ColorSwatch(0xFF8899A8, {
      'highlight': Color(0xFF8899A8),
      'splash': Color(0xFFA9CAE8),
    }),
    ColorSwatch(0xFFEAD37E, {
      'highlight': Color(0xFFEAD37E),
      'splash': Color(0xFFFFE070),
    }),
    ColorSwatch(0xFF81A56F, {
      'highlight': Color(0xFF81A56F),
      'splash': Color(0xFF7CC159),
    }),
    ColorSwatch(0xFFD7C0E2, {
      'highlight': Color(0xFFD7C0E2),
      'splash': Color(0xFFCA90E5),
    }),
    ColorSwatch(0xFFCE9A9A, {
      'highlight': Color(0xFFCE9A9A),
      'splash': Color(0xFFF94D56),
      'error': Color(0xFF912D2D),
    }),
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _categoriesNames.length; i++) {
      var category = Category(
        color: _baseColors[i],
        name: _categoriesNames[i],
        iconLocation: Icons.cake,
        units: _retrieveUnits(_categoriesNames[i]),
      );
      if (i == 0) {
        _defaultCategory = category;
      }
      _categories.add(category);
    }
  }

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  Widget _buildCategories(Orientation deviceOrientation) {
    if(deviceOrientation==Orientation.portrait){
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => CategoryTile(
            category: _categories[index],
            onTap: _onCategoryTap,
          ),
      itemCount: _categories.length,
    );
  }
  else{
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3.0,
        children: _categories.map((Category category){
            return CategoryTile(
                category: category,
                onTap: _onCategoryTap,
            );
        }).toList(),
    );
  }
  }

  List<Unit> _retrieveUnits(String categoryName) {
    return List.generate(10, (int i) {
      i += 1;
      return Unit(name: '$categoryName Unit $i', conversion: i.toDouble());
    });
  }

  @override
  Widget build(BuildContext context) {
    final listView = Padding(
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 48.0,
      ),
      child: _buildCategories(MediaQuery.of(context).orientation),
    );

    return Backdrop(
      currentCategory:
          _currentCategory == null ? _defaultCategory : _currentCategory,
      frontPanel: _currentCategory == null
          ? UnitConverter(category: _defaultCategory)
          : UnitConverter(category: _currentCategory),
      backPanel: listView,
      frontTitle: Text('Unit Converter'),
      backTitle: Text('Select a Category'),
    );
  }
}
