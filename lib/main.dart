import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' hide Colors, Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Flutter Demo',
      theme: FluentThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1.0),
        accentColor: Colors.blue,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});



  @override
  Widget build(BuildContext context) {
    const  Color dividerColor = Color.fromRGBO(112, 112, 112, 1.0);
    return NavigationView(

      titleBar:  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          // 1. 상단 섹터 (Top Section)
          const SizedBox(

          height: 80.0, // 상단의 세로 비율 (고정 높이가 필요하다면 Container의 height로 변경 가능)
          child: TopSection(),
        ),
        Container(
          height: 1.0, // 선의 두께
          color: dividerColor,
        ),
          ]
      ),
      content: ScaffoldPage(
        padding: EdgeInsets.zero,
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 2-1. 하단 좌측 (비율 1)
            Expanded(
              flex: 1,
              child: const BottomLeftSection(),
            ),
            Container(
             width: 1.0,
              color: dividerColor,
            ),
            // 2-2. 하단 중앙 (비율 2)
            Expanded(
              flex: 2,
              child: const BottomCenterSection(),
            ),
            Container(
              width: 1.0,
              color: dividerColor,
            ),
            // 2-3. 하단 우측 (비율 1)
            Expanded(
              flex: 1,
              child: const BottomRightSection(),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// [자식 위젯들] 각 섹터별 분리된 클래스
// ============================================================================

/// 상단 섹터 위젯
class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Text('상단 섹터\n(연결 상태, 공통 정보 등)', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

/// 하단 좌측 섹터 위젯 (비율 1)
class BottomLeftSection extends StatelessWidget {
  const BottomLeftSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Text('하단 좌측\n[비율 1]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

/// 하단 중앙 섹터 위젯 (비율 2)
class BottomCenterSection extends StatelessWidget {
  const BottomCenterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Text('하단 중앙\n[비율 2]\n(메인 제어부 또는 모니터링 화면)', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

/// 하단 우측 섹터 위젯 (비율 1)
class BottomRightSection extends StatelessWidget {
  const BottomRightSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Text('하단 우측\n[비율 1]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}