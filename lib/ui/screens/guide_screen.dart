import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../entity/exp_entity.dart';
import '../screens/exp_screen.dart';

class GuideScreen extends StatelessWidget {
  final ExpEntity firstExpEnv;

  const GuideScreen({Key? key, required this.firstExpEnv}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설명'),
      ),
      body: Focus(
        autofocus: true,
        focusNode: FocusNode(),
        onKey: (FocusNode node, RawKeyEvent event) {
          if (event.logicalKey == LogicalKeyboardKey.keyS) {
            print('S key pressed');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExpScreen(expEnv: firstExpEnv, trialCount: 1,)),
            );
            return KeyEventResult.handled;
          } else {
            return KeyEventResult.ignored;
          }
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(height: 20),
                Text(
                  '''
                  Moving Target Acquisition

                  중지를 위해서는 ESC 키를 누르세요.
                  해당 게임은 끝날때까지 메인화면으로 돌아갈 수 없습니다.

                  이 게임에서 움직이는 타겟은 획득 영역을 향해 직선 운동합니다.
                  움직이는 타겟은 정해진 주기로 반복 생성되어 획득 영역을 향해 직선 운동합니다.

                  움직이는 타겟이 획득영역 내에 있을 때 Space Bar를 누르세요.
                  타겟이 획득영역 밖에 있을 때 Space Bar를 누르면 실패로 간주됩니다.

                  하나의 움직이는 타겟에 대해서는 단 한번의 버튼 입력만 시도하세요.
                  (여러번 반복하여 마구 누르기 금지)

                  버튼 입력을 한번 시작하고 나면 이후부터 새롭게 나타난 타겟을 획득하지 않고 그냥 지나치면 안됩니다.
                  (모든 새롭게 등장하는 타겟에 대해 한번의 버튼 입력 필수)

                  한번 게임을 시작하면 요구하는 수행횟수를 충족시킬 때까지 자리를 비우거나 게임을 멈추지 마세요.
                  40번의 수행횟수가 36번개의 조건으로 반복됩니다.

                  시작을 위해서 S 키를 누르세요.

                  ''',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}