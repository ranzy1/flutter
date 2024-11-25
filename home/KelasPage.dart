import 'package:flutter/material.dart';
import 'data_service.dart';
import 'package:malisa/home/basepage.dart';
import 'detailmatakuliah.dart';

class KelasPage extends BasePage {
  const KelasPage({super.key}) : super(title: 'Kelas');

  @override
  Widget build(BuildContext context) {
    final dataService = DataService();
    final mataKuliah = dataService.getAllMataKuliah();

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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Mata Kuliah Semester',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ),
              Expanded(
                child: _buildMataKuliahGrid(mataKuliah),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMataKuliahGrid(List<MataKuliah> mataKuliah) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: mataKuliah.length,
      itemBuilder: (context, index) {
        return _buildKelasCard(context, mataKuliah[index]);
      },
    );
  }

  Widget _buildKelasCard(BuildContext context, MataKuliah mataKuliah) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke detail mata kuliah
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMatakuliahPage(mataKuliah: mataKuliah),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              mataKuliah.warna.withOpacity(0.7),
              mataKuliah.warna.withOpacity(0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                mataKuliah.nama,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Text(
                '${mataKuliah.sks} SKS',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: mataKuliah.progress,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(mataKuliah.warna),
              ),
            ],
          ),
        ),
      ),
    );
  }
}