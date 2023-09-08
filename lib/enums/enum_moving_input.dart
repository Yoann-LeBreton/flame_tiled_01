enum MovingInput {
  idle,
  left,
  right,
  up,
  down;

  int get movingValue {
    switch (this) {
      case idle:
        return 0;
      case down:
        return 1;
      case left:
        return -1;
      case up:
        return -1;
      case right:
        return 1;
    }
  }
}
