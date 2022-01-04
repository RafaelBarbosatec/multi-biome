import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:multibiomegame/main.dart';

class GamePlayer extends SimplePlayer with ObjectCollision {
  static final sizePlayer = tileSize * 1.5;
  Paint _paintFocus = Paint()..blendMode = BlendMode.clear;
  bool isWater = false;
  double baseSpeed = sizePlayer * 2;

  GamePlayer(Vector2 position, SpriteSheet spriteSheet,
      {Direction initDirection = Direction.right})
      : super(
          animation: SimpleDirectionAnimation(
            idleUp:
                spriteSheet.createAnimation(row: 0, stepTime: 0.1).asFuture(),
            idleDown:
                spriteSheet.createAnimation(row: 1, stepTime: 0.1).asFuture(),
            idleLeft:
                spriteSheet.createAnimation(row: 2, stepTime: 0.1).asFuture(),
            idleRight:
                spriteSheet.createAnimation(row: 3, stepTime: 0.1).asFuture(),
            runUp:
                spriteSheet.createAnimation(row: 4, stepTime: 0.1).asFuture(),
            runDown:
                spriteSheet.createAnimation(row: 5, stepTime: 0.1).asFuture(),
            runLeft:
                spriteSheet.createAnimation(row: 6, stepTime: 0.1).asFuture(),
            runRight:
                spriteSheet.createAnimation(row: 7, stepTime: 0.1).asFuture(),
          ),
          size: Vector2.all(sizePlayer),
          position: position,
          initDirection: initDirection,
          life: 100,
          speed: sizePlayer * 2,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(sizePlayer * 0.5, sizePlayer / 3),
            align: Vector2(sizePlayer * 0.25, sizePlayer * 0.65),
          ),
        ],
      ),
    );
  }

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
      canvas.saveLayer(toRect(), Paint());
    }
    super.render(canvas);
    if (isWater) {
      canvas.drawRect(
        Rect.fromLTWH(
          left,
          top + height * 0.62,
          width,
          height * 0.38,
        ),
        _paintFocus,
      );
      canvas.restore();
    }
  }

  bool tileIsWater() => tileTypeBelow() == 'water';
}
