import 'package:flutter/material.dart';
part 'screens/normal/guide_normal.dart';
part 'screens/ura/guide_ura.dart';
part 'screens/normal/menu_normal.dart';
part 'screens/ura/menu_ura.dart';

void main() => runApp(const TempProjectApp());

class TempProjectApp extends StatelessWidget {
  const TempProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // 初期表示は必要に応じて
      home: const MenuScreenUra(),
      routes: {
        '/input/normal': (context) => const InputScreenNormal(),
        '/guide/normal': (context) => const GuideScreenNormal(),
        '/menu/normal': (context) => const MenuScreenNormal(),
        '/analysis/result': (context) => const AnalysisResultScreenUra(),
        '/menu/ura': (context) => const MenuScreenUra(),
        '/input/ura': (context) => const InputScreenUra(),
        '/generate/ura': (context) => const GenerateScreenUraNoChar(),
        '/analysis/input/ura': (context) => const AnalysisInputScreenUra(),
        '/generate/normal': (context) => const GenerateScreenNoChar(),
        '/guide/ura': (context) => const GuideScreenUra(),
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

/* =========================
   メニュー（通常／裏）
   ========================= */



/* =========================
   生成（通常／裏）※キャラなし
   ========================= */

/// 生成（通常）キャラなし
class GenerateScreenNoChar extends StatelessWidget {
  const GenerateScreenNoChar({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(children: [
      // 背景（通常）
      const Positioned.fill(
        child: ImageAsset('assets/images/bg_main_default.png'),
      ),
      // ブラウン管（default）
      const RelPositioned(
        x: 0, y: 100, width: 1080, height: 810,
        child: ImageAsset('assets/images/label_braun_frame_default.png'),
      ),
      // 音声トグル
      const RelPositioned(
        x: 786, y: 20, width: 272, height: 96,
        child: ImageAsset('assets/images/btn_sound_toggle_on.png'),
      ),
      // 戻る（上）
      const RelPositioned(
        x: 52, y: 20, width: 238, height: 96,
        child: ImageAsset('assets/images/btn_back_top_default.png'),
      ),
      // 入力欄（表示のみ）
      const RelPositioned(
        x: 0, y: 953, width: 1080, height: 282,
        child: ImageAsset('assets/images/input_field.png'),
      ),
      // メーター（例：5）
      const RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: ImageAsset('assets/images/meter_5.png'),
      ),
      // スライダー（普通）
      const RelPositioned(
        x: 28, y: 1376, width: 372, height: 221,
        child: ImageAsset('assets/images/slider_level_normal.png'),
      ),
      // 禁断（仮ダイアログ）
      RelPositioned(
        x: 413, y: 1248, width: 260, height: 384,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: const Text('アップグレード後にご利用になれます。今すぐアップグレードする？'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context), // 閉じるだけ
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context), // 閉じるだけ
                      child: const Text('No'),
                    ),
                  ],
                ),
              );
            },
            child: const ImageAsset('assets/images/btn_forbidden_default.png'),
          ),
        ),
      ),
      // もう一度トライ
      const RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: ImageAsset('assets/images/btn_tryagain_default.png'),
      ),
      // 戻る（下）
      RelPositioned(
        x: 26, y: 1926, width: 500, height: 200,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/menu/normal');
            },
            child: const ImageAsset('assets/images/btn_back_bottom_default.png'),
          ),
        ),
      ),
      // シェア
      const RelPositioned(
        x: 550, y: 1926, width: 500, height: 200,
        child: ImageAsset('assets/images/btn_share_default.png'),
      ),
    ]);
  }
}

/// 生成（裏）キャラなし（背景のみ差し替え）
class GenerateScreenUraNoChar extends StatelessWidget {
  const GenerateScreenUraNoChar({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(children: [
      // 背景（裏）
      const Positioned.fill(
        child: ImageAsset('assets/images/bg_dark_default.png'),
      ),
      // ブラウン管（裏：default）
      const RelPositioned(
        x: 0, y: 100, width: 1080, height: 810,
        child: ImageAsset('assets/images/label_braun_frame_default.png'),
      ),
      // 音声トグル
      const RelPositioned(
        x: 786, y: 20, width: 272, height: 96,
        child: ImageAsset('assets/images/btn_sound_toggle_on.png'),
      ),
      // 戻る（上）
      const RelPositioned(
        x: 52, y: 20, width: 238, height: 96,
        child: ImageAsset('assets/images/btn_back_top_default.png'),
      ),
      // 入力欄（表示のみ）
      const RelPositioned(
        x: 0, y: 953, width: 1080, height: 282,
        child: ImageAsset('assets/images/input_field.png'),
      ),
      // メーター（例：5）
      const RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: ImageAsset('assets/images/meter_5.png'),
      ),
      // スライダー（普通）
      const RelPositioned(
        x: 28, y: 1376, width: 372, height: 221,
        child: ImageAsset('assets/images/slider_level_normal.png'),
      ),
      // 禁断ボタン（裏はアクティブ遷移先あり：後段で実装）
      const RelPositioned(
        x: 413, y: 1248, width: 260, height: 384,
        child: ImageAsset('assets/images/btn_forbidden_default.png'),
      ),
      // もう一度トライ
      const RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: ImageAsset('assets/images/btn_tryagain_default.png'),
      ),
      // 戻る（下）→ /menu/ura へ即時遷移（挙動を元に戻す）
      RelPositioned(
        x: 26, y: 1926, width: 500, height: 200,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/menu/ura');
            },
            child: const ImageAsset('assets/images/btn_back_bottom_default.png'),
          ),
        ),
      ),
      // シェア
      const RelPositioned(
        x: 550, y: 1926, width: 500, height: 200,
        child: ImageAsset('assets/images/btn_share_default.png'),        
      ),
    ]); 
  }
}

