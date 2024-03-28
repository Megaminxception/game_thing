import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/physics.dart';
import '../config.dart';
import '../helpers/helpers.dart';

class Player extends SpriteComponent with HasGameReference {
  // [left, right, up]
  var direction = Direction();
  // NOTE: all speeds recorded in M/S^2.
  final playerSpeed = 5.0;
  var playerVerticalVelocity = 0.0;

  Player({
    required super.position,
    required image,
  }) : super(sprite: Sprite(image), size: playerDims);

  @override
  void update(double dt) {
    applyPhysics(dt);
    movePlayer(dt);
    super.update(dt);
  }

  applyPhysics(double dt) {
    final gravityEffect = gravity * dt;
    playerVerticalVelocity += gravityEffect;
    position
        .add(Vector2(0, dt * convertMetersToPixels(playerVerticalVelocity)));

    for (final block in game.world.children.whereType<SpriteComponent>()) {
      if (block == this) {
        continue;
      }
      if (block.toRect().overlaps(toRect())) {
        position.add(
            Vector2(0, dt * -convertMetersToPixels(playerVerticalVelocity)));
        playerVerticalVelocity = 0.0;
        return;
      }
    }
  }

  movePlayer(double dt) {
    if (direction.left) {
      moveLeft(dt);
    }
    if (direction.right) {
      moveRight(dt);
    }
    if (direction.jump) {
      jump(dt);
    }
  }

  moveLeft(double dt) {
    final pixelAdjust = convertMetersToPixels(playerSpeed);
    position.add(Vector2(dt * -pixelAdjust, 0));
    if (collisionCheck(toRect())) {
      position.add(Vector2(dt * pixelAdjust, 0));
    }
  }

  moveRight(double dt) {
    final pixelAdjust = convertMetersToPixels(playerSpeed);
    position.add(Vector2(dt * pixelAdjust, 0));
    if (collisionCheck(toRect())) {
      position.add(Vector2(dt * -pixelAdjust, 0));
    }
  }

  jump(double dt) {
    if (playerVerticalVelocity == 0.0) {
      final jumpVelocity =
          calculateJumpVelocity(convertPixelsToMeters(playerDims.y * 0.75));
      playerVerticalVelocity = jumpVelocity;
    }
  }

  bool collisionCheck(Rect rect) {
    for (final block in game.world.children.whereType<SpriteComponent>()) {
      if (block == this) {
        continue;
      }
      if (block.toRect().overlaps(rect)) {
        return true;
      }
    }
    return false;
  }
}
