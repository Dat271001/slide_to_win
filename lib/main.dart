import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'prompt.dart';
import 'score.dart';
import 'control.dart';
import 'game_model.dart';
import 'dart:math';


void main() {
  runApp(BasicApp());
}

class BasicApp extends StatelessWidget {
  const BasicApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return  MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      title: "ĐẠT",
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameModel _model;

  @override
  void initState() {
    super.initState();
    _model = GameModel(_newTargetValue());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Prompt(
                targetValue: _model.target,
              ),
              Control(
                model: _model,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _showAlert(context);
                    },
                    child: Text(
                        "hãy nhấn tôi",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Score(
                model: _model,
                onStartOver: () {
                  _startNewGame();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _newTargetValue() => Random().nextInt(100) + 1;
  int _differenceAmount() => (_model.target - _model.current).abs();

  //tinh diem trong vong hien tai
  int _pointForCurrentRound() {
    const maxScore = 100;
    var bonus = 0;
    var difference = _differenceAmount();
    if (difference == 0)
      bonus = 100;
    else if (difference == 1) bonus = 50;
    return maxScore - _differenceAmount();
  }

  String _alertTitle() {
    var difference = _differenceAmount();
    if (difference == 0) {
      return 'HAY';
    } else if (difference <= 5) {
      return 'TÍ ĐƯỢC';
    } else if (difference <= 10) {
      return 'GIỎI';
    } else {
      return 'CỐ LÊN';
    }
  }

  // hien thi ra man hinh bang diem khi bam nut
  void _showAlert(BuildContext context) {
    var okButton = IconButton(
      icon: Icon(Icons.close),
      onPressed: () {
        Navigator.of(context).pop();
        _model.totalScore += _pointForCurrentRound();
        _model.target = _newTargetValue();
        _model.round += 1;
        setState(() {});
      },
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_alertTitle()),
          content: Text('Giá trị thanh trượt là ${_model.current}\n'
              'Bạn đã ghi được ${_pointForCurrentRound()} điểm trong vòng này'),
          actions: [okButton],
        );
      },
    );
  }

  void _startNewGame() {
    _model.totalScore = GameModel.scoreStart;
    _model.target = _newTargetValue();
    _model.round = GameModel.roundStart;
    _model.current = GameModel.sliderStart;
    setState(() {

    });
  }
}
