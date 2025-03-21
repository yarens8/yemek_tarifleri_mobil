import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarif Ara'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Arama Çubuğu
            TextField(
              decoration: InputDecoration(
                hintText: 'Tarif ara...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 20),

            // Filtreler
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list),
                    label: const Text('Filtreler'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Popüler Aramalar
            const Text(
              'Popüler Aramalar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildPopularSearchChip('Kek'),
                _buildPopularSearchChip('Pilav'),
                _buildPopularSearchChip('Makarna'),
                _buildPopularSearchChip('Salata'),
                _buildPopularSearchChip('Çorba'),
                _buildPopularSearchChip('Börek'),
              ],
            ),
            const SizedBox(height: 20),

            // Son Aramalar
            const Text(
              'Son Aramalar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.history),
                    title: Text('Son Arama ${index + 1}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {},
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

  Widget _buildPopularSearchChip(String label) {
    return ActionChip(
      label: Text(label),
      onPressed: () {},
    );
  }
} 