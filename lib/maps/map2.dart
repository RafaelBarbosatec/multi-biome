import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:multibiomegame/main.dart';
import 'package:multibiomegame/maps/map1.dart';
import 'package:multibiomegame/player/game_player.dart';
import 'package:multibiomegame/player/sprite_sheet_hero.dart';
import 'package:multibiomegame/util/exit_map_sensor.dart';
import 'package:multibiomegame/util/extensions.dart';

class Map2 extends StatelessWidget {
  final ShowInEnum showInEnum;

  const Map2({Key key, this.showInEnum = ShowInEnum.left}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BonfireTiledWidget(
      joystick: Joystick(
        keyboardConfig: KeyboardConfig(),
        directional: JoystickDirectional(),
      ),
      player: GamePlayer(
        _getInitPosition(),
        SpriteSheetHero.hero1,
        initDirection: _getDirection(),
      ),
      map: TiledWorldMap(
        'maps/map_biome2.json',
        forceTileSize: Size(tileSize, tileSize),
      )..registerObject(
          'sensorLeft',
          (p) => ExitMapSensor(
            'sensorLeft',
            p.position,
            p.size,
            (v) => _exitMap(v, context),
          ),
        ),
      cameraConfig: CameraConfig(moveOnlyMapArea: true),
      progress: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.black,
      ),
    );
  }

  Vector2 _getInitPosition() {
    switch (showInEnum) {
      case ShowInEnum.left:
        return Vector2(tileSize * 1, tileSize * 14);
        break;
      case ShowInEnum.right:
        return Vector2(tileSize * 28, tileSize * 12);
        break;
      case ShowInEnum.top:
        return Vector2.zero();
        break;
      case ShowInEnum.bottom:
        return Vector2.zero();
        break;
      default:
        return Vector2.zero();
    }
  }

  void _exitMap(String value, BuildContext context) {
    if (value == 'sensorLeft') {
      context.goTo(Map1(
        showInEnum: ShowInEnum.right,
      ));
    }
  }

  Direction _getDirection() {
    switch (showInEnum) {
      case ShowInEnum.left:
        return Direction.right;
        break;
      case ShowInEnum.right:
        return Direction.left;
        break;
      case ShowInEnum.top:
        return Direction.right;
        break;
      case ShowInEnum.bottom:
        return Direction.right;
        break;
      default:
        return Direction.right;
    }
  }
}
