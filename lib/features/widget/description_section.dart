import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_add_robot_arm_controller/core/theme/app_theme.dart';

class DescriptionSection extends StatelessWidget {

  const DescriptionSection({
  super.key,
  required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal:20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(height: 1.0, color: AppColors.dividerColor),
        const SizedBox(height: 5.0),
        Text(
          text,
          style: AppTextStyles.description,
          textAlign: TextAlign.center,
        ),
         const SizedBox(height: 10.0),
      ],
    ),
    );
  }
}

