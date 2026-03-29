import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_add_robot_arm_controller/core/theme/app_theme.dart';
import 'package:window_add_robot_arm_controller/model/robot_arm_payload_data.dart';
import 'package:window_add_robot_arm_controller/utils/robot_arm_controller_protocol.dart';

import '../../providers/robot_arm_service_provider.dart';

class BottomCenterSection extends ConsumerWidget {
  
  const BottomCenterSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             SizedBox(
              width: 150,
              height: 80,
              child: GestureDetector(
                onTap: (){},
                child: Image.asset('assets/rac_bt_walking_on.png',fit: BoxFit.contain),
                          ),
                        ),
            const SizedBox(width: 30,),
             SizedBox(
              width: 150,
              height: 80,
              child: GestureDetector(
                          onTap: (){
                          },
                          child: Image.asset('assets/rac_bt_running_on.png',
                              fit: BoxFit.contain),
                          ),
                        )
                      ]),
              const SizedBox(height: 60,),
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text('팔 동작 시간 :', style: AppTextStyles.armController),
              const SizedBox(width: 16),
              SizedBox(width: 100, child: TextBox( textAlign: TextAlign.center, style: const TextStyle(fontSize: 20))),
              const SizedBox(width: 8),
              const Text('min', style: TextStyle(fontSize: 20)),
               const Spacer(),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               const Spacer(),
              const Text('팔 동작 속도 :', style: AppTextStyles.armController),
              const SizedBox(width: 16),
              SizedBox(width: 100, child: TextBox( textAlign: TextAlign.center, style: const TextStyle(fontSize: 20))),
              const SizedBox(width: 8),
              const Text('%', style: TextStyle(fontSize: 20)),
               const Spacer(),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200, height: 130,
                child: GestureDetector(
                  onTap: (){},
                  child: Image.asset('assets/rac_bt_stop.png',fit: BoxFit.contain,))
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 300, height: 130,
                child: GestureDetector(
                  onTap: () async {
            
                    debugPrint('데이터전송');
                     final service =   ref.read(robotArmServiceProvider);
                     try{
                      final payload = RobotArmPayloadData(commandId: RobotArmCommandId.start, runMode: RobotArmRunMode.running, runTime: 10, runSpeed: 10, turnAngle: 100);
                      await service.writeData(payload);
                     }catch(e){
                      debugPrint(e.toString());
                     }
                   
                    
                  },
                  child: Image.asset('assets/rac_bt_start.png',fit: BoxFit.contain,)),
              ),
            ],
          ),
          const SizedBox(height: 50,)
 
          ]);
  }

}