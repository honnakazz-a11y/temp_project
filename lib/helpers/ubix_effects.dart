part of '../main.dart';

class UbixEffects {
  static const String _line = '使い方ガイドにお宝が！';

  static Future<void> showLineThenGo(
    BuildContext context, {
    required String toRoute,
    Duration delay = const Duration(milliseconds: 2000),
  }) async {
    // ダイアログ表示（タップ不可）
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return const Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.black87,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Text(
              _line,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        );
      },
    );

    // 約2秒待機
    await Future<void>.delayed(delay);

    // ダイアログを閉じる
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    // 置き換え遷移
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, toRoute);
    }
  }
}
