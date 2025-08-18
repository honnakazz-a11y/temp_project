part of '../main.dart';

class OracleScreen extends StatelessWidget {
  const OracleScreen({super.key});

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

      // 音声トグル（右上）※非アクティブ
      const RelPositioned(
        x: 786, y: 20, width: 272, height: 96,
        child: ImageAsset('assets/images/btn_sound_toggle_on.png'),
      ),

      // 戻る（上）→ /menu/ura（例外仕様：履歴無視で固定遷移）
      RelPositioned(
        x: 52, y: 20, width: 238, height: 96,
        child: UxImageButton(
          normalAsset: 'assets/images/btn_back_top_default.png',
          pressedAsset: 'assets/images/btn_back_top_pressed.png',
          onPressed: () => NavHelper.replaceToMenuUra(context),
          semanticLabel: '上戻る',
          width: 238, height: 96,
        ),
      ),


      // 入力欄は配置しない（禁断との差分：完全除外）

      // アナログメーター（禁断と同等の枠）
      const RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: ImageAsset('assets/images/meter_max.png'),
      ),

      // Ubixのお告げボタン ※非アクティブ（画像のみ）
      const RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: ImageAsset('assets/images/btn_oracle_default.png'),
      ),

      // 戻る（下）→ /menu/ura へ即時遷移（正典：pushReplacementNamed）
      RelPositioned(
        x: 26, y: 1926, width: 500, height: 200,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => Navigator.pushReplacementNamed(context, '/menu/ura'),
            child: const ImageAsset('assets/images/btn_back_bottom_default.png'),
          ),
        ),
      ),

      // シェア ※非アクティブ（画像のみ）
      const RelPositioned(
        x: 550, y: 1926, width: 500, height: 200,
        child: ImageAsset('assets/images/btn_share_default.png'),
      ),
    ]);
  }
}
