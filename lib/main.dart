import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'src/game_thing.dart';

void main() {
  final game = GameThing();
  runApp(GameWidget(game: game));
}
