import 'package:flutter/material.dart';

void main() {
  runApp(const RecipeExplorerApp());
}

class RecipeExplorerApp extends StatelessWidget {
  const RecipeExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Recipe Explorer'),
        ),
        body: const Center(
          child: Text(
            'Welcome to Recipe Explorer!',
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }
}