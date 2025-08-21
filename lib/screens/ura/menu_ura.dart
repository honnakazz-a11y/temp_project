part of '../../main.dart';

class MenuScreenUra extends StatelessWidget {
  const MenuScreenUra({super.key});

  @override
  Widget build(BuildContext context) {
    AssetRegistry.precacheCommon(context);
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
      // 戻る（下）→ 仮ダイアログ表示（遷移なし）
      RelPositioned(
        x: 26, y: 1926, width: 500, height: 200,
        child: UxImageButton(
          normalAsset: 'assets/images/btn_back_bottom_default.png',
          pressedAsset: 'assets/images/btn_back_bottom_pressed.png',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('戻れませんよ？')),
            );
          },
          semanticLabel: '下戻る（メニュー・無効）',
          width: 500, height: 200,
        ),
      ),
      
      // シェア
      RelPositioned(
        x: 550, y: 1926, width: 500, height: 200,
        child: UxImageButton(
          normalAsset: 'assets/images/btn_share_default.png',
          pressedAsset: 'assets/images/btn_share_pressed.png',
          onPressed: () {
            // 将来はシェア機能に置き換え
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('準備中です')),
            );
          },
          semanticLabel: 'シェア（準備中）',
          width: 500, height: 200,
        ),
      ),
      
      // 言い訳を作ってもらう → /input/ura へ遷移
      RelPositioned(
        x: 67, y: 987, width: 946, height: 214,
        child: UxImageButton(
          normalAsset: 'assets/images/btn_start_generate_default.png',
          pressedAsset: 'assets/images/btn_start_generate_pressed.png',
          onPressed: () => Navigator.pushNamed(context, '/input/ura'),
          semanticLabel: '言い訳を作ってもらう（入力へ）',
          width: 946, height: 214,
        ),
      ),
      
      // 言い訳を解析してもらう → /analysis/input/ura へ遷移
      RelPositioned(
        x: 67, y: 1343, width: 946, height: 214,
        child: UxImageButton(
          normalAsset: 'assets/images/btn_start_analysis_default.png',
          pressedAsset: 'assets/images/btn_start_analysis_pressed.png',
          onPressed: () => Navigator.pushNamed(context, '/analysis/input/ura'),
          semanticLabel: '言い訳を解析してもらう（解析入力へ）',
          width: 946, height: 214,
        ),
      ),

      // 使い方ガイド → /guide/ura へ遷移
      RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: UxImageButton(
          normalAsset: 'assets/images/btn_guide_default.png',
          pressedAsset: 'assets/images/btn_guide_pressed.png',
          onPressed: () => Navigator.pushNamed(context, '/guide/ura'),
          semanticLabel: '使い方ガイド',
          width: 946, height: 214,
        ),
      ),
    ]);
  }
}