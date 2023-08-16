import 'package:flutter/material.dart';

class Dice extends StatelessWidget {
  final int dice;
  final bool disableDice;
  final VoidCallback updateDice;
  const Dice({
    super.key,
    required this.dice,
    required this.disableDice,
    required this.updateDice,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.all(25.0)),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey;
          }
          return Theme.of(context).colorScheme.primary;
        }),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
      ),
      onPressed: disableDice ? null : updateDice,
      child: Row(
        children: [
          Expanded(
            child: Image.asset('images/dice$dice.png'),
          ),
        ],
      ),
    );
  }
}
