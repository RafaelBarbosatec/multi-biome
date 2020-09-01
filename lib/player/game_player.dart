import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flutter/material.dart';
import 'package:multibiomegame/main.dart';

class GamePlayer extends SimplePlayer {
  final Position initPosition;
  double stamina = 100;
  Timer _timerStamina;
  static final sizePlayer = tileSize * 1.5;

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
            align: Offset(sizePlayer * 0.25, sizePlayer * 0.7),
          ),
        );

  void _verifyStamina() {
    if (_timerStamina == null) {
      _timerStamina = Timer(Duration(milliseconds: 150), () {
        _timerStamina = null;
      });
    } else {
      return;
    }

    stamina += 2;
    if (stamina > 100) {
      stamina = 100;
    }
  }

  void decrementStamina(int i) {
    stamina -= i;
    if (stamina < 0) {
      stamina = 0;
    }
  }

  @override
  void update(double dt) {
    if (isDead) return;
    _verifyStamina();
    super.update(dt);
  }

  void showEmote(FlameAnimation.Animation emoteAnimation) {
    gameRef.add(
      AnimatedFollowerObject(
        animation: emoteAnimation,
        target: this,
        width: position.width / 2,
        height: position.width / 2,
        positionFromTarget: Position(25, -10),
      ),
    );
  }

  @override
  void receiveDamage(double damage, int from) {
    this.showDamage(
      damage,
      config: TextConfig(color: Colors.red, fontSize: 14),
    );
    super.receiveDamage(damage, from);
  }
}
