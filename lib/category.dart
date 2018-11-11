import 'package:flutter/material.dart';

final _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

class Category extends StatelessWidget {
  final IconData icon;
  final String text;
  final ColorSwatch color;

  Category(
      {Key key, @required this.icon, @required this.text, @required this.color})
      : assert(icon != null),
        assert(text != null),
        assert(color != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: color,
          splashColor: color,
          onTap: () {
            print("Ouuch !! I was Tapped");
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    icon,
                    size: 60.0,
                  ),
                ),
                Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24.0),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
