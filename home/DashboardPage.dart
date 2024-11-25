import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'data_service.dart';
import 'package:malisa/home/basepage.dart';
import 'detailmatakuliah.dart';

// Tema Aplikasi
class AppTheme {
  static final LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.black87,
      Colors.deepPurple.shade900,
      Colors.black87,
    ],
  );

  static final TextStyle welcomeTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    color: Colors.white.withOpacity(0.6),
  );

  static final TextStyle nameTextStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.cyanAccent,
    letterSpacing: 1.2,
  );

  static final TextStyle sectionTitleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white.withOpacity(0.8),
  );
}

// Dimensi Aplikasi
class AppDimensions {
  static const double cardBorderRadius = 20.0;
  static const double defaultPadding = 20.0;
  static const double defaultSpacing = 10.0;
  static const double iconSize = 30.0;
}

// Utility untuk Glassmorphism
class GlassMorphicStyles {
  static GlassmorphicContainer buildGlassContainer({
    required Widget child,
    double width = double.infinity,
    double height = 120,
    double blur = 10,
  }) {
    return GlassmorphicContainer(
      width: width,
      height: height,
      borderRadius: AppDimensions.cardBorderRadius,
      blur: blur,
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
      child: child,
    );
  }
}

// Layout Responsif
class ResponsiveLayout extends StatelessWidget {
  final Widget Function(BuildContext, BoxConstraints) builder;

  const ResponsiveLayout({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return builder(context, constraints);
      },
    );
  }
}

class DashboardPage extends BasePage {
  const DashboardPage({super.key}) : super(title: 'Dashboard');

  @override
  Widget build(BuildContext context) {
    final dataService = DataService();
    final mataKuliah = dataService.getAllMataKuliah();
    final tugas = dataService.getAllTugas();

    return ResponsiveLayout(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            gradient: AppTheme.backgroundGradient,
          ),
          child: SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(AppDimensions.defaultPadding),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      FadeInDown(child: _buildWelcomeHeader()),
                      const SizedBox(height: AppDimensions.defaultPadding),
                      FadeInUp(
                        child: _buildStatistikCard(
                          kelas: mataKuliah.length,
                          tugas: tugas.length,
                          materi: mataKuliah.expand((mk) => mk.materi).length,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.defaultPadding),
                      FadeInUp(
                        delay: const Duration(milliseconds: 300),
                        child: _buildMataKuliahSection(mataKuliah),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWelcomeHeader() {
    return GlassMorphicStyles.buildGlassContainer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selamat Datang,',
              style: AppTheme.welcomeTextStyle,
            ),
            Text(
              'Malisa APP',
              style: AppTheme.nameTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistikCard({
    required int kelas,
    required int tugas,
    required int materi,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard('Kelas', kelas.toString(), Icons.school),
        _buildStatCard('Tugas', tugas.toString(), Icons.assignment),
        _buildStatCard('Materi', materi.toString(), Icons.library_books),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return GlassMorphicStyles.buildGlassContainer(
      width: 100,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: AppDimensions.iconSize, color: Colors.cyanAccent),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.cyanAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMataKuliahSection(List<MataKuliah> mataKuliah) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mata Kuliah Aktif',
          style: AppTheme.sectionTitleStyle,
        ),
        const SizedBox(height: AppDimensions.defaultSpacing),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: mataKuliah.length,
          itemBuilder: (context, index) {
            return _buildMataKuliahCard(context, mataKuliah[index]);
          },
        ),
      ],
    );
  }

  Widget _buildMataKuliahCard(BuildContext context, MataKuliah mataKuliah) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMatakuliahPage(mataKuliah: mataKuliah),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              mataKuliah.warna.withOpacity(0.7),
              mataKuliah.warna.withOpacity(0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            mataKuliah.nama,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '${mataKuliah.sks} SKS',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          trailing: Icon(
            mataKuliah.icon,
            color: Colors.cyanAccent,
          ),
        ),
      ),
    );
  }
}