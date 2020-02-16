import 'package:flutter/foundation.dart';
import 'explosion_exception.dart';

class Field {
  final int row;
  final int column;
  final List<Field> adjacents = [];

  bool _opened = false;
  bool _flagged = false;
  bool _hasBomb = false;
  bool _exploded = false;

  Field({
    @required this.row,
    @required this.column,
  });

  void addAdjacent(Field adjacent) {
    final rowDelta = (row - adjacent.row).abs();
    final columnDelta = (column - adjacent.column).abs();

    if (rowDelta == 0 && columnDelta == 0) {
      return;
    }

    if (rowDelta <= 1 && columnDelta <= 1) {
      adjacents.add(adjacent);
    }
  }

  void open() {
    if (opened || flagged) {
      return;
    }

    _opened = true;

    if (hasBomb) {
      _exploded = true;
      throw ExplosionException();
    }

    if (safeAdjacents) {
      adjacents.forEach((adjacent) => adjacent.open());
    }
  }

  void showBomb() {
    if (hasBomb) {
      _opened = true;
    }
  }

  void addBomb() {
    _hasBomb = true;
  }

  void toggleFlag() {
    _flagged = !_flagged;
  }

  void reset() {
    _opened = false;
    _flagged = false;
    _hasBomb = false;
    _exploded = false;
  }

  bool get opened {
    return _opened;
  }

  bool get flagged {
    return _flagged;
  }

  bool get hasBomb {
    return _hasBomb;
  }

  bool get exploded {
    return _exploded;
  }

  bool get safeAdjacents {
    return adjacents.every((adjacent) => !adjacent.hasBomb);
  }

  bool get resolved {
    bool resolution1 = hasBomb && flagged;
    bool resolution2 = !hasBomb && opened;

    return resolution1 || resolution2;
  }

  int get bombsAround {
    return adjacents.where((adjacent) => adjacent.hasBomb).length;
  }
}
