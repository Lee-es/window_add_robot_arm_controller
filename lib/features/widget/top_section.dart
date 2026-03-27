import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';

class TopSection extends ConsumerWidget {
  
  const TopSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Row(
              children: [
                Container(width: 16, height: 16, decoration: BoxDecoration(color: AppColors.greenColor, shape: BoxShape.circle)),
                const SizedBox(width: 12),
                const Text('ADD Robot Arm Controller', style: AppTextStyles.title),
              ],
            ),
            Row(
              children: [
                Container(width: 16, height: 16, decoration: BoxDecoration(color:  AppColors.greenColor, shape: BoxShape.circle)),
                const SizedBox(width: 8),
                const Text('블루투스 연결됨', style: AppTextStyles.connectionStatus),
              ],
            )
          ],
      ),
    );
  }

}