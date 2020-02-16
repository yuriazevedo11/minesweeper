import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper/models/field.dart';

main() {
  group('Field', () {
    test('Open Field with explosion', () {
      Field f = Field(row: 0, column: 0);
      f.addBomb();

      expect(f.open, throwsException);
    });

    test('Open Field without explosion', () {
      Field f = Field(row: 0, column: 0);
      f.open();

      expect(f.opened, isTrue);
    });

    test('Add adjacent Field', () {
      Field f1 = Field(row: 3, column: 3);
      Field f2 = Field(row: 3, column: 4);
      Field f3 = Field(row: 2, column: 2);
      Field f4 = Field(row: 4, column: 4);
      f1.addAdjacent(f2);
      f1.addAdjacent(f3);
      f1.addAdjacent(f4);

      expect(f1.adjacents.length, 3);
    });

    test('Add non adjacent Field', () {
      Field f1 = Field(row: 0, column: 0);
      Field f2 = Field(row: 1, column: 3);
      f1.addAdjacent(f2);

      expect(f1.adjacents.isEmpty, isTrue);
    });

    test('Field has bombs around', () {
      Field f1 = Field(row: 3, column: 3);
      Field f2 = Field(row: 3, column: 4);
      Field f3 = Field(row: 2, column: 2);
      Field f4 = Field(row: 4, column: 4);
      f2.addBomb();
      f4.addBomb();
      f1.addAdjacent(f2);
      f1.addAdjacent(f3);
      f1.addAdjacent(f4);

      expect(f1.bombsAround, 2);
    });

    test('Opens safe adjacents recursively', () {
      Field f1 = Field(row: 3, column: 3);
      Field f2 = Field(row: 3, column: 4);
      Field f3 = Field(row: 2, column: 2);
      Field f4 = Field(row: 4, column: 4);
      f1.addAdjacent(f2);
      f1.addAdjacent(f3);
      f1.addAdjacent(f4);
      f1.open();

      expect(f2.opened, isTrue);
      expect(f3.opened, isTrue);
      expect(f4.opened, isTrue);
    });
  });
}
