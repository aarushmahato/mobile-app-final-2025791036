import 'package:shared_preferences/shared_preferences.dart';

class FavoritesStorage {
  static const _key = 'favoriteMealIds';
  final _preferences = SharedPreferencesAsync();

  Future<List<String>> getFavoriteIds() async {
    final ids = await _preferences.getStringList(_key);
    return ids ?? [];
  }

  Future<void> setFavorite(String mealId, bool isFavorite) async {
    final ids = (await getFavoriteIds()).toSet();
    if (isFavorite) {
      ids.add(mealId);
    } else {
      ids.remove(mealId);
    }
    await _preferences.setStringList(_key, ids.toList());
  }
}
