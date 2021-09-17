import 'package:flutter/material.dart';

class GridBuilder extends StatelessWidget {
  final Function nextMove;
  final List<String> gameGrid;
  String player;

  GridBuilder(this.nextMove, this.gameGrid, this.player);

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
              nextMove(index);
            },
            child: Text(
              gameGrid[index],
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
