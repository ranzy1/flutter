import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:malisa/home/basepage.dart';

class ForumDiskusiPage extends BasePage {
  const ForumDiskusiPage({super.key}) : super(title: 'Forum Diskusi');

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
              Colors.blueGrey.shade900,
              Colors.black87,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header Pencarian dan Tambah Diskusi
              _buildHeader(context),

              // Kategori Diskusi
              _buildKategoriDiskusi(),

              // Daftar Diskusi
              Expanded(
                child: _buildListDiskusi(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFAB(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Cari topik diskusi...',
                  hintStyle: TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.search, color: Colors.cyanAccent),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.cyanAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              icon: const Icon(Icons.filter_list_rounded, color: Colors.cyanAccent),
              onPressed: () {
                // Aksi filter
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKategoriDiskusi() {
    final List<Map<String, dynamic>> kategori = [
      {'nama': 'Semua', 'aktif': true},
      {'nama': 'Matematika', 'aktif': false},
      {'nama': 'Sains', 'aktif': false},
      {'nama': 'Teknologi', 'aktif': false},
      {'nama': 'Sosial', 'aktif': false},
    ];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: kategori.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              label: Text(kategori[index]['nama']),
              selected: kategori[index]['aktif'],
              selectedColor: Colors.cyanAccent,
              backgroundColor: Colors.white.withOpacity(0.1),
              labelStyle: TextStyle(
                color: kategori[index]['aktif'] ? Colors.black : Colors.white,
              ),
              onSelected: (bool selected) {
                // Logika pemilihan kategori
              },
            ),
          );
        },
      ),
    );
  }

Widget _buildListDiskusi() {
  final List<Map<String, dynamic>> diskusi = [
    {
      'judul': 'Metode Pemecahan Persamaan Diferensial',
      'penulis': 'Ahmad Santoso',
      'komentar': 42,
      'waktu': '2 jam yang lalu',
      'kategori': 'Matematika',
    },
    {
      'judul': 'Diskusi Tentang Kecerdasan Buatan',
      'penulis': 'Budi Pratama',
      'komentar': 28,
      'waktu': '5 jam yang lalu',
      'kategori': 'Teknologi',
    },
    {
      'judul': 'Pengaruh Teknologi pada Interaksi Sosial',
      'penulis': 'Dewi Anggraeni',
      'komentar': 35,
      'waktu': '1 hari yang lalu',
      'kategori': 'Sosial',
    },
  ];

  return ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    itemCount: diskusi.length,
    itemBuilder: (BuildContext context, int index) {
      return AnimationConfiguration.staggeredList(
        position: index,
        duration: const Duration(milliseconds: 375),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              child: ListTile(
                title: Text(
                  diskusi[index]['judul'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      diskusi[index]['penulis'],
                      style: const TextStyle(color: Colors.white54),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.cyanAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        diskusi[index]['kategori'],
                        style: const TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.comment, 
                          color: Colors.white54, 
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          diskusi[index]['komentar'].toString(),
                          style: const TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                    Text(
                      diskusi[index]['waktu'],
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Aksi buka detail diskusi
                }, 
              ),
            ),
          ),
        ),
      );
    },
  );
}

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Aksi untuk menambah diskusi baru
      },
      backgroundColor: Colors.cyanAccent,
      child: const Icon(Icons.add),
    );
  }
}