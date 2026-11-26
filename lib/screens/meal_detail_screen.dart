import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    final heading = Theme.of(context).textTheme.titleLarge;
    final imageUrl = meal.imageUrl;
    return Scaffold(
      appBar: AppBar(title: Text(meal.name)),
      body: SafeArea(
        child: ListView(
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
        ),
      ),
    );
  }
}
