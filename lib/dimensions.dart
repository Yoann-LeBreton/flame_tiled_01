import 'package:flame/experimental.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Dimensions {
  static const fixedWidth = 600.0;
  static const fixedHeight = 450.0;

  static Rectangle getBounds(TiledComponent tile) {
    final mapWidth =
        (tile.tileMap.map.width * tile.tileMap.map.tileWidth).toDouble();
    final mapHeight =
        (tile.tileMap.map.height * tile.tileMap.map.tileHeight).toDouble();
    return Rectangle.fromLTRB(fixedWidth / 2, fixedHeight / 2,
        mapWidth - fixedWidth / 2, mapHeight - fixedHeight / 2);
    //return Rectangle.fromLTRB(0, 0, mapWidth, mapHeight);
  }
}
