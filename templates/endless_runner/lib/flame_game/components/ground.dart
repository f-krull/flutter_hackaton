import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

import '../endless_world.dart';

/// The [Ground] component can represent three different types of obstacles
/// that the player can run into.
class Ground extends SpriteComponent with HasWorldReference<EndlessWorld> {
  Ground({
    super.position,
    required this.pixelHeight,
    required this.index,
    required this.maxGrounds,
  });
  final double pixelHeight;
  final int index;
  final int maxGrounds;

  @override
  Future<void> onLoad() async {
    // Since all the obstacles reside in the same image, srcSize and srcPosition
    // are used to determine what part of the image that should be used.
    sprite = await Sprite.load(
      'ground/black_10x10.png',
      srcSize: Vector2(10, 10),
      srcPosition: Vector2.zero(),
    );
    super.size = Vector2((world.size.x / maxGrounds) * 2 + 1, pixelHeight + 1);
    // When adding a RectangleHitbox without any arguments it automatically
    // fills up the size of the component.
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    // We need to move the component to the left together with the speed that we
    // have set for the world.
    // `dt` here stands for delta time and it is the time, in seconds, since the
    // last update ran. We need to multiply the speed by `dt` to make sure that
    // the speed of the obstacles are the same no matter the refresh rate/speed
    // of your device.
    position.x -= world.speed * dt;

    // When the component is no longer visible on the screen anymore, we
    // remove it.
    // The position is defined from the upper left corner of the component (the
    // anchor) and the center of the world is in (0, 0), so when the components
    // position plus its size in X-axis is outside of minus half the world size
    // we know that it is no longer visible and it can be removed.
    if (position.x + size.x < -world.size.x / 2) {
      position.x += world.size.x * 2;
    }
  }
}

enum ObstacleType {
  small,
  tall,
  wide,
}
