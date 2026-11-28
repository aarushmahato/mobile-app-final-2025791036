class Meal {
  const Meal({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.instructions,
    required this.ingredients,
    this.category,
    this.area,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    final ingredients = <String>[];
    for (var i = 1; i <= 20; i++) {
      final ingredient = (json['strIngredient$i'] as String?)?.trim() ?? '';
      final amount = (json['strMeasure$i'] as String?)?.trim() ?? '';
      if (ingredient.isNotEmpty) {
        ingredients.add(amount.isEmpty ? ingredient : '$amount $ingredient');
      }
    }
    return Meal(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      imageUrl: json['strMealThumb'] as String?,
      instructions: (json['strInstructions'] as String?)?.trim() ?? '',
      ingredients: List.unmodifiable(ingredients),
      category: (json['strCategory'] as String?)?.trim(),
      area: (json['strArea'] as String?)?.trim(),
    );
  }

  final String id;
  final String name;
  final String? imageUrl;
  final String instructions;
  final List<String> ingredients;
  final String? category;
  final String? area;
}
