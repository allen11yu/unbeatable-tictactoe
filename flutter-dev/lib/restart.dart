import 'package:flutter/material.dart';

class Restart extends StatelessWidget {
  final String winner;
  final Function resetHandler;

  Restart(this.winner, this.resetHandler);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        winner == 'tie' ? const Text('Game is tied!') : const Text('AI wins!'),
        ElevatedButton(
          onPressed: resetHandler,
          child: const Text('Restart'),
        ),
      ],
    );
  }
}
