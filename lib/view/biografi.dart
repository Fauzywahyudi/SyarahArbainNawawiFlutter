import 'package:flutter/material.dart';
import 'package:hadits_syarah_arbain_nawawi/database/DBHelper.dart';

class Biografi extends StatefulWidget {
  @override
  _BiografiState createState() => _BiografiState();
}

class _BiografiState extends State<Biografi> {
  String warna = "0xFF4CAF5";
  String warna_font = "0xFFFFFFFF";
  String nm_warna = "";
  int _fontSize = 15;

  Future<List> _getWarnaSelected() async {
    var db = new DBHelper();
    int res = await db.getIdWarna();
    print(res);
    List<Map> list = await db.getWarnaSelected(res);
    setState(() {
      warna = list[0]['warna'];
      warna_font = list[0]['warna_font'];
      nm_warna = list[0]['nm_warna'];
    });
    print("warna : $warna , warna font : $warna_font");
    return list;
  }

  Future<int> _getFontSize() async {
    var db = new DBHelper();
    int res = await db.getFontSize();
    setState(() {
      _fontSize = res;
    });
    print("Font Size adalah $res");
  }

  @override
  void initState() {
    _getWarnaSelected();
    _getFontSize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return AppBar(
      iconTheme: new IconThemeData(color: Color(int.parse(warna_font))),
      actionsIconTheme: IconThemeData(color: Color(int.parse(warna_font))),
      backgroundColor: Color(int.parse(warna)),
      title: Text(
        "Biografi",
        style: TextStyle(color: Color(int.parse(warna_font))),
      ),
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.grey[200],
      child: ListView(
        children: <Widget>[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "1. Nama Lengkap, kelahiran, keturunan dan kegigihannya dalam menuntut ilmu.",
                    style: TextStyle(
                        fontSize: _fontSize.toDouble(),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\nImam Nawawi dijuluki dengan Al-imam Al-hafizh al-auhad (satu-satunya) al-qudwah (tauladan) Syaikhul Islam (syaikh islam) ilmu awliya (pemimpin para wali) Muhyiddin ( pemberi kehidupan agama) Abu Zakariya (Bapaknya Zakaria) Yahya bin Syaraf bin Muri Al-Khuzami Al-Hawaribi As-Syafi’i. Beliau lahir pada bulan Muharram tahun 631H \n"
                    "\nPada tahun 649, atau pada umur 10 tahun beliau berkelana menuju kota Damaskus dan tinggal di sana untuk menuntut ilmu, menghafal kitab at-tanbiih dalam kurun waktu 4,5 bulan, menghafal kitab al-muhadzdzab dalam kurun setengah tahun di hadapan gurunya Al-Kamal bin Ahmad, kemudian menunaikan ibadah haji bersama orang tuanya dan tinggal di kota Madinah selama satu setengah bulan, dan menuntut ilmu di sana. Dikisahkan oleh Syeikh Abul Hasan bin Al-Atthar bahwa imam Nawawi setiap belajar 12 mata pelajaran dan menghafalnya di hadapan guru-gurunya dengan syarah yang begitu gamblang dan benar; dua pelajaran pada kitab al-wasith, satu pelajaran kitab al-muhadzab, satu pelajaran pada kitab al-jam’u baina as-shahihain, satu pelajaran pada kitab shahih Muslim, satu pelajaran pada kitab al-Luma’ karangan Ibnu Jana, satu pelajaran pada kitab ishlahul mantiq, satu pelajaran pada kitab tashrif, satu pelajaran pada kitab ushul fiqh, satu pelajaran pada kitab “Asmaur rijal”, satu pelajaran pada kitab ushuluddin."
                    "\n\nImam Nawawi berkata, “Saya berusaha melekatkan diri dalam menjelaskan sesuatu yang sulit dipahami, menjelaskan ungkapan yang samar dan menertibkan tata bahasa, dan Alhamdulillah Allah memberkahi waktu yang aku miliki, namun suatu ketika terbetik dalam hati ingin bergelut dalam ilmu kedokteran sehingga aku pun sibuk dengan ilmu perundang-undangan, sehingga aku merasa telah menzhalimi diri sendiri dan hari-hari selanjutnya aku tidak mampu melakukan tugas; akhirnya aku pun rindu pada ilmu yang sebelumnya telah aku pelajari, aku jual kitab perundang-undangan sehingga hatiku kembali bersinar.",
                    style: TextStyle(fontSize: _fontSize.toDouble()),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "2. Guru-guru imam Nawawi.",
                    style: TextStyle(
                        fontSize: _fontSize.toDouble(),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\nImam Nawawi berguru pada syaikh Ar-Ridha bin al-Burhan, Syaikh Abdul Aziz bin Muhammad Al-Anshari, Zainuddin bin Abdul Daim, Imaduddin Abdul Karim Al-Khurasani, Zainuddin Khalaf bin Yusuf, Taqiyyuddin bin Abil Yasar, Jamaluddin bin As-Shayarfi, Syamsuddin bin Abi Umar dan ulama-ulama lainnya yang sederajat."
                        "\n\nBeliau banyak belajar kitab-kitab hadits seperti kutub sittah, al-Musnad, al-Muwattha, Syarah Sunnah karangan Al-Baghwi, Sunan Ad-Daruquthni, dan kitab-kitab lainnya."
                        "\n\nSebagaimana beliau juga belajar kitab al-Kamal karangan al-Hafizh Abdul Ghani Alauddin , Syarah Hadits-hadits shahih bersama para muhaditsin seperti Ibnu Ishaq Ibrahim bin Isa Al-Muradi. Belajar kitab Ushul dengan ustadz Al-Qadhi At-tafalisi. Kitab Al-Kamal dengan ustadz ishaq al-Mu’arri, Syamsuddin Abdurrahman bin Nuh, Izzuddin Umar bin Sa’ad Al-Arbali dan Al-Kamal Salar Al-Arbali. Belajar kitab tentang bahasa bersama ustadz Ahmad Al-Masri dan ustadz lainnya. Lalu setelah itu beliau konsen dalam mengajarkan dan menyebarkan ilmu, beribadah, berdzikir, berpuasa, bersabar dengan kehidupan yang sederhana, baik makan maupun pakaian.",
                    style: TextStyle(fontSize: _fontSize.toDouble()),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "3. Murid-murid Imam Nawawi.",
                    style: TextStyle(
                        fontSize: _fontSize.toDouble(),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\nAdapun murid-murid Imam Nawawi yang menjadi ulama terkenal setelah beliau adalah Al-Khatib Shadr Sulaiman Al-Ja’fari, Syihabuddin Ahmad bin Ja’wan, Syihabuddin Al-Arbadi, Alauddin bin Al-Atthar, Ibnu Abi Al-Fath dan Al-Mazi serta Ibnu Al-Atthar.",
                    style: TextStyle(fontSize: _fontSize.toDouble()),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "4. Ijtihad Imam Nawawi dan Aktivitas ubudiyahnya.",
                    style: TextStyle(
                        fontSize: _fontSize.toDouble(),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\nDikisahkan oleh syeikh Ibnu Al-Atthar: Bahwa Imam Nawawi bercerita kepadanya, beliau tidak pernah sedikit pun meninggalkan waktu terbuang sia-sia baik malam ataupun siang hari bahkan saat berada dijalan. Beliau melakukan mulazamah selama 6 tahun lalu menulis kitab, memberikan nasihat dan menyampaikan kebenaran."
                        "\n\nImam Nawawi memiliki semangat yang tinggi dalam beribadah dan beramal, teliti, wara’, hati-hati, jiwa yang bersih dari dosa dan noda, jauh dari kepentingan pribadi, banyak menghafal hadits, memahami seni dalam ilmu hadits, perawi hadits, shahih dan cacat hadits, serta menjadi pemuka dalam mengenal madzhab."
                        "\n\nSyeikh Imam Rasyid bin Al-Mu’allim berkata, “Syeikh imam Nawawi adalah sosok yang tidak terlalu banyak masuk ke dalam kamar mandi, menyia-nyiakan waktu dalam makan dan berpakaian serta urusan-urusan lainnya, beliau sangat takut terkena penyakit sehingga menjadikan dirinya lengah dalam bekerja”. Beliau juga tidak mau makan buah-buahan dan mentimun, beliau berkata, “Saya khawatir membuat diri saya lemas dan menjadi suka tidur”.",
                    style: TextStyle(fontSize: _fontSize.toDouble()),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "5. Kitab-kitab karangan Imam Nawawi.",
                    style: TextStyle(
                        fontSize: _fontSize.toDouble(),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\nDi antara kitab karangan Imam Nawawi adalah sebagai berikut: Syarah Shahih Muslim, Riyadlus shalihin, Al-Adzkar, Al-Arbain, Al-Irsyad Fi ulumil hadits, At-Taqrib, Al-Mubhamat, Tahrirul Al-Alfazh littanbih, Al-Idhah fil Manasik, At-Tibyan fi Adabi Hamalatil Quran, Al-Fatawa, Ar-Raudlatu Arbaati Asfar, Syarah Al-Muhadzab ila bab al-mirah (4 jilid) Syarah sebagian kitab Al-Bukhari, syarah kitab al-Wasith dan banyak lagi kitab lainnya dalam bidang hukum, bahasa, adab dan ilmu-ilmu fiqh.",
                    style: TextStyle(fontSize: _fontSize.toDouble()),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "6. Wara’nya Imam Nawawi.",
                    style: TextStyle(
                        fontSize: _fontSize.toDouble(),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\nImam Nawawi adalah seorang ulama yang wara’ dan zuhud, beliau sama sekali tidak menerima imbalan apapun dalam mengajar ilmu, beliau pernah menerima hadiah lampu templok dari seorang fakir. Imam Burhanuddin al-Iskandarani pernah mengajaknya buka puasa bersamanya, beliau berkata, “Bawalah makananmu kemari dan kita berbuka bersama di sini, lalu beliau makan hanya dua jenis makanan, selain itu ditinggalkan”."
                    "\n\nDiceritakan oleh Imam Quthbuddin Al-Yunini bahwa Imam Nawawi adalah satu-satunya seorang ulama yang luas ilmunya, wara’, ahli ibadah, sederhana dan tidak bermewah-mewah dalam kehidupannya.",
                    style: TextStyle(fontSize: _fontSize.toDouble()),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "7. Sikap Imam Nawawi terhadap raja di masa hidupnya.",
                    style: TextStyle(
                        fontSize: _fontSize.toDouble(),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\Imam Nawawi selalu berhadapan dengan raja dan kezhaliman, mengingkari dan mengingatkan mereka dalam bentuk tulisan dan peringatan akan azab Allah. Di antara contoh surat beliau adalah sebagai berikut:"
                    "\n\n“Dari Abdullah bin Yahya An-Nawawi, Salamullah alaikum warahmatuhu wabarakatuh atas raja yang baik, raja para umara Badruddin, semoga Allah mengekalkan baginya kebaikan dan membimbingnya dengan kebenaran dan menyampaikannya menuju kebaikan dunia dan akhirat pada segala cita-cita dan urusannya, serta memberikan keberkahan dalam setiap perbuatannya. Amin."
                    "\n\nSebagaimana diketahui bahwa penduduk Syam sedang mengalami kesempitan dan kekeringan karena sudah lama tidak turun hujan… beliau menjelaskan secara detail dan panjang dalam surat tersebut kepada sang raja, namun sang raja menjawabnya dengan lebih keras dan menyakitkan, sehingga menambah runcing keadaan dan kekhawatiran para jamaah”."
                    "\n\nImam Syeikh Ibnu Farh mengisahkan perjalanan hidup beliau yang penuh dengan kenangan, beliau berkata, “Syeikh Muhyiddin An-Nawawi memiliki tiga tingkatan yang jika setiap orang mengetahui akan setiap tingkatannya maka akan segera pergi kepadanya, “Ilmu, zuhud dan al-amru bil ma’ruf dan an-nahyu anil mungkar”.",
                    style: TextStyle(fontSize: _fontSize.toDouble()),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "8. Wafatnya Imam Nawawi",
                    style: TextStyle(
                        fontSize: _fontSize.toDouble(),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\nSetelah melakukan perjalanan ke Baitul Maqdis dan kembali ke kota Nawa, Imam Nawawi menderita sakit di samping orang tuanya, lalu meninggal pada tanggal 24 Rajab tahun 676 H. dan dikubur di kota Yazar. Rahimahullah al-imam An-Nawawi.",
                    style: TextStyle(fontSize: _fontSize.toDouble()),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
