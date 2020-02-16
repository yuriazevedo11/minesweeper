import 'package:flutter/material.dart';

class MinesweeperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Minesweeper'),
        ),
        body: Container(
          child: Text('Board'),
        ),
      ),
    );
  }
}
