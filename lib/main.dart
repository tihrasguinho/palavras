import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:palavras/app/main_app.dart';
import 'package:palavras/app/pages/home_controller.dart';
import 'package:palavras/app/pages/home_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  var box = await Hive.openBox('box');

  if (!box.containsKey('streak')) box.put('streak', 0);

  final getIt = GetIt.instance;

  getIt.registerLazySingleton<HomeStore>(() => HomeStore());

  getIt.registerLazySingleton<HomeController>(() => HomeController(getIt()));

  runApp(const MainApp());
}
