import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

part 'screens/opening/splash_video_screen.dart';
part 'screens/normal/guide_normal.dart';
part 'screens/ura/guide_ura.dart';
part 'screens/normal/menu_normal.dart';
part 'screens/ura/menu_ura.dart';
part 'screens/normal/input_normal_nochar.dart';
part 'screens/ura/input_ura_nochar.dart';
part 'screens/normal/generate_normal_no_char.dart';
part 'screens/ura/generate_ura_no_char.dart';
part 'screens/ura/analysis_input_ura.dart';
part 'screens/ura/analysis_result_ura.dart';
part 'screens/ura/forbidden_ura_no_char.dart';

void main() => runApp(const TempProjectApp());

class TempProjectApp extends StatelessWidget {
  const TempProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // 初期表示は必要に応じて
      home: const ForbiddenScreenUraNoChar(),
      routes: {
        '/opening': (context) => const SplashVideoScreen(), 
        '/input/normal': (context) => const InputScreenNormalNoChar(),
        '/guide/normal': (context) => const GuideScreenNormal(),
        '/menu/normal': (context) => const MenuScreenNormal(),
        '/analysis/result': (context) => const AnalysisResultScreenUra(),
        '/menu/ura': (context) => const MenuScreenUra(),
        '/input/ura': (context) => const InputScreenUraNoChar(),
        '/generate/ura': (context) => const GenerateScreenUraNoChar(),
        '/analysis/input/ura': (context) => const AnalysisInputScreenUra(),
        '/generate/normal': (context) => const GenerateScreenNoChar(),
        '/guide/ura': (context) => const GuideScreenUra(),
        '/forbidden/ura': (context) => const ForbiddenScreenUraNoChar(),        
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

