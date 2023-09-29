import 'package:apple_shop/data/model/card_model.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CardModelAdapter());
  await Hive.openBox<CardModel>('cardBox');
  //add this here because sharedPref has native codes
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
