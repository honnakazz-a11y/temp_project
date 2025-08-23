// lib/helpers/launch_counter.dart
import 'package:shared_preferences/shared_preferences.dart';

/// 起動回数（累積）を管理するヘルパ。
/// - 通常のコールドスタート、および「解析結果→下戻るでOpening再生」時に increment() を呼ぶ。
/// - 累積値はメニュー表示用にそのまま使用。
/// - デコ判定は normalized 値（1..250）を使用。
class LaunchCounter {
  static const _key = 'launch_count';

  /// 累積を+1して保存。現在の累積値を返す。
  static Future<int> increment() async {
    final prefs = await SharedPreferences.getInstance();
    final now = (prefs.getInt(_key) ?? 0) + 1;
    await prefs.setInt(_key, now);
    return now;
  }

  /// 現在の累積値（無ければ0）
  static Future<int> getCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_key) ?? 0;
  }

  /// デコ用の正規化値（1..250）
  static Future<int> getNormalized() async {
    final raw = await getCount();
    return (raw % 250) + 1;
  }

  /// デバッグ用の強制セット（Releaseでは無効）
  static Future<void> debugSet(int value) async {
    assert(() {
      SharedPreferences.getInstance().then((p) => p.setInt(_key, value));
      return true;
    }());
  }
}
