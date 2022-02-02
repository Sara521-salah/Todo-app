
import 'package:todoapp/archived.dart';
import 'package:todoapp/done.dart';
import 'package:todoapp/layout/layoutScreens.dart';
import 'package:todoapp/task.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home());

    }}