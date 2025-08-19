part of '../main.dart';

enum LevelTier { divine, normal, poop }

class LevelSlider extends StatefulWidget {
  const LevelSlider({
    super.key,
    this.value = LevelTier.normal,
    this.onChanged,
    this.showLabels = true, // 今は未使用
    this.isUra = false,     // 今は未使用（将来: コントラスト等）
    this.enableHaptic = false,
  });

  final LevelTier value;
  final ValueChanged<LevelTier>? onChanged;
  final bool showLabels;
  final bool isUra;
  final bool enableHaptic;

  @override
  State<LevelSlider> createState() => _LevelSliderState();
}

class _LevelSliderState extends State<LevelSlider> {
  late LevelTier _tier;

  @override
  void initState() {
    super.initState();
    _tier = widget.value;
  }

  void _setTier(LevelTier t, {bool fromUser = false}) {
    if (_tier == t) return;
    setState(() => _tier = t);
    widget.onChanged?.call(t);
    if (fromUser && widget.enableHaptic) {
      HapticFeedback.selectionClick();
    }
  }

  // 0.0…1.0 を3段階にスナップ
  LevelTier _snap(double frac) {
    if (frac < 1 / 3) return LevelTier.divine;   // 左=神
    if (frac < 2 / 3) return LevelTier.normal;   // 中=普通
    return LevelTier.poop;                       // 右=うんこ
  }

  String _trackFor(LevelTier t) {
    switch (t) {
      case LevelTier.divine: return Assets.img.level.trackKami;
      case LevelTier.normal: return Assets.img.level.trackNormal;
      case LevelTier.poop:   return Assets.img.level.trackUnko;
    }
  }

  String _tierLabel(LevelTier t) {
    switch (t) {
      case LevelTier.divine: return '神';
      case LevelTier.normal: return '通常';
      case LevelTier.poop:   return 'うんこ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.arrowLeft): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.arrowRight): DismissIntent(),
      },
      actions: {
        // ← 左へ1段階
        ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (intent) {
          if (_tier == LevelTier.normal) _setTier(LevelTier.divine, fromUser: true);
          else if (_tier == LevelTier.poop) _setTier(LevelTier.normal, fromUser: true);
          return null;
        }),
        // → 右へ1段階
        DismissIntent: CallbackAction<DismissIntent>(onInvoke: (intent) {
          if (_tier == LevelTier.normal) _setTier(LevelTier.poop, fromUser: true);
          else if (_tier == LevelTier.divine) _setTier(LevelTier.normal, fromUser: true);
          return null;
        }),
      },
      child: Semantics(
        label: 'レベル',
        value: _tierLabel(_tier),
        button: false,
        enabled: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (d) {
            final box = context.findRenderObject() as RenderBox?;
            final w = box?.size.width ?? 1;
            final localX = d.localPosition.dx.clamp(0, w);
            _setTier(_snap(localX / w), fromUser: true);
          },
          onPanUpdate: (d) {
            final box = context.findRenderObject() as RenderBox?;
            final w = box?.size.width ?? 1;
            final localX = (d.localPosition.dx).clamp(0, w);
            _setTier(_snap(localX / w), fromUser: false);
          },
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // 選択中Tierに応じたトラック画像のみ表示
                return Image.asset(
                  _trackFor(_tier),
                  fit: BoxFit.contain,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
