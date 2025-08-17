part of '../main.dart';

class OracleScreen extends StatelessWidget {
  const OracleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 最小の受け皿。UIは増やさない。
    return const Scaffold(
      body: SizedBox.shrink(),
    );
  }
}
