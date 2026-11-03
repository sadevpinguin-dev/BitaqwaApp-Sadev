import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class JadwalSholatScreen extends StatefulWidget {
  const JadwalSholatScreen({super.key});

  @override
  State<JadwalSholatScreen> createState() => _JadwalSholatScreenState();
}

class _JadwalSholatScreenState extends State<JadwalSholatScreen> {
  bool _isLoading = true;
  String _lokasi = 'Karanganyar';
  String _tanggal = '';

  Map<String, String> _jadwal = {
    'Imsak': '--:--',
    'Subuh': '--:--',
    'Terbit': '--:--',
    'Dzuhur': '--:--',
    'Ashar': '--:--',
    'Maghrib': '--:--',
    'Isya': '--:--',
  };

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null).then((_) {
      _tanggal = DateFormat(
        'EEEE, d MMMM yyyy',
        'id_ID',
      ).format(DateTime.now());
      _loadJadwalSholat();
    });
  }

  Future<void> _loadJadwalSholat() async {
    double lat = -7.5923; // Default Karanganyar/Solo
    double lon = 110.9545;
    String namaKota = 'Karanganyar';

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled) {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }

        if (permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always) {
          Position pos = await Geolocator.getCurrentPosition(
            desiredAccuracy: kIsWeb
                ? LocationAccuracy.low
                : LocationAccuracy.high,
          );
          lat = pos.latitude;
          lon = pos.longitude;

          // Mengambil nama kota/kabupaten asli dari koordinat GPS (seperti Solo, Karanganyar, dll)
          if (!kIsWeb) {
            try {
              List<Placemark> placemarks = await placemarkFromCoordinates(
                lat,
                lon,
              );
              if (placemarks.isNotEmpty) {
                Placemark place = placemarks[0];
                namaKota =
                    place.subAdministrativeArea ??
                    place.locality ??
                    place.administrativeArea ??
                    'Karanganyar';
                // Membersihkan kata 'Kabupaten' atau 'Kota' jika ingin lebih ringkas
                namaKota = namaKota
                    .replaceAll('Kabupaten ', '')
                    .replaceAll('Kota ', '');
              }
            } catch (_) {}
          } else {
            namaKota = 'Solo / Karanganyar (Web)';
          }
        }
      }
    } catch (_) {}

    // Fetch API AlAdhan
    try {
      final dateStr = DateFormat('dd-MM-yyyy').format(DateTime.now());
      final res = await http.get(
        Uri.parse(
          'https://api.aladhan.com/v1/timings/$dateStr?latitude=$lat&longitude=$lon&method=20',
        ),
      );

      if (res.statusCode == 200) {
        final t = json.decode(res.body)['data']['timings'];
        setState(() {
          _jadwal = {
            'Imsak': t['Imsak'],
            'Subuh': t['Fajr'],
            'Terbit': t['Sunrise'],
            'Dzuhur': t['Dhuhr'],
            'Ashar': t['Asr'],
            'Maghrib': t['Maghrib'],
            'Isya': t['Isha'],
          };
          _lokasi = namaKota;
          _isLoading = false;
        });
        return;
      }
    } catch (_) {}

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3EFFC),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFF28B66)),
            )
          : SingleChildScrollView(
              // Menggunakan SingleChildScrollView agar pas di semua ukuran layar tanpa error overflow
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    // 1. Header Atas
                    Container(
                      height: MediaQuery.of(context).size.height * 0.42,
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Color(0xFF6B8A9A)),
                      child: SafeArea(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  const Text(
                                    'Jadwal Sholat',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 48),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _tanggal,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Dzuhur',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _jadwal['Dzuhur']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Color(0xFFF28B66),
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _lokasi,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 2. Kartu Daftar Full Sholat (Tanpa Scroll Terpotong, Tampil Semua)
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.32,
                      left: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: _jadwal.entries
                              .map((e) => _buildItem(e.key, e.value))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildItem(String title, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          Row(
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.access_alarm_rounded,
                color: Color(0xFFF28B66),
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
