import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomLeftSection extends ConsumerWidget {
  
  const BottomLeftSection({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      return  Card(
        child: Center(
          child: Text('하단 좌측\n[비율 1]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      );
    }

}