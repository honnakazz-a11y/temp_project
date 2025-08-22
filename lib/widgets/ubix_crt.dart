// lib/widgets/ubix_crt.dart
import 'dart:async';
import 'package:flutter/material.dart';

class UbixCrt {
  // ==== 定数 ====
  static const Duration kTypewriterSpeed = Duration(milliseconds: 45);
  static const Duration kLineBreakDelay = Duration(milliseconds: 120);

  // 「wait...」はタイプライターで出した後に少し見せてから消灯
  static const Duration kWaitHoldAfterShown = Duration(milliseconds: 120);
  // 2秒設計： 270ms(タイプ) +120ms(ホールド) +276ms(消灯) ≒ 666ms ×3 ≒ 2s
  static const Duration kWaitOffGap = Duration(milliseconds: 276);
  static const int kWaitBlinkCount = 3;

  /// CRT風オーバーレイを表示。
  /// [text] == "wait..." のときもタイプライターで出して消灯を3サイクル。
  /// [persist] が true の場合は閉じずに表示を残す（/oracle 用）。
  static Future<void> show(
    BuildContext context,
    String text, {
    Duration? afterDelay,
    VoidCallback? onDone,
    bool persist = false,
  }) async {
    await showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 120),
      pageBuilder: (ctx, anim, secondary) {
        return _UbixCrtDialog(
          text: text,
          afterDelay: afterDelay,
          onDone: onDone,
          persist: persist,
        );
      },
    );
  }

  /// persist=true で出した表示を明示的に閉じる
  static void closeIfShowing(BuildContext context) {
    final nav = Navigator.of(context, rootNavigator: true);
    if (nav.canPop()) {
      nav.pop();
    }
  }
}

class _UbixCrtDialog extends StatefulWidget {
  final String text;
  final Duration? afterDelay;
  final VoidCallback? onDone;
  final bool persist;

  const _UbixCrtDialog({
    required this.text,
    this.afterDelay,
    this.onDone,
    this.persist = false,
  });

  @override
  State<_UbixCrtDialog> createState() => _UbixCrtDialogState();
}

class _UbixCrtDialogState extends State<_UbixCrtDialog> {
  String _display = "";
  bool _visible = true;
  bool _isDone = false;

  @override
  void initState() {
    super.initState();
    if (widget.text.trim() == "wait...") {
      _runWaitBlinkAsTypewriter();
    } else {
      _runTypewriterAndFinish(widget.text);
    }
  }

  Future<void> _finish() async {
    if (_isDone) return;
    _isDone = true;

    if (widget.afterDelay != null) {
      await Future<void>.delayed(widget.afterDelay!);
    }
    if (!mounted) return;

    if (widget.persist) {
      // /oracle 用：閉じない・onDone も呼ばない
      return;
    }

    // 先に閉じてから次フレームで onDone
    Navigator.of(context, rootNavigator: true).pop();
    await Future<void>.delayed(const Duration(milliseconds: 16));
    if (mounted) {
      widget.onDone?.call();
    }
  }

  Future<void> _typeTextOnce(String full) async {
    final runes = full.runes.toList();
    final sb = StringBuffer();
    for (final r in runes) {
      if (!mounted) return;
      final ch = String.fromCharCode(r);
      sb.write(ch);
      setState(() {
        _display = sb.toString();
        _visible = true;
      });
      await Future<void>.delayed(
        ch == '\n' ? UbixCrt.kLineBreakDelay : UbixCrt.kTypewriterSpeed,
      );
    }
  }

  Future<void> _runTypewriterAndFinish(String full) async {
    await _typeTextOnce(full);
    await _finish();
  }

  Future<void> _runWaitBlinkAsTypewriter() async {
    const word = "wait...";
    for (int i = 0; i < UbixCrt.kWaitBlinkCount; i++) {
      if (!mounted) return;
      await _typeTextOnce(word); // タイプライターで出す
      await Future<void>.delayed(UbixCrt.kWaitHoldAfterShown); // 見せる
      if (!mounted) return;
      setState(() => _visible = false); // 消灯
      await Future<void>.delayed(UbixCrt.kWaitOffGap);
      if (!mounted) return;
      setState(() => _display = ""); // 次サイクルに備えてクリア
    }
    await _finish();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true, // タップ不可
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 120),
            opacity: _visible ? 1 : 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 28),
              constraints: const BoxConstraints(maxWidth: 720),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.82),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white24, width: 1),
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  _display,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white,
                    height: 1.35,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
