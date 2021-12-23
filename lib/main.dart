import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'mainwindow.dart';
//import 'tab_containter_load1time.dart';
//import 'tab_containter_indexedstack.dart';
//import 'tab_containter_default.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('ru'),
        Locale('en')
      ],
      locale: const Locale('ru'),
      title: 'Задача 4',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home:// TabContainerDefault(),
      MainWindow(),
//      TabContainerLoad1Time(),
//      TabContainerIndexedStack(),
//      TabContainer(),
    );
  }
}
