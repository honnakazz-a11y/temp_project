part of '../main.dart';

/// 画面遷移の共通ヘルパー（例外仕様・フォールバックを集中管理）
class NavHelper {
  static void replaceToMenuUra(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/menu/ura');
  }

  static void replaceToMenuNormal(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/menu/normal');
  }

  static void replaceToInputUra(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/input/ura');
  }

  /// 上戻るの基本動作：1つ前へ戻る。戻れない時はメニューへフォールバック。
  static void backOrFallbackToMenu(BuildContext context, {required bool isUra}) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(context, isUra ? '/menu/ura' : '/menu/normal');
    }
  }
}
