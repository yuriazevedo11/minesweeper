import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool gameWon;
  final Function onReset;

  ResultWidget({
    @required this.gameWon,
    @required this.onReset,
  });

  Color _getColor() {
    if (gameWon == null) {
      return Colors.yellow;
    }

    if (gameWon) {
      return Colors.green[300];
    }

    return Colors.red;
  }

  IconData _getIcon() {
    if (gameWon == null) {
      return Icons.sentiment_satisfied;
    }

    if (gameWon) {
      return Icons.sentiment_very_satisfied;
    }

    return Icons.sentiment_very_dissatisfied;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: _getColor(),
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                _getIcon(),
                color: Colors.black,
                size: 35,
              ),
              onPressed: onReset,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
