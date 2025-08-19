/// アセットパスを集中管理
class Assets {
  Assets._();
  static final img = _Img();
  static final sfx = _Sfx();
}

// 画像系
class _Img {
  final menu = _Menu();
  final button = _Button();
  final meter = _Meter();
  final ura = _Ura();

  // ★ 追加
  final level = _Level();
}

// ★ 新規クラス
class _Level {
  String get trackKami    => 'assets/images/slider_level_kami.png';
  String get trackNormal  => 'assets/images/slider_level_normal.png';
  String get trackUnko    => 'assets/images/slider_level_unko.png';
}

class _Menu {
  final generateNormal = 'assets/images/btn_generate_normal.png';
  final generatePressed = 'assets/images/btn_generate_pressed.png';
}

class _Button {
  final backUpperNormal = 'assets/images/btn_back_top_default.png';
  final backUpperPressed = 'assets/images/btn_back_top_pressed.png';
  final backLowerNormal = 'assets/images/btn_back_bottom_default.png';
  final backLowerPressed = 'assets/images/btn_back_bottom_pressed.png';
}

class _Meter {
  List<String> get frames =>
      List.generate(18, (i) => 'assets/images/meter_${i + 1}.png');
}

class _Ura {
  final bg = 'assets/images/bg_dark_default.png';
  final crtOverlay = 'assets/images/crt_overlay.png';
}

/// サウンド系
class _Sfx {
  final click = 'assets/se/se_button_click.wav';
  final typing = 'assets/se/se_typing_loop.wav';
  final block = 'assets/se/se_warning_block.wav';
}
