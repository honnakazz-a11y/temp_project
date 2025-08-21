part of '../../main.dart';

/// 生成（裏）キャラなし
class GenerateScreenUraNoChar extends StatefulWidget {
  const GenerateScreenUraNoChar({super.key});

  @override
  State<GenerateScreenUraNoChar> createState() => _GenerateScreenUraNoCharState();
}

class _GenerateScreenUraNoCharState extends State<GenerateScreenUraNoChar> {
  late LevelTier currentTier;
  
  bool _forbiddenLatched = false; 
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final tierStr = args?['level'] as String?;
    currentTier = LevelTierX.fromName(tierStr);
  }

  @override
  Widget build(BuildContext context) {
    // ← この行の直後に追加
    final int baseForNormal = () {
      switch (currentTier) {
        case LevelTier.divine: return 3;
        case LevelTier.normal: return 5;
        case LevelTier.poop:   return 9;
      }
    }();

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

      // アナログメーター（JitteredFrame：常時プルプル）
      RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: JitteredFrame(
          baseIndex: baseForNormal,
          mode: JitterMode.normal,
        ),
      ),
      
      // 禁断（裏）→ /forbidden/ura へ。押下後は押下見た目を維持（ラッチ）
      RelPositioned(
        x: 413, y: 1248, width: 260, height: 384,
        child: UxImageButton(
          normalAsset: _forbiddenLatched
              ? 'assets/images/btn_forbidden_pressed.png'
              : 'assets/images/btn_forbidden_default.png',
          pressedAsset: 'assets/images/btn_forbidden_pressed.png',
          onPressed: () {
            setState(() => _forbiddenLatched = true);
            Navigator.pushNamed(context, '/forbidden/ura');
          },
          semanticLabel: '禁断',
          width: 260, height: 384,
        ),
      ),
      // もう一度トライ（表示のみ）
      RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: UxImageButton(
          normalAsset: 'assets/images/btn_tryagain_default.png',
          pressedAsset: 'assets/images/btn_tryagain_pressed.png',
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              '/generate/ura',
              arguments: {'level': currentTier.name},
            );
          },
          semanticLabel: 'もう一度トライ',
          width: 946, height: 214,
        ),
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
