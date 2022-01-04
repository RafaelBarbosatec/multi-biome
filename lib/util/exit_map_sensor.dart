import 'package:bonfire/bonfire.dart';
import 'package:flutter/widgets.dart';

class ExitMapSensor extends GameDecoration with Sensor {
  final String id;
  bool hasContact = false;
  final ValueChanged<String> exitMap;

  ExitMapSensor(this.id, Vector2 position, Vector2 size, this.exitMap)
      : super(
          position: position,
          size: size,
        );

  @override
  void onContact(collision) {
    if (!hasContact && collision is Player) {
      hasContact = true;
      exitMap(id);
    }
  }
}
