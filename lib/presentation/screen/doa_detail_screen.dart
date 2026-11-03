import 'package:flutter/material.dart';
import 'package:bitaqwa/data/model/doa_model.dart';

class DoaDetailScreen extends StatefulWidget {
  final Doa doa;

  const DoaDetailScreen({super.key, required this.doa});

  @override
  State<DoaDetailScreen> createState() => _DoaDetailScreenState();
}

class _DoaDetailScreenState extends State<DoaDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Variabel state untuk animasi sentuhan/ketukan card
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    // 1. Inisialisasi AnimationController (Durasi animasi entrance: 600ms)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // 2. Animasi Fade (Muncul bertahap dari transparan)
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    // 3. Animasi Slide (Naik sedikit dari bawah ke tengah)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // Jalankan animasi saat halaman pertama kali dibuka
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // TOMBOL KEMBALI LEBIH JELAS & ELEGAN
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(
              0.85,
            ), // Background putih transparan
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFF333333),
              size: 18,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          widget.doa.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: "PoppinsMedium",
            shadows: [
              Shadow(
                color: Colors.black45,
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // BACKGROUND FULL SCREEN
          Positioned.fill(
            child: Image.asset('assets/images/bg_doa.png', fit: BoxFit.cover),
          ),

          // CARD KONTEN DENGAN ANIMASI FADE + SLIDE + BOUNCE SCALE
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: GestureDetector(
                    onTapDown: (_) => setState(() => _isPressed = true),
                    onTapUp: (_) => setState(() => _isPressed = false),
                    onTapCancel: () => setState(() => _isPressed = false),
                    child: AnimatedScale(
                      scale: _isPressed ? 0.98 : 1.0,
                      duration: const Duration(milliseconds: 150),
                      curve: Curves.easeInOut,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 32,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Judul Doa
                            Text(
                              widget.doa.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                                fontFamily: "PoppinsMedium",
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Teks Arab
                            Text(
                              widget.doa.arabicText,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C3E50),
                                height: 1.8,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Terjemahan Bahasa Indonesia
                            Text(
                              widget.doa.translation,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF7CA1C9),
                                height: 1.5,
                                fontFamily: "PoppinsMedium",
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Referensi Hadist
                            Text(
                              widget.doa.reference,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                                fontFamily: "PoppinsMedium",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
