import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/assets.dart';

/// メーターを「基準 ↔ ±1」でプルプルさせる。
/// - normal: 基準と隣（-1 / +1 を交互に）
/// - max: 末尾(max) と max_p1(末尾+1相当=配列では末尾) を往復（見た目は2点）
enum JitterMode { normal, max }

class JitteredFrame extends StatefulWidget {
  final int baseIndex;              // 帯の基準フレーム（0,1,3,5,7,9 or max など）
  final JitterMode mode;
  final Duration interval;

  const JitteredFrame({
    super.key,
    required this.baseIndex,
    required this.mode,
    this.interval = const Duration(milliseconds: 180),
  });

  @override
  State<JitteredFrame> createState() => _JitteredFrameState();
}

class _JitteredFrameState extends State<JitteredFrame> {
  late final List<String> _frames;
  Timer? _timer;

  // 表示トグル用
  bool _showBase = true;
  bool _useHighNeighbor = true; // 基準から外れるときに low/high を交互に

  @override
  void initState() {
    super.initState();
    _frames = Assets.img.meter.frames; // 18枚（0,1,3,5,7,9 各±1 と max/max_p1）
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant JitteredFrame oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.baseIndex != widget.baseIndex || oldWidget.mode != widget.mode || oldWidget.interval != widget.interval) {
      _timer?.cancel();
      _showBase = true;
      _useHighNeighbor = true;
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(widget.interval, (_) {
      setState(() {
        _showBase = !_showBase;
        if (_showBase == true) {
          // 基準に戻るタイミングで、次に外れる側(low/high)を切り替える
          _useHighNeighbor = !_useHighNeighbor;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  int _clamp(int i) {
    final last = _frames.length - 1; // 17
    if (i < 0) return 0;
    if (i > last) return last;
    return i;
  }

  @override
  Widget build(BuildContext context) {
    final last = _frames.length - 1;
    final base = _clamp(widget.baseIndex);

    // 端のクリップ（0なら0↔1、末尾なら末尾↔末尾-1）
    final low  = _clamp(base - 1);
    final high = _clamp(base + 1);

    int indexToShow;
    if (widget.mode == JitterMode.max) {
      // max は末尾付近の2点往復（資料：max ↔ max_p1）
      final a = last - 1 >= 0 ? last - 1 : last; // 保険
      final b = last;
      indexToShow = _showBase ? a : b;
    } else {
      // normal は「基準 ↔ 隣」を交互に。隣は low と high を交互に採用
      if (_showBase) {
        indexToShow = base;
      } else {
        indexToShow = _useHighNeighbor ? high : low;
      }
    }

    final path = _frames[indexToShow];
    return Image.asset(path, fit: BoxFit.contain, filterQuality: FilterQuality.high);
  }
}
