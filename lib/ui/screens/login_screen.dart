import 'package:flutter/material.dart';
import 'package:moving_target_select/consts/core_consts.dart';
import 'package:provider/provider.dart';

import '../states/exp_states.dart';
import '../screens/exp_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController nameInputController = TextEditingController();
  final TextEditingController pwInputController = TextEditingController();

  LoginScreen({super.key});

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
            TextField(
              controller: nameInputController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: pwInputController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              child: const Text('Start'),
              onPressed: () {
                context.read<UserNameState>().setName(nameInputController.text);
                startExperiment(context);
              },
            ),
            SizedBox(height: 100),
            ElevatedButton(
              child: const Icon(Icons.info),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('실험 안내'),
                      content: const Text(
                        '실험을 시작하려면 이름을 입력하고 Start 버튼을 눌러주세요.\n 실험은 총 24번 진행됩니다....등등 TBD',
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void startExperiment(BuildContext context) {
  var expReadyQueue = [];

  var accCaseList = List.from(accExpList);
  var deAccCaseList = List.from(deAccExpList);
  var uniSpeedCaseList = List.from(uniSpeedExpList);

  accCaseList.shuffle();
  deAccCaseList.shuffle();
  uniSpeedCaseList.shuffle();

  //randomlly append all three case lists
  var caseLists = ['accCaseList', 'deAccCaseList', 'uniSpeedCaseList']..shuffle();

  for (var list in caseLists) {
    if (list == 'accCaseList') {
      expReadyQueue.addAll(accCaseList);
    } else if (list == 'deAccCaseList') {
      expReadyQueue.addAll(deAccCaseList);
    } else if (list == 'uniSpeedCaseList') {
      expReadyQueue.addAll(uniSpeedCaseList);
    }
  }

  context.read<ExpReserveState>().setReserveList(expReadyQueue);
  
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ExpScreen()),
  );
}