import 'package:flutter/material.dart';
import './grid_builder.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  List<String> grid = ['', '', '', '', '', '', '', '', ''];

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
            GridBuilder(
              gameGrid: grid,
              nextMove: 'X',
            ),
          ],
        ),
      ),
    );
  }
}
