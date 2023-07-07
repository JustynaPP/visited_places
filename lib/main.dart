import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visited_places/screens/home_screen.dart';

var kLightColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 207, 106, 238));

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 2, 1, 32),
  brightness: Brightness.dark,
);

final darkTheme = ThemeData().copyWith(
  colorScheme: kDarkColorScheme,
  scaffoldBackgroundColor: kDarkColorScheme.background,
  useMaterial3: true,
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: kDarkColorScheme.onPrimary,
    foregroundColor: kDarkColorScheme.primary,
  ),
);

final theme = ThemeData().copyWith(
  colorScheme: kLightColorScheme,
  useMaterial3: true,
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: kLightColorScheme.primary,
    foregroundColor: kLightColorScheme.onPrimary,
  ),
);

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      theme: theme,
      home: const HomeScreen(),
    );
  }
}
