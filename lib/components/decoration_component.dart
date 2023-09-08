import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class DecorationComponent extends PositionComponent {
  DecorationComponent({required this.tile});
  final TiledObject tile;
  late RectangleHitbox _hitbox;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    position = Vector2(tile.x, tile.y);
    width = tile.width;
    height = tile.height;
    _hitbox = RectangleHitbox();
    add(_hitbox);
  }
}
