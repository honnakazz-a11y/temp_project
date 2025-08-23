// lib/helpers/asset_registry.dart
import 'package:flutter/widgets.dart';
import '../constants/assets.dart';

class AssetRegistry {
  AssetRegistry._();

  /// 共通：戻る系・シェアなど（どの画面でも使う最低限）
  static Future<void> precacheCommon(BuildContext context) async {
    // 戻る（上/下）
    await precacheImage(AssetImage(Assets.img.button.backUpperNormal), context);
    await precacheImage(AssetImage(Assets.img.button.backUpperPressed), context);
    await precacheImage(AssetImage(Assets.img.button.backLowerNormal), context);
    await precacheImage(AssetImage(Assets.img.button.backLowerPressed), context);

    // シェア
    await precacheImage(const AssetImage('assets/images/btn_share_default.png'), context);
    await precacheImage(const AssetImage('assets/images/btn_share_pressed.png'), context);

    // （必要に応じて）お告げ
    await precacheImage(const AssetImage('assets/images/btn_oracle_default.png'), context);
    await precacheImage(const AssetImage('assets/images/btn_oracle_pressed.png'), context);
    
    await precacheImage(AssetImage(Assets.img.ura.bgDefault), context);
    await precacheImage(AssetImage(Assets.img.ura.bgGlitch1), context);
    await precacheImage(AssetImage(Assets.img.ura.bgGlitch2), context);

    await precacheImage(AssetImage(Assets.img.ura.frameDefault), context);
    await precacheImage(AssetImage(Assets.img.ura.frameGlitch1), context);
    await precacheImage(AssetImage(Assets.img.ura.frameGlitch2), context);
    await precacheImage(AssetImage(Assets.img.ura.frameGlitch3), context);    
    
  }

  /// 生成画面用：共通＋メーター全フレーム＋レベルスライダー
  static Future<void> precacheGenerate(BuildContext context) async {
    await precacheCommon(context);

    // メーター18枚
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

  /// 解析系で使うもの（共通＋メーター）
  static Future<void> precacheAnalysis(BuildContext context) async {
    await precacheCommon(context);
    for (final p in Assets.img.meter.frames) {
      await precacheImage(AssetImage(p), context);
    }
  }

  /// 禁断/裏テーマ（共通＋裏背景＋CRTオーバーレイ＋メーター）
  static Future<void> precacheForbidden(BuildContext context) async {
    await precacheCommon(context);

    await precacheImage(AssetImage(Assets.img.ura.bgDefault), context);
    await precacheImage(AssetImage(Assets.img.ura.frameDefault), context);

    for (final p in Assets.img.meter.frames) {
      await precacheImage(AssetImage(p), context);
    }
  }
}
