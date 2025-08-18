part of '../main.dart';

class UxImageButton extends StatefulWidget {
  const UxImageButton({
    super.key,
    required this.normalAsset,
    required this.pressedAsset,
    required this.onPressed,
    required this.width,
    required this.height,
    this.semanticLabel,
    this.enableHaptic = false,
  });

  final String normalAsset;
  final String pressedAsset;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final String? semanticLabel;
  final bool enableHaptic;

  @override
  State<UxImageButton> createState() => _UxImageButtonState();
}

class _UxImageButtonState extends State<UxImageButton> {
  bool _pressed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 事前読み込み（チラつき防止）
    precacheImage(AssetImage(widget.normalAsset), context);
    precacheImage(AssetImage(widget.pressedAsset), context);
  }

  void _setPressed(bool v) {
    if (_pressed != v && mounted) {
      setState(() => _pressed = v);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.semanticLabel,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque, // 画像外の余白でもタップ可
        onTapDown: (_) => _setPressed(true),
        onTapCancel: () => _setPressed(false),
        onTapUp: (_) => _setPressed(false),
        onTap: () {
          if (widget.enableHaptic) {
            HapticFeedback.selectionClick();
          }
          widget.onPressed();
        },
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          // 見た目は既存踏襲（画像だけ切り替える）
          child: ImageAsset(_pressed ? widget.pressedAsset : widget.normalAsset),
        ),
      ),
    );
  }
}
