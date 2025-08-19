part of '../../main.dart';

/// 生成（通常）キャラなし
class GenerateScreenNoChar extends StatefulWidget {
  const GenerateScreenNoChar({super.key});
  @override
  State<GenerateScreenNoChar> createState() => _GenerateScreenNoCharState();
}

class _GenerateScreenNoCharState extends State<GenerateScreenNoChar> {
  @override
  void initState() {
    super.initState();
    AssetRegistry.precacheGenerate(context);
  }

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

      // 戻る（上）＝ 基本動作（1つ前へ戻る）／スタック無し→ /menu/normal にフォールバック
      RelPositioned(
        x: 52, y: 20, width: 238, height: 96,
        child: UxImageButton(
          normalAsset: Assets.img.button.backUpperNormal,
          pressedAsset: Assets.img.button.backUpperPressed,
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
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Yes')),
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('No')),
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

      // 下戻る（演出→約2秒後に /menu/normal へ）
      RelPositioned(
        x: 26, y: 1926, width: 500, height: 200,
        child: UxImageButton(
          normalAsset: Assets.img.button.backLowerNormal,
          pressedAsset: Assets.img.button.backLowerPressed,
          onPressed: () => UbixEffects.showLineThenGo(context, toRoute: '/menu/normal'),
          semanticLabel: '下戻る',
          width: 500, height: 200,
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
