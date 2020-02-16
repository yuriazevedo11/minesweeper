import 'package:flutter/material.dart';
import '../components/result_widget.dart';
import '../components/field_widget.dart';
import '../models/field.dart';

class MinesweeperApp extends StatelessWidget {
  void _reset() {
    print('Resetting game...');
  }

  void _open(Field field) {
    print('Openning field...');
  }

  void _toggleFlag(Field field) {
    print('Toggling flag on field...');
  }

  @override
  Widget build(BuildContext context) {
    Field field = Field(row: 0, column: 0);

    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          gameWon: null,
          onReset: _reset,
        ),
        body: Container(
          child: FieldWidget(
            field: field,
            onOpen: _open,
            onToggleFlag: _toggleFlag,
          ),
        ),
      ),
    );
  }
}
