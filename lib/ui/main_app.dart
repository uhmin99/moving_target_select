import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';
import 'states/exp_states.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserInfoState()),
        ChangeNotifierProvider(create: (context) => ExpReserveState()),
        ChangeNotifierProvider(create: (context) => ExpResultState()),
      ],
      child: MaterialApp(
        home: LoginScreen(),
      )
    );
  }
}