/// 入力（通常）キャラなし・ハード系のみ
class InputScreenNormal extends StatelessWidget {
  const InputScreenNormal({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(children: [
      // 背景（通常）
      const Positioned.fill(
        child: ImageAsset('assets/images/bg_main_default.png'),
      ),

      // ブラウン管（通常：default）
      const RelPositioned(
        x: 0, y: 100, width: 1080, height: 810,
        child: ImageAsset('assets/images/label_braun_frame_default.png'),
      ),

      // 音声トグル（右上）
      const RelPositioned(
        x: 786, y: 20, width: 272, height: 96,
        child: ImageAsset('assets/images/btn_sound_toggle_on.png'),
      ),

      // 戻る（上）
      const RelPositioned(
        x: 52, y: 20, width: 238, height: 96,
        child: ImageAsset('assets/images/btn_back_top_default.png'),
      ),

      // 入力欄
      const RelPositioned(
        x: 0, y: 953, width: 1080, height: 282,
        child: ImageAsset('assets/images/input_field.png'),
      ),

      // スライダー（初期：普通）
      const RelPositioned(
        x: 28, y: 1376, width: 372, height: 221,
        child: ImageAsset('assets/images/slider_level_normal.png'),
      ),

      // アナログメーター（初期：0）
      const RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: ImageAsset('assets/images/meter_0.png'),
      ),

      // 言い訳生成ボタン → /generate/normal へ遷移
      RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/generate/normal');
            },
            child: const ImageAsset('assets/images/btn_generate_default.png'),
          ),
        ),
      ),

      // 戻る（下）→ /menu/normal へ遷移
      RelPositioned(
        x: 26, y: 1926, width: 500, height: 200,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/menu/normal');
            },
            child: const ImageAsset('assets/images/btn_back_bottom_default.png'),
          ),
        ),
      ),
      // シェア
      const RelPositioned(
        x: 550, y: 1926, width: 500, height: 200,
        child: ImageAsset('assets/images/btn_share_default.png'),
      ),
    ]);
  }
}

/// 入力（裏）キャラなし・ハード系のみ
class InputScreenUra extends StatelessWidget {
  const InputScreenUra({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(children: [
      // 背景（裏）
      const Positioned.fill(
        child: ImageAsset('assets/images/bg_dark_default.png'),
      ),

      // ブラウン管（裏：glitch1）
      const RelPositioned(
        x: 0, y: 100, width: 1080, height: 810,
        child: ImageAsset('assets/images/label_braun_frame_glitch1.png'),
      ),

      // 音声トグル（右上）
      const RelPositioned(
        x: 786, y: 20, width: 272, height: 96,
        child: ImageAsset('assets/images/btn_sound_toggle_on.png'),
      ),

      // 戻る（上）
      const RelPositioned(
        x: 52, y: 20, width: 238, height: 96,
        child: ImageAsset('assets/images/btn_back_top_default.png'),
      ),

      // 入力欄
      const RelPositioned(
        x: 0, y: 953, width: 1080, height: 282,
        child: ImageAsset('assets/images/input_field.png'),
      ),

      // スライダー（初期：普通）
      const RelPositioned(
        x: 28, y: 1376, width: 372, height: 221,
        child: ImageAsset('assets/images/slider_level_normal.png'),
      ),

      // アナログメーター（初期：0）
      const RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: ImageAsset('assets/images/meter_0.png'),
      ),

      // 言い訳生成ボタン → /analysis/input/ura へ遷移
      RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/generate/ura');
            },
            child: const ImageAsset('assets/images/btn_generate_default.png'),
          ),
        ),
      ),

      // 戻る（下）→ /menu/ura へ遷移
      RelPositioned(
        x: 26, y: 1926, width: 500, height: 200,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/menu/ura');
            },
            child: const ImageAsset('assets/images/btn_back_bottom_default.png'),
          ),
        ),
      ),
      // シェア
      const RelPositioned(
        x: 550, y: 1926, width: 500, height: 200,
        child: ImageAsset('assets/images/btn_share_default.png'),
      ),
    ]);
  }
}

