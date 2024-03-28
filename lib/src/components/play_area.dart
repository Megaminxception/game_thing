import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart' as events;
import 'package:flutter/material.dart';
import '../game_thing.dart';
import 'components.dart';
import '../config.dart';

class PlayArea extends RectangleComponent
    with
        HasGameReference<GameThing>,
        events.PointerMoveCallbacks,
        events.TapCallbacks {
  PlayArea()
      : super(
          paint: Paint()..color = const Color.fromARGB(255, 255, 255, 255),
        );

  var pointer = Mouse(
    position: Vector2(0, 0),
    radius: 10,
  );

  final textCoords = TextComponent(
      text: '(x: 0, y: 0)',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ));

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
    setFloor();

    // Load player sprite
    // final player = Player(
    //     position: spawnPos, image: game.images.fromCache('wood_block.jpg'));
    // game.world.add(player);
  }

  @override
  void onPointerMove(events.PointerMoveEvent event) {
    if (!game.world.contains(pointer)) {
      game.world.add(pointer);
    }
    pointer.position = event.localPosition;
    loadCoords();
  }

  @override
  void onTapDown(events.TapDownEvent event) {
    final gameCoords = convertLocalCoordsToGameCoords(pointer.position.clone());
    final localCoords = convertGameCoordsToLocalCoords(gameCoords);

    game.world.add(FallingBlock(
      image: game.images.fromCache('wood_block.jpg'),
      targetPosition: localCoords,
    ));
  }

  loadCoords() {
    final gameCoords = convertLocalCoordsToGameCoords(pointer.position);
    textCoords.text = '(x: ${gameCoords.x}, y: ${gameCoords.y})';
    game.world.add(textCoords);
  }

  convertLocalCoordsToGameCoords(Vector2 localCoords) {
    // print(localCoords);
    return Vector2(
      (localCoords.x / blockDims.x).floor().toDouble(),
      (localCoords.y / blockDims.y).floor().toDouble(),
    );
  }

  convertGameCoordsToLocalCoords(Vector2 gameCoords) {
    // print(gameCoords);
    return Vector2(
      gameCoords.x * blockDims.x,
      gameCoords.y * blockDims.y,
    );
  }

  setFloor() {
    final image = game.images.fromCache('wood_block.jpg');
    for (var i = 0; i < 30; i++) {
      game.world.add(StaticBlock(
          position: Vector2(i * blockDims.x, game.height - blockDims.y),
          image: image));
    }
  }
}
