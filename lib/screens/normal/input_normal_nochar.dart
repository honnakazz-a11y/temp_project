part of '../../main.dart';

/// 入力（通常）キャラなし・ハード系のみ
class InputScreenNormalNoChar extends StatefulWidget {
  const InputScreenNormalNoChar({super.key});

  @override
  State<InputScreenNormalNoChar> createState() => _InputScreenNormalNoCharState();
}

class _InputScreenNormalNoCharState extends State<InputScreenNormalNoChar> {
  // 既定は normal
  LevelTier currentTier = LevelTier.normal;

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
      RelPositioned(
        x: 52, y: 20, width: 238, height: 96,
        child: UxImageButton(
          normalAsset: 'assets/images/btn_back_top_default.png',
          pressedAsset: 'assets/images/btn_back_top_pressed.png',
          onPressed: () => NavHelper.backOrFallbackToMenu(context, isUra: false),
          semanticLabel: '上戻る',
          width: 238, height: 96,
        ),
      ),

      // 入力欄
      const RelPositioned(
        x: 0, y: 953, width: 1080, height: 282,
        child: ImageAsset('assets/images/input_field.png'),
      ),

      // LevelSlider（現在値はStateで保持）
      RelPositioned(
        x: 28, y: 1376, width: 372, height: 221,
        child: LevelSlider(
          value: currentTier,
          onChanged: (tier) => setState(() => currentTier = tier),
          isUra: false,
        ),
      ),

      // アナログメーター（仮）
      RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: JitteredFrame(
          baseIndex: 0, // TODO: 入力文字数や審問結果に応じて 0/1/3/5/7 に丸める
          mode: JitterMode.normal,
        ),
      ),

      // 言い訳爆誕（/generate/normal へ、tier 引き継ぎは現状どおり）
      RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: UxImageButton(
          normalAsset: 'assets/images/btn_generate_default.png',
          pressedAsset: 'assets/images/btn_generate_pressed.png',
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/generate/normal',
              arguments: {'level': currentTier.name},
            );
          },
          semanticLabel: '言い訳爆誕',
          width: 946, height: 214,
        ),
      ),

      // シェア（ダミー）
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
