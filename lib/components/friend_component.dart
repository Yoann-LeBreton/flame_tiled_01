import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_tiled_01/components/base_component.dart';

class FriendComponent extends BaseComponent {
  FriendComponent({required TiledObject tile, required this.dialog})
      : super(tile: tile, haveHitBox: true);
  final String dialog;
}
