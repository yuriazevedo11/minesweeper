import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper/models/board.dart';

main() {
  group('Board', () {
    test('Win game', () {
      Board board = Board(
        rows: 2,
        columns: 2,
        bombs: 0,
      );

      board.fields[0].addBomb();
      board.fields[3].addBomb();

      board.fields[0].toggleFlag();
      board.fields[1].open();
      board.fields[2].open();
      board.fields[3].toggleFlag();

      expect(board.resolved, isTrue);
    });

    test('Quantity of bombs must be lower than number of fields', () {
      expect(
        () => Board(
          rows: 2,
          columns: 2,
          bombs: 5,
        ),
        throwsException,
      );
    });
  });
}
