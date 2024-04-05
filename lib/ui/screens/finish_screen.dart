import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:moving_target_select/entity/exp_entity.dart';
import 'dart:io';

import 'package:provider/provider.dart';

import '../states/exp_states.dart';

class FinishScreen extends StatelessWidget {

  const FinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finish Screen'),
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
                      saveToCSV(context.read<UserInfoState>().name, context.read<ExpResultState>().result);
                    },
                    child: const Text('Export to CSV'),
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
                        label: Text('TZ 넓이'),
                      ),
                      DataColumn(
                        label: Text('TZ 위치'),
                      ),
                      DataColumn(
                        label: Text('성공 여부'),
                      ),
                      DataColumn(
                        label: Text('실패 타입'),
                      ),
                      DataColumn(
                        label: Text('타이밍 정확도'),
                      ),
                      // Add more DataColumn for each column in your data
                    ],
                    rows: context.watch<ExpResultState>().result.map<DataRow>((item) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(expTypeToString(item.expEntity.expType))),
                          DataCell(Text(item.expEntity.zoneWidth.toString())),
                          DataCell(Text(item.expEntity.zonePositionX.toString())),
                          DataCell(Text(item.success ? "성공":"실패")),
                          DataCell(Text(item.errorType.toString())),
                          DataCell(Text(item.timingAccuracy.toString())),
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

void saveToCSV(String userName, List<ExpResultEntity> data) async {
  List<List<dynamic>> rows = [];
  rows.add(['가속 타입', 'TZ 넓이', 'TZ 위치', '성공 여부', '실패 타입', '타이밍 정확도']);
  for (var item in data) {
    rows.add([expTypeToString(item.expEntity.expType), item.expEntity.zoneWidth, item.expEntity.zonePositionX, item.success?"성공":"실패", item.errorType, item.timingAccuracy]);
  }

  String csv = const ListToCsvConverter().convert(rows);
  final directory = Directory.current;
  String currentTimeString = DateTime.now().toString();
  final file = File('${directory.path}/${userName}_potg_result_$currentTimeString.csv');
  await file.writeAsString(csv);

  print('CSV saved to ${file.path}');
}