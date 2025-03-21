class Recipe {
  final int id;
  final String title;
  final String ingredients;
  final String instructions;
  final String createdAt;
  final int userId;
  final int categoryId;
  final int views;
  final String servingSize;
  final String preparationTime;
  final String cookingTime;
  final String tips;
  final String imageUrl;
  final String ingredientsSections;
  final String username;

  Recipe({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.instructions,
    required this.createdAt,
    required this.userId,
    required this.categoryId,
    required this.views,
    required this.servingSize,
    required this.preparationTime,
    required this.cookingTime,
    required this.tips,
    required this.imageUrl,
    required this.ingredientsSections,
    required this.username,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id']?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
      ingredients: json['ingredients']?.toString() ?? '',
      instructions: json['instructions']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      userId: json['user_id']?.toInt() ?? 0,
      categoryId: json['category_id']?.toInt() ?? 0,
      views: json['views']?.toInt() ?? 0,
      servingSize: json['serving_size']?.toString() ?? '',
      preparationTime: json['preparation_time']?.toString() ?? '',
      cookingTime: json['cooking_time']?.toString() ?? '',
      tips: json['tips']?.toString() ?? '',
      imageUrl: json['image_url']?.toString() ?? '',
      ingredientsSections: json['ingredients_sections']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'ingredients': ingredients,
      'instructions': instructions,
      'created_at': createdAt,
      'user_id': userId,
      'category_id': categoryId,
      'views': views,
      'serving_size': servingSize,
      'preparation_time': preparationTime,
      'cooking_time': cookingTime,
      'tips': tips,
      'image_url': imageUrl,
      'ingredients_sections': ingredientsSections,
      'username': username,
    };
  }
} 