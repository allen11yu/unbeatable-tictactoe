import 'package:flutter/material.dart';

class Restart extends StatelessWidget {
  final String winner;
  final Function resetHandler;

  Restart(this.winner, this.resetHandler);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        winner == 'tie' ? Text('Game is tied!') : Text('Winner is $winner'),
        ElevatedButton(
          onPressed: resetHandler,
          child: const Text('Restart'),
        ),
      ],
    );
  }
}
