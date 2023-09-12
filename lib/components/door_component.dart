import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_tiled_01/components/base_component.dart';

class DoorComponent extends BaseComponent {
  DoorComponent({required TiledObject tile})
      : super(tile: tile, haveHitBox: true);
}
