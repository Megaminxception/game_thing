import 'dart:ui';

import 'package:flame/components.dart';
import '../game_thing.dart';
import 'static_block.dart';
import '../config.dart';

class FallingBlock extends SpriteComponent with HasGameReference<GameThing> {
  final Vector2 targetPosition;
  final Image image;

  FallingBlock({
    required this.image,
    required this.targetPosition,
  }) : super(
          sprite: Sprite(image),
          size: blockDims,
          position: Vector2(targetPosition.x, 0),
        );

  @override
  void update(double dt) {
    super.update(dt);
    final collisionResult = checkCollision();

    if (collisionResult == null) {
      position.y += 750 * dt;
    } else {
      if (!toRect().overlaps(game.player.toRect())) {
        final restingPosition = collisionResult - Vector2(0, blockDims.y);
        game.world.add(StaticBlock(position: restingPosition, image: image));
      }
      game.world.remove(this);
    }
  }

  Vector2? checkCollision() {
    for (final block in game.world.children.whereType<SpriteComponent>()) {
      if (block != this && block.toRect().overlaps(toRect())) {
        return block.position.clone();
      }
    }
    return null;
  }
}