/// 禁断の言い訳（裏）キャラなし・ハード系のみ
class ForbiddenScreenUra extends StatelessWidget {
  const ForbiddenScreenUra({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(children: [
      // 背景（裏）
      const Positioned.fill(
        child: ImageAsset('assets/images/bg_dark_default.png'),
      ),

      // ブラウン管（裏：default）
      const RelPositioned(
        x: 0, y: 100, width: 1080, height: 810,
        child: ImageAsset('assets/images/label_braun_frame_default.png'),
      ),

      // 音声トグル（右上）
      const RelPositioned(
        x: 786, y: 20, width: 272, height: 96,
        child: ImageAsset('assets/images/btn_sound_toggle_on.png'),
      ),

      // 戻る（上）→ 裏モード入力に戻る（遷移は後で）
      const RelPositioned(
        x: 52, y: 20, width: 238, height: 96,
        child: ImageAsset('assets/images/btn_back_top_default.png'),
      ),

      // 入力欄（表示のみ）
      const RelPositioned(
        x: 0, y: 953, width: 1080, height: 282,
        child: ImageAsset('assets/images/input_field.png'),
      ),

      // アナログメーター（禁断はMAX）
      const RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: ImageAsset('assets/images/meter_max.png'),
      ),

      // Ubixのお告げボタン（禁断用）
      const RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: ImageAsset('assets/images/btn_oracle_default.png'),
      ),

      // 戻る（下）→ 裏モード入力に戻る（遷移は後で）
      const RelPositioned(
        x: 26, y: 1926, width: 500, height: 200,
        child: ImageAsset('assets/images/btn_back_bottom_default.png'),
      ),

      // シェア
      const RelPositioned(
        x: 550, y: 1926, width: 500, height: 200,
        child: ImageAsset('assets/images/btn_share_default.png'),
      ),
    ]);
  }
}

/// 解析モード入力（裏）キャラなし・ハード系のみ
class AnalysisInputScreenUra extends StatelessWidget {
  const AnalysisInputScreenUra({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(children: [
      // 背景（裏）
      const Positioned.fill(
        child: ImageAsset('assets/images/bg_dark_default.png'),
      ),

      // ブラウン管（裏：default）
      const RelPositioned(
        x: 0, y: 100, width: 1080, height: 810,
        child: ImageAsset('assets/images/label_braun_frame_default.png'),
      ),

      // 音声トグル
      const RelPositioned(
        x: 786, y: 20, width: 272, height: 96,
        child: ImageAsset('assets/images/btn_sound_toggle_on.png'),
      ),

      // 戻る（上）
      const RelPositioned(
        x: 52, y: 20, width: 238, height: 96,
        child: ImageAsset('assets/images/btn_back_top_default.png'),
      ),

      // 入力欄
      const RelPositioned(
        x: 0, y: 953, width: 1080, height: 282,
        child: ImageAsset('assets/images/input_field.png'),
      ),

      // メーター（初期：0）
      const RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: ImageAsset('assets/images/meter_0.png'),
      ),

      // 解析開始ボタン → /analysis/result へ遷移
      RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/analysis/result');
            },
            child: const ImageAsset('assets/images/btn_analyze_default.png'),
          ),
        ),
      ),

      // 戻る（下）
      const RelPositioned(
        x: 26, y: 1926, width: 500, height: 200,
        child: ImageAsset('assets/images/btn_back_bottom_default.png'),
      ),

      // シェア
      const RelPositioned(
        x: 550, y: 1926, width: 500, height: 200,
        child: ImageAsset('assets/images/btn_share_default.png'),
      ),
    ]);
  }
}

/// 解析モード結果（裏）キャラなし・ハード系のみ
class AnalysisResultScreenUra extends StatelessWidget {
  const AnalysisResultScreenUra({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(children: [
      // 背景（裏）
      const Positioned.fill(
        child: ImageAsset('assets/images/bg_dark_default.png'),
      ),

      // ブラウン管（裏：default）
      const RelPositioned(
        x: 0, y: 100, width: 1080, height: 810,
        child: ImageAsset('assets/images/label_braun_frame_default.png'),
      ),

      // 音声トグル
      const RelPositioned(
        x: 786, y: 20, width: 272, height: 96,
        child: ImageAsset('assets/images/btn_sound_toggle_on.png'),
      ),

      // 戻る（上）
      const RelPositioned(
        x: 52, y: 20, width: 238, height: 96,
        child: ImageAsset('assets/images/btn_back_top_default.png'),
      ),

      // 入力欄（表示のみ）
      const RelPositioned(
        x: 0, y: 953, width: 1080, height: 282,
        child: ImageAsset('assets/images/input_field.png'),
      ),

      // メーター（仮値：5）
      const RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: ImageAsset('assets/images/meter_5.png'),
      ),

      // Ubixのお告げボタン
      const RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: ImageAsset('assets/images/btn_oracle_default.png'),
      ),

      // 戻る（下）→ /menu/ura へ遷移
      RelPositioned(
        x: 26, y: 1926, width: 500, height: 200,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/menu/ura');
            },
            child: const ImageAsset('assets/images/btn_back_bottom_default.png'),
          ),
        ),
      ),
      // シェア
      const RelPositioned(
        x: 550, y: 1926, width: 500, height: 200,
        child: ImageAsset('assets/images/btn_share_default.png'),
      ),
    ]);
  }
}
