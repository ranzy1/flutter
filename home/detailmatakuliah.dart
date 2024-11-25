import 'package:flutter/material.dart';
import 'data_service.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMatakuliahPage extends StatelessWidget {
  final MataKuliah mataKuliah;

  const DetailMatakuliahPage({
    Key? key, 
    required this.mataKuliah
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mataKuliah.nama),
        backgroundColor: mataKuliah.warna,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black87,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Mata Kuliah
                      _buildHeaderSection(),
                      const SizedBox(height: 20),
                      
                      // Deskripsi Mata Kuliah
                      _buildDeskripsiSection(),
                      const SizedBox(height: 20),
                      
                      // Tugas Section
                      _buildSectionTitle('Daftar Tugas'),
                      const SizedBox(height: 10),
                      ..._buildTugasCards(),
                      const SizedBox(height: 20),
                      
                      // Materi Section
                      _buildSectionTitle('Materi Kuliah'),
                      const SizedBox(height: 10),
                      ..._buildMateriCards(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mataKuliah.nama,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Kode: ${mataKuliah.kode}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
            Text(
              '${mataKuliah.sks} SKS',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDeskripsiSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        mataKuliah.deskripsi,
        style: TextStyle(
          color: Colors.white.withOpacity(0.8),
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.cyanAccent,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  List<Widget> _buildTugasCards() {
    return mataKuliah.tugas.map((tugas) {
      return _TugasCard(tugas: tugas);
    }).toList();
  }

  List<Widget> _buildMateriCards() {
    return List.generate(mataKuliah.materi.length, (index) {
      return _MateriCard(
        materi: mataKuliah.materi[index],
        url: mataKuliah.urlMateri[index],
      );
    });
  }
}

class _TugasCard extends StatefulWidget {
  final String tugas;

  const _TugasCard({Key? key, required this.tugas}) : super(key: key);

  @override
  _TugasCardState createState() => _TugasCardState();
}

class _TugasCardState extends State<_TugasCard> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple.shade700.withOpacity(0.7),
            Colors.deepPurple.shade900.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.tugas,
                style: TextStyle(
                  color: isCompleted ? Colors.green : Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: isCompleted 
                    ? TextDecoration.lineThrough 
                    : TextDecoration.none,
                ),
              ),
            ),
            Checkbox(
              value: isCompleted,
              onChanged: (value) {
                setState(() {
                  isCompleted = value ?? false;
                });
              },
              activeColor: Colors.cyanAccent,
              checkColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class _MateriCard extends StatelessWidget {
  final String materi;
  final String url;

  const _MateriCard({
    Key? key, 
    required this.materi, 
    required this.url
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple.shade700.withOpacity(0.7),
            Colors.deepPurple.shade900.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          materi,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.link, color: Colors.cyanAccent),
          onPressed: () => _launchURL(context),
        ),
      ),
    );
  }

  void _launchURL(BuildContext context) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch the URL')),
      );
    }
  }
}