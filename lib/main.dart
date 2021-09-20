import 'dart:math';

import 'package:dart_numerics/dart_numerics.dart';
import 'package:flutter/material.dart';
import './select_player.dart';
import './grid_builder.dart';
import './restart.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> grid = ['', '', '', '', '', '', '', '', ''];
  var winner = '';
  var currPlayer = 'X';
  String human = 'X';
  String ai = 'O';
  var gameOver = false;

  void nextMove(int index) {
    // if current player = human
    // // insertMove()
    // else // current player = ai
    // aiMove()
    if (grid[index] != '' || gameOver) {
      return;
    } else {
      aiMove();
      humanMove(index);

      winner = checkGameOver();
      if (winner != '') {
        print('winner is $winner');
        setState(() {
          gameOver = true;
        });
      }
    }
  }

  void humanMove(int index) {
    setState(() {
      print('human set state');
      grid[index] = human;
    });
    currPlayer = ai;
  }

  void aiMove() {
    print('in here');
    var bestScore = int64MinValue;
    int bestIndex = 0;
    for (int i = 0; i < grid.length; i++) {
      if (grid[i] == '') {
        grid[i] = ai;
        var score = minimax(grid, 0, false);
        grid[i] = '';
        if (score > bestScore) {
          bestScore = score;
          bestIndex = i;
        }
      }
    }

    setState(() {
      print(bestIndex);
      grid[bestIndex] = ai;
      print(grid.toString());
    });
    currPlayer = human;
  }

  int minimax(List<String> gameGrid, int depth, bool isMax) {
    winner = checkGameOver();

    if (winner == human) {
      return -10;
    } else if (winner == ai) {
      return 10;
    } else if (winner == 'tie') {
      return 0;
    }

    if (isMax) {
      var maxVal = int64MinValue;
      var gridCopy = [...gameGrid];
      for (int i = 0; i < gridCopy.length; i++) {
        if (gridCopy[i] == '') {
          gridCopy[i] = ai;
          var val = minimax(gridCopy, 0, false);
          gridCopy[i] = '';
          maxVal = max(maxVal, val);
        }
      }
      return maxVal;
    } else {
      var minVal = int64MaxValue;
      var gridCopy = [...gameGrid];
      for (int i = 0; i < gridCopy.length; i++) {
        if (gridCopy[i] == '') {
          gridCopy[i] = human;
          var val = minimax(gridCopy, 0, true);
          gridCopy[i] = '';
          minVal = min(minVal, val);
        }
      }
      return minVal;
    }
  }

  void startGame(String player) {
    human = player;
    if (human == 'X') {
      ai = 'O';
    } else {
      ai = 'X';
    }

    setState(() {
      currPlayer = player;
    });
  }

  String checkGameOver() {
    // check vertical
    // 0 3 6
    // 1 4 7
    // 2 5 8
    for (int i = 0; i < 3; i++) {
      var colMove1 = grid[i];
      var colMove2 = grid[i + 3];
      var colMove3 = grid[i + 6];

      if (colMove1 == human && colMove2 == human && colMove3 == human) {
        return human;
      }

      if (colMove1 == ai && colMove2 == ai && colMove3 == ai) {
        return ai;
      }
    }

    //check horizontal
    // 0 1 2
    // 3 4 5
    // 6 7 8
    for (int i = 0; i <= 6; i += 3) {
      var rowMove1 = grid[i];
      var rowMove2 = grid[i + 1];
      var rowMove3 = grid[i + 2];

      if (rowMove1 == human && rowMove2 == human && rowMove3 == human) {
        return human;
      }

      if (rowMove1 == ai && rowMove2 == ai && rowMove3 == ai) {
        return ai;
      }
    }

    // check diagonal
    // 0 4 8
    // 2 4 6
    var d1 = grid[0];
    var d2 = grid[4];
    var d3 = grid[8];

    var d11 = grid[2];
    var d22 = grid[4];
    var d33 = grid[6];

    if (d1 == human && d2 == human && d3 == human) {
      return human;
    }

    if (d11 == human && d22 == human && d33 == human) {
      return human;
    }

    if (d1 == ai && d2 == ai && d3 == ai) {
      return ai;
    }

    if (d11 == ai && d22 == ai && d33 == ai) {
      return ai;
    }

    // tie
    for (int i = 0; i < grid.length; i++) {
      if (grid[i] == '') {
        return '';
      }
    }
    return 'tie';
  }

  void restartGame() {
    for (int i = 0; i < grid.length; i++) {
      grid[i] = '';
    }
    winner = '';

    setState(() {
      currPlayer = '';
      gameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: const Text('Unbeatable Tic Tac Toe'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            currPlayer == ''
                ? SelectPlayer(startGame)
                : GridBuilder(
                    nextMove,
                    grid,
                    currPlayer,
                  ),
            gameOver
                ? Restart(
                    winner,
                    restartGame,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
