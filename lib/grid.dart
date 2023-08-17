import 'package:flutter/material.dart';
import 'dart:math';

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
    const mainAxisCount = itemCount / crossAxisCount;
    const borderWidth = 1.0;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height * heightRatio;
    final cellWidth =
        (width - (crossAxisCount - 1) * borderWidth) / crossAxisCount;
    final cellHeight =
        (height - (mainAxisCount - 1) * borderWidth) / mainAxisCount;
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
                      : Text(
                          '$value',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                ),
              );
            },
          ),
          // Ladder Positions
          Positioned(
            left: cellWidth + 2 * borderWidth,
            bottom: 0,
            width: cellWidth,
            height: 3 * cellHeight + 4 * borderWidth,
            child: Transform.rotate(
              alignment: Alignment.bottomRight,
              angle: atan(2 / 7),
              child: Image.asset(
                'images/ladder.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: 7 * cellWidth + 12 * borderWidth,
            bottom: 0,
            width: cellWidth,
            height: 4 * cellHeight + 6 * borderWidth,
            child: Transform.rotate(
              alignment: Alignment.bottomLeft,
              angle: -atan(1 / 4),
              child: Image.asset(
                'images/ladder.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: cellHeight + 2 * borderWidth,
            width: cellWidth,
            height: 7 * cellHeight + 12 * borderWidth,
            child: Transform.rotate(
              alignment: Alignment.bottomRight,
              angle: atan(4 / 11),
              child: Image.asset(
                'images/ladder.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            right: cellWidth + 2 * borderWidth,
            bottom: 3 * cellHeight + 6 * borderWidth,
            width: cellWidth,
            height: 4 * cellHeight + 6 * borderWidth,
            child: Transform.rotate(
              alignment: Alignment.bottomRight,
              angle: -atan(1 / 5),
              child: Image.asset(
                'images/ladder.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 4 * cellHeight + 6 * borderWidth,
            width: cellWidth,
            height: 4 * cellHeight + 6 * borderWidth,
            child: Transform.rotate(
              alignment: Alignment.bottomLeft,
              angle: atan(1 / 5),
              child: Image.asset(
                'images/ladder.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: 6 * cellWidth + 10 * borderWidth,
            bottom: 7 * cellHeight + 14 * borderWidth,
            width: cellWidth,
            height: 2 * cellHeight + 2 * borderWidth,
            child: Transform.rotate(
              alignment: Alignment.bottomLeft,
              angle: atan(1 / 3),
              child: Image.asset(
                'images/ladder.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: cellWidth + 2 * borderWidth,
            bottom: 8 * cellHeight + 16 * borderWidth,
            width: cellWidth,
            height: 2 * cellHeight + 2 * borderWidth,
            child: Transform.rotate(
              alignment: Alignment.bottomRight,
              angle: -atan(1 / 2),
              child: Image.asset(
                'images/ladder.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: 4 * cellWidth + 6 * borderWidth,
            bottom: 8 * cellHeight + 16 * borderWidth,
            width: cellWidth,
            height: 2 * cellHeight + 2 * borderWidth,
            child: Transform.rotate(
              alignment: Alignment.bottomLeft,
              angle: atan(1 / 2),
              child: Image.asset(
                'images/ladder.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Snake Positions
          Positioned(
            left: 4 * cellWidth + 6 * borderWidth,
            bottom: 2 * cellHeight + 4 * borderWidth,
            width: cellWidth,
            height: 8 * cellHeight + 14 * borderWidth,
            child: Transform.rotate(
              alignment: Alignment.bottomRight,
              angle: -atan(1 / 6),
              child: Image.asset(
                'images/snake.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: 9 * cellWidth + 16 * borderWidth,
            bottom: 6 * cellHeight + 12 * borderWidth,
            width: cellWidth,
            height: 4 * cellHeight + 6 * borderWidth,
            child: Transform.rotate(
              alignment: Alignment.bottomRight,
              angle: -atan(1 / 3),
              child: Image.asset(
                'images/snake.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: 6 * cellWidth + 10 * borderWidth,
            bottom: 5 * cellHeight + 10 * borderWidth,
            width: cellWidth,
            height: 4 * cellHeight + 6 * borderWidth,
            child: Transform.rotate(
              alignment: Alignment.bottomRight,
              angle: -atan(1 / 3),
              child: Image.asset(
                'images/snake.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: 3 * cellWidth + 4 * borderWidth,
            bottom: 3 * cellHeight + 6 * borderWidth,
            width: cellWidth,
            height: 4 * cellHeight + 6 * borderWidth,
            child: Transform.rotate(
              alignment: Alignment.bottomRight,
              angle: -atan(3 / 5),
              child: Image.asset(
                'images/snake.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: 7 * cellWidth + 12 * borderWidth,
            bottom: 3 * cellHeight + 6 * borderWidth,
            width: cellWidth,
            height: 3 * cellHeight + 4 * borderWidth,
            child: Transform.rotate(
              alignment: Alignment.bottomLeft,
              angle: 0,
              child: Image.asset(
                'images/snake.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: 4 * cellWidth + 6 * borderWidth,
            bottom: 0,
            width: cellWidth,
            height: 5 * cellHeight + 8 * borderWidth,
            child: Transform.rotate(
              alignment: Alignment.bottomLeft,
              angle: atan(1 / 3),
              child: Image.asset(
                'images/snake.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: 4.5 * cellWidth + 8 * borderWidth,
            bottom: 1.5 * cellHeight + 2 * borderWidth,
            width: cellWidth,
            height: 3.5 * cellHeight + 4 * borderWidth,
            child: Transform.rotate(
              alignment: Alignment.bottomRight,
              angle: -atan((4 * (cellWidth + 2 * borderWidth)) /
                  (3 * (cellHeight + 2 * borderWidth))),
              child: Image.asset(
                'images/snake.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: 8 * cellWidth + 14 * borderWidth,
            bottom: 0,
            width: cellWidth,
            height: 3 * cellHeight + 4 * borderWidth,
            child: Transform.rotate(
              alignment: Alignment.bottomRight,
              angle: 0,
              child: Image.asset(
                'images/snake.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
