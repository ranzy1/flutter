import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MataKuliah {
  final String kode;
  final String nama;
  final int sks;
  final String deskripsi;
  final List<String> tugas;
  final List<String> materi;
  final List<String> urlMateri;
  final Color warna;
  final IconData icon;
  final double progress;
  final DateTime createdAt;

  MataKuliah({
    required this.kode,
    required this.nama,
    required this.sks,
    required this.deskripsi,
    required this.tugas,
    required this.materi,
    required this.urlMateri,
    required this.warna,
    required this.icon,
    this.progress = 0.5,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Metode untuk menghitung estimasi waktu tersisa
  String get estimasiWaktu {
    final totalTugas = tugas.length;
    final completedTugas = (progress * totalTugas).round();
    return '$completedTugas dari $totalTugas tugas selesai';
  }
}

class Tugas {
  final String id;
  final String nama;
  final String mataKuliah;
  final DateTime deadline;
  final Color warna;
  bool isCompleted;
  final Priority priority;

  Tugas({
    required this.id,
    required this.nama,
    required this.mataKuliah,
    required this.deadline,
    required this.warna,
    this.isCompleted = false,
    this.priority = Priority.medium,
  });

  // Getter untuk menentukan status prioritas
  Color get priorityColor {
    switch (priority) {
      case Priority.high:
        return Colors.red;
      case Priority.medium:
        return Colors.orange;
      case Priority.low:
        return Colors.green;
    }
  }
}

enum Priority { low, medium, high }

class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  final List<MataKuliah> _mataKuliah = [
    MataKuliah(
      kode: 'TSI1233',
      nama: 'Statistik',
      sks: 3,
      deskripsi: 'Analisis data statistik dan konsep probabilitas',
      tugas: [
        'Laporan Analisis Data',
        'Ujian Tengah Semester',
        'Proyek Statistik'
      ],
      materi: [
        'Pengantar Statistik',
        'Probabilitas Dasar',
        'Distribusi Probabilitas'
      ],
      urlMateri: [
        'https://example.com/statistik-intro',
        'https://example.com/probabilitas-dasar',
        'https://example.com/distribusi-probabilitas'
      ],
      warna: Colors.deepPurple,
      icon: Icons.analytics_rounded,
      progress: 0.6,
      createdAt: DateTime(2024, 1, 15),
    ),
    // ... mata kuliah lainnya
  ];

  final List<Tugas> _tugas = [
    Tugas(
      id: 'TSI1233_1',
      nama: 'Laporan Analisis Data',
      mataKuliah: 'Statistik',
      deadline: DateTime(2024, 2, 15),
      warna: Colors.deepPurple,
      priority: Priority.high,
    ),
    // ... tugas lainnya
  ];

  List<MataKuliah> getAllMataKuliah() => _mataKuliah;

  List<Tugas> getAllTugas() => _tugas;

  // Fungsi untuk mencari mata kuliah berdasarkan nama
  MataKuliah? findMataKuliahByName(String nama) {
    try {
      return _mataKuliah.firstWhere((mk) => mk.nama.toLowerCase() == nama.toLowerCase());
    } catch (e) {
      return null;
    }
  }

  // Fungsi untuk mendapatkan tugas berdasarkan mata kuliah
  List<Tugas> getTugasByMataKuliah(String mataKuliahNama) {
    return _tugas.where((tugas) => tugas.mataKuliah == mataKuliahNama).toList();
  }

  // Fungsi untuk membuka URL dengan error handling yang lebih baik
  Future<bool> launchURL(BuildContext context, String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunch(uri.toString())) {
        await launch(uri.toString());
        return true;
      } else {
        _showErrorSnackBar(context, 'Tidak dapat membuka URL');
        return false;
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Terjadi kesalahan saat membuka URL');
      return false;
    }
  }

  // Metode privat untuk menampilkan error
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Fungsi untuk menambahkan tugas baru
  void addTugas(Tugas tugas) {
    _tugas.add(tugas);
  }

  // Fungsi untuk menghapus tugas
  void removeTugas(String id) {
    _tugas.removeWhere((tugas) => tugas.id == id);
  }

  // Fungsi untuk memperbarui status tugas
  void updateTugasStatus(String id, bool isCompleted) {
    final index = _tugas.indexWhere((tugas) => tugas.id == id);
    if (index != -1) {
      _tugas[index].isCompleted = isCompleted;
    }
  }
}

// Extension untuk formatting tanggal
extension DateTimeExtension on DateTime {
  String formatTanggal() {
    return '$day/${month}/${year}';
  }
}