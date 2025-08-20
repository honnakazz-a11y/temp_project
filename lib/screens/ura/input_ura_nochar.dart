part of '../../main.dart';

/// 入力（裏）キャラなし・ハード系のみ
class InputScreenUraNoChar extends StatefulWidget {
  const InputScreenUraNoChar({super.key});

  @override
  State<InputScreenUraNoChar> createState() => _InputScreenUraNoCharState();
}

class _InputScreenUraNoCharState extends State<InputScreenUraNoChar> {
  LevelTier currentTier = LevelTier.normal;

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

      // 戻る（上）
      RelPositioned(
        x: 52, y: 20, width: 238, height: 96,
        child: UxImageButton(
          normalAsset: 'assets/images/btn_back_top_default.png',
          pressedAsset: 'assets/images/btn_back_top_pressed.png',
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

      // LevelSlider
      RelPositioned(
        x: 28, y: 1376, width: 372, height: 221,
        child: LevelSlider(
          value: currentTier,
          onChanged: (tier) => setState(() => currentTier = tier),
          isUra: true,
        ),
      ),

      // アナログメーター（仮）
      const RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: ImageAsset('assets/images/meter_0.png'),
      ),

      // 生成 → /generate/ura（level を arguments で渡す）
      RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/generate/ura',
                arguments: {'level': currentTier.name},
              );
            },
            child: const ImageAsset('assets/images/btn_generate_default.png'),
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
