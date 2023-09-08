import 'package:flame/components.dart';

enum PlayerCollisionType {
  top,
  bottom,
  left,
  right,
  none,
}

List<PlayerCollisionType> playerCollisionSide(Set<Vector2> intersectionPoints,
    Vector2 playerPosition, Vector2 playerSize) {
  final Vector2 collisionPoint = intersectionPoints.first;
  final average = intersectionPoints.reduce((a, b) => a + b) /
      intersectionPoints.length.toDouble();
  final collisionHorizontal = (average.x == collisionPoint.x);
  final collisionVertical = (average.y == collisionPoint.y);
  final center = Vector2(
    playerPosition.x + playerSize.x / 2,
    playerPosition.y + playerSize.y / 2,
  );
  List<PlayerCollisionType> collisions = [];
  if (collisionHorizontal) {
    final collisionRight = (average.x > center.x);
    final collisionLeft = (average.x < center.x);
    if (collisionLeft) {
      collisions.add(PlayerCollisionType.left);
    } else if (collisionRight) {
      collisions.add(PlayerCollisionType.right);
    }
  }
  if (collisionVertical) {
    final collisionBottom = (average.y > center.y);
    final collisionTop = (average.y < center.y);
    if (collisionTop) {
      collisions.add(PlayerCollisionType.top);
    } else if (collisionBottom) {
      collisions.add(PlayerCollisionType.bottom);
    } else {
      collisions.add(PlayerCollisionType.none);
    }
  }
  return collisions;
}
