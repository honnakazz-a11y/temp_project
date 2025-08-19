import 'package:flutter/widgets.dart';
import '../constants/assets.dart';

class AssetRegistry {
  AssetRegistry._();

  static Future<void> precacheCommon(BuildContext context) async {
    await precacheImage(AssetImage(Assets.img.button.backUpperNormal), context);
    await precacheImage(AssetImage(Assets.img.button.backUpperPressed), context);
    await precacheImage(AssetImage(Assets.img.button.backLowerNormal), context);
    await precacheImage(AssetImage(Assets.img.button.backLowerPressed), context);
  }

  static Future<void> precacheGenerate(BuildContext context) async {
    await precacheCommon(context);
    for (final frame in Assets.img.meter.frames) {
      await precacheImage(AssetImage(frame), context);
    }
    // 生成系の他ボタンも必要に応じて追加
  }

  static Future<void> precacheAnalysis(BuildContext context) async {
    await precacheCommon(context);
    // 解析系に必要なものを適宜追加
  }

  static Future<void> precacheForbidden(BuildContext context) async {
    await precacheCommon(context);
    await precacheImage(AssetImage(Assets.img.ura.bg), context);
    await precacheImage(AssetImage(Assets.img.ura.crtOverlay), context);
  }
}
