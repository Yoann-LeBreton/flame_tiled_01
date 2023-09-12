import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_tiled_01/components/decoration_component.dart';
import 'package:flame_tiled_01/components/door_component.dart';
import 'package:flame_tiled_01/components/friend_component.dart';
import 'package:flame_tiled_01/components/house_component.dart';
import 'package:flame_tiled_01/util/friends_dialogs.dart';
import 'package:flame_tiled_01/components/player_component.dart';
import 'package:flame_tiled_01/components/dialog_component.dart';
import 'package:flame_tiled_01/dimensions.dart';

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  final _world = World();
  late CameraComponent cameraComponent;
  @override
  Future<void> onLoad() async {
    debugMode = true;

    cameraComponent = CameraComponent.withFixedResolution(
      world: _world,
      width: Dimensions.fixedWidth,
      height: Dimensions.fixedHeight,
    );
    await setLandMap();
    //Setup view
    await addAll([cameraComponent, _world]);
  }

  Future setLandMap() async {
    _world.children.clear();
    TiledComponent homeMap =
        await TiledComponent.load('map_01.tmx', Vector2.all(16));
    await homeMap.add(RectangleHitbox());
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
    final housesGroup = homeMap.tileMap.getLayer<ObjectGroup>('houses_hitbox');
    for (var house in housesGroup!.objects) {
      await _world.add(HouseComponent(tile: house));
    }
    cameraComponent.follow(
      player,
    );
  }

  Future setHouseMap() async {
    _world.children.clear();
    TiledComponent homeMap =
        await TiledComponent.load('map_02.tmx', Vector2.all(16));
    await homeMap.add(RectangleHitbox());
    cameraComponent.setBounds(Dimensions.getBounds(homeMap));
    PlayerComponent player = PlayerComponent()
      ..position = Vector2(20, 20)
      ..size = Vector2.all(48);
    await _world.add(homeMap);
    await _world.add(player);
    final doorsGroup = homeMap.tileMap.getLayer<ObjectGroup>('doors');
    for (var door in doorsGroup!.objects) {
      await _world.add(DoorComponent(tile: door));
    }
    cameraComponent.follow(
      player,
    );
  }

  void onFriendSpeak(String dialog, Vector2 position) {
    _world.add(DialogComponent(dialog: dialog, position: position));
  }
}
