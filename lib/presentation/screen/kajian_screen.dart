import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'detail_kajian_screen.dart';

// Model Data Kajian
class KajianModel {
  final String title;
  final String ustadz;
  final String youtubeUrl;
  final String description;

  const KajianModel({
    required this.title,
    required this.ustadz,
    required this.youtubeUrl,
    required this.description,
  });
}

class KajianScreen extends StatelessWidget {
  const KajianScreen({super.key});

  // Daftar 5 Video Kajian beserta Link YouTube (Tanpa 'const' agar tidak error)
  final List<KajianModel> _listKajian = const [
    KajianModel(
      title: '''

Rahasiakan Rencanamu, Maka Hidup Akan Lancar!
''',
      ustadz: ' Ustadz Khalid Basalamah',
      youtubeUrl: 'https://youtu.be/z4eqiux-ifk?si=QzmCTz8_KoqBZx7V',
      description: '''
Assalamualaikum Warahmatullah,
Pada video Ustadz Khalid Basalamah terbaru di channel kami, beliau menerangkan tentang Rahasiakan Rencanamu! Maka Hidup Akan Lancar. Beliau yang sering disapa Ustadz Khalid ini, dan juga beliau yang pernah diundang podcast Denny Sumargo, Deddy Corbuzer, sampai Dr Richard lee ini mengingatkan untuk tidak sembarangan mengatakan rencana atau menyebarkan rahasia. Banyak diantara kita mengatakan rencana kepada siapapun atau mengekposnya, lalu banyak orang yang hasad sehingga rencana kita itu gagal. Oleh karena itu ustadz Khalid melalui Dakwah Sunnah, beliau juga ber Manhaj Salaf dan beliau salah satu tokoh salafi di Indonesia, menyampaikan dan mengingatkan bahwa Rahasiakan Rencanamu! Maka Hidup Akan Lancar
''',
    ),
    KajianModel(
      title: 'Hindari 3 Sifat Buruk Ini Agar Rezekimu Mudah & Lancar',
      ustadz: ' Ustadz Khalid Basalamah',
      youtubeUrl: 'https://youtu.be/U2XOwnuUQ6s?si=j4o0dQWY8qvvFtd3',
      description: '''
Assalamualaikum Warahmatullah,
Pada video Ustadz Khalid Basalamah terbaru di channel kami, beliau menerangkan tentang Hindari 3 Sifat Buruk Ini Agar Rezekimu Mudah & Lancar. Beliau yang sering disapa Ustadz Khalid ini, dan juga beliau yang pernah diundang podcast Denny Sumargo, Deddy Corbuzer, sampai Dr Richard lee ini mengingatkan ada 3 Sifat Buruk yang dibenci oleh Nabi. Oleh karena itu ustadz Khalid melalui Dakwah Sunnah, beliau juga ber Manhaj Salaf dan beliau salah satu tokoh salafi di Indonesia, menyampaikan dan mengingatkan Hindari 3 Sifat Buruk Ini Agar Rezekimu Mudah & Lancar.
''',
    ),
    KajianModel(
      title: 'Ketahuilah Penyebab Rezeki Sempit dan Hidup Susah!',
      ustadz: 'Ustadz Khalid Basalamah',
      youtubeUrl: 'https://youtu.be/GelhDoBxej0?si=dPSq5grCwZ883I59',
      description: '''

Assalamualaikum Warahmatullah
Pada video Ustadz Khalid Basalamah terbaru di channel kami beliau menyampaikan tentang apa yang sering menjadi permasalahan umat yaitu rezeki seret atau rezeki sempit. Beliau menerangkan tentang penyebab rezeki seret bisa jadi dalam rumah tangga, ataupun penyebab rezeki seret menurut islam. Beliau yang sering disapa Ustadz Khalid ini dan juga beliau yang sering diundang dalam podcast seperti Denny Sumargo dan Deddy Corbuzier, menyampaikan tentang cara mengatasi gelisah dan gundah. Walaupun rezeki tak kan kemana, kita mesti berusaha untuk mendapatkannya, karena ada istah rejeki anak sholeh, yang artinya ia mendapat rejeki dari Allah karena melakukan hal yang diridhoi oleh Allah.
Ustadz Khalid Basalamah menyampaikan hal-hal yang menghalangi rezeki lancar dan berkah. Memang rezeki sudah dijamin oleh Allah, namun Beliau mengajurkan untuk senantiasa menghindari dosa agar rezeki itu menjadi berkah. Juga tidak kalah pentingnya menjauhi sifat bkhil, dan kikir, karena itu salah satu dari dosa besar. Dan justru Ustadz Khalid menerangkan tentang sedekah, karena sedekah akan dibalas allah 700 kali lipat, dan mendatang rezeki dari segala penjuru dan tidak disangka sangka. Semoga yang disampaikan Ustadz Khalid kali ini bermanfaat.
Wassalamualaikum Warahmatullah
Terimakasih Sudah Menonton, Like, dan Komentar di Channel kami. Semoga Allah melimpahkan rezeki dan kesehatan. Aamiin. Channel ini kami isi dengan konten atau kajian dakwah sunnah dan nasihat para ulama Indonesia yang di Rahmati oleh Allah. Seperti Ustadz Khalid basalamah, Ustadz Nuzul Dzikri, Ustadz Dr. Firanda Andirja, M.A., Ustadz Dr. Syafiq Riza Basalamah, M.A, Ustadz Badrusalam, Lc., Ustadz Abu Yahya Badrusalam, Lc., Ustadz Muflih Safitra, M.Sc., Almarhum Ustadz Yazid bin Abdul Qadir Jawas, Almarhum Ustadz Abdul Hakim bin Amir Abdat. Namun tidak mengurangi rasa hormat kepada Ustadz lain seperti Ustadz Adi Hidayat, Ustadz Abdul Somad, Gus Baha, Ustadz Daas Latif, Ustadz Hilman Fauzi, Ustadz Feix Siauw, Ustadz Hanan Attaki, Ustadz Faizar, Ustadzah Halimah Alaydrus dan Ustadz Lainnya yang tidak bisa kami sebutkan satu persatu, yang Insyaallah mereka dalam naungan Ahlus Sunnah Wal Jamaah. Semoga Channel ini bisa menjadi Motivasi Islami, Siraman Kalbu, dan petunjuk untuk mendatangkan rezeki dari segaa penjuru, bahkan lunas hutang. Karena pada dasarnya semua manusia ingin hidup tenang dan bahagia, sehat, lancar rezeki, dan dimudahkan dalam segala urusan. Dimana kita mencari motivasi islami menyentuh hati,Motivasi islam semangat hidup,Motivasi islam tentang kehidupan,dakwah penenang hati.''',
    ),
    KajianModel(
      title: 'Inilah Langkah Pertama Untuk Memperbaiki Diri Anda!',
      ustadz: 'Ustadz Khalid Basalamah',
      youtubeUrl: 'https://youtu.be/4Wp21Znx_Po?si=NQuzk7dsvxfC-gnk',
      description: '''

Assalamualaikum Warahmatullah,
Pada video Ustadz Khalid Basalamah terbaru di channel kami, beliau menerangkan tentang Inilah Langkah Pertama Untuk Memperbaiki Diri Anda!. Banyak orang ingin hidup tenang dan bahagia dan menjadikan hidup lebih baik, namun bingung memulainya darimana untuk memperbaiki diri, sebenarnya kita semua bisa mulai memperbaiki diri dari Akhlak atau ahlaq yang mulia, akhlakmu akan merubah hidupmu.
Beliau yang sering disapa Ustadz Khalid ini dan juga beliau yang seringkali diundang podcast Denny Sumargo sampai Dr Richard Lee ini, memberikan penjelasan bahwa apabila kita semakin memperbaiki Ahlaq semakin Allah akan memberikan pertolongan yang tidak masuk akal, karena pertolongan Allah itu dekat, pasti datang dan tidak disangka sangka. Maka jadikanlah Akhlak yang baik sebagai kunci sukses dalam hidup. Oleh karena itu ustadz Khalid melalui Dakwah Sunnah, beliau juga ber Manhaj Salaf dan beliau salah satu tokoh salafi di Indonesia, menyampaikan Inilah Langkah Pertama Untuk Memperbaiki Diri Anda!. Maka, dengan kajian Tauhid dari ustadz Khalid ini, membawa kita semakin taqwa kepada Allah. Agar hidup kita tenang dan bahagia. Wassalamualaikum Warahmatullah.

''',
    ),
    KajianModel(
      title: 'Orang-Orang yang Akan Diangkat Derajatnya Oleh Allah! ',
      ustadz: 'Ustadz Khalid Basalamah',
      youtubeUrl: 'https://youtu.be/alcGWG5_m-w?si=t9yqDKEQtIVDIRXs',
      description: '''

Assalamualaikum Warahmatullah,
Pada video Ustadz Khalid Basalamah terbaru di channel kami, beliau menerangkan Orang-Orang yang Akan Diangkat Derajatnya Oleh Allah. Kita setuju, bahwa setiap muslim, tujuannya adalah akhirat, namun bukan berarti kita melupakan dunia begitu saja. Pada video kali ini Ustadz Khalid basalamah yang kerap ber dakwah sunnah, juga beliau adalah tokoh salafi dan tentunya ber manhaj salaf, menyampaikan atau memberikan sebuah pesan dari Al Quran dan Sunnah tentang dunia akan menjadi hina apabila kita mengejar dan mengutamakan akhirat. Beliau selaku pendakwah juga pengusaha membuktikan sendiri, beliau mampu menaungi ratusan karyawan dengan baik, dan kerap menerima rezeki-rezeki yang tidak terduga atau tidak disangka-sangka. Maka dari itu kesimpulannya adalah ketika kita ingin dunia tunduk kepadamu, dunia datang dengan hina, hidup sukses, rezeki datang dari segala penjuru, mendapat rezeki berkah, hidup tenang dan bahagia, agar kebutuhan terpenuhi, agar sukses dunia akhirat adalah dengan bertaqwa kepada Allah subhanahu wa ta'ala. Beliau yang sering disapa Ustadz Khalid ini, dan juga beliau yang pernah diundang podcast Denny Sumargo, menerangkan pentingnya memiliki akhlaq yang baik, dan tidak mudah emosi dan menyimpan dendam. Cara menghadapi ketika disakiti adalah sabar dan beribadah kepada Allah, kita balas hal buruk dengan hal baik. Karena lebih baik kita ikhlas ketika disakiti dan bagaimana menyikapi saat kita disakiti adalah dengan tetap berdoa kepada Allah, dan karena Allah Maha Adil dan Bijaksana.
Wassalamualaikum Warahmatullah

''',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF28B66),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Video Kajian',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _listKajian.length,
        itemBuilder: (context, index) {
          final kajian = _listKajian[index];
          final videoId = YoutubePlayer.convertUrlToId(kajian.youtubeUrl) ?? '';

          return GestureDetector(
            onTap: () {
              // Navigasi menggunakan push biasa ke Detail Kajian Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailKajianScreen(kajian: kajian),
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
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.network(
                          'https://img.youtube.com/vi/$videoId/hqdefault.jpg',
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                height: 180,
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.videocam,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ),
                        ),
                      ),
                      const CircleAvatar(
                        backgroundColor: Color(0xFFF28B66),
                        radius: 24,
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          kajian.ustadz,
                          style: const TextStyle(
                            color: Color(0xFFF28B66),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          kajian.title,
                          style: const TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
