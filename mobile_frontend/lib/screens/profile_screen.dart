import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Ayarlar sayfasına yönlendirme
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profil Başlığı
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(128),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://source.unsplash.com/random/150x150/?portrait',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Kullanıcı Adı',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'kullanici@email.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // İstatistikler
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem('Tarifler', '12'),
                  _buildStatItem('Favoriler', '24'),
                  _buildStatItem('Takipçiler', '156'),
                  _buildStatItem('Takip', '89'),
                ],
              ),
            ),

            const Divider(),

            // Menü Öğeleri
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('Favori Tariflerim'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Favori tarifler sayfasına yönlendirme
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle_outline),
              title: const Text('Tarif Ekle'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Tarif ekleme sayfasına yönlendirme
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Son Görüntülenenler'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Son görüntülenenler sayfasına yönlendirme
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Bildirimler'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Bildirimler sayfasına yönlendirme
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Yardım ve Destek'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Yardım sayfasına yönlendirme
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Çıkış Yap'),
              onTap: () {
                // Çıkış işlemi
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
} 