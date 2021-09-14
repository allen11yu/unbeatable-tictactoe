import 'package:flutter/material.dart';

class GridBuilder extends StatefulWidget {
  final List<String> gameGrid;
  String nextMove;

  GridBuilder({Key key, this.gameGrid, this.nextMove}) : super(key: key);

  @override
  _GridBuilderState createState() => _GridBuilderState();
}

class _GridBuilderState extends State<GridBuilder> {
  void _nextMove(int index) {
    setState(() {
      var symbol = widget.gameGrid[index];
      if (symbol == '') {
        widget.gameGrid[index] = widget.nextMove;
      } else {
        return;
      }
    });

    if (widget.nextMove == 'X') {
      widget.nextMove = 'O';
    } else {
      widget.nextMove = 'X';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(15),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: List.generate(9, (index) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.white),
            onPressed: () {
              _nextMove(index);
            },
            child: Text(
              widget.gameGrid[index],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 50,
              ),
            ),
          );
        }),
      ),
    );
  }
}
