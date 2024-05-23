import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:moving_target_select/entity/exp_entity.dart';
import 'dart:io';

import 'package:provider/provider.dart';

import '../../consts/core_consts.dart';
import '../states/exp_states.dart';

class FinishScreen extends StatelessWidget {

  const FinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('실험 완료'),
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Text('모든 실험이 완료되었습니다. 결과를 확인하고 CSV로 내보내세요.', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      saveToCSV(context, context.read<ExpResultState>().result, context.read<UserInfoState>().name, context.read<UserInfoState>().age, context.read<UserInfoState>().gender);
                    },
                    child: const Text('결과 CSV로 추출하기'),
                  ),
                  const SizedBox(height: 30),
                  Text('실험자 : ${context.read<UserInfoState>().name} / 나이 : ${context.read<UserInfoState>().age} / 성별 : ${context.read<UserInfoState>().gender}'),
                  Text('실험날짜 : ${DateTime.now()}'),
                  DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text('가속 타입'),
                      ),
                      DataColumn(
                        label: Text('타겟 등장 주기'),
                      ),
                      DataColumn(
                        label: Text('타겟 도착 시간'),
                      ),
                      // DataColumn(
                      //   label: Text('타겟 머무르는 시간'),
                      // ),
                      DataColumn(
                        label: Text('실 등장 시간'),
                      ),
                      // DataColumn(
                      //   label: Text('실 도착 시간'),
                      // ),
                      // DataColumn(
                      //   label: Text('실 탈출 시간'),
                      // ),
                      DataColumn(
                        label: Text('버튼 누른 시간'),
                      ),
                      // DataColumn(
                      //   label: Text('등장~도착 시간'),
                      // ),
                      // DataColumn(
                      //   label: Text('존 안에 머무르는 시간'),
                      // ),
                      DataColumn(
                        label: Text('등장~버튼누른시간ms'),
                      ),
                    ],
                    rows: context.watch<ExpResultState>().result.map<DataRow>((item) {
                      // String appearToArrival;
                      // String zoneStayTime;
                      // if(item.zoneArrivalTime != null && item.targetAppearanceTime != null) {
                      //   appearToArrival = item.zoneArrivalTime!.difference(item.targetAppearanceTime!).inMilliseconds.toString();
                      // } else {
                      //   appearToArrival = 'N/A';
                      // }

                      // if(item.zoneLeaveTime != null && item.zoneArrivalTime != null) {
                      //   zoneStayTime = item.zoneLeaveTime!.difference(item.zoneArrivalTime!).inMilliseconds.toString();
                      // } else {
                      //   zoneStayTime = 'N/A';
                      // }
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(expTypeToString(item.expEntity.expType))),
                          DataCell(Text(item.expEntity.targetAppearancePeriod.toString())),
                          DataCell(Text(item.expEntity.zoneArrivalTime.toString())),
                          // DataCell(Text(item.expEntity.zoneStayTime.toString())),
                          DataCell(Text(item.targetAppearanceTime.toString())),
                          // DataCell(Text(item.zoneArrivalTime.toString())),
                          // DataCell(Text(item.zoneLeaveTime.toString())),
                          DataCell(Text(item.buttonPressTime.toString())),
                          // DataCell(Text(appearToArrival)),
                          // DataCell(Text(zoneStayTime)),
                          DataCell(Text((item.targetAppearanceTime != null && item.buttonPressTime != null) ? item.buttonPressTime!.difference(item.targetAppearanceTime!).inMilliseconds.toString() : 'N/A')),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            )
          ]
        )
      ),
    );
  }
}

void saveToCSV(BuildContext context, List<ExpResultEntity> data, String userName, String age, String gender) async {
  try {
    List<List<dynamic>> rows = [];
    rows.add(['name', 'age', 'gender']);
    rows.add([userName, age, gender]);
    rows.add(['mv_type', 'p', 'tc', 'appeared_t', 'pressed_t', 'appear_to_press_t_ms']);
    for (var item in data) {
      rows.add([
        expTypeToString(item.expEntity.expType),  //가속 타입
        item.expEntity.targetAppearancePeriod,  //타겟 등장 주기
        item.expEntity.zoneArrivalTime, //타겟 도착 시간
        // item.success?"성공":"실패", //성공 여부
        // item.errorType, //실패 타입
        item.targetAppearanceTime,  //실 등장 시간
        // item.zoneArrivalTime, //실 도착 시간
        item.buttonPressTime, //버튼 누른 시간
        (item.targetAppearanceTime != null && item.buttonPressTime != null) ? item.buttonPressTime?.difference(item.targetAppearanceTime!).inMilliseconds : 'N/A' //등장~버튼누른시간ms
      ]);
    }

    String csv = const ListToCsvConverter().convert(rows);
    final directory = Directory.current;
    String currentTimeString = DateTime.now().hour.toString() + DateTime.now().minute.toString() + DateTime.now().second.toString();
    final file = File('${directory.path}/${userName}_potg_result_$currentTimeString.csv');
    File resultFile = await file.writeAsString(csv);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('CSV 저장 완료'),
          content: Text('결과가 다음 경로에 저장되었습니다:\n${resultFile.path}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
    print('CSV saved to ${file.path}');

  } catch (e) {
    print(e);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('CSV 저장 실패'),
          content: Text('CSV 저장에 실패했습니다. 다시 시도해주세요.\nError: $e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}