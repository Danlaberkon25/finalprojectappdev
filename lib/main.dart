import 'package:myfirstapp/models/goal.dart';
import 'package:myfirstapp/providers/GoalProvider.dart';
import 'package:myfirstapp/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/providers/GoalProvider.dart';
import 'package:myfirstapp/providers/selectionProvider.dart';
import 'package:localstorage/localstorage.dart';

late final ValueNotifier<int> notifier;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  runApp(MyApp(localStorage: localStorage)
  );
}

class MyApp extends StatelessWidget {
  final LocalStorage localStorage;

  const MyApp({Key? key, required this.localStorage}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_) => GoalProvider(localStorage)),
      ChangeNotifierProvider(create: (_) => SelectedCurrencyProvider()),
    ],
        child: MaterialApp(
          home: HomePage(),

    ),
    );

  }
}


