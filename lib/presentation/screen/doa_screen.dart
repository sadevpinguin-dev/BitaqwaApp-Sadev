import 'package:bitaqwa/data/dummy/kategori_doa_data.dart';
import 'package:bitaqwa/extention/kategori_doa_ext.dart';
import 'package:bitaqwa/presentation/widget/card_doa.dart';
import 'package:bitaqwa/presentation/screen/doa_list_screen.dart';
import 'package:flutter/material.dart';

class DoaScreen extends StatefulWidget {
  const DoaScreen({super.key});

  @override
  State<DoaScreen> createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bannerFadeAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Controller utama untuk mengontrol durasi animasi
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // 2. Animasi fade-in untuk banner atas
    _bannerFadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );

    // Jalankan animasi saat screen pertama kali dibuka
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F9), // Warna latar belakang soft
      appBar: AppBar(
        backgroundColor: const Color(0xFFF28B66), // Warna oranye AppBar
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Doa-doa',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. Banner / Gambar ilustrasi bagian atas (Dengan Animasi Fade)
          FadeTransition(
            opacity: _bannerFadeAnimation,
            child: Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/bg_doa.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // 2. GridView Kategori Doa (Dengan Animasi Staggered Slide-Up)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                itemCount: doaCategoryData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final item = doaCategoryData[index];

                  // Membuat interval waktu animasi yang berbeda untuk setiap item grid (Staggered)
                  final itemAnimation = Tween<double>(begin: 0.0, end: 1.0)
                      .animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve: Interval(
                            0.2 + (index / doaCategoryData.length) * 0.5,
                            1.0,
                            curve: Curves.easeOutCubic,
                          ),
                        ),
                      );

                  return AnimatedBuilder(
                    animation: itemAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: itemAnimation.value,
                        child: Transform.translate(
                          offset: Offset(0, 40 * (1 - itemAnimation.value)),
                          child: child,
                        ),
                      );
                    },
                    child: CardDoa(
                      image: item.category.image,
                      title: item.category.title,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DoaListScreen(category: item.category),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
