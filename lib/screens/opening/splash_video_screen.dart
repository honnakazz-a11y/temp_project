part of '../../main.dart';

class SplashVideoScreen extends StatefulWidget {
  const SplashVideoScreen({super.key});

  @override
  State<SplashVideoScreen> createState() => _SplashVideoScreenState();
}

class _SplashVideoScreenState extends State<SplashVideoScreen> {
  late VideoPlayerController _controller;
  bool _navigated = false;

  void _goToUraMenu() {
    if (_navigated || !mounted) return;
    _navigated = true;
    Navigator.of(context).pushReplacementNamed('/menu/ura');
  }

  @override
  void initState() {
    super.initState();

    // 8秒でフォールバック（動画が読めない場合の保険）
    Future.delayed(const Duration(seconds: 8), _goToUraMenu);

    _controller = VideoPlayerController.asset(
      'assets/videos/ubix_opening_zorome_full.mp4',
    )..initialize().then((_) {
        if (!mounted) return;
        setState(() {});
        _controller.play();
      });

    _controller.addListener(() {
      final v = _controller.value;
      // 読み込み完了 & 動画再生が最後まで到達したら遷移
      if (v.isInitialized && v.position >= v.duration) {
        _goToUraMenu();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
