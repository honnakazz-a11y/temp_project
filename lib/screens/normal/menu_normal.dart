part of '../../main.dart';

class MenuScreenNormal extends StatelessWidget {
  const MenuScreenNormal({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(children: [
      // 背景（通常）
      const Positioned.fill(
        child: ImageAsset('assets/images/bg_main_default.png'),
      ),
      // ブラウン管（通常：pristine）
      const RelPositioned(
        x: 0, y: 100, width: 1080, height: 810,
        child: ImageAsset('assets/images/label_braun_frame_pristine.png'),
      ),
      // 音声トグル
      const RelPositioned(
        x: 786, y: 20, width: 272, height: 96,
        child: ImageAsset('assets/images/btn_sound_toggle_on.png'),
      ),
      // 戻る（下）仮メッセージ
      RelPositioned(
        x: 26, y: 1926, width: 500, height: 200,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('戻れませんよ？')),
              );
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
      // 言い訳を作ってもらう（タップ検知：一旦メッセージだけ）
      RelPositioned(
        x: 67, y: 987, width: 946, height: 214,
        child: Material(
          type: MaterialType.transparency, // 見た目はそのまま
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/input/normal');
            },
            child: const ImageAsset('assets/images/btn_start_generate_default.png'),
          ),
        ),
      ),
      // 言い訳を解析してもらう（仮ダイアログ）
      RelPositioned(
        x: 67, y: 1343, width: 946, height: 214,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text('アップグレード後にご利用になれます。今すぐアップグレードする？'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context), // 閉じるだけ
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context), // 閉じるだけ
                        child: const Text('No'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const ImageAsset('assets/images/btn_start_analysis_default.png'),
          ),
        ),
      ),
      // 使い方ガイド（通常へ遷移）
      RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/guide/normal');
            },
            child: const ImageAsset('assets/images/btn_guide_default.png'),
          ),
        ),
      ),
    ]);
  }
}
