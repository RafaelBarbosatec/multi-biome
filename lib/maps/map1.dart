import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:multibiomegame/main.dart';
import 'package:multibiomegame/maps/map2.dart';
import 'package:multibiomegame/player/game_player.dart';
import 'package:multibiomegame/player/sprite_sheet_hero.dart';
import 'package:multibiomegame/util/exit_map_sensor.dart';
import 'package:multibiomegame/util/extensions.dart';

class Map1 extends StatelessWidget {
  final ShowInEnum showInEnum;

  const Map1({Key key, this.showInEnum = ShowInEnum.left}) : super(key: key);
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
        'maps/map_biome1.json',
        forceTileSize: Size(tileSize, tileSize),
      )..registerObject(
          'sensorRight',
          (p) => ExitMapSensor(
            'sensorRight',
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
        return Vector2(tileSize * 2, tileSize * 10);
        break;
      case ShowInEnum.right:
        return Vector2(tileSize * 27, tileSize * 12);
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
    if (value == 'sensorRight') {
      context.goTo(Map2(
        showInEnum: ShowInEnum.left,
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
