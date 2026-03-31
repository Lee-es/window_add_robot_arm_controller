import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_add_robot_arm_controller/core/theme/app_theme.dart';
import 'package:window_add_robot_arm_controller/features/widget/bottom_center_section.dart';
import 'package:window_add_robot_arm_controller/features/widget/bottom_left_section.dart';
import 'package:window_add_robot_arm_controller/features/widget/bottom_right_section.dart';
import 'package:window_add_robot_arm_controller/features/widget/description_section.dart';
import 'package:window_add_robot_arm_controller/features/widget/top_section.dart';
import 'package:window_add_robot_arm_controller/providers/robot_arm_controller_notifier.dart';
import 'package:window_add_robot_arm_controller/providers/robot_arm_service_provider.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  void initState() {
    super.initState();
    _initializeBluetooth();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      titleBar: null,
      content: ScaffoldPage(
        padding: EdgeInsets.zero,
        header: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 60.0, child: TopSection()),
            Container(height: 1.0, color: AppColors.dividerColor),
          ],
        ),
        content: Column(
          children: [
            // 💡 [핵심 수정] 메인 화면 영역(Row)을 Expanded로 감싸서 높이 한계(Constraint)를 지정합니다.
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Expanded(flex: 1, child: BottomLeftSection()),
                  Container(width: 1.0, color: AppColors.dividerColor),
                  const Expanded(flex: 2, child: BottomCenterSection()),
                  Container(width: 1.0, color: AppColors.dividerColor),
                  const Expanded(flex: 1, child: BottomRightSection()),
                ],
              ),
            ),

            // 하단 설명 텍스트 영역 (높이 80 고정)
            SizedBox(
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 이 부분에 각 섹션별 설명 텍스트 위젯을 넣으시면 됩니다.
                  const Expanded(
                    flex: 1,
                    child: DescriptionSection(
                      text:
                          '상의를 착의하기 위해서는 먼저 착의 버튼\n을 눌러 팔을 착의 자세로 위치하고, 착의 후\n에는 팔의 자세를 원위치로 위치합니다.',
                    ),
                  ),
                  Container(width: 1.0, color: AppColors.dividerColor),
                  const Expanded(
                    flex: 2,
                    child: DescriptionSection(
                      text:
                          "'걷기' 또는 '달리기'를 선택해 팔 흔들기 시간을 설정하고, 속도를 조절한 뒤 '동작 시\n작'을 누르면 팔이 움직입니다. 속도는 기본값 대비 ±10% 범위에서 조절할 수 있으\n며,필요 시 '긴급 정지' 버튼으로 즉시 멈출 수 있습니다.",
                    ),
                  ),
                  Container(width: 1.0, color: AppColors.dividerColor),
                  const Expanded(
                    flex: 1,
                    child: DescriptionSection(
                      text:
                          "턴테이블의 정면 중앙이 '0' 이고, 좌측 회전\n 방향은 -방향, 우측 회전 방향은 + 방향을\n의미하고 각도를 10도 단위로 입력합니다.",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _initializeBluetooth() async {
    final service = ref.read(robotArmControllerProvider.notifier);

    debugPrint('테스트: 스캔 시작... (최대 15초 소요)');
    await service.startArmControl();
  }
}
