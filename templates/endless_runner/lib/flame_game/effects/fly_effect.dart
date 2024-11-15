import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';

class FlyEffect extends MoveByEffect {
  FlyEffect(double offset)
      : super(Vector2(0, offset),
            EffectController(duration: 0.1, curve: Curves.ease));
}
