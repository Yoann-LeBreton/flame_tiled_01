import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

abstract class BaseComponent extends PositionComponent {
  BaseComponent({required this.tile, this.haveHitBox = false});
  final TiledObject tile;
  final bool haveHitBox;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    position = Vector2(tile.x, tile.y);
    width = tile.width;
    height = tile.height;
    if (haveHitBox) {
      add(RectangleHitbox());
    }
  }
}
