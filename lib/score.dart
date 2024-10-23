import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled4/info_page.dart';
import 'game_model.dart';

class Score extends StatelessWidget {
  const Score({
    super.key,
    required this.model,
    required this.onStartOver,
  });

  final GameModel model;
  final VoidCallback onStartOver;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       Padding(
         padding: const EdgeInsets.only(left: 100, right: 30),
         child: IconButton(
           icon: Icon(Icons.refresh),
           onPressed: (){
             onStartOver();
           },
         ),
       ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Column(
              children: [
                Text('Điểm'),
                Text('${model.totalScore}'),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Column(
              children: [
                Text(
                  'Lượt',
                ),
                Text('${model.round}'),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 100),
          child: IconButton(icon: Icon(Icons.info), onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InfoPage()),
            );
          }),
        )
      ],
    );
  }
}
