import 'package:flutter/material.dart';
import '../components/board_widget.dart';
import '../components/result_widget.dart';
import '../models/field.dart';
import '../models/board.dart';
import '../models/explosion_exception.dart';

class MinesweeperApp extends StatefulWidget {
  @override
  _MinesweeperAppState createState() => _MinesweeperAppState();
}

class _MinesweeperAppState extends State<MinesweeperApp> {
  bool _gameWon;
  Board _board;

  void _reset() {
    setState(() {
      _gameWon = null;
      _board.reset();
    });
  }

  void _open(Field field) {
    if (_gameWon != null) {
      return null;
    }

    setState(() {
      try {
        field.open();
        if (_board.resolved) {
          _gameWon = true;
        }
      } on ExplosionException {
        _gameWon = false;
        _board.showBombs();
      }
    });
  }

  void _toggleFlag(Field field) {
    if (_gameWon != null) {
      return null;
    }

    setState(() {
      field.toggleFlag();
      if (_board.resolved) {
        _gameWon = true;
      }
    });
  }

  Board _createBoard(double width, double height) {
    if (_board == null) {
      int columns = 12;
      double fieldSize = width / columns;
      int rows = (height / fieldSize).floor();

      _board = Board(
        rows: rows,
        columns: columns,
        bombs: 20,
      );
    }

    return _board;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          gameWon: _gameWon,
          onReset: _reset,
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              return BoardWidget(
                board: _createBoard(
                  constraints.maxWidth,
                  constraints.maxHeight,
                ),
                onOpen: _open,
                onToggleFlag: _toggleFlag,
              );
            },
          ),
        ),
      ),
    );
  }
}
