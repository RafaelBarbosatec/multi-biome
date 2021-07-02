import 'package:bonfire/bonfire.dart';

class SpriteSheetHero {
  static Future<void> load() async {
    hero1 = await _create('hero1.png');
  }

  static Future<SpriteSheet> _create(String path) async {
    final image = await Flame.images.load(path);
    return SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 3,
      rows: 8,
    );
  }

  static SpriteSheet hero1;
}
