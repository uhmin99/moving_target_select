import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:io';

import 'package:provider/provider.dart';

import '../states/exp_states.dart';

class FinishScreen extends StatelessWidget {

  const FinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finish Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('모든 실험이 완료되었습니다. 결과를 확인하고 CSV로 내보내세요.', style: TextStyle(fontSize: 20)),
            Text(
              'Results: \n${context.read<ExpResultState>().result}',
            ),
            ElevatedButton(
              onPressed: () async{
                // TODO: Implement CSV export
                // String csv = const ListToCsvConverter().convert(context.read<ExpResultState>().result);
                // print('CSV: $csv');
                // final directory = Directory('..');
                // final now = DateTime.now();
                // final formattedDate = "${now.year}${now.month.toString().padLeft(2,'0')}${now.day.toString().padLeft(2,'0')}_${now.hour.toString().padLeft(2,'0')}${now.minute.toString().padLeft(2,'0')}${now.second.toString().padLeft(2,'0')}";
                // final file = await File('${directory.path}/experiment_data_$formattedDate.csv').create();
                // file.writeAsString(csv);
                print('File saving TBD');
              },
              child: const Text('Export to CSV'),
            ),
          ],
        ),
      ),
    );
  }
}