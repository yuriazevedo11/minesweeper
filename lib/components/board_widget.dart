import 'package:flutter/material.dart';
import '../components/field_widget.dart';
import '../models/board.dart';
import '../models/field.dart';

class BoardWidget extends StatelessWidget {
  final Board board;
  final void Function(Field) onOpen;
  final void Function(Field) onToggleFlag;

  BoardWidget({
    @required this.board,
    @required this.onOpen,
    @required this.onToggleFlag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: board.columns,
        children: board.fields
            .map(
              (field) => FieldWidget(
                field: field,
                onOpen: onOpen,
                onToggleFlag: onToggleFlag,
              ),
            )
            .toList(),
      ),
    );
  }
}
