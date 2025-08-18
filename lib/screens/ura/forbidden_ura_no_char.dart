part of '../../main.dart';

class ForbiddenScreenUraNoChar extends StatelessWidget {
  const ForbiddenScreenUraNoChar({super.key});

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

      // 戻る（上）→ /input/ura（例外仕様：履歴無視で固定遷移）
      RelPositioned(
        x: 52, y: 20, width: 238, height: 96,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => Navigator.pushReplacementNamed(context, '/input/ura'),
            child: const ImageAsset('assets/images/btn_back_top_default.png'),
          ),
        ),
      ),

      // 入力欄（表示のみ）
      const RelPositioned(
        x: 0, y: 953, width: 1080, height: 282,
        child: ImageAsset('assets/images/input_field.png'),
      ),

      // アナログメーター（禁断はMAX）
      const RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: ImageAsset('assets/images/meter_max.png'),
      ),

      // Ubixのお告げボタン（禁断用）
      RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/oracle'),
          child: const ImageAsset('assets/images/btn_oracle_default.png'),
        ),
      ),

      // 戻る（下）→ /input/ura へ即時遷移（正典：pushReplacementNamed）
      RelPositioned(
        x: 26, y: 1926, width: 500, height: 200,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/input/ura');
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
