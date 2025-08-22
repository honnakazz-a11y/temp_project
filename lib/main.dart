// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'widgets/jittered_frame.dart';
import 'widgets/ubix_crt.dart';
import 'constants/ubix_oracle_100.dart';

// 集中定義・プリロード（import）
import 'constants/assets.dart';
import 'helpers/asset_registry.dart';

// ===== このプロジェクトの「同一ライブラリ」ファイル（part） =====
part 'screens/opening/splash_video_screen.dart';

part 'screens/normal/guide_normal.dart';
part 'screens/normal/menu_normal.dart';
part 'screens/normal/input_normal_nochar.dart';
part 'screens/normal/generate_normal_no_char.dart';

part 'screens/ura/guide_ura.dart';
part 'screens/ura/menu_ura.dart';
part 'screens/ura/input_ura_nochar.dart';
part 'screens/ura/generate_ura_no_char.dart';
part 'screens/ura/analysis_input_ura_nochar.dart';
part 'screens/ura/analysis_result_ura_nochar.dart';
part 'screens/ura/forbidden_ura_no_char.dart';

part 'screens/oracle.dart';

part 'helpers/navigation_helper.dart';
part 'helpers/ubix_effects.dart';

part 'widgets/ux_image_button.dart';
part 'widgets/ux_toggle_image_button.dart';
part 'widgets/level_slider.dart';
// ================================================================

void main() => runApp(const TempProjectApp());

class TempProjectApp extends StatelessWidget {
  const TempProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // 必要に応じて初期画面を切り替え
      home: const MenuScreenUra(),
      routes: {
        '/opening': (context) => const SplashVideoScreen(),

        // 入力
        '/input/normal': (context) => const InputScreenNormalNoChar(),
        '/input/ura':    (context) => const InputScreenUraNoChar(),

        // 生成
        '/generate/normal': (context) => const GenerateScreenNormalNoChar(),
        '/generate/ura':    (context) => const GenerateScreenUraNoChar(),

        // 解析（NoChar）
        '/analysis/input/ura': (context) => const AnalysisInputScreenUraNoChar(),
        '/analysis/result':    (context) => const AnalysisResultScreenUraNoChar(),

        // 禁断・お告げ
        '/forbidden/ura': (context) => const ForbiddenScreenUraNoChar(),
        '/oracle':        (context) => const OracleScreen(),

        // メニュー
        '/menu/normal': (context) => const MenuScreenNormal(),
        '/menu/ura':    (context) => const MenuScreenUra(),

        // ガイド
        '/guide/normal': (context) => const GuideScreenNormal(),
        '/guide/ura':    (context) => const GuideScreenUra(),
      },
    );
  }
}
/* =========================
   共通ユーティリティ
   ========================= */

/// アセット画像の薄いラッパ
class ImageAsset extends StatelessWidget {
  final String path;
  const ImageAsset(this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
}

/// 相対配置（1080x2160基準）。レターボックス対応版
class RelPositioned extends StatelessWidget {
  static const double baseW = 1080;
  static const double baseH = 2160;

  final double x, y, width, height;
  final Widget child;

  const RelPositioned({
    super.key,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // 画面に 1080x2160 を比率固定でフィットさせ、余白を計算
    final scale = size.width / baseW;
    final offsetX = (size.width - baseW * scale) / 2;
    final offsetY = 0;

    return Positioned(
      left:  offsetX + x * scale,
      top:   offsetY + y * scale,
      width:        width  * scale,
      height:       height * scale,
      child: child,
    );
  }
}

/// 画面の外枠：1080:2160の縦横比を固定し、中央にレターボックスで収める
class BaseScreen extends StatelessWidget {
  final List<Widget> children;
  const BaseScreen({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    const baseW = 1080.0, baseH = 2160.0;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AspectRatio(
            aspectRatio: baseW / baseH,
            child: Stack(children: children),
          ),
        ),
      ),
    );
  }
}

