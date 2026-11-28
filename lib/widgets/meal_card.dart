import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealCard extends StatelessWidget {
  const MealCard({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    final imageUrl = meal.imageUrl;
    const placeholder = Icon(Icons.restaurant);
    Widget thumbnail = placeholder;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      thumbnail = ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          excludeFromSemantics: true,
          errorBuilder: (context, error, stackTrace) => placeholder,
        ),
      );
    }

    return Card(
      child: ListTile(
        leading: SizedBox.square(dimension: 48, child: thumbnail),
        title: Text(meal.name),
      ),
    );
  }
}
