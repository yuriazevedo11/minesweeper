import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
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
  static int _bombs = 30;
  bool _gameWon;
  Board _board;
  int _flags = _bombs;
  int _elapsedTime = 0;
  bool _gameStarted = false;

  void _startTimer() {
    setState(() {
      _gameStarted = true;
    });

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_gameWon != null || _gameStarted == false || _elapsedTime == 999) {
        timer.cancel();
      } else {
        setState(() {
          _elapsedTime++;
        });
      }
    });
  }

  void _reset() {
    setState(() {
      _gameWon = null;
      _board.reset();
      _flags = _bombs;
      _elapsedTime = 0;
      _gameStarted = false;
    });
  }

  void _vibrate() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
  }

  void _open(Field field) async {
    if (_gameWon != null) {
      return;
    }

    if (!_gameStarted) {
      _startTimer();
    }

    setState(() {
      try {
        field.open();
        if (_board.resolved) {
          _gameWon = true;

          if (_flags != 0) {
            _board.showFlags();
            setState(() {
              _flags = 0;
            });
          }
        }
      } on ExplosionException {
        _gameWon = false;
        _board.showBombs();
        _vibrate();
      }
    });
  }

  void _toggleFlag(Field field) {
    if (_gameWon != null) {
      return null;
    }

    if (!_gameStarted) {
      _startTimer();
    }

    if ((!field.flagged && _flags == 0) || field.opened) {
      return;
    }

    setState(() {
      field.toggleFlag();

      if (field.flagged) {
        _flags--;
      } else {
        _flags++;
      }

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
        bombs: _bombs,
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
          elapsedTime: _elapsedTime,
          flags: _flags,
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
