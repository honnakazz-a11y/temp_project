part of '../../main.dart';

/// 禁断（裏）キャラなし
class ForbiddenScreenUraNoChar extends StatefulWidget {
  const ForbiddenScreenUraNoChar({super.key});

  @override
  State<ForbiddenScreenUraNoChar> createState() => _ForbiddenScreenUraNoCharState();
}

class _ForbiddenScreenUraNoCharState extends State<ForbiddenScreenUraNoChar> {
  bool _oracleLatched = false;
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
    return UraDecor(
      child: BaseScreen(
        children: [
          // 音声トグル（右上）
          const RelPositioned(
            x: 786, y: 20, width: 272, height: 96,
            child: ImageAsset('assets/images/btn_sound_toggle_on.png'),
          ),

          // 上戻る（例外仕様：常に /input/ura へ置換遷移）
          RelPositioned(
            x: 52, y: 20, width: 238, height: 96,
            child: UxImageButton(
              normalAsset: Assets.img.button.backUpperNormal,
              pressedAsset: Assets.img.button.backUpperPressed,
              onPressed: () => NavHelper.replaceToInputUra(context),
              semanticLabel: '上戻る',
              width: 238, height: 96,
            ),
          ),

          // 入力欄（表示のみ）
          const RelPositioned(
            x: 0, y: 953, width: 1080, height: 282,
            child: ImageAsset('assets/images/input_field.png'),
          ),

          // アナログメーター（禁断：max帯を2点往復）
          RelPositioned(
            x: 686, y: 1352, width: 388, height: 280,
            child: JitteredFrame(
              baseIndex: 16,
              mode: JitterMode.max,
            ),
          ),

          // Ubixのお告げボタン → /oracle
          RelPositioned(
            x: 67, y: 1699, width: 946, height: 214,
            child: UxImageButton(
              normalAsset: _oracleLatched
                  ? 'assets/images/btn_oracle_pressed.png' // 押したら固定
                  : 'assets/images/btn_oracle_default.png',
              pressedAsset: 'assets/images/btn_oracle_pressed.png',
              onPressed: () {
                setState(() => _oracleLatched = true);
                UbixCrt.show(
                  context,
                  "wait...",
                  onDone: () {
                    if (context.mounted) {
                      Navigator.pushNamed(context, '/oracle');
                    }
                  },
                );
              },
              semanticLabel: 'Ubixのお告げ',
              width: 946, height: 214,
            ),
          ),
      
          // 下戻る（正典：即時に /input/ura へ置換遷移）
          RelPositioned(
            x: 26, y: 1926, width: 500, height: 200,
            child: UxImageButton(
              normalAsset: Assets.img.button.backLowerNormal,
              pressedAsset: Assets.img.button.backLowerPressed,
              onPressed: () => NavHelper.replaceToInputUra(context),
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
