part of '../../main.dart';

/// 解析結果（裏）キャラなし
class AnalysisResultScreenUraNoChar extends StatefulWidget {
  const AnalysisResultScreenUraNoChar({super.key});

  @override
  State<AnalysisResultScreenUraNoChar> createState() =>
      _AnalysisResultScreenUraNoCharState();
}

class _AnalysisResultScreenUraNoCharState extends State<AnalysisResultScreenUraNoChar> {
  bool _oracleLatched = false; // ← ラッチ用フラグ
  bool _didPrecache = false;
  
  @override
  void didChangeDependencies() {
  super.didChangeDependencies();
  if (!_didPrecache) {
    _didPrecache = true;
    AssetRegistry.precacheForbidden(context);
  }
}
  @override
  Widget build(BuildContext context) {
    // 0/1/3/5/7/9 のいずれか
    final candidates = [0, 1, 3, 5, 7, 9]..shuffle();
    final int analysisBase = candidates.first;

    return BaseScreen(children: [
      // 背景（裏）
      const Positioned.fill(
        child: ImageAsset('assets/images/bg_dark_default.png'),
      ),
      // ブラウン管
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
      // 入力欄（ダミー）
      const RelPositioned(
        x: 0, y: 953, width: 1080, height: 282,
        child: ImageAsset('assets/images/input_field.png'),
      ),
      // メーター（プルプル）
      RelPositioned(
        x: 686, y: 1352, width: 388, height: 280,
        child: JitteredFrame(
          baseIndex: analysisBase,
          mode: JitterMode.normal,
        ),
      ),

      // === Ubixのお告げ（ラッチ対応） ===
      RelPositioned(
        x: 67, y: 1699, width: 946, height: 214,
        child: UxImageButton(
          normalAsset: _oracleLatched
              ? 'assets/images/btn_oracle_pressed.png' // 押したら固定
              : 'assets/images/btn_oracle_default.png',
          pressedAsset: 'assets/images/btn_oracle_pressed.png',
          onPressed: () => UbixCrt.show(
            context,
            "wait...",
            onDone: () {
              if (context.mounted) {
                Navigator.pushNamed(context, '/oracle');
              }
            },
          ),
          semanticLabel: 'Ubixのお告げ',
          width: 946, height: 214,
        ),
      ),
      // 戻る（下）→ /opening（既存）
      RelPositioned(
        x: 26, y: 1926, width: 500, height: 200,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, '/opening'),
            child: const ImageAsset('assets/images/btn_back_bottom_default.png'),
          ),
        ),
      ),

      // シェア（ダミー）
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
