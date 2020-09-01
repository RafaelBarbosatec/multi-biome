import 'package:bonfire/bonfire.dart';
import 'package:flutter/widgets.dart';

class ExitMapSensor extends GameDecoration {
  final Position initPosition;
  final String id;
  bool hasContact = false;
  final ValueChanged<String> exitMap;

  ExitMapSensor(
      this.id, this.initPosition, double width, double height, this.exitMap)
      : super.sprite(
          null,
          initPosition: initPosition,
          width: width,
          height: height,
          isSensor: true,
          collision: Collision(
            width: width,
            height: height,
          ),
        );

  @override
  void onContact(collision) {
    if (!hasContact && collision is Player) {
      hasContact = true;
      exitMap(id);
    }
  }
}
