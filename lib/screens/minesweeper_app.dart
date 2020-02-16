import 'package:flutter/material.dart';
import '../components/board_widget.dart';
import '../components/result_widget.dart';
import '../models/field.dart';
import '../models/board.dart';

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
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          gameWon: null,
          onReset: _reset,
        ),
        body: Container(
          child: BoardWidget(
            board: Board(
              rows: 10,
              columns: 10,
              bombs: 5,
            ),
            onOpen: _open,
            onToggleFlag: _toggleFlag,
          ),
        ),
      ),
    );
  }
}
