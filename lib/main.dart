import 'dart:math';

import 'package:dart_numerics/dart_numerics.dart';
import 'package:flutter/material.dart';
import './select_player.dart';
import './grid_builder.dart';
import './restart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> grid = ['', '', '', '', '', '', '', '', ''];
  var winner = '';
  var currPlayer = '';
  late String human;
  late String ai;
  var gameOver = false;
  var humanFirst = false;

  void nextMove(int index) {
    if (grid[index] != '' || gameOver) {
      return;
    } else {
      humanFirst = true;
      setState(() {
        humanMove(index);

        int aiIndex = aiMove();
        if (aiIndex != -1) {
          grid[aiIndex] = ai;
        }

        winner = checkGameOver();
        if (winner != '') {
          gameOver = true;
        }
      });
    }
  }

  // return -1 when no more avaiable index.
  int nextAvailableIndex() {
    for (int i = 0; i < grid.length; i++) {
      if (grid[i] == '') {
        return i;
      }
    }
    return -1;
  }

  void humanMove(int index) {
    grid[index] = human;
    currPlayer = ai;
  }

  // return the index and update state in next move.
  // set the bestIndex to the next aviable index, and set it accordingily
  int aiMove() {
    var bestScore = int64MinValue;
    int bestIndex = nextAvailableIndex();
    for (int i = 0; i < grid.length; i++) {
      if (grid[i] == '') {
        grid[i] = ai;
        var score = minimaxAB(0, int64MinValue, int64MaxValue, false);
        grid[i] = '';
        if (score > bestScore) {
          bestScore = score;
          bestIndex = i;
        }
      }
    }
    currPlayer = human;
    return bestIndex;
  }

  int minimaxAB(int depth, int alpha, int beta, bool isMax) {
    var currWinner = checkGameOver();
    if (currWinner == human) {
      return -10 + depth;
    } else if (currWinner == ai) {
      return 10 - depth;
    } else if (currWinner == 'tie') {
      return 0;
    }

    if (isMax) {
      var maxVal = int64MinValue;
      for (int i = 0; i < grid.length; i++) {
        if (grid[i] == '') {
          grid[i] = ai;
          var val = minimaxAB(depth + 1, alpha, beta, false);
          grid[i] = '';
          maxVal = max(maxVal, val);
          alpha = max(alpha, val);
          if (beta <= alpha) {
            break;
          }
        }
      }
      return maxVal;
    } else {
      var minVal = int64MaxValue;
      for (int i = 0; i < grid.length; i++) {
        if (grid[i] == '') {
          grid[i] = human;
          var val = minimaxAB(depth - 1, alpha, beta, true);
          grid[i] = '';
          minVal = min(minVal, val);
          beta = min(beta, val);
          if (beta <= alpha) {
            break;
          }
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
      int aiIndex = aiMove();
      setState(() {
        grid[aiIndex] = ai;
      });
      currPlayer = player;
    });
  }

  void humanGoFirst() {
    if (humanFirst) {
      return;
    } else {
      setState(() {
        grid[0] = '';
      });
    }
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

    humanFirst = false;
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
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: humanGoFirst,
                        child: const Text('Let me go first'),
                      ),
                      GridBuilder(
                        nextMove,
                        grid,
                        currPlayer,
                      ),
                    ],
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
