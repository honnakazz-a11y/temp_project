part of '../../main.dart';

/// 生成（裏）キャラなし（背景のみ差し替え）
class GenerateScreenUraNoChar extends StatelessWidget {
  const GenerateScreenUraNoChar({super.key});

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
      // 戻る（上）
      const RelPositioned(
        x: 52, y: 20, width: 238, height: 96,
        child: ImageAsset('assets/images/btn_back_top_default.png'),
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
      // 禁断ボタン（裏はアクティブ遷移先あり：/forbidden/ura）
      RelPositioned(
        x: 413, y: 1248, width: 260, height: 384,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/forbidden/ura'),
          child: const ImageAsset('assets/images/btn_forbidden_default.png'),
        ),
      ),
      // もう一度トライ
      const RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: ImageAsset('assets/images/btn_tryagain_default.png'),
      ),
      // 戻る（下）→ /menu/ura へ即時遷移（挙動を元に戻す）
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
