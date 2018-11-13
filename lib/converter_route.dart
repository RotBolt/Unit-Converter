import 'package:flutter/material.dart';
import 'unit.dart';
import 'package:meta/meta.dart';

class ConverterRoute extends StatelessWidget {
  final String title;
  final Color color;
  final List<Unit> units;

  ConverterRoute(
      {@required this.title, @required this.color, @required this.units})
      : assert(title != null),
        assert(color != null),
        assert(units != null);

  @override
  Widget build(BuildContext context) {
    final unitWidgets = units.map((Unit unit) {
      return Container(
        color: color,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              unit.name,
              style: Theme.of(context).textTheme.headline,
            ),
            Text(
              'Conversion : ${unit.conversion}',
              style: Theme.of(context).textTheme.subhead,
            )
          ],
        ),
      );
    }).toList();

    final appBar = AppBar(
      elevation: 1.0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.display1,
      ),
      backgroundColor: color,
      centerTitle: true,
    );
    return Scaffold(
      appBar: appBar,
      body: ListView(
        children: unitWidgets,
      ),
    );
  }
}
