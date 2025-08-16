part of '../../main.dart';

/// 入力（通常）キャラなし・ハード系のみ
class InputScreenNormalNoChar extends StatelessWidget {
  const InputScreenNormalNoChar({super.key});

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
      const RelPositioned(
        x: 52, y: 20, width: 238, height: 96,
        child: ImageAsset('assets/images/btn_back_top_default.png'),
      ),

      // 入力欄
      const RelPositioned(
        x: 0, y: 953, width: 1080, height: 282,
        child: ImageAsset('assets/images/input_field.png'),
      ),

      // スライダー（初期：普通）
      const RelPositioned(
        x: 28, y: 1376, width: 372, height: 221,
        child: ImageAsset('assets/images/slider_level_normal.png'),
      ),

      // アナログメーター（初期：0）
      const RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: ImageAsset('assets/images/meter_0.png'),
      ),

      // 言い訳生成ボタン → /generate/normal へ遷移
      RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/generate/normal');
            },
            child: const ImageAsset('assets/images/btn_generate_default.png'),
          ),
        ),
      ),

      // 戻る（下）→ /menu/normal へ遷移
      RelPositioned(
        x: 26, y: 1926, width: 500, height: 200,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/menu/normal');
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
