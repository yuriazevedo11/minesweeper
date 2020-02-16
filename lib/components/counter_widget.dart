import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final int count;

  CounterWidget({
    @required this.count,
  });

  String get _stringTimer {
    return count.toString().padLeft(3, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      padding: EdgeInsets.fromLTRB(5, 5, 2, 0),
      child: Text(
        _stringTimer,
        style: TextStyle(
          color: Colors.red[500],
          fontSize: 32,
          fontFamily: 'PressStart2P',
        ),
      ),
    );
  }
}
