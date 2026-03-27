import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomCenterSection extends ConsumerWidget {
  
  const BottomCenterSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Card(
      child: Center(
        child: Text('하단 중앙\n[비율 2]\n(메인 제어부 또는 모니터링 화면)', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

}