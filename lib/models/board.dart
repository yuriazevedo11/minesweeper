import 'dart:math';
import 'package:flutter/foundation.dart';
import 'bomb_exception.dart';
import 'field.dart';

class Board {
  final int rows;
  final int columns;
  final int bombs;
  final List<Field> _fields = [];

  Board({
    @required this.rows,
    @required this.columns,
    @required this.bombs,
  }) {
    _createFields();
    _relateAdjacents();
    _sortBombs();
  }

  void reset() {
    _fields.forEach((field) => field.reset());
    _sortBombs();
  }

  void showBombs() {
    _fields.forEach((field) => field.showBomb());
  }

  void showFlags() {
    _fields.forEach((field) => field.showFlag());
  }

  void _createFields() {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < columns; c++) {
        _fields.add(Field(row: r, column: c));
      }
    }
  }

  void _relateAdjacents() {
    for (var field in _fields) {
      for (var adjacent in _fields) {
        field.addAdjacent(adjacent);
      }
    }
  }

  void _sortBombs() {
    int sorted = 0;

    if (bombs > rows * columns) {
      throw BombException();
    }

    while (sorted < bombs) {
      int i = Random().nextInt(_fields.length);
      var currentField = _fields[i];

      if (!currentField.hasBomb) {
        currentField.addBomb();
        sorted++;
      }
    }
  }

  List<Field> get fields {
    return _fields;
  }

  bool get resolved {
    return _fields.every((field) => field.resolved);
  }
}
