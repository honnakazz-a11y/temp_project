part of '../../main.dart';

/// 解析モード入力（裏）キャラなし・ハード系のみ
class AnalysisInputScreenUraNoChar extends StatefulWidget {
  const AnalysisInputScreenUraNoChar({super.key});

  @override
  State<AnalysisInputScreenUraNoChar> createState() =>
      _AnalysisInputScreenUraNoCharState();
}

class _AnalysisInputScreenUraNoCharState extends State<AnalysisInputScreenUraNoChar> {
  @override
  void initState() {
    super.initState();
    // 解析系アセットの事前読み込み（チラつき防止）
    AssetRegistry.precacheAnalysis(context);
  }

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

      // 戻る（上）＝ 基本動作（1つ前へ戻る）／スタック無し→ /menu/ura にフォールバック
      RelPositioned(
        x: 52, y: 20, width: 238, height: 96,
        child: UxImageButton(
          normalAsset: Assets.img.button.backUpperNormal,
          pressedAsset: Assets.img.button.backUpperPressed,
          onPressed: () => NavHelper.backOrFallbackToMenu(context, isUra: true),
          semanticLabel: '上戻る',
          width: 238, height: 96,
        ),
      ),

      // 入力欄
      const RelPositioned(
        x: 0, y: 953, width: 1080, height: 282,
        child: ImageAsset('assets/images/input_field.png'),
      ),

      // メーター（初期：0）
      RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: JitteredFrame(
          baseIndex: 0, // TODO: 入力文字数や審問結果に応じて 0/1/3/5/7 に丸める
          mode: JitterMode.normal,
        ),
      ),

      // 解析開始ボタン → /analysis/result へ遷移
      RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: UxImageButton(
          normalAsset: 'assets/images/btn_analyze_default.png',
          pressedAsset: 'assets/images/btn_analyze_pressed.png',
          onPressed: () {
            Navigator.pushNamed(context, '/analysis/result');
          },
          semanticLabel: '解析開始',
          width: 946, height: 214,
        ),
      ),

      // シェア
      RelPositioned(
        x: 550, y: 1926, width: 500, height: 200,
        child: UxImageButton(
          normalAsset: 'assets/images/btn_share_default.png',
          pressedAsset: 'assets/images/btn_share_pressed.png',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('準備中です')),
            );
          },
          semanticLabel: 'シェア（準備中）',
          width: 500, height: 200,
        ),
      ),  
    ]);
  }
}
