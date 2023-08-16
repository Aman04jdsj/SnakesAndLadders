import 'package:flutter/material.dart';

class GameGrid extends StatelessWidget {
  final int playerPosition;
  final double heightRatio;
  final Map<int, int> snakeLocations;
  final Map<int, int> ladderLocations;
  const GameGrid({
    super.key,
    required this.playerPosition,
    required this.heightRatio,
    required this.snakeLocations,
    required this.ladderLocations,
  });

  @override
  Widget build(BuildContext context) {
    const crossAxisCount = 10;
    const itemCount = 100;
    const borderWidth = 1.0;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height * heightRatio;
    return Container(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            reverse: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              childAspectRatio: width / height,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final row = index ~/ 10; // Integer division to determine row
              final col = index % 10; // Modulus operation to determine column

              // Calculate the value based on alternating increasing and decreasing rows
              final value =
                  row % 2 == 0 ? (row * 10) + col + 1 : (row + 1) * 10 - col;

              return Container(
                decoration: BoxDecoration(
                  color: playerPosition == value
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.inversePrimary,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: borderWidth),
                ),
                child: Center(
                  child: playerPosition == value
                      ? Image.asset('images/pawn.png')
                      : snakeLocations.containsKey(value)
                          ? Image.asset('images/snake.png')
                          : ladderLocations.containsKey(value)
                              ? Image.asset('images/ladderright.png')
                              : Text(
                                  '$value',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
