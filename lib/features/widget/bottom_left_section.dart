import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_add_robot_arm_controller/core/theme/app_theme.dart';

class BottomLeftSection extends ConsumerWidget {
  
  const BottomLeftSection({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal:15 ),
         child: Column(children: [
          const SizedBox(height: 10),
          Expanded(flex:2,
          child: Text('상의 착의', style: AppTextStyles.title)
          ),
          Expanded(
            flex: 8,
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: 
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.asset('assets/robot_1.png',
                      fit: BoxFit.contain,
                      alignment: AlignmentGeometry.bottomCenter,
                      ),
                    )
                    ),
              const SizedBox(width: 5),
              Expanded(
                flex: 1,
                child:
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Image.asset('assets/robot_2.png',
                        fit: BoxFit.contain,
                        alignment: AlignmentGeometry.bottomCenter,
                        ),
                      ),
                    )
                    ),
              ]
              )
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        child:GestureDetector(
                          onTap: (){
                          },
                          child:Padding(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset('assets/rac_bt_wearing_on.png',
                              fit: BoxFit.contain),
                          ),
                        )
                      )),
                      const SizedBox(width: 15),
                      Expanded(
                      flex: 1,
                      child:  SizedBox( 
                       child:GestureDetector(
                        onTap: (){
                        },
                        child:Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.asset('assets/rac_bt_return_on.png',
                            fit: BoxFit.contain),
                        ),
                        )
                      ),
                        ),
                  ],
              ),
              ),
              const SizedBox(height: 10),
         ])
         );
    }

}