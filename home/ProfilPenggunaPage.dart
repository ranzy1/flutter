import 'package:flutter/material.dart';
import 'package:malisa/home/basepage.dart';
import 'package:animate_do/animate_do.dart';

class ProfilPenggunaPage extends BasePage {
  const ProfilPenggunaPage({super.key}) : super(title: 'Profil Pengguna');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black87,
              Colors.deepPurple.shade900,
              Colors.black87,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header Profil
                _buildProfileHeader(),

                // Statistik Pengguna
                _buildUserStatistics(),

                // Menu Pengaturan
                _buildSettingsMenu(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return FadeInDown(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Row(
          children: [
            // Foto Profil
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Colors.cyanAccent,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://ui-avatars.com/api/?name=Nama+Pengguna&background=0D8ABC&color=fff',
                ),
              ),
            ),
            const SizedBox(width: 20),
            
            // Informasi Profil
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nama Pengguna',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'email@example.com',
                    style: TextStyle(
                      color: Colors.cyanAccent.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Aksi edit profil
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Edit Profil'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserStatistics() {
    return FadeInUp(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade800.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.cyanAccent.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('Diskusi', '24'),
            _buildStatItem('Komentar', '128'),
            _buildStatItem('Skor', '1250'),
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
            color: Colors.cyanAccent,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            color: Colors.cyanAccent.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsMenu() {
    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.notifications, 'title': 'Notifikasi', 'subtitle': 'Atur preferensi notifikasi'},
      {'icon': Icons.lock, 'title': 'Keamanan', 'subtitle': 'Ubah kata sandi'},
      {'icon': Icons.language, 'title': 'Bahasa', 'subtitle': 'Pilih bahasa aplikasi'},
      {'icon': Icons.help, 'title': 'Bantuan', 'subtitle': 'Pusat bantuan'},
      {'icon': Icons.logout, 'title': 'Keluar', 'subtitle': 'Logout dari aplikasi'},
    ];

    return FadeInUp(
      delay: const Duration(milliseconds: 300),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Pengaturan',
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...menuItems.map((item) => _buildSettingsMenuItem(item)),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsMenuItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade800.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.cyanAccent.withOpacity(0.2),
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.cyanAccent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            item['icon'],
            color: Colors.cyanAccent,
          ),
        ),
        title: Text(
          item['title'],
          style: const TextStyle(color: Colors.cyanAccent),
        ),
        subtitle: Text(
          item['subtitle'],
          style: TextStyle(color: Colors.cyanAccent.withOpacity(0.7)),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.cyanAccent.withOpacity(0.7),
        ),
        onTap: () {
          // Aksi untuk setiap menu item
        },
      ),
    );
  }
}