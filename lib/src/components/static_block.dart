import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config.dart';

class StaticBlock extends SpriteComponent {
  StaticBlock({
    required super.position,
    required image,
  }) : super(
          sprite: Sprite(image),
          size: blockDims,
        );
}
