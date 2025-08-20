part of '../../main.dart';

/// 生成（通常）キャラなし
class GenerateScreenNormalNoChar extends StatefulWidget {
  const GenerateScreenNormalNoChar({super.key});

  @override
  State<GenerateScreenNormalNoChar> createState() => _GenerateScreenNormalNoCharState();
}

class _GenerateScreenNormalNoCharState extends State<GenerateScreenNormalNoChar> {
  late LevelTier currentTier;
  
  bool _didPrecache = false;
  
int _pickBaseForNormal(LevelTier tier) {
  final rnd = [0, 1]..shuffle(); // 乱数用（0 or 1）
  switch (tier) {
    case LevelTier.divine: // 神
      return rnd.first == 0 ? 5 : 7;
    case LevelTier.normal: // 普通
      return rnd.first == 0 ? 1 : 3;
    case LevelTier.poop:   // うんこ
      return rnd.first == 0 ? 7 : 9;
  }
}

  @override
void didChangeDependencies() {
  super.didChangeDependencies();
  final args = ModalRoute.of(context)?.settings.arguments as Map?;
  final tierStr = args?['level'] as String?;
  currentTier = LevelTierX.fromName(tierStr); // 未指定→normal

  if (!_didPrecache) {
    _didPrecache = true;
    AssetRegistry.precacheGenerate(context); // メーター＆スライダー画像を事前読込
  }
}

  @override
  Widget build(BuildContext context) {
      // ← この行の直後に追加
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

      // 戻る（上）＝ 基本動作（1つ前へ戻る）／スタック無し→ /menu/normal にフォールバック
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

      // 入力欄（表示のみ）
      const RelPositioned(
        x: 0, y: 953, width: 1080, height: 282,
        child: ImageAsset('assets/images/input_field.png'),
      ),

      // LevelSlider（引き継いだ tier を初期表示）
      RelPositioned(
        x: 28, y: 1376, width: 372, height: 221,
        child: LevelSlider(
          value: currentTier,
          onChanged: (tier) => setState(() => currentTier = tier),
          isUra: false,
        ),
      ),

      // アナログメーター（JitteredFrame：常時プルプル）
      RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: JitteredFrame(
          baseIndex: _pickBaseForNormal(currentTier),
          mode: JitterMode.normal,
        ),
      ),

      // 禁断（仮ダイアログ：課金誘導の簡易演出）
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
                      onPressed: () => Navigator.pop(context), // 閉じるだけ（導線はまだ実装しない）
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

      // もう一度トライ（見た目のみ・遷移なし）
      const RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: ImageAsset('assets/images/btn_tryagain_default.png'),
      ),

      // 戻る（下）＝ Ubix演出 → 約2秒後に /menu/normal へ
      RelPositioned(
        x: 26, y: 1926, width: 500, height: 200,
        child: UxImageButton(
          normalAsset: 'assets/images/btn_back_bottom_default.png',
          pressedAsset: 'assets/images/btn_back_bottom_pressed.png',
          onPressed: () => UbixEffects.showLineThenGo(context, toRoute: '/menu/normal'),
          semanticLabel: '下戻る',
          width: 500, height: 200,
        ),
      ),

      // シェア（見た目のみ）
      const RelPositioned(
        x: 550, y: 1926, width: 500, height: 200,
        child: ImageAsset('assets/images/btn_share_default.png'),
      ),
    ]);
  }
}
