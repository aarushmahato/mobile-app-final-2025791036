class Category {
  const Category({required this.name, required this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['strCategory'] as String,
      imageUrl: json['strCategoryThumb'] as String,
    );
  }

  final String name;
  final String imageUrl;
}
