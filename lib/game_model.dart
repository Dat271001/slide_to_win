
class GameModel{
  static const sliderStart = 50;
  static const scoreStart = 0;
  static const roundStart = 1;

  int target;
  int current;
  int totalScore;
  int round;

  GameModel(
      this.target,
      [
      this.current = sliderStart,
      this.totalScore = scoreStart,
      this.round = roundStart,
      ]
  );
}