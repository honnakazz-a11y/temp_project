part of '../../main.dart';

/// 解析モード入力（裏）キャラなし・ハード系のみ
class AnalysisInputScreenUraNoChar extends StatelessWidget {
  const AnalysisInputScreenUraNoChar({super.key});

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

      // メーター（初期：0）
      const RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: ImageAsset('assets/images/meter_0.png'),
      ),

      // 解析開始ボタン → /analysis/result へ遷移
      RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/analysis/result');
            },
            child: const ImageAsset('assets/images/btn_analyze_default.png'),
          ),
        ),
      ),

      // 戻る（下）→ /menu/ura へ即時遷移（演出なし）
      RelPositioned(
        x: 26, y: 1926, width: 500, height: 200,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/menu/ura');
            },
            child: const ImageAsset('assets/images/btn_back_bottom_default.png'),
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
