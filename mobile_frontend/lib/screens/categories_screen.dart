import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategoriler'),
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return _buildCategoryCard(
            context,
            _getCategoryData(index),
          );
        },
      ),
    );
  }

  Map<String, dynamic> _getCategoryData(int index) {
    final categories = [
      {
        'title': 'Çorbalar',
        'icon': Icons.soup_kitchen,
        'color': Colors.orange[100],
        'count': '24 Tarif',
      },
      {
        'title': 'Ana Yemekler',
        'icon': Icons.restaurant,
        'color': Colors.red[100],
        'count': '48 Tarif',
      },
      {
        'title': 'Salatalar',
        'icon': Icons.eco,
        'color': Colors.green[100],
        'count': '32 Tarif',
      },
      {
        'title': 'Tatlılar',
        'icon': Icons.cake,
        'color': Colors.pink[100],
        'count': '36 Tarif',
      },
      {
        'title': 'Kahvaltılıklar',
        'icon': Icons.breakfast_dining,
        'color': Colors.yellow[100],
        'count': '28 Tarif',
      },
      {
        'title': 'Atıştırmalıklar',
        'icon': Icons.cookie,
        'color': Colors.brown[100],
        'count': '42 Tarif',
      },
    ];
    return categories[index];
  }

  Widget _buildCategoryCard(BuildContext context, Map<String, dynamic> data) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          // Kategori detay sayfasına yönlendirme
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: data['color'],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                data['icon'],
                size: 48,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 8),
              Text(
                data['title'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                data['count'],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 