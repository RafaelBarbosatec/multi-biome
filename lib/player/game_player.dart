import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:multibiomegame/main.dart';

class GamePlayer extends SimplePlayer {
  final Position initPosition;
  static final sizePlayer = tileSize * 1.5;
  Paint _paintFocus = Paint()..blendMode = BlendMode.clear;
  bool isWater = false;
  double baseSpeed = sizePlayer * 2;

  GamePlayer(this.initPosition, SpriteSheet spriteSheet,
      {Direction initDirection = Direction.right})
      : super(
          animIdleTop: spriteSheet.createAnimation(0, stepTime: 0.1),
          animIdleBottom: spriteSheet.createAnimation(1, stepTime: 0.1),
          animIdleLeft: spriteSheet.createAnimation(2, stepTime: 0.1),
          animIdleRight: spriteSheet.createAnimation(3, stepTime: 0.1),
          animRunTop: spriteSheet.createAnimation(4, stepTime: 0.1),
          animRunBottom: spriteSheet.createAnimation(5, stepTime: 0.1),
          animRunLeft: spriteSheet.createAnimation(6, stepTime: 0.1),
          animRunRight: spriteSheet.createAnimation(7, stepTime: 0.1),
          width: sizePlayer,
          height: sizePlayer,
          initPosition: initPosition,
          initDirection: initDirection,
          life: 100,
          speed: sizePlayer * 2,
          collision: Collision(
            height: sizePlayer / 3,
            width: sizePlayer * 0.5,
            align: Offset(sizePlayer * 0.25, sizePlayer * 0.65),
          ),
        );

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    if (event.directional != JoystickMoveDirectional.IDLE) {
      speed = (baseSpeed * (isWater ? 0.5 : 1)) * event.intensity;
    }
    super.joystickChangeDirectional(event);
    isWater = tileIsWater();
  }

  @override
  void render(Canvas canvas) {
    if (isWater) {
      canvas.saveLayer(position, Paint());
    }
    super.render(canvas);
    if (isWater) {
      canvas.drawRect(
        Rect.fromLTWH(
          position.left,
          position.top + height * 0.62,
          position.width,
          position.height * 0.38,
        ),
        _paintFocus,
      );
      canvas.restore();
    }
  }

  bool tileIsWater() => tileTypeBelow() == 'water';
}
