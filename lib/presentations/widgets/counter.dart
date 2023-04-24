import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';

class CounterView extends StatefulWidget {
  final int? initNumber;
  final Function(int)? counterCallback;
  final Function? increaseCallback;
  final Function? decreaseCallback;
  final int? minNumber;
  static int maxCap = 3;
  CounterView({
    this.initNumber,
    this.counterCallback,
    this.increaseCallback,
    this.decreaseCallback,
    this.minNumber,
  });
  @override
  _CounterViewState createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  late int _currentCount;
  late Function _counterCallback;
  late Function _increaseCallback;
  late Function _decreaseCallback;
  late int _minNumber;

  @override
  void initState() {
    _currentCount = widget.initNumber ?? 1;
    _counterCallback = widget.counterCallback ?? (int number) {};
    _increaseCallback = widget.increaseCallback ?? () {};
    _decreaseCallback = widget.decreaseCallback ?? () {};
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
      CounterView.maxCap = _currentCount;
      _counterCallback(_currentCount);
      _increaseCallback();
    });
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > _minNumber) {
        _currentCount--;
        CounterView.maxCap = _currentCount;
        _counterCallback(_currentCount);
        _decreaseCallback();
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
