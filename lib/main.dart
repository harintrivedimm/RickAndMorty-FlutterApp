import 'package:flutter/material.dart';
import 'package:rick_and_morty/onboarding.dart';

void main() {
  runApp(const RickAndMortyApp());
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick & Morty',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE6E0E9)),
        useMaterial3: true,
      ),
      home: const Onboarding(),
    );
  }
}
