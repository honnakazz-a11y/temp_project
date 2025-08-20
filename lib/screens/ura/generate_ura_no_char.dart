part of '../../main.dart';

/// 生成（裏）キャラなし
class GenerateScreenUraNoChar extends StatefulWidget {
  const GenerateScreenUraNoChar({super.key});

  @override
  State<GenerateScreenUraNoChar> createState() => _GenerateScreenUraNoCharState();
}

class _GenerateScreenUraNoCharState extends State<GenerateScreenUraNoChar> {
  late LevelTier currentTier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final tierStr = args?['level'] as String?;
    currentTier = LevelTierX.fromName(tierStr);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(children: [
      // 背景（裏）
      const Positioned.fill(
        child: ImageAsset('assets/images/bg_dark_default.png'),
      ),

      // ブラウン管（裏）
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

      // LevelSlider（引き継いだtierを初期表示）
      RelPositioned(
        x: 28, y: 1376, width: 372, height: 221,
        child: LevelSlider(
          value: currentTier,
          onChanged: (tier) => setState(() => currentTier = tier),
          isUra: true,
        ),
      ),

      // 入力欄（表示のみ）
      const RelPositioned(
        x: 0, y: 953, width: 1080, height: 282,
        child: ImageAsset('assets/images/input_field.png'),
      ),

      // アナログメーター（仮）
      const RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: ImageAsset('assets/images/meter_0.png'),
      ),
      
      // 禁断ボタン（裏はアクティブ：/forbidden/ura）
      RelPositioned(
        x: 413, y: 1248, width: 260, height: 384,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, '/forbidden/ura'),
            child: const ImageAsset('assets/images/btn_forbidden_default.png'),
          ),
        ),
      ),

      // もう一度トライ（表示のみ）
      const RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: ImageAsset('assets/images/btn_tryagain_default.png'),
      ),

      // 戻る（下）：RG3-1 演出 → 約2秒後に /menu/ura
      RelPositioned(
        x: 26, y: 1926, width: 500, height: 200,
        child: UxImageButton(
          normalAsset: Assets.img.button.backLowerNormal,
          pressedAsset: Assets.img.button.backLowerPressed,
          onPressed: () => UbixEffects.showLineThenGo(context, toRoute: '/menu/ura'),
          semanticLabel: '下戻る',
          width: 500, height: 200,
        ),
      ),

      // シェア（表示のみ）
      const RelPositioned(
        x: 550, y: 1926, width: 500, height: 200,
        child: ImageAsset('assets/images/btn_share_default.png'),
      ),
    ]);
  }
}
