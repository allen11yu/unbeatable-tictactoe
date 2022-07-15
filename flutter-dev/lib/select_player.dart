import 'package:flutter/material.dart';

class SelectPlayer extends StatelessWidget {
  final Function startGame;

  SelectPlayer(this.startGame);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('X or O today?'),
        Container(
          margin: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () {
                  startGame('X');
                },
                child: const Text(
                  'X',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () {
                  startGame('O');
                },
                child: const Text(
                  'O',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
