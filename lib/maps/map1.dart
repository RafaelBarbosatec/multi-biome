import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:multibiomegame/main.dart';
import 'package:multibiomegame/maps/map2.dart';
import 'package:multibiomegame/player/game_player.dart';
import 'package:multibiomegame/player/sprite_sheet_hero.dart';
import 'package:multibiomegame/util/exit_map_sensor.dart';

class Map1 extends StatelessWidget {
  final ShowInEnum showInEnum;

  const Map1({Key key, this.showInEnum = ShowInEnum.left}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BonfireTiledWidget(
      joystick: Joystick(
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
          (x, y, width, height) => ExitMapSensor(
            'sensorRight',
            Position(x, y),
            width,
            height,
            (v) => _exitMap(v, context),
          ),
        ),
      cameraMoveOnlyMapArea: true,
      progress: SizedBox.shrink(),
    );
  }

  Position _getInitPosition() {
    switch (showInEnum) {
      case ShowInEnum.left:
        return Position(tileSize * 2, tileSize * 10);
        break;
      case ShowInEnum.right:
        return Position(tileSize * 27, tileSize * 12);
        break;
      case ShowInEnum.top:
        return Position.empty();
        break;
      case ShowInEnum.bottom:
        return Position.empty();
        break;
      default:
        return Position.empty();
    }
  }

  void _exitMap(String value, BuildContext context) {
    if (value == 'sensorRight') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Map2(
            showInEnum: ShowInEnum.left,
          ),
        ),
        (Route<dynamic> route) => false,
      );
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
