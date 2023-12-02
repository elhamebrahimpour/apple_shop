import 'package:apple_shop/data/model/card_model.dart';
import 'package:apple_shop/features/di/api_di.dart';
import 'package:apple_shop/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

GlobalKey<NavigatorState> navigatorGlobalKey = GlobalKey<NavigatorState>();

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CardModelAdapter());
  await Hive.openBox<CardModel>('cardBox');

  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  runApp(const MyApplication());
}

class MyApplication extends StatefulWidget {
  const MyApplication({Key? key}) : super(key: key);

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorGlobalKey,
      home: const SplashScreen(),
    );
  }
}
