part of '../../main.dart';

/// Ubixのお告げ（Oracle）画面：禁断レイアウト流用（入力欄なし）
class OracleScreen extends StatefulWidget {
  const OracleScreen({super.key});

  @override
  State<OracleScreen> createState() => _OracleScreenState();
}

class _OracleScreenState extends State<OracleScreen> {
  bool _shownOnce = false; // 1回だけ表示するためのラッチ

  @override
  void initState() {
    super.initState();
    // お告げは解析系に束ねてプリロード（既存）
    AssetRegistry.precacheAnalysis(context);

    // 画面入場後に「語録100」から1本を UbixCrt で常駐表示（タイプライター）
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _shownOnce || ubixOracle100.isEmpty) return;
      _shownOnce = true;

      // const List を可変コピーしてからシャッフル
      final list = List<String>.from(ubixOracle100);
      list.shuffle();
      final pick = list.first;

      // 消えない常駐表示（/oracle では閉じない）
      UbixCrt.show(context, pick, persist: true);
    });
  }

  @override
  void dispose() {
    // /oracle を離れるときに常駐Ubixを明示的に閉じる
    UbixCrt.closeIfShowing(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // アナログメーター（お告げ：5/7/9帯からランダム）
    final candidates = [5, 7, 9]; // 仕様：5/7/9帯から
    candidates.shuffle();
    final int oracleBase = candidates.first;

    return UraDecor(
      child: BaseScreen(
        children: [
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

          // アナログメーター
          RelPositioned(
            x: 686, y: 1352, width: 388, height: 280,
            child: JitteredFrame(
              baseIndex: oracleBase,
              mode: JitterMode.normal,
            ),
          ),

          // 「Ubixのお告げ」ボタン（Oracleでは非アクティブ）※onTapなし
          const RelPositioned(
            x: 67, y: 1699, width: 946, height: 214,
            child: ImageAsset('assets/images/btn_oracle_pressed.png'),
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
        ],
      ),
    );
  }
}
