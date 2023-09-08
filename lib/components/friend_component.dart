import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class FriendComponent extends PositionComponent {
  FriendComponent({required this.tile, required this.dialog});
  final TiledObject tile;
  final String dialog;
  late RectangleHitbox _hitbox;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = Vector2(tile.x, tile.y);
    width = tile.width;
    height = tile.height;
    _hitbox = RectangleHitbox();
    add(_hitbox);
  }
}
