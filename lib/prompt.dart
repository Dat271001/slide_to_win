import 'package:flutter/material.dart';

class Prompt extends StatelessWidget {
  const Prompt({
    super.key,
    required this.targetValue,
  });

  final int targetValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'RANDOM',
        ),
        Text('$targetValue',),
      ],
    );
  }
}
