import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';

import 'components/components.dart';

import 'config.dart';

class GameThing extends FlameGame with KeyboardEvents {
  GameThing()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  double get width => size.x;
  double get height => size.y;
  late Player _player;
  Player get player => _player;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    camera.viewfinder.anchor = Anchor.topLeft;

    await loadImages();
    world.add(PlayArea());
    spawnPlayer();

    // debugMode = true;
  }

  loadImages() async {
    await images.load('wood_block.jpg');
  }

  spawnPlayer() {
    _player =
        Player(image: images.fromCache('wood_block.jpg'), position: spawnPos);
    world.add(_player);
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is KeyDownEvent || event is KeyRepeatEvent;
    final keyDirection = Direction();

    for (LogicalKeyboardKey keyPressed in keysPressed) {
      if (keyPressed == LogicalKeyboardKey.keyA) {
        keyDirection.left = true;
      }
      if (keyPressed == LogicalKeyboardKey.keyD) {
        keyDirection.right = true;
      }
      if (keyPressed == LogicalKeyboardKey.space ||
          keyPressed == LogicalKeyboardKey.keyW) {
        keyDirection.jump = true;
      }
    }
    _player.direction = keyDirection;

    return super.onKeyEvent(event, keysPressed);
  }
}
