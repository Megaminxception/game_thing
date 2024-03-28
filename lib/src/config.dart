import 'package:flame/components.dart';

const gameWidth = 1500.0;
const gameHeight = 1000.0;
final blockDims = Vector2(50, 50);
final playerDims = Vector2(49, 100);
final spawnPos = Vector2(50, 150);

class Direction {
  bool left = false, right = false, jump = false;
}
