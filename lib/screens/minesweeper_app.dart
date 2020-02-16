import 'package:flutter/material.dart';
import '../components/result_widget.dart';

class MinesweeperApp extends StatelessWidget {
  _reset() {
    print('Resetting game...');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          gameWon: null,
          onReset: _reset,
        ),
        body: Container(
          child: Text('Board'),
        ),
      ),
    );
  }
}
