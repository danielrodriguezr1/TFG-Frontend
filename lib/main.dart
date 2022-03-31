import 'package:flutter/material.dart';
import 'package:tfgapp/src/pages/homeScreen.dart';
import 'package:tfgapp/src/pages/loginScreen.dart';
import 'package:flutter/services.dart';
import 'package:tfgapp/src/pages/signupScreen.dart';

import 'src/storage/secure_storage.dart';

bool loggedIn;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SecureStorage.readSecureStorage('App_Token').then(
      (value) => {if (value != null) loggedIn = true else loggedIn = false});

  if (loggedIn)
    print('TFG APP');
  else
    print('dfsdfgfgfgdfg');

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (loggedIn) return MaterialApp(title: 'TFG APP', home: HomeScreen());
    //return MaterialApp(title: 'TFG APP', home: LoginPage());
    return MaterialApp(title: 'TFG APP', home: LoginPage());
  }
}
