// lib/widgets/ura_decor.dart
import 'package:flutter/material.dart';
import '../helpers/launch_counter.dart';
import '../constants/assets.dart';

/// 裏モード画面のデコ（背景＋フレーム）を自動適用するラッパ。
/// 使い方: `return UraDecor(child: BaseScreen(children: [...]))`
/// レイヤ順: 背景 → child（画面コンテンツ）→ フレーム（最前面, タップ不可/A11y除外）
class UraDecor extends StatelessWidget {
  final Widget child;
  const UraDecor({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: LaunchCounter.getNormalized(),
      builder: (context, snap) {
        final n = snap.data ?? 1;

        // 背景
        final String bgPath = (n <= 20)
            ? Assets.img.ura.bgDefault
            : (n <= 120)
                ? Assets.img.ura.bgGlitch1
                : Assets.img.ura.bgGlitch2;

        // フレーム
        final String framePath = (n <= 5)
            ? Assets.img.ura.frameDefault
            : (n <= 50)
                ? Assets.img.ura.frameGlitch1
                : (n <= 200)
                    ? Assets.img.ura.frameGlitch2
                    : Assets.img.ura.frameGlitch3;

        return Stack(
          children: [
            // 背景（画面全面）
            Positioned.fill(
              child: Image.asset(
                bgPath,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
            // 画面コンテンツ（既存）
            child,

            // フレーム（上に重ねる、タップ不可/A11y除外）
            Positioned.fill(
              child: IgnorePointer(
                ignoring: true,
                child: ExcludeSemantics(
                  child: Align(
                    alignment: Alignment.topCenter,
                    // 元実装のフレーム位置 (x:0, y:100, w:1080, h:810) を概ね再現
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Image.asset(
                        framePath,
                        fit: BoxFit.contain,
                        // 横幅いっぱいにして縦は自動
                        width: MediaQuery.of(context).size.width,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
