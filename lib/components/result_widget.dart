import 'package:flutter/material.dart';
import '../components/counter_widget.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool gameWon;
  final Function onReset;
  final int elapsedTime;
  final int flags;

  ResultWidget({
    @required this.gameWon,
    @required this.onReset,
    @required this.elapsedTime,
    @required this.flags,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CounterWidget(
                count: flags,
              ),
              CircleAvatar(
                backgroundColor: _getColor(),
                child: IconButton(
                  padding: EdgeInsets.all(2),
                  icon: Icon(
                    _getIcon(),
                    color: Colors.black,
                    size: 35,
                  ),
                  onPressed: onReset,
                ),
              ),
              CounterWidget(
                count: elapsedTime,
              ),
            ],
          ),
          padding: EdgeInsets.all(10),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
