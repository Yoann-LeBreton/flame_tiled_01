import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_tiled_01/components/base_component.dart';

class DecorationComponent extends BaseComponent {
  DecorationComponent({required TiledObject tile})
      : super(tile: tile, haveHitBox: true);
}
