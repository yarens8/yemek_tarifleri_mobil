import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../services/api_service.dart';
import '../models/category.dart';
import '../models/recipe.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _logger = Logger('HomeScreen');
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  List<Category> _categories = [];
  List<Recipe> _recipes = [];
  bool _isLoading = true;
  String _apiStatus = 'API durumu bilinmiyor';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _apiStatus = 'Veriler yükleniyor...';
    });

    try {
      final categoriesData = await _apiService.getCategories();
      final recipesData = await _apiService.getRecipes();
      
      setState(() {
        _categories = categoriesData.map((map) => Category.fromJson(map)).toList();
        _recipes = recipesData.map((map) => Recipe.fromJson(map)).toList();
        _isLoading = false;
        _apiStatus = 'Veriler başarıyla yüklendi';
      });
    } catch (e) {
      _logger.severe('Veri yüklenirken hata: $e');
      setState(() {
        _isLoading = false;
        _apiStatus = 'Veri yüklenirken hata oluştu: $e';
      });
    }
  }

  Future<void> _searchRecipes(String query) async {
    if (query.isEmpty) {
      _loadData();
      return;
    }

    try {
      final searchData = await _apiService.searchRecipes(query);
      setState(() {
        _recipes = searchData.map((map) => Recipe.fromJson(map)).toList();
      });
    } catch (e) {
      _logger.severe('Arama yapılırken hata: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lezzetli Tarifler'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
            tooltip: 'Yenile',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // API durumu
            if (_apiStatus.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _apiStatus,
                  style: TextStyle(
                    color: _apiStatus.contains('hata') ? Colors.red : Colors.green,
                  ),
                ),
              ),
            // Arama çubuğu
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Tarif ara...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: _searchRecipes,
              ),
            ),

            // Kategori listesi
            if (_categories.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          final recipes = await _apiService.getRecipesByCategory(category.id);
                          setState(() {
                            _recipes = recipes.map((map) => Recipe.fromJson(map)).toList();
                          });
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.orange,
                              child: Icon(
                                _getCategoryIcon(category.icon),
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(category.name),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

            // Tarif listesi
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = _recipes[index];
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.orange,
                              child: Text(recipe.title[0]),
                            ),
                            title: Text(recipe.title),
                            subtitle: Text('${recipe.preparationTime} dakika'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              // TODO: Tarif detay sayfasına git
                              _logger.info('Tarif seçildi: ${recipe.title}');
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String icon) {
    switch (icon) {
      case 'soup':
        return Icons.soup_kitchen;
      case 'main_dish':
        return Icons.restaurant;
      case 'dessert':
        return Icons.cake;
      case 'salad':
        return Icons.eco;
      case 'beverage':
        return Icons.local_drink;
      default:
        return Icons.food_bank;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
} 