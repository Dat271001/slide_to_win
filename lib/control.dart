import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game_model.dart';


class Control extends StatefulWidget {
  const Control({
    super.key,
    required this.model,
  });

  final GameModel model;

  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "1",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Slider(
              value: widget.model.current.toDouble(),
              onChanged: (value) {
                widget.model.current = value.toInt();
                setState(() {});
              },
              min: 1.0,
              max: 100.0,
            ),
          ),
          Text(
            "100",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
