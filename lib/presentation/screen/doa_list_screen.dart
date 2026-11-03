import 'package:flutter/material.dart';
import 'package:bitaqwa/data/model/doa_model.dart';
import 'package:bitaqwa/enum/kategori_doa_enum.dart';
import 'package:bitaqwa/data/dummy/doa_data.dart';
import 'package:bitaqwa/presentation/screen/doa_detail_screen.dart';

class DoaListScreen extends StatefulWidget {
  final DoaCategory category;

  const DoaListScreen({super.key, required this.category});

  @override
  State<DoaListScreen> createState() => _DoaListScreenState();
}

class _DoaListScreenState extends State<DoaListScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 1. Controller untuk animasi list item masuk
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Doa> listDoa = doaData[widget.category] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFE3EFFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF28B66),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _getCategoryTitle(widget.category),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: "PoppinsMedium",
          ),
        ),
        centerTitle: true,
      ),
      body: listDoa.isEmpty
          ? const Center(
              child: Text(
                'Data doa tidak ditemukan',
                style: TextStyle(fontFamily: "PoppinsMedium"),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: listDoa.length,
              itemBuilder: (context, index) {
                final doa = listDoa[index];

                // 2. Membuat efek animasi bergeser & muncul satu per satu (Staggered Animation)
                final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: Interval(
                      (index / listDoa.length) * 0.5,
                      ((index + 1) / listDoa.length) * 0.5 + 0.5,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
                );

                return AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: animation.value,
                      child: Transform.translate(
                        offset: Offset(0, 50 * (1 - animation.value)),
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        // Efek saat card ditekan
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoaDetailScreen(doa: doa),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              // Gambar Icon Doa
                              Container(
                                width: 48,
                                height: 48,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    doa.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Judul Doa
                              Expanded(
                                child: Text(
                                  doa.title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "PoppinsMedium",
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _getCategoryTitle(DoaCategory category) {
    switch (category) {
      case DoaCategory.harian:
        return 'harian';
      case DoaCategory.kesehatan:
        return 'kesehatan';
      case DoaCategory.pagiMalam:
        return 'Pagi & Malam';
      case DoaCategory.makananMinuman:
        return 'Makanan & Minuman';
      case DoaCategory.rumah:
        return 'Rumah';
      case DoaCategory.perjalanan:
        return 'Perjalanan';
      case DoaCategory.sholat:
        return 'Sholat';
      case DoaCategory.etikaBaik:
        return 'Etika Baik';
    }
  }
}
