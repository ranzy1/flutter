import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:malisa/home/basepage.dart';

class TugasPage extends BasePage {
  const TugasPage({super.key}) : super(title: 'Tugas');

  @override
  Widget build(BuildContext context) {
    return Container(
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
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Tugas
                FadeInDown(
                  child: GlassmorphicContainer(
                    width: double.infinity,
                    height: 120,
                    borderRadius: 20,
                    blur: 10,
                    alignment: Alignment.bottomCenter,
                    border: 2,
                    linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.05),
                      ],
                      stops: const [0.1, 1],
                    ),
                    borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.1),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Daftar Tugas',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyanAccent,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Kelola dan Selesaikan Tugas Anda',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Statistik Tugas
                FadeInUp(
                  child: _buildTugasStatistics(context),
                ),
                const SizedBox(height: 30),

                // Judul Daftar Tugas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tugas Anda',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.8),
                        letterSpacing: 1.1,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.filter_list_rounded,
                        color: Colors.cyanAccent,
                        size: 30,
                      ),
                      onPressed: () {
                        // Aksi filter tugas
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                
                // Daftar Tugas
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5, // Jumlah tugas
                  itemBuilder: (context, index) {
                    return FadeInUp(
                      delay: Duration(milliseconds: 200 * index),
                      child: _buildTugasCard(context, index),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTugasStatistics(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildStatCard('Total Tugas', '12', Icons.assignment_rounded),
          const SizedBox(width: 15),
          _buildStatCard('Belum Selesai', '5', Icons.pending_rounded),
          const SizedBox(width: 15),
          _buildStatCard('Selesai', '7', Icons.check_circle_rounded),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return GlassmorphicContainer(
      width: 130,
      height: 170,
      borderRadius: 20,
      blur: 10,
      alignment: Alignment.center,
      border: 2,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.1),
          Colors.white.withOpacity(0.05),
        ],
        stops: const [0.1, 1],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.5),
          Colors.white.withOpacity(0.1),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.cyanAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon, 
              size: 40, 
              color: Colors.cyanAccent,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
              fontSize: 16, 
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w600,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32, 
              color: Colors.cyanAccent,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTugasCard(BuildContext context, int index) {
    final List<String> tugasNames = [
      'Laporan Praktikum Fisika',
      'Makalah Sejarah',
      'Proyek Pemrograman',
      'Analisis Jurnal',
      'Presentasi Kelompok'
    ];

    final List<String> mataPelajaran = [
      'Fisika',
      'Sejarah',
      'Pemrograman',
      'Bahasa Indonesia',
      'Ilmu Pengetahuan Sosial'
    ];

    final List<Color> progressColors = [
      Colors.redAccent,
      Colors.orangeAccent,
      Colors.greenAccent,
      Colors.blueAccent,
      Colors.purpleAccent,
    ];

    return Container(
       margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple.shade700.withOpacity(0.7),
            Colors.deepPurple.shade900.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul dan Mata Pelajaran
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    tugasNames[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  mataPelajaran[index],
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Progress
            LinearProgressIndicator(
              value: (index + 1) / 5, // Contoh progress
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(progressColors[index % progressColors.length]),
            ),
            const SizedBox(height: 5),
            // Tombol Aksi
            ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol ditekan
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text('Lihat Tugas'),
            ),
          ],
        ),
      ),
    );
  }
}