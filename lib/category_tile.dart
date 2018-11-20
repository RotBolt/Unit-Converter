import 'package:flutter/material.dart';
import 'package:unit_converter/category.dart';
import 'package:unit_converter/unit_converter.dart';

final _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

class CategoryTile extends StatelessWidget {
  final Category category;
  final ValueChanged<Category> onTap;

  const CategoryTile({Key key, this.category, this.onTap})
      : assert(category != null),
        super(key: key);

  // Used Earlier when no backdrop
  void _navigateToConverter(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return Scaffold(
          body: UnitConverter(category: category),

          // This prevents the attempt to resize the screen when the keyboard
          // is opened
          resizeToAvoidBottomPadding: false,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: onTap == null
            ? Color.fromRGBO(50, 50, 50, 0.2)
            : Colors.transparent,
        child: Container(
          height: _rowHeight,
          child: InkWell(
            borderRadius: _borderRadius,
            highlightColor: category.color['highlight'],
            splashColor: category.color['splash'],
            onTap: onTap == null ? null : () => onTap(category),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Image.asset(category.iconLocation)),
                  Center(
                    child: Text(
                      category.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
