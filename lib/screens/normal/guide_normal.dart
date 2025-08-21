// ← 最上部にこれだけ書く（import は書かない）
part of '../../main.dart';

// ↓ ここに main.dart にある GuideScreenNormal を “そのまま” 貼り付け
/// 使い方ガイド（通常）ハード系のみ
class GuideScreenNormal extends StatelessWidget {
  const GuideScreenNormal({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(children: [
      // 背景（通常）
      const Positioned.fill(
        child: ImageAsset('assets/images/bg_main_default.png'),
      ),

      // 拡張ブラウン管（ガイド用）
      const RelPositioned(
        x: 0, y: 100, width: 1080, height: 1850,
        child: ImageAsset('assets/images/label_braun_text_guide.png'),
      ),

      // 音声トグル（右上）
      const RelPositioned(
        x: 786, y: 20, width: 272, height: 96,
        child: ImageAsset('assets/images/btn_sound_toggle_on.png'),
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