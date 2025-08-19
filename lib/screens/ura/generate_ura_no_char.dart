part of '../../main.dart';

/// 生成（裏）キャラなし
class GenerateScreenUraNoChar extends StatefulWidget {
  const GenerateScreenUraNoChar({super.key});
  @override
  State<GenerateScreenUraNoChar> createState() => _GenerateScreenUraNoCharState();
}

class _GenerateScreenUraNoCharState extends State<GenerateScreenUraNoChar> {
  @override
  void initState() {
    super.initState();
    // 裏生成用の素材を事前読み込み（メーター含む）
    AssetRegistry.precacheGenerate(context);
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

      // 音声トグル（右上）
      const RelPositioned(
        x: 786, y: 20, width: 272, height: 96,
        child: ImageAsset('assets/images/btn_sound_toggle_on.png'),
      ),

      // 戻る（上）＝ 基本動作（1つ前）／スタック無し→ /menu/ura にフォールバック
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

      // 入力欄（表示のみ）
      const RelPositioned(
        x: 0, y: 953, width: 1080, height: 282,
        child: ImageAsset('assets/images/input_field.png'),
      ),

      // アナログメーター（例：5）
      const RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: ImageAsset('assets/images/meter_5.png'),
      ),
      
      // スライダー（普通）
      const RelPositioned(
        x: 28, y: 1376, width: 372, height: 221,
        child: ImageAsset('assets/images/slider_level_normal.png'),
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
