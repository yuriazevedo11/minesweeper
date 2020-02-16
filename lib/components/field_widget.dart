import 'package:flutter/material.dart';
import '../models/field.dart';

class FieldWidget extends StatelessWidget {
  final Field field;
  final void Function(Field) onOpen;
  final void Function(Field) onToggleFlag;

  FieldWidget({
    @required this.field,
    @required this.onOpen,
    @required this.onToggleFlag,
  });

  Widget _getContent() {
    int bombsAround = field.bombsAround;

    if (field.opened && field.hasBomb && field.exploded) {
      return Image.asset('assets/images/bomb_0.jpeg');
    } else if (field.opened && field.hasBomb) {
      return Image.asset('assets/images/bomb_1.jpeg');
    } else if (field.opened) {
      return Image.asset('assets/images/opened_$bombsAround.jpeg');
    } else if (field.flagged) {
      return Image.asset('assets/images/flag.jpeg');
    }

    return Image.asset('assets/images/closed.jpeg');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onToggleFlag(field),
      child: _getContent(),
    );
  }
}
