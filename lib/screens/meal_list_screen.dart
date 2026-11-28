import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/meal.dart';
import '../services/meal_api.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_screen.dart';

class MealListScreen extends StatefulWidget {
  const MealListScreen({super.key, required this.category});

  final Category category;

  @override
  State<MealListScreen> createState() => _MealListScreenState();
}

class _MealListScreenState extends State<MealListScreen> {
  List<Meal> _meals = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  Future<void> _loadMeals() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final meals = await const MealApi().fetchMealsByCategory(
        widget.category.name,
      );
      if (!mounted) return;
      setState(() {
        _meals = meals;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.name)),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(semanticsLabel: 'Loading meals'),
      );
    }
    if (_hasError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Couldn’t load meals.'),
            TextButton(onPressed: _loadMeals, child: const Text('Retry')),
          ],
        ),
      );
    }
    if (_meals.isEmpty) {
      return const Center(child: Text('No meals found in this category.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: _meals.length,
      itemBuilder: (context, index) {
        final meal = _meals[index];
        return MealCard(
          key: ValueKey(meal.id),
          meal: meal,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) =>
                    MealDetailScreen(meal: meal, loadDetails: true),
              ),
            );
          },
        );
      },
    );
  }
}
