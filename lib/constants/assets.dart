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
  List<String> get frames => const [
    'assets/images/meter_0.png',
    'assets/images/meter_1_m1.png',
    'assets/images/meter_1_p1.png',
    'assets/images/meter_1.png',
    'assets/images/meter_3_m1.png',
    'assets/images/meter_3_p1.png',
    'assets/images/meter_3.png',
    'assets/images/meter_5_m1.png',
    'assets/images/meter_5_p1.png',
    'assets/images/meter_5.png',
    'assets/images/meter_7_m1.png',
    'assets/images/meter_7_p1.png',
    'assets/images/meter_7.png',
    'assets/images/meter_9_m1.png',
    'assets/images/meter_9_p1.png',
    'assets/images/meter_9.png',
    'assets/images/meter_max_p1.png',
    'assets/images/meter_max.png',
  ];
}

class _Ura {
  // 背景
  final String bgDefault = 'assets/images/bg_dark_default.png';
  final String bgGlitch1 = 'assets/images/bg_dark_glitch1.png';
  final String bgGlitch2 = 'assets/images/bg_dark_glitch2.png';

  // フレーム
  final String frameDefault = 'assets/images/label_braun_frame_default.png';
  final String frameGlitch1  = 'assets/images/label_braun_frame_glitch1.png';
  final String frameGlitch2  = 'assets/images/label_braun_frame_glitch2.png';
  final String frameGlitch3  = 'assets/images/label_braun_frame_glitch3.png';
}

  /// サウンド系
class _Sfx {
  final click = 'assets/se/se_button_click.wav';
  final typing = 'assets/se/se_typing_loop.wav';
  final block = 'assets/se/se_warning_block.wav';
}
