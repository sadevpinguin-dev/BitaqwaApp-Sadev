import 'package:flutter/material.dart';

class ZakatScreen extends StatefulWidget {
  const ZakatScreen({super.key});

  @override
  State<ZakatScreen> createState() => _ZakatScreenState();
}

class _ZakatScreenState extends State<ZakatScreen> {
  final TextEditingController _hartaController = TextEditingController();

  double _totalHarta = 0;
  double _zakatDikeluarkan = 0;

  // Standar asumsi nisab harta (misal: setara 85 gram emas, asumsikan Rp 1.000.000 / gram = Rp 85.000.000)
  // Nilai ini bisa disesuaikan dengan harga emas live atau aturan lembaga zakat.
  final double _nisabZakat = 85000000;

  @override
  void initState() {
    super.initState();
    // Mendengarkan setiap perubahan ketikan secara live (auto-calculate)
    _hartaController.addListener(_hitungZakatOtomatis);
  }

  void _hitungZakatOtomatis() {
    String cleanText = _hartaController.text.replaceAll(RegExp(r'[^0-9]'), '');
    double inputHarta = double.tryParse(cleanText) ?? 0;

    setState(() {
      _totalHarta = inputHarta;
      if (inputHarta >= _nisabZakat) {
        _zakatDikeluarkan =
            inputHarta * 0.025; // Hitung 2.5% jika memenuhi syarat
      } else {
        _zakatDikeluarkan = 0; // Belum wajib zakat
      }
    });
  }

  // Format angka ke Rupiah manual tanpa package external
  String _formatRupiah(double amount) {
    String formatted = amount.toStringAsFixed(2);
    List<String> parts = formatted.split('.');
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String mathFunc(Match match) => '${match[1]}.';
    String result = parts[0].replaceAllMapped(reg, mathFunc);
    return 'Rp. $result,${parts[1]}';
  }

  @override
  void dispose() {
    _hartaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Cek apakah harta di bawah nisab dan tidak kosong
    bool isNisabBelumCukup = _totalHarta > 0 && _totalHarta < _nisabZakat;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF28B66),
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFF333333),
              size: 16,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Zakat',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: "PoppinsMedium",
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. BANNER ILUSTRASI ZAKAT
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage('assets/images/bg_zakat.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 2. KARTU INPUT TOTAL HARTA
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF0ECEC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Harta',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF28B66),
                      fontFamily: "PoppinsMedium",
                    ),
                  ),
                  const SizedBox(height: 16),

                  // TextField Input (Auto calculate)
                  TextField(
                    controller: _hartaController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Masukkan Total Harta',
                      labelStyle: const TextStyle(color: Colors.grey),
                      hintText: 'Rp. 0',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFF28B66)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFF28B66),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 3. NOTIFIKASI PERINGATAN HAUL / NISAB TIDAK TERPENUHI
            if (isNisabBelumCukup)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFEF5350), width: 1),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: Color(0xFFC62828)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Peringatan: Haul atau Nisab tidak terpenuhi (Harta belum mencapai batas minimum nisab zakat mal).',
                        style: TextStyle(
                          color: Color(0xFFC62828),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontFamily: "PoppinsMedium",
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // 4. KARTU HASIL: TOTAL UANG (Auto Update)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFE27C79),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Total Uang',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: "PoppinsMedium",
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatRupiah(_totalHarta),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 5. KARTU HASIL: ZAKAT DIKELUARKAN (Auto Update 2.5%)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFB072CB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Zakat Dikeluarkan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: "PoppinsMedium",
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatRupiah(_zakatDikeluarkan),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
