import 'package:flutter/widgets.dart';
import '../constants/assets.dart';

class AssetRegistry {
  AssetRegistry._();

  static Future<void> precacheCommon(BuildContext context) async {
    // 戻るボタン系（上・下）
    await precacheImage(AssetImage(Assets.img.button.backUpperNormal), context);
    await precacheImage(AssetImage(Assets.img.button.backUpperPressed), context);
    await precacheImage(AssetImage(Assets.img.button.backLowerNormal), context);
    await precacheImage(AssetImage(Assets.img.button.backLowerPressed), context);
  }

  /// 生成画面系（通常/裏 共通）＋メーター18枚＋レベルスライダー
  static Future<void> precacheGenerate(BuildContext context) async {
    await precacheCommon(context);

    // メーター18枚を一括プリロード（framesに統一）
    for (final p in Assets.img.meter.frames) {
      await precacheImage(AssetImage(p), context);
    }

    // レベルスライダー（kami / normal / unko）
    await Future.wait([
      precacheImage(AssetImage(Assets.img.level.trackKami), context),
      precacheImage(AssetImage(Assets.img.level.trackNormal), context),
      precacheImage(AssetImage(Assets.img.level.trackUnko), context),
    ]);
  }

  /// 解析系で必要なプリロード（必要に応じて拡張）
  static Future<void> precacheAnalysis(BuildContext context) async {
    await precacheCommon(context);

    // メーター（解析でも使うため、全フレーム）
    for (final p in Assets.img.meter.frames) {
      await precacheImage(AssetImage(p), context);
    }
  }

  /// 禁断/裏テーマなど
  static Future<void> precacheForbidden(BuildContext context) async {
    await precacheCommon(context);

    // 裏テーマ背景・オーバーレイ
    await precacheImage(AssetImage(Assets.img.ura.bg), context);
    await precacheImage(AssetImage(Assets.img.ura.crtOverlay), context);

    // メーター（禁断=MAX帯、ただし今は全フレームまとめて）
    for (final p in Assets.img.meter.frames) {
      await precacheImage(AssetImage(p), context);
    }
  }
}
