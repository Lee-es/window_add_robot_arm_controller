import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_add_robot_arm_controller/core/theme/app_theme.dart';

class BottomRightSection extends ConsumerWidget {
  
  const BottomRightSection({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      return  Column(
        children: [
          const SizedBox(height: 10,),
          Expanded(flex:2,
          child: Text('턴테이블', style: AppTextStyles.title)
          ),
          Expanded(flex:5,
          child: SizedBox(
            child: Image.asset('assets/robot_3.png'),
          ),
          ),
         const SizedBox(height: 10,),
          Expanded(flex:3, 
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
 SizedBox(width: 100, child: TextBox( textAlign: TextAlign.center, style: const TextStyle(fontSize: 20))),
              const SizedBox(width: 8),
              const Text('deg', style: TextStyle(fontSize: 20)),
                ],
              ),
              const SizedBox(height: 15,),

              SizedBox(
                width: 150,
                height: 60,
                child: GestureDetector(
                  onTap:() {
                    
                  },
                  child: Image.asset('assets/rac_bt_setting_on.png'),
                ),)
            ],
          )
          ),
          const SizedBox(height: 5,)

        ],
      );
    }

}