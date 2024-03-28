import 'dart:math';

const double gravity = 25;

double calculateJumpVelocity(double jumpHeight) {
  final uSquared = -2 * -gravity * jumpHeight;
  final minimumRequiredVelocity = sqrt(uSquared);
  return -minimumRequiredVelocity;
}

// Making the decision that 50 pixels is a meter
double convertPixelsToMeters(double pixels) {
  return pixels / 50;
}

double convertMetersToPixels(double meters) {
  return meters * 50;
}
