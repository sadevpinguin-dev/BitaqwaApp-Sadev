import 'package:bitaqwa/enum/kategori_doa_enum.dart';

extension DoaCategoryExtension on DoaCategory {
  String get title {
    switch (this) {
      case DoaCategory.harian:
        return "harian";

      case DoaCategory.kesehatan:
        return "kesehatan";

      case DoaCategory.makananMinuman:
        return "Makanan & Minuman";

      case DoaCategory.pagiMalam:
        return "Pagi & Malam";

      case DoaCategory.rumah:
        return "Rumah";

      case DoaCategory.perjalanan:
        return "Perjalanan";

      case DoaCategory.sholat:
        return "Sholat";

      case DoaCategory.etikaBaik:
        return "Etika Baik";
    }
  }

  String get image {
    switch (this) {
      case DoaCategory.harian:
        return "assets/images/ic_doa_harian.png";

      case DoaCategory.kesehatan:
        return "assets/images/ic_doa_kesehatan.png";

      case DoaCategory.makananMinuman:
        return "assets/images/ic_doa_makanan_minuman.png";

      case DoaCategory.pagiMalam:
        return "assets/images/ic_doa_pagi_malam.png";

      case DoaCategory.rumah:
        return "assets/images/ic_doa_rumah.png";

      case DoaCategory.perjalanan:
        return "assets/images/ic_doa_perjalanan.png";

      case DoaCategory.sholat:
        return "assets/images/ic_doa_sholat.png";

      case DoaCategory.etikaBaik:
        return "assets/images/ic_doa_etika_baik.png";
    }
  }
}
