import 'package:flutter/material.dart';
import 'dart:async';

class ExcuseInputScreen extends StatefulWidget {
  const ExcuseInputScreen({super.key});

  @override
  State<ExcuseInputScreen> createState() => _ExcuseInputScreenState();
}

class _ExcuseInputScreenState extends State<ExcuseInputScreen>
    with TickerProviderStateMixin {
  bool isSoundOn = true;
  final TextEditingController _textController = TextEditingController();
  String displayedText = '';
  bool isIntroComplete = false;
  bool showCharacters = false;

  late AnimationController _angelController;
  late Animation<Offset> _angelOffset;
  late AnimationController _devilController;
  late Animation<Offset> _devilOffset;
  late Animation<double> _angelOpacity;
  late Animation<double> _devilOpacity;

  @override
  void initState() {
    super.initState();
    _angelController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _angelOffset = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: const Offset(0, 0.5), end: const Offset(0, -0.1))
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 50),
      TweenSequenceItem(
          tween: Tween(begin: const Offset(0, -0.1), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50),
    ]).animate(_angelController);
    _angelOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _angelController,
      curve: Curves.easeIn,
    ));

    _devilController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _devilOffset = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: const Offset(0, 0.5), end: const Offset(0, -0.1))
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 50),
      TweenSequenceItem(
          tween: Tween(begin: const Offset(0, -0.1), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50),
    ]).animate(_devilController);
    _devilOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _devilController,
      curve: Curves.easeIn,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startUbixIntro();
    });
  }

  Future<void> _startUbixIntro() async {
    await _typeText('何をやらかした？\n言い訳を考えてあげよう。');
    setState(() {
      isIntroComplete = true;
      showCharacters = true;
    });
    _angelController.forward();
    _devilController.forward();
  }

  Future<void> _typeText(String fullText) async {
    displayedText = '';
    for (int i = 0; i < fullText.length; i++) {
      await Future.delayed(const Duration(milliseconds: 80));
      setState(() {
        displayedText += fullText[i];
      });
    }
  }

  @override
  void dispose() {
    _angelController.dispose();
    _devilController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
            // 背景画像
            Positioned.fill(
              child: Image.asset(
                'assets/images/bg_main_default.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.none,
              ),
            ),
            // テレビのフレーム
            Positioned(
              left: 0,
              top: screenHeight * 0.05, // 画面の高さの5%の位置
              right: 0,
              height: screenHeight * 0.4, // 画面の高さの40%のサイズ
              child: Image.asset(
                'assets/images/label_braun_frame_default.png',
                fit: BoxFit.contain, // 画像がアスペクト比を維持しつつ収まるように
                alignment: Alignment.center,
                filterQuality: FilterQuality.none,
              ),
            ),
            // テキスト表示部分
            Positioned(
              left: screenWidth * 0.1, // 画面幅の10%の余白
              top: screenHeight * 0.25, // 画面の高さの25%の位置
              width: screenWidth * 0.8, // 画面幅の80%の幅
              child: Center(
                child: Text(
                  displayedText,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // 入力フィールドの画像
            Positioned(
              left: 0,
              top: screenHeight * 0.45,
              right: 0,
              child: Image.asset(
                'assets/images/input_field.png',
                fit: BoxFit.fitWidth, // 幅に合わせて画像を調整
                filterQuality: FilterQuality.none,
              ),
            ),
            // テキストフィールド
            Positioned(
              left: screenWidth * 0.04, // 画面幅の4%の余白
              top: screenHeight * 0.48,
              width: screenWidth * 0.92, // 画面幅の92%の幅
              height: screenHeight * 0.1,
              child: TextField(
                controller: _textController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'ここにテキスト/音声で入力してください（40文字以下推奨です）',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 28 * (screenWidth / 1080)),
                ),
                style: TextStyle(color: Colors.white, fontSize: 28 * (screenWidth / 1080)),
              ),
            ),
            // 天使のキャラクター
            Positioned(
              right: 0,
              bottom: 0, // 画面の右下に配置
              child: AnimatedOpacity(
                opacity: showCharacters ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 400),
                child: SlideTransition(
                  position: _angelOffset,
                  child: Image.asset(
                    'assets/images/char_angel.png',
                    fit: BoxFit.none,
                    filterQuality: FilterQuality.none,
                  ),
                ),
              ),
            ),
            // 悪魔のキャラクター
            Positioned(
              left: 0,
              bottom: 0, // 画面の左下に配置
              child: AnimatedOpacity(
                opacity: showCharacters ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 400),
                child: SlideTransition(
                  position: _devilOffset,
                  child: Image.asset(
                    'assets/images/char_devil.png',
                    fit: BoxFit.none,
                    filterQuality: FilterQuality.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}