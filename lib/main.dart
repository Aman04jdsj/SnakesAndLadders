import 'dart:math';
import 'package:flutter/material.dart';
import 'grid.dart';
import 'dice.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snakes and Ladders',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Snakes and Ladders!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int dice = 1 + Random().nextInt(6);
  int playerPosition = 1;
  int targetPosition = 1;
  int maxPosition = 100;
  bool disableDice = false;
  static const Map<int, int> snakeLocations = {
    97: 25,
    92: 70,
    86: 54,
    62: 37,
    53: 33,
    47: 5,
    38: 15,
    29: 9
  };
  static const Map<int, int> ladderLocations = {
    2: 23,
    8: 34,
    20: 77,
    32: 68,
    41: 79,
    74: 88,
    85: 95,
    82: 100
  };

  void _updateDice() {
    int nextVal = 1 + Random().nextInt(6);
    setState(() {
      dice = nextVal;
      disableDice = true;
    });
    Duration duration = const Duration(milliseconds: 500);
    Timer(duration, _updatePlayerPosition);
  }

  void _updatePlayerPosition() {
    int newTarget = playerPosition + dice;
    if (newTarget <= maxPosition) {
      setState(() {
        targetPosition = newTarget;
      });
      movePlayer();
    } else {
      setState(() {
        disableDice = false;
      });
    }
  }

  void _resetGame() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Game Complete!'),
            content: const Text('Congratulations on completing the game!'),
            actions: <Widget>[
              TextButton(
                child: const Text('Reset'),
                onPressed: () {
                  Navigator.of(context).pop();
                  int nextVal = 1 + Random().nextInt(6);
                  setState(() {
                    dice = nextVal;
                    playerPosition = 1;
                    targetPosition = 1;
                  });
                },
              ),
            ],
          );
        });
  }

  void movePlayer() {
    Duration duration = const Duration(milliseconds: 200);
    if (playerPosition != targetPosition) {
      int delta = playerPosition < targetPosition ? 1 : -1;
      int newPosition = playerPosition + delta;
      newPosition.clamp(1, 100);
      setState(() {
        playerPosition = newPosition;
      });
      Timer(duration, movePlayer);
    } else if (snakeLocations.containsKey(targetPosition)) {
      setState(() {
        targetPosition = snakeLocations[targetPosition]!;
      });
      movePlayer();
    } else if (ladderLocations.containsKey(targetPosition)) {
      setState(() {
        targetPosition = ladderLocations[targetPosition]!;
      });
      movePlayer();
    } else {
      setState(() {
        disableDice = false;
        if (playerPosition == maxPosition) {
          _resetGame();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const appBarFlex = 1, diceFlex = 1, gridFlex = 3;
    const gridHeightRatio = gridFlex / (gridFlex + appBarFlex + diceFlex);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: appBarFlex,
            child: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text(
                widget.title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: gridFlex,
            child: GameGrid(
                playerPosition: playerPosition,
                heightRatio: gridHeightRatio,
                snakeLocations: snakeLocations,
                ladderLocations: ladderLocations),
          ),
          Expanded(
            flex: diceFlex,
            child: Dice(
              dice: dice,
              disableDice: disableDice,
              updateDice: _updateDice,
            ),
          ),
        ],
      ),
    );
  }
}
