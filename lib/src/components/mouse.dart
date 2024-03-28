import 'package:flame/components.dart';
import 'package:flame/events.dart' as events;
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import '../game_thing.dart';

class Mouse extends CircleComponent {
  Mouse({required super.position, required super.radius, required})
      : super(
          anchor: Anchor.center,
          paint: Paint()
            ..color = const Color.fromARGB(255, 0, 0, 0)
            ..style = PaintingStyle.stroke,
        );
}
