part of '../main.dart';

/// 押下後に遷移が完了するまで pressed 表示を維持するボタン
class UxToggleImageButton extends StatefulWidget {
  final String normalAsset;
  final String pressedAsset;
  final Future<void> Function()? onPressed; // 非同期OK（遷移など）
  final String? semanticLabel;
  final double width;
  final double height;

  const UxToggleImageButton({
    super.key,
    required this.normalAsset,
    required this.pressedAsset,
    this.onPressed,
    this.semanticLabel,
    required this.width,
    required this.height,
  });

  @override
  State<UxToggleImageButton> createState() => _UxToggleImageButtonState();
}

class _UxToggleImageButtonState extends State<UxToggleImageButton> {
  bool _latched = false;     // 押したら true にして見た目固定
  bool _pressing = false;    // 押下中の視覚（押す瞬間～onTapまで）

  @override
  Widget build(BuildContext context) {
    final childAsset = (_latched || _pressing)
        ? widget.pressedAsset
        : widget.normalAsset;

    return Semantics(
      button: true,
      label: widget.semanticLabel,
      enabled: !_latched,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTapDown: (_) {
            if (!_latched) setState(() => _pressing = true);
          },
          onTapCancel: () {
            if (!_latched) setState(() => _pressing = false);
          },
          onTap: () async {
            if (_latched) return;
            setState(() {
              _pressing = false; // 押し込みフラグは解除
              _latched = true;   // 以降は pressed 表示固定
            });
            // 遷移などの非同期を待つ（戻ってくることは基本ないが、戻ってきた場合でも押下状態維持）
            if (widget.onPressed != null) {
              await widget.onPressed!();
            }
          },
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: ImageAsset(childAsset),
          ),
        ),
      ),
    );
  }
}
