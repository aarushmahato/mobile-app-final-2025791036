import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../services/meal_api.dart';

class MealDetailScreen extends StatefulWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
    this.loadDetails = false,
  });

  final Meal meal;
  final bool loadDetails;

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Meal? _meal;
  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    if (widget.loadDetails) {
      _loadMeal();
    } else {
      _meal = widget.meal;
    }
  }

  Future<void> _loadMeal() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final meal = await const MealApi().fetchMealById(widget.meal.id);
      if (!mounted) return;
      setState(() {
        _meal = meal;
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
      appBar: AppBar(title: Text(widget.meal.name)),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(semanticsLabel: 'Loading recipe'),
      );
    }
    if (_hasError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Couldn’t load this recipe.'),
            TextButton(onPressed: _loadMeal, child: const Text('Retry')),
          ],
        ),
      );
    }
    final meal = _meal;
    if (meal == null) {
      return const Center(child: Text('Recipe not found.'));
    }

    final heading = Theme.of(context).textTheme.titleLarge;
    final imageUrl = meal.imageUrl;
    final category = meal.category;
    final area = meal.area;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (imageUrl != null && imageUrl.isNotEmpty)
          Image.network(
            imageUrl,
            height: 220,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const SizedBox.shrink(),
          ),
        if (category != null && category.isNotEmpty)
          Text('Category: $category'),
        if (area != null && area.isNotEmpty) Text('Cuisine: $area'),
        if (meal.ingredients.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('Ingredients', style: heading),
          for (final ingredient in meal.ingredients) Text('• $ingredient'),
        ],
        const SizedBox(height: 16),
        Text('Instructions', style: heading),
        Text(
          meal.instructions.isEmpty
              ? 'No cooking instructions are available.'
              : meal.instructions,
        ),
      ],
    );
  }
}
