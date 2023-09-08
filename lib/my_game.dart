import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_tiled_01/components/decoration_component.dart';
import 'package:flame_tiled_01/components/friend_component.dart';
import 'package:flame_tiled_01/util/friends_dialogs.dart';
import 'package:flame_tiled_01/components/player_component.dart';
import 'package:flame_tiled_01/components/dialog_component.dart';
import 'package:flame_tiled_01/dimensions.dart';

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  final _world = World();

  @override
  Future<void> onLoad() async {
    debugMode = true;
    TiledComponent homeMap =
        await TiledComponent.load('map_01.tmx', Vector2.all(16));
    await homeMap.add(RectangleHitbox());

    final CameraComponent cameraComponent = CameraComponent.withFixedResolution(
      world: _world,
      width: Dimensions.fixedWidth,
      height: Dimensions.fixedHeight,
    );

    cameraComponent.setBounds(Dimensions.getBounds(homeMap));
    PlayerComponent player = PlayerComponent()
      ..position = Vector2(20, 20)
      ..size = Vector2.all(48);
    await _world.add(homeMap);
    await _world.add(player);
    final friendGroup = homeMap.tileMap.getLayer<ObjectGroup>('friends_hitbox');
    for (TiledObject friend in friendGroup!.objects) {
      await _world.add(
        FriendComponent(
          tile: friend,
          dialog: FriendsDialogs.getDialogByName(friend.name),
        ),
      );
    }
    final waterGroup = homeMap.tileMap.getLayer<ObjectGroup>('waters_hitbox');
    for (var water in waterGroup!.objects) {
      await _world.add(DecorationComponent(tile: water));
    }
    cameraComponent.follow(
      player,
    );
    //Setup view
    await addAll([cameraComponent, _world]);
  }

  void onFriendSpeak(String dialog, Vector2 position) {
    _world.add(DialogComponent(dialog: dialog, position: position));
  }
}
