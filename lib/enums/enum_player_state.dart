import 'package:flame/sprite.dart';

enum PlayerState {
  idle,
  left,
  right,
  up,
  down;

  SpriteAnimation animation(SpriteSheet spriteSheet) {
    switch (this) {
      case down:
        return spriteSheet.createAnimation(row: 0, stepTime: .1, to: 4);
      case left:
        return spriteSheet.createAnimation(row: 1, stepTime: .1, to: 4);
      case up:
        return spriteSheet.createAnimation(row: 2, stepTime: .1, to: 4);
      case right:
        return spriteSheet.createAnimation(row: 3, stepTime: .1, to: 4);
      case idle:
        return spriteSheet.createAnimation(row: 0, stepTime: .1, to: 1);
    }
  }
}
