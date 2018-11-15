import 'package:flutter/material.dart';
import 'unit.dart';
import 'package:meta/meta.dart';

const _padding = EdgeInsets.all(16.0);

class ConverterRoute extends StatefulWidget {
  final String title;
  final Color color;
  final List<Unit> units;

  ConverterRoute(
      {@required this.title, @required this.color, @required this.units})
      : assert(title != null),
        assert(color != null),
        assert(units != null);

  @override
  _ConverterRouteState createState() =>
      _ConverterRouteState(color: color, title: title, units: units);
}

class _ConverterRouteState extends State<ConverterRoute> {
  Unit _fromValue;
  Unit _toValue;
  double _inputValue;
  String _convertedValue = '';
  final String title;
  final Color color;
  final List<Unit> units;
  bool _showValidationError = false;
  List<DropdownMenuItem> _unitMenuItems;

  @override
  void initState() {
    super.initState();
    _createDropdownMenuItems();
    _setDefaults();
  }

  _ConverterRouteState(
      {@required this.title, @required this.color, @required this.units})
      : assert(title != null),
        assert(color != null),
        assert(units != null);

  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);

    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;

      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }

    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }

    return outputNum;
  }

  void _updateConversion() {
    setState(() {
      _convertedValue =
          _format(_inputValue * (_toValue.conversion / _fromValue.conversion));
    });
  }

  void _updateInputValue(String input) {
    setState(() {
      if (input == null || input == '') {
        _convertedValue = '';
      } else {
        try {
          final inputDouble = double.parse(input);
          _inputValue = inputDouble;
          _showValidationError = false;
          _updateConversion();
        } on Exception catch (e) {
          print("Error : $e");
          _showValidationError = true;
        }
      }
    });
  }

  void _setDefaults() {
    setState(() {
      _fromValue = widget.units[0];
      _toValue = widget.units[1];
    });
  }

  Unit _getUnit(String unitName) {
    return widget.units.firstWhere(
      (Unit unit) {
        return unit.name == unitName;
      },
      orElse: null,
    );
  }

  void _updateFromConversion(dynamic unitName) {
    setState(() {
      _fromValue = _getUnit(unitName);
    });
    // to change the input according to current from conversion unit
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  void _updateToConversion(dynamic unitName) {
    setState(() {
      _toValue = _getUnit(unitName);
    });
    // to change the input according to current from conversion unit
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  void _createDropdownMenuItems() {
    var newItems = <DropdownMenuItem>[];
    for (var unit in widget.units) {
      newItems.add(DropdownMenuItem(
        value: unit.name,
        child: Container(
          child: Text(
            unit.name,
            softWrap: true,
          ),
        ),
      ));
    }
    setState(() {
      _unitMenuItems = newItems;
    });
  }

  Widget _createDropDown(String currentValue, ValueChanged<dynamic> onChnaged) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border.all(color: Colors.grey[400], width: 1.0)),
      child: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.grey[50]),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                onChanged: onChnaged,
                value: currentValue,
                items: _unitMenuItems,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inputBox = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            style: Theme.of(context).textTheme.display1,
            decoration: InputDecoration(
                labelStyle: Theme.of(context).textTheme.display1,
                labelText: "Input",
                errorText:
                    _showValidationError ? "Invalid Number Entered" : null,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0))),
            keyboardType: TextInputType.number,
            onChanged: _updateInputValue,
          ),
          _createDropDown(_fromValue.name, _updateFromConversion)
        ],
    
      ),
    );

    final arrows = RotatedBox(
      quarterTurns: 1,
      child: Icon(
        Icons.compare_arrows,
        size: 40.0,
      ),
    );
    final outputBox = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InputDecorator(
            child: Text(
              _convertedValue,
              style: Theme.of(context).textTheme.display1,
            ),
            decoration: InputDecoration(
                labelText: "Output",
                labelStyle: Theme.of(context).textTheme.display1,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0))),
          ),
          _createDropDown(_toValue.name, _updateToConversion),
        ],
      ),
    );

    final converter = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[inputBox, arrows, outputBox],
    );
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
      body: Padding(
        padding: _padding,
        child: converter,
      ),
    );
  }
}
