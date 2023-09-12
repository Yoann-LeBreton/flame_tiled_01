import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_tiled_01/components/base_component.dart';
import 'package:flame_tiled_01/components/decoration_component.dart';
import 'package:flame_tiled_01/components/door_component.dart';
import 'package:flame_tiled_01/components/friend_component.dart';
import 'package:flame_tiled_01/components/house_component.dart';
import 'package:flame_tiled_01/enums/enum_collision_type.dart';
import 'package:flame_tiled_01/enums/enum_moving_input.dart';
import 'package:flame_tiled_01/enums/enum_player_state.dart';
import 'package:flame_tiled_01/my_game.dart';
import 'package:flutter/services.dart';

class PlayerComponent extends SpriteAnimationGroupComponent<PlayerState>
    with HasGameRef<MyGame>, KeyboardHandler, CollisionCallbacks {
  PlayerComponent();
  final double _speed = 2;

  final Map<MovingInput, bool> _directionsAllow = {
    MovingInput.up: true,
    MovingInput.down: true,
    MovingInput.left: true,
    MovingInput.right: true
  };
  MovingInput _direction = MovingInput.idle;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteSheet = SpriteSheet(
        image: await gameRef.images.load('george2.png'),
        srcSize: Vector2(48, 48));
    animations = <PlayerState, SpriteAnimation>{
      PlayerState.down: PlayerState.down.animation(spriteSheet),
      PlayerState.left: PlayerState.left.animation(spriteSheet),
      PlayerState.up: PlayerState.up.animation(spriteSheet),
      PlayerState.right: PlayerState.right.animation(spriteSheet),
      PlayerState.idle: PlayerState.idle.animation(spriteSheet),
    };

    add(RectangleHitbox.relative(Vector2(0.7, 0.72), parentSize: size));
    current = PlayerState.idle;
  }

  @override
  void update(double dt) {
    if (_directionsAllow[MovingInput.left]! && _direction == MovingInput.left) {
      _directionsAllow[MovingInput.right] = true;

      position.x = position.x + (_direction.movingValue * _speed);
    }
    if (_directionsAllow[MovingInput.right]! &&
        _direction == MovingInput.right) {
      _directionsAllow[MovingInput.left] = true;

      position.x = position.x + (_direction.movingValue * _speed);
    }
    if (_directionsAllow[MovingInput.up]! && _direction == MovingInput.up) {
      _directionsAllow[MovingInput.down] = true;

      position.y = position.y + (_direction.movingValue * _speed);
    }
    if (_directionsAllow[MovingInput.down]! && _direction == MovingInput.down) {
      _directionsAllow[MovingInput.up] = true;

      position.y = position.y + (_direction.movingValue * _speed);
    }
    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is BaseComponent) {
      final collision = playerCollisionSide(intersectionPoints, position, size);
      current = PlayerState.idle;
      if (collision.contains(PlayerCollisionType.top)) {
        _directionsAllow[MovingInput.up] = false;
        if (other is FriendComponent) {
          final pos = Vector2(
              other.topLeftPosition.x - 50, other.topLeftPosition.y - 50);
          gameRef.onFriendSpeak(other.dialog, pos);
        } else if (other is HouseComponent) {
          removeFromParent();
          gameRef.setHouseMap();
        }
      }
      if (collision.contains(PlayerCollisionType.bottom)) {
        _directionsAllow[MovingInput.down] = false;
      }
      if (collision.contains(PlayerCollisionType.left)) {
        _directionsAllow[MovingInput.left] = false;
      }
      if (collision.contains(PlayerCollisionType.right)) {
        if (other is DoorComponent) {
          removeFromParent();
          gameRef.setLandMap();
        } else {}
        _directionsAllow[MovingInput.right] = false;
      }
    }
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.length == 1) {
      LogicalKeyboardKey keyPressed = keysPressed.first;
      switch (keyPressed) {
        case LogicalKeyboardKey.arrowLeft:
          {
            current = PlayerState.left;
            _direction = MovingInput.left;
          }
        case LogicalKeyboardKey.arrowRight:
          {
            current = PlayerState.right;
            _direction = MovingInput.right;
          }
        case LogicalKeyboardKey.arrowUp:
          {
            current = PlayerState.up;
            _direction = MovingInput.up;
          }
        case LogicalKeyboardKey.arrowDown:
          {
            current = PlayerState.down;
            _direction = MovingInput.down;
          }
      }
    } else {
      current = PlayerState.idle;
      _direction = MovingInput.idle;
    }
    return true;
  }
}
