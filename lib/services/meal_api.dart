import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/category.dart';
import '../models/meal.dart';

class MealApi {
  const MealApi();

  Future<List<Category>> fetchCategories() async {
    final uri = Uri.https('www.themealdb.com', '/api/json/v1/1/categories.php');
    final data = await _fetchJson(uri);
    final categories = data['categories'] as List<dynamic>;
    return categories
        .map((category) => Category.fromJson(category as Map<String, dynamic>))
        .toList();
  }

  Future<List<Meal>> searchByName(String query) async {
    final name = query.trim();
    if (name.isEmpty) return const [];

    final uri = Uri.https('www.themealdb.com', '/api/json/v1/1/search.php', {
      's': name,
    });
    return _fetchMeals(uri);
  }

  Future<List<Meal>> fetchMealsByCategory(String category) {
    final uri = Uri.https('www.themealdb.com', '/api/json/v1/1/filter.php', {
      'c': category,
    });
    return _fetchMeals(uri);
  }

  Future<Meal?> fetchMealById(String id) async {
    final uri = Uri.https('www.themealdb.com', '/api/json/v1/1/lookup.php', {
      'i': id,
    });
    final meals = await _fetchMeals(uri);
    if (meals.isEmpty) return null;
    return meals.first;
  }

  Future<List<Meal>> _fetchMeals(Uri uri) async {
    final data = await _fetchJson(uri);
    final meals = data['meals'] as List<dynamic>?;
    if (meals == null) return const [];
    return meals
        .map((meal) => Meal.fromJson(meal as Map<String, dynamic>))
        .toList();
  }

  Future<Map<String, dynamic>> _fetchJson(Uri uri) async {
    final client = http.Client();
    try {
      final response = await client
          .get(uri)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode != 200) {
        throw http.ClientException(
          'TheMealDB returned ${response.statusCode}',
          uri,
        );
      }

      return jsonDecode(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>;
    } finally {
      client.close();
    }
  }
}
