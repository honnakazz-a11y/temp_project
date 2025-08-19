part of '../../main.dart';

/// Ubixのお告げ（Oracle）画面：禁断レイアウト流用（入力欄なし）
class OracleScreen extends StatefulWidget {
  const OracleScreen({super.key});

  @override
  State<OracleScreen> createState() => _OracleScreenState();
}

class _OracleScreenState extends State<OracleScreen> {
  @override
  void initState() {
    super.initState();
    // お告げは解析系に束ねてプリロード
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

      // 音声トグル（右上）
      const RelPositioned(
        x: 786, y: 20, width: 272, height: 96,
        child: ImageAsset('assets/images/btn_sound_toggle_on.png'),
      ),

      // 上戻る（例外仕様：常に /menu/ura へ置換遷移）
      RelPositioned(
        x: 52, y: 20, width: 238, height: 96,
        child: UxImageButton(
          normalAsset: Assets.img.button.backUpperNormal,
          pressedAsset: Assets.img.button.backUpperPressed,
          onPressed: () => NavHelper.replaceToMenuUra(context),
          semanticLabel: '上戻る',
          width: 238, height: 96,
        ),
      ),

      // 入力欄は置かない（Oracleは枠のみ）

      // アナログメーター（枠の統一感を維持：例としてMAX）
      const RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: ImageAsset('assets/images/meter_max.png'),
      ),

      // 「Ubixのお告げ」ボタン（Oracleでは非アクティブ）※onTapなし
      const RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: ImageAsset('assets/images/btn_oracle_default.png'),
      ),

      // 下戻る（例外仕様：常に /menu/ura へ置換遷移）
      RelPositioned(
        x: 26, y: 1926, width: 500, height: 200,
        child: UxImageButton(
          normalAsset: Assets.img.button.backLowerNormal,
          pressedAsset: Assets.img.button.backLowerPressed,
          onPressed: () => NavHelper.replaceToMenuUra(context),
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
