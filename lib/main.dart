import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'themeprovider.dart'; // Import ThemeProvider
import 'splashscreen.dart'; // Import Splash Screen

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Outfit Matching App',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: SplashScreen(), // Keep Splash Screen as the start
        );
      },
    );
  }
}
