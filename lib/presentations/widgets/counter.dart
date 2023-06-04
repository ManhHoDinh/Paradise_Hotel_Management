import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';

class CounterView extends StatefulWidget {
  final int? initNumber;
  final Function(int)? counterCallback;
  final int? minNumber;
  static int numberOfGuestNoSurcharge = 2;
  static int maxCap = 3;
  final int type; // 0 : max cap || else numberOfGuestNoSurcharge
  CounterView(
      {this.initNumber,
      this.counterCallback,
      this.minNumber,
      required this.type});
  @override
  _CounterViewState createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  late int _currentCount;
  late int _minNumber;

  @override
  void initState() {
    _currentCount = widget.initNumber ?? 1;
    _minNumber = widget.minNumber ?? 0;
    CounterView.maxCap = _currentCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: ColorPalette.detailBorder)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _createIncrementDicrementButton(Icons.remove, () => _dicrement()),
          Text(_currentCount.toString()),
          _createIncrementDicrementButton(Icons.add, () => _increment()),
        ],
      ),
    );
  }

  void _increment() {
    setState(() {
      _currentCount++;
      if (widget.type == 0)
        CounterView.maxCap = _currentCount;
      else
        CounterView.numberOfGuestNoSurcharge = _currentCount;
    });
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > _minNumber) {
        _currentCount--;
        if (widget.type == 0)
          CounterView.maxCap = _currentCount;
        else
          CounterView.numberOfGuestNoSurcharge = _currentCount;
      }
    });
  }

  Widget _createIncrementDicrementButton(IconData icon, onPressed) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
      onPressed: onPressed,
      elevation: 2.0,
      child: Icon(
        icon,
        color: ColorPalette.primaryColor,
        size: 12.0,
      ),
      shape: CircleBorder(),
    );
  }
}

Widget _createIncrementDicrementButton(IconData icon, onPressed) {
  return RawMaterialButton(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
    onPressed: onPressed,
    elevation: 2.0,
    child: Icon(
      icon,
      color: ColorPalette.primaryColor,
      size: 12.0,
    ),
    shape: CircleBorder(),
  );
}
