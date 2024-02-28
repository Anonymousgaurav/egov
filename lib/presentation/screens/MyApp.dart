import 'package:egov/presentation/screens/HomePage.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    /// closes the keyboard when we press anywhere in the screen
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: const MaterialApp(
        title: 'Gaurav Flutter Test',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        home: HomePage(),
      ),
    );
  }
}

