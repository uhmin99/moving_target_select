import 'package:flutter/material.dart';
import 'package:moving_target_select/consts/core_consts.dart';
import 'package:moving_target_select/ui/screens/finish_screen.dart';
import 'package:provider/provider.dart';

import '../../entity/exp_entity.dart';
import '../states/exp_states.dart';
import '../screens/exp_screen.dart';
import 'guide_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameInputController = TextEditingController();
  final TextEditingController ageInputController = TextEditingController();

  String _gender='남성';
  List<String> genderList = ['남성', '여성', '성별선택안함'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Team POTG : Moving Target Select Experiment',
              style: TextStyle(fontSize: 30),
            ),
            TextField(
              controller: nameInputController,
              decoration: const InputDecoration(
                labelText: '이름',
              ),
            ),
            TextField(
              controller: ageInputController,
              decoration: const InputDecoration(
                labelText: '나이',
              ),
            ),
            DropdownButton<String>(
              hint: const Text('성별'),
              onChanged: (selectedGender) {
                setState(() {
                  _gender = selectedGender!;
                });
              },
              value: _gender,
              items: genderList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              child: const Text('다음'),
              onPressed: () {
                context.read<UserInfoState>().setName(nameInputController.text);
                context.read<UserInfoState>().setAge(ageInputController.text);
                context.read<UserInfoState>().setGender(_gender);
                startExperiment(context);
              },
            ),
            SizedBox(height: 100),
            // ElevatedButton(
            //   child: const Icon(Icons.info),
            //   onPressed: () {
            //     showDialog(
            //       context: context,
            //       builder: (BuildContext context) {
            //         return AlertDialog(
            //           title: const Text('실험 안내'),
            //           content: const Text(
            //             '실험을 시작하려면 이름을 입력하고 Start 버튼을 눌러주세요.\n 실험은 총 24번 진행됩니다....등등 TBD',
            //           ),
            //           actions: <Widget>[
            //             TextButton(
            //               child: const Text('Close'),
            //               onPressed: () {
            //                 Navigator.of(context).pop();
            //               },
            //             ),
            //           ],
            //         );
            //       },
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

void startExperiment(BuildContext context) {
  List<ExpEntity> expReadyQueue = [];

  List<ExpEntity> accCaseList = List.from(accExpList);
  List<ExpEntity> deAccCaseList = List.from(deAccExpList);
  List<ExpEntity> uniSpeedCaseList = List.from(uniSpeedExpList);

  accCaseList.shuffle();
  deAccCaseList.shuffle();
  uniSpeedCaseList.shuffle();

  //randomlly append all three case lists
  var randomCaseList = ['accCaseList', 'deAccCaseList', 'uniSpeedCaseList']..shuffle();

  for (var list in randomCaseList) {
    if (list == 'accCaseList') {
      expReadyQueue.addAll(accCaseList);
    } else if (list == 'deAccCaseList') {
      expReadyQueue.addAll(deAccCaseList);
    } else if (list == 'uniSpeedCaseList') {
      expReadyQueue.addAll(uniSpeedCaseList);
    }
  }

  if (expReadyQueue.isEmpty) {
    // No experiments to be done
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FinishScreen()),
    );
    return;
  }

  ExpEntity nextExp = expReadyQueue[0];

  context.read<ExpReserveState>().setReserveList(expReadyQueue);

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => GuideScreen(firstExpEnv: nextExp,)),
  );
}