import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:palavras/app/pages/home_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Palavras',
      theme: FlexThemeData.light(scheme: FlexScheme.blue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.blue),
      themeMode: ThemeMode.dark,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            {
              return MaterialPageRoute(builder: (context) => const HomePage());
            }
        }
      },
    );
  }
}
