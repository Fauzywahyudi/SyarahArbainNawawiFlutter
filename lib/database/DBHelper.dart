import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'dart:async';
//
class DBHelper{
  static final DBHelper _instance = new DBHelper.internal();
  DBHelper.internal();

  factory DBHelper()=> _instance;

  static Database _db;

  static final nm_db = "db_syarah";

  static final tb_hadits = "tb_hadits";
  static final tb_set = "tb_setting";
  static final tb_warna = "tb_warna";

  static final _nm_warna = "nm_warna";
  static final _warna = "warna";
  static final _warna_font = "warna_font";

  static final _nm_set = "nm_set";
  static final _angka_set = "angka_set";


  static final _id = "_id";
  static final _judul = "judul";
  static final _arab = "arab";
  static final _terjemahan = "terjemahan";
  static final _isi = "isi";
  static final _bookmark = "bookmark";

  String ins_judul,ins_arab,ins_terjemahan,ins_isi;
  int no,bookmark;



  Future<Database> get db async{
    if(_db!=null)return _db;
    _db=await setDB();
    return _db;
  }

  setDB()async{
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,nm_db);
    var dB = await openDatabase(path,version: 1,onCreate: _onCreate);
    return dB;
  }

  void _onCreate(Database db,int version) async{
    await db.execute("CREATE TABLE $tb_set ($_id INTEGER PRIMARY KEY, "
        "$_nm_set TEXT, "
        "$_angka_set TEXT)");

    await db.execute("CREATE TABLE $tb_warna ($_id INTEGER PRIMARY KEY, "
        "$_nm_warna TEXT, "
        "$_warna TEXT,"
        "$_warna_font TEXT)");

    await db.execute("CREATE TABLE $tb_hadits ($_id INTEGER PRIMARY KEY, "
        "$_judul TEXT, "
        "$_arab TEXT, "
        "$_terjemahan TEXT, "
        "$_isi TEXT, "
        "$_bookmark INTEGER)");
    String ins_nm_set = "last_read";
    String ins_angka_set = "0";
    int import = await db.rawUpdate("INSERT INTO $tb_set VALUES(null,'$ins_nm_set','$ins_angka_set')");
    if(import==1){
      print("sukses set last read");
    }else{
      print("gagal set last read");
    }

    ins_nm_set = "font_size";
    ins_angka_set = "15";
    import = await db.rawUpdate("INSERT INTO $tb_set VALUES(null,'$ins_nm_set','$ins_angka_set')");
    if(import==1){
      print("sukses set font size");
    }else{
      print("gagal set font size");
    }

    ins_nm_set = "tema";
    ins_angka_set = "1";
    import = await db.rawUpdate("INSERT INTO $tb_set VALUES(null,'$ins_nm_set','$ins_angka_set')");
    if(import==1){
      print("sukses set warna");
    }else{
      print("gagal set warna");
    }

    List<Map> warna = [
      {"id_warna":"1","nm_warna":"Green","warna":"0xFF4CAF50","warna_font":"0xFFFFFFFF"},
      {"id_warna":"2","nm_warna":"Blue","warna":"0xFF2196F3","warna_font":"0xFFFFFFFF"},
      {"id_warna":"3","nm_warna":"Amber","warna":"0xFFFFC107","warna_font":"0xFF000000"},
      {"id_warna":"4","nm_warna":"Yellow","warna":"0xFFFFEB3B","warna_font":"0xFF000000"},
      {"id_warna":"5","nm_warna":"Red","warna":"0xFFF44336","warna_font":"0xFFFFFFFF"},
      {"id_warna":"6","nm_warna":"Pink","warna":"0xFFE91E63","warna_font":"0xFFFFFFFF"},
      {"id_warna":"7","nm_warna":"Light Blue","warna":"0xFF03A9F4","warna_font":"0xFF000000"},
      {"id_warna":"8","nm_warna":"Light Green","warna":"0xFF8BC34A","warna_font":"0xFF000000"},
      {"id_warna":"9","nm_warna":"Deep Purple","warna":"0xFF673AB7","warna_font":"0xFFFFFFFF"},
      {"id_warna":"10","nm_warna":"Deep Orange","warna":"0xFFFF5722","warna_font":"0xFFFFFFFF"}
    ];

    for(int i=0 ; i < warna.length; i++){
      int importData = await db.rawUpdate("INSERT INTO $tb_warna VALUES(null,'${warna[i]['nm_warna']}','${warna[i]['warna']}','${warna[i]['warna_font']}')");
      if(importData==1){
        print("sukses warna ${warna[i]['nm_warna']}");
      }else{
        print("gagal warna ${warna[i]['nm_warna']}");
      }

    }

    ///////////////// 1
    no=1;
    bookmark=0;
    ins_judul = "Niat dan Ikhlas";
    ins_arab = "عَنْ أَمِيرِ المُؤمِنينَ أَبي حَفْصٍ عُمَرَ بْنِ الخَطَّابِ رَضيَ اللهُ تعالى عنْهُ قَالَ: ( سَمِعْتُ رَسُولَ اللهِ يَقُولُ: إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ، وَإِنَّمَا لِكُلِّ امْرِئٍ مَا نَوَى، فَمَنْ كَانَتْ هِجْرَتُهُ إِلى اللهِ وَرَسُوله فَهِجْرَتُهُ إلى اللهِ وَرَسُوله، وَمَنْ كَانَتْ هِجْرَتُهُ لِدُنْيَا يُصِيْبُهَا، أَو امْرأَة يَنْكِحُهَا، فَهِجْرَتُهُ إِلى مَا هَاجَرَ إِلَيْهِ ) – رواه إماما المحدثين أبو عبد الله محمد بن إسماعيل بن إبراهيم بن المغيرة بن بَرْدِزْبَهْ البخاري، وأبو الحسين مسلم بن الحجَّاج بن مسلم القشيري النيسابوري، في صحيحيهما اللَذين هما أصح الكتب المصنفة";
    ins_terjemahan = "Dari Amirul Mukminin Abu Hafsh, Umar bin Al-Khathab radhiyallahu ‘anhu, ia berkata : "
        "“Aku mendengar Rasulullah shallallahu ‘alaihi wa sallam bersabda: “Segala amal itu tergantung niatnya, "
        "dan setiap orang hanya mendapatkan sesuai niatnya. Maka barang siapa yang hijrahnya kepada Allah dan Rasul-Nya,"
        " maka hijrahnya itu kepada Allah dan Rasul-Nya. Barang siapa yang hijrahnya itu Karena kesenangan dunia atau "
        "karena seorang wanita yang akan dikawininya, maka hijrahnya itu kepada apa yang ditujunya”."
        "\n\n"
        "[Diriwayatkan oleh dua orang ahli hadits yaitu Abu Abdullah Muhammad bin Ismail bin Ibrahim bin Mughirah "
        "bin Bardizbah Al Bukhari (orang Bukhara) dan Abul Husain Muslim bin Al Hajjaj bin Muslim Al Qusyairi An "
        "Naisaburi di dalam kedua kitabnya yang paling shahih di antara semua kitab hadits. Bukhari no. 1 dan Muslim no. 1907]";
    ins_isi = "Hadits ini adalah Hadits shahih yang telah disepakati keshahihannya, ketinggian derajatnya dan "
        "didalamnya banyak mengandung manfaat. Imam Bukhari telah meriwayatkannya pada beberapa bab pada kitab shahihnya, "
        "juga Imam Muslim telah meriwayatkan hadits ini pada akhir bab Jihad."
        "\n\n"
        "Hadits ini salah satu pokok penting ajaran islam. Imam Ahmad dan Imam Syafi’I berkata : “Hadits tentang niat ini "
        "mencakup sepertiga ilmu.” Begitu pula kata imam Baihaqi dll. Hal itu karena perbuatan manusia terdiri dari niat "
        "didalam hati, ucapan dan tindakan. Sedangkan niat merupakan salah satu dari tiga bagian itu. Diriwayatkan dari "
        "Imam Syafi’i, “Hadits ini mencakup tujuh puluh bab fiqih”, sejumlah Ulama’ mengatakan hadits ini mencakup "
        "sepertiga ajaran islam."
        "\n\n"
        "Para ulama gemar memulai karangan-karangannya dengan mengutip hadits ini. Di antara mereka yang memulai "
        "dengan hadits ini pada kitabnya adalah Imam Bukhari. Abdurrahman bin Mahdi berkata : “bagi setiap penulis "
        "buku hendaknya memulai tulisannya dengan hadits ini, untuk mengingatkan para pembacanya agar meluruskan niatnya”."
        "\n\n"
        "Hadits ini dibanding hadits-hadits yang lain adalah hadits yang sangat terkenal, tetapi dilihat dari sumber "
        "sanadnya, hadits ini adalah hadits ahad, karena hanya diriwayatkan oleh Umar bin Khaththab dari Nabi Shallallahu ‘"
        "alaihi wa Sallam. Dari Umar hanya diriwayatkan oleh ‘Alqamah bin Abi Waqash, kemudian hanya diriwayatkan oleh "
        "Muhammad bin Ibrahim At Taimi, dan selanjutnya hanya diriwayatkan oleh Yahya bin Sa’id Al Anshari, kemudian barulah "
        "menjadi terkenal pada perawi selanjutnya. Lebih dari 200 orang rawi yang meriwayatkan dari Yahya bin Sa’id dan "
        "kebanyakan mereka adalah para Imam."
        "\n\n"
        "Pertama : Kata “Innamaa” bermakna “hanya/pengecualian” , yaitu menetapkan sesuatu yang disebut dan mengingkari "
        "selain yang disebut itu. Kata “hanya” tersebut terkadang dimaksudkan sebagai pengecualian secara mutlak dan terkadang "
        "dimaksudkan sebagai pengecualian yang terbatas. Untuk membedakan antara dua pengertian ini dapat diketahui dari "
        "susunan kalimatnya."
        "\n\n"
        "Misalnya, kalimat pada firman Allah : “Innamaa anta mundzirun” (Engkau (Muhammad) hanyalah seorang penyampai "
        "ancaman). (QS. Ar-Ra’d : 7) Kalimat ini secara sepintas menyatakan bahwa tugas Nabi Shallallahu ‘alaihi wa "
        "Sallam hanyalah menyampaikan ancaman dari Allah, tidak mempunyai tugas-tugas lain. Padahal sebenarnya beliau "
        "mempunyai banyak sekali tugas, seperti menyampaikan kabar gembira dan lain sebagainya. Begitu juga kalimat "
        "pada firman Allah : “Innamal hayatud dunyaa la’ibun walahwun” à “Kehidupan dunia itu hanyalah kesenangan dan "
        "permainan”. (QS. Muhammad : 36) Kalimat ini (wallahu a’lam) menunjukkan pembatasan berkenaan dengan akibat atau "
        "dampaknya, apabila dikaitkan dengan hakikat kehidupan dunia, maka kehidupan dapat menjadi wahana berbuat kebaikan. "
        "Dengan demikian apabila disebutkan kata “hanya” dalam suatu kalimat, hendaklah diperhatikan betul pengertian "
        "yang dimaksudkan."
        "\n\n"
        "Pada Hadits ini, kalimat “Segala amal hanya menurut niatnya” yang dimaksud dengan amal disini adalah semua "
        "amal yang dibenarkan syari’at, sehingga setiap amal yang dibenarkan syari’at tanpa niat maka tidak berarti "
        "apa-apa menurut agama islam. Tentang sabda Rasulullah, “semua amal itu tergantung niatnya” ada perbedaan "
        "pendapat para ulama tentang maksud kalimat tersebut. Sebagian memahami niat sebagai syarat sehingga amal "
        "tidak sah tanpa niat, sebagian yang lain memahami niat sebagai penyempurna sehingga amal itu akan sempurna "
        "apabila ada niat."
        "\n\n"
        "Kedua : Kalimat “Dan setiap orang hanya mendapatkan sesuai niatnya” oleh Khathabi dijelaskan bahwa kalimat "
        "ini menunjukkan pengertian yang berbeda dari sebelumnya. Yaitu menegaskan sah tidaknya amal bergantung pada "
        "niatnya. Juga Syaikh Muhyidin An-Nawawi menerangkan bahwa niat menjadi syarat sahnya amal. Sehingga seseorang "
        "yang meng-qadha sholat tanpa niat maka tidak sah Sholatnya, walahu a’lam"
        "\n\n"
        "Ketiga : Kalimat “Dan Barang siapa berhijrah kepada Allah dan Rosul-Nya, maka hijrahnya kepada Allah dan "
        "Rosul-Nya” menurut penetapan ahli bahasa Arab, bahwa kalimat syarat dan jawabnya, begitu pula mubtada’ "
        "(subyek) dan khabar (predikatnya) haruslah berbeda, sedangkan di kalimat ini sama. Karena itu kalimat syarat "
        "bermakna niat atau maksud baik secara bahasa atau syari’at, maksudnya barangsiapa berhijrah dengan niat karena "
        "Allah dan Rosul-Nya maka akan mendapat pahala dari hijrahnya kepada Allah dan Rosul-Nya."
        "\n\n"
        "Hadits ini memang muncul karena adanya seorang lelaki yang ikut hijrah dari Makkah ke Madinah untuk mengawini "
        "perempuan bernama Ummu Qais. Dia berhijrah tidak untuk mendapatkan pahala hijrah karena itu ia dijuluki Muhajir"
        " Ummu Qais. Wallahu a’lam";

    int res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");

    print("id $no = $res");

    ///////////////// 2
    no=2;
    bookmark=0;
    ins_judul = "Iman, Islam dan Ihsan";
    ins_arab = "عَنْ عُمَرَ رَضِيَ اللهُ تَعَالَى عَنْهُ أَيضاً قَال: بَيْنَمَا نَحْنُ جُلُوْسٌ عِنْدَ رَسُولِ اللهِ صلى الله عليه وسلم ذَاتَ يَوْمٍ إِذْ طَلَعَ عَلَيْنَا رَجُلٌ شَدِيْدُ بَيَاضِ الثِّيَاب شَدِيْدُ سَوَادِ الشَّعْرِ لاَ يُرَى عَلَيْهِ أَثَرُ السَّفَرِ وَلاَ يَعْرِفُهُ مِنَّا أَحَدٌ حَتَّى جَلَسَ إِلَى النبي صلى الله عليه وسلم فَأَسْنَدَ رُكْبَتَيْهِ إِلَى رُكْبَتَيْهِ وَوَضَعَ كَفَّيْهِ عَلَى فَخِذَيْهِ وَقَالَ: يَا مُحَمَّدُ أَخْبِرْنِي عَنِ الإِسْلاَم، فَقَالَ رَسُولُ اللهِ صلى الله عليه وسلم: ( الإِسْلاَمُ أَنْ تَشْهَدَ أَنْ لاَ إِلَهَ إِلاَّ اللهُ وَأَنَّ مُحَمَّدَاً رَسُولُ الله، وَتُقِيْمَ الصَّلاَة، وَتُؤْتِيَ الزَّكَاةَ، وَتَصُوْمَ رَمَضَانَ، وَتَحُجَّ البيْتَ إِنِ اِسْتَطَعتَ إِليْهِ سَبِيْلاً قَالَ: صَدَقْتَ. فَعَجِبْنَا لَهُ يَسْأَلُهُ وَيُصَدِّقُهُ، قَالَ: فَأَخْبِرْنِيْ عَنِ الإِيْمَانِ، قَالَ: أَنْ تُؤْمِنَ بِالله، وَمَلائِكَتِه، وَكُتُبِهِ وَرُسُلِهِ، وَالْيَوْمِ الآَخِر، وَتُؤْمِنَ بِالقَدَرِ خَيْرِهِ وَشَرِّهِ قَالَ: صَدَقْتَ، قَالَ: فَأَخْبِرْنِيْ عَنِ الإِحْسَانِ، قَالَ: أَنْ تَعْبُدَ اللهَ كَأَنَّكَ تَرَاهُ، فَإِنْ لَمْ تَكُنْ تَرَاهُ فَإِنَّهُ يَرَاكَ قَالَ: فَأَخْبِرْنِي عَنِ السَّاعَةِ، قَالَ: مَا الْمَسئُوُلُ عَنْهَا بِأَعْلَمَ مِنَ السَّائِلِ قَالَ: فَأَخْبِرْنِيْ عَنْ أَمَارَاتِها، قَالَ: أَنْ تَلِدَ الأَمَةُ رَبَّتَهَا، وَأَنْ تَرى الْحُفَاةَ العُرَاةَ العَالَةَ رِعَاءَ الشَّاءِ يَتَطَاوَلُوْنَ فِي البُنْيَانِ ثُمَّ انْطَلَقَ فَلَبِثَ مَلِيَّاً ثُمَّ قَالَ: يَا عُمَرُ أتَدْرِي مَنِ السَّائِلُ؟ قُلْتُ: اللهُ وَرَسُوله أَعْلَمُ، قَالَ: فَإِنَّهُ جِبْرِيْلُ أَتَاكُمْ يُعَلِّمُكُمْ دِيْنَكُمْ ) – رواه مسلم";
    ins_terjemahan = "Dari Umar bin Al-Khathab radhiallahu ‘anh, dia berkata: ketika kami tengah berada di majelis "
        "bersama Rasulullah pada suatu hari, tiba-tiba tampak dihadapan kami seorang laki-laki yang berpakaian sangat "
        "putih, berambut sangat hitam, tidak terlihat padanya tanda-tanda bekas perjalanan jauh dan tidak seorangpun "
        "diantara kami yang mengenalnya. Lalu ia duduk di hadapan Rasulullah dan menyandarkan lututnya pada lutut "
        "Rasulullah dan meletakkan tangannya diatas paha Rasulullah, selanjutnya ia berkata,” Hai Muhammad, beritahukan "
        "kepadaku tentang Islam ” Rasulullah menjawab, ”Islam itu engkau bersaksi bahwa sesungguhnya tiada Tuhan selain "
        "Alloh dan sesungguhnya Muhammad itu utusan Alloh, engkau mendirikan sholat, mengeluarkan zakat, berpuasa pada "
        "bulan Romadhon dan mengerjakan ibadah haji ke Baitullah jika engkau mampu melakukannya.” Orang itu berkata, "
        "”Engkau benar,” kami pun heran, ia bertanya lalu membenarkannya Orang itu berkata lagi,” Beritahukan kepadaku "
        "tentang Iman” Rasulullah menjawab, ”Engkau beriman kepada Alloh, kepada para Malaikat-Nya, Kitab-kitab-Nya, "
        "kepada utusan-utusan Nya, kepada hari Kiamat dan kepada takdir yang baik maupun yang buruk” Orang tadi berkata,” "
        "Engkau benar” Orang itu berkata lagi,” Beritahukan kepadaku tentang Ihsan” Rasulullah menjawab, ”Engkau beribadah "
        "kepada Alloh seakan-akan engkau melihat-Nya, jika engkau tidak melihatnya, sesungguhnya Dia pasti melihatmu.” "
        "Orang itu berkata lagi, ”Beritahukan kepadaku tentang kiamat” Rasulullah menjawab,” Orang yang ditanya itu tidak "
        "lebih tahu dari yang bertanya.” selanjutnya orang itu berkata lagi,”beritahukan kepadaku tentang tanda-tandanya” "
        "Rasulullah menjawab,” Jika hamba perempuan telah melahirkan tuan puterinya, jika engkau melihat orang-orang yang "
        "tidak beralas kaki, tidak berbaju, miskin dan penggembala kambing, berlomba-lomba mendirikan bangunan.” Kemudian "
        "pergilah ia, aku tetap tinggal beberapa lama kemudian Rasulullah berkata kepadaku, “Wahai Umar, tahukah engkau siapa "
        "yang bertanya itu?” Saya menjawab,” Alloh dan Rosul-Nya lebih mengetahui” Rasulullah berkata,” Ia adalah Jibril, "
        "dia datang untuk mengajarkan kepadamu tentang agama kepadamu.";
    ins_isi = "Hadits ini sangat berharga karena mencakup semua fungsi perbuatan lahiriah dan bathiniah, serta menjadi tempat "
        "merujuk bagi semua ilmu syari’at dan menjadi sumbernya. Oleh sebab itu hadits ini menjadi induk ilmu sunnah. \n"
        "Hadits ini menunjukkan adanya contoh berpakaian yang bagus, berperilaku yang baik dan bersih ketika datang kepada "
        "ulama, orang terhormat atau penguasa, karena jibril datang untuk mengajarkan agama kepada manusia dalam keadaan "
        "seperti itu.\nKalimat “ Ia meletakkan kedua telapak tangannya diatas kedua paha beliau, lalu ia berkata : "
        "Wahai Muhammad…..” adalah riwayat yang masyhur. Nasa’i meriwayatkan dengan kalimat, “Dan ia meletakkan kedua "
        "tangannya pada kedua lutut Rasulullah….” Dengan demikian yang dimaksud kedua pahanya adalah kedua lututnya."
        "\n\n"
        "Dari hadits ini dipahami bahwa islam dan iman adalah dua hal yang berbeda, baik secara bahasa maupun syari’at. "
        "Namun terkadang, dalam pengertian syari’at, kata islam dipakai dengan makna iman dan sebaliknya.\nKalimat, "
        "“Kami heran, dia bertanya tetapi dia sendiri yang membenarkannya” mereka para shahabat Rasulullah menjadi "
        "heran atas kejadian tersebut, karena orang yang datang kepada Rasulullah hanya dikenal oleh beliau dan orang "
        "itu belum pernah mereka ketahui bertemu dengan Rasulullah dan mendengarkan sabda beliau. Kemudian ia mengajukan "
        "pertanyaan yang ia sendiri sudah tahu jawabannya bahkan membenarkannya, sehingga orang-orang heran dengan kejadian itu."
        "\n\n"
        "Kalimat, “Engkau beriman kepada Allah, kepada para malaikat-Nya, dan kepada kitab-kitab-Nya….” Iman kepada Allah "
        "yaitu mengakui bahwa Allah itu ada dan mempunyai sifat-sifat Agung serta sempurna, bersih dari sifat kekurangan,. "
        "Dia tunggal, benar, memenuhi segala kebutuhan makhluk-Nya, tidak ada yang setara dengan Dia, pencipta segala makhluk, "
        "bertindak sesuai kehendak-Nya dan melakukan segala kekuasaan-Nya sesuai keinginan-Nya.\nIman kepada Malaikat, "
        "maksudnya mengakui bahwa para malaikat adalah hamba Allah yang mulia, tidak mendahului sebelum ada perintah, "
        "dan selalu melaksanakan apa yang diperintahkan-Nya.\nIman kepada Para Rasul Allah, maksudnya mengakui bahwa mereka "
        "jujur dalam menyampaikan segala keterangan yang diterima dari Allah dan mereka diberi mukjizat yang mengukuhkan "
        "kebenarannya, menyampaikan semua ajaran yang diterimanya, menjelaskan kepada orang-orang mukalaf apa-apa yang Allah "
        "perintahkan kepada mereka. Para Rasul Allah wajib dimuliakan dan tidak boleh dibeda-bedakan."
        "\n\n"
        "Iman kepada hari Akhir, maksudnya mengakui adanya kiamat, termasuk hidup setelah mati, berkumpul dipadang Mahsyar, "
        "adanya perhitungan dan timbangan amal, menempuh jembatan antara surga dan neraka, serta adanya Surga dan Neraka, dan "
        "juga mengakui hal-hal lain yang tersebut dalam Qur’an dan Hadits Rosululloh."
        "\n\n"
        "Iman kepada taqdir yaitu mengakui semua yang tersebut diatas, ringkasnya tersebut dalam firman Allah "
        "QS. Ash-Shaffaat : 96, “Allah menciptakan kamu dan semua perbuatan kamu” dan dalam QS. Al-Qamar : 49, "
        "“Sungguh segala sesuatu telah kami ciptakan dengan ukuran tertentu” dan di ayat-ayat yang lain. Demikian "
        "juga dalam Hadits Rasulullah, Dari Ibnu Abbas, “Ketahuilah, sekiranya semua umat berkumpul untuk "
        "memberikan suatu keuntungan kepadamu, maka hal itu tidak akan kamu peroleh selain dari apa yang Allah "
        "telah tetapkan pada dirimu. Sekiranya merekapun berkumpul untuk melakukan suatu yang membahayakan dirimu, "
        "niscaya tidak akan membahayakan dirimu kecuali apa yang telah Allah tetapkan untuk dirimu. Segenap pena "
        "diangkat dan lembaran-lembaran telah kering”"
        "\n\n"
        "Para Ulama mengatakan, Barangsiapa membenarkan segala urusan dengan sungguh-sungguh lagi penuh keyakinan "
        "tidak sedikitpun terbersit keraguan, maka dia adalah mukmin sejati.\nKalimat, “Engkau menyembah Allah seolah-olah "
        "engkau melihat-Nya….” Pada pokoknya merujuk pada kekhusyu’an dalam beribadah, memperhatikan hak Allah dan "
        "menyadari adanya pengawasan Allah kepadanya serta keagungan dan kebesaran Allah selama menjalankan ibadah."
        "\n\n"
        "Kalimat, “Beritahukan kepadaku tanda-tandanya ? sabda beliau : Budak perempuan melahirkan anak tuannya” "
        "maksudnya kaum muslimin kelak akan menguasai negeri kafir, sehingga banyak tawanan, maka budak-budak banyak "
        "melahirkan anak tuannya dan anak ini akan menempati posisi majikan karena kedudukan bapaknya. Hal ini menjadi "
        "sebagian tanda-tanda kiamat. Ada juga yang mengatakan bahwa itu menunjukkan kerusakan umat manusia sehingga "
        "orang-orang terhormat menjual budak yang menjadi ibu dari anak-anaknya, sehingga berpindah-pindah tangan yang "
        "mungkin sekali akan jatuh ke tangan anak kandungnya tanpa disadarinya."
        "\n\n"
        "Hadits ini juga menyatakan adanya larangan berlomba-lomba membangun bangunan yang sama sekali tidak dibutuhkan. "
        "Sebagaimana sabda Rasulullah,” Anak adam diberi pahala untuk setiap belanja yang dikeluarkannya kecuali "
        "belanja untuk mendirikan bangunan”"
        "\n\n"
        "Kalimat, “Penggembala Domba” secara khusus disebutkan karena merekalah yang merupakan golongan badui yang paling "
        "lemah sehingga umumnya tidak mampu mendirikan bangunan, berbeda dengan para pemilik onta yang umumnya orang "
        "terhormat.\nKalimat, “Saya tetap tinggal beberapa lama” maksudnya Umar radhiallahu ‘anh tetap tinggal ditempat "
        "itu beberapa lama setelah orang yang bertanya pergi, dalam riwayat yang lain yang dimaksud tetap tinggal adalah "
        "Rosululloh."
        "\n\n"
        "Kalimat, “Ia datang kepada kamu sekalian untuk mengajarkan agamamu” maksudnya mengajarkan pokok-pokok agamamu, "
        "demikian kata Syaikh Muhyidin An Nawawi dalam syarah shahih muslim. Isi hadits ini yang terpenting adalah "
        "penjelasan islam, iman dan ihsan, serta kewajiban beriman kepada Taqdir Allah Ta’ala."
        "\n\n"
        "Sesungguhnya keimanan seseorang dapat bertambah dan berkurang, QS. Al-Fath : 4, “Untuk menambah keimanan "
        "mereka pada keimanan yang sudah ada sebelumnya”. Imam Bukhari menyebutkan dalam kitab shahihnya bahwa ibnu "
        "Abu Mulaikah berkata, “Aku temukan ada 30 orang shahabat Rasulullah yang khawatir ada sifat kemunafikan "
        "dalam dirinya. Tidak ada seorangpun dari mereka yang berani mengatakan bahwa ia memiliki keimanan seperti "
        "halnya keimanan Jibril dan Mikail ‘alaihimus salaam”"
        "\n\n"
        "Kata iman mencakup pengertian kata islam dan semua bentuk ketaatan yang tersebut dalam hadits ini, "
        "karena semua hal tersebut merupakan perwujudan dari keyakinan yang ada dalam bathin yang menjadi tempat "
        "keimanan. Oleh karena itu kata Mukmin secara mutlak tidak dapat diterapkan pada orang-orang yang melakukan "
        "dosa-dosa besar atau meninggalkan kewajiban agama, sebab suatu istilah harus menunjukkan pengertian yang "
        "lengkap dan tidak boleh dikurangi, kecuali dengan maksud tertentu. Juga dibolehkan menggunakan kata Tidak "
        "beriman sebagaimana pengertian hadits Rasulullah, “Seseorang tidak berzina ketika dia beriman dan tidak mencuri "
        "ketika dia beriman” maksudnya seseorang dikatakan tidak beriman ketika berzina atau ketika dia mencuri."
        "\n\n"
        "Kata islam mencakup makna iman dan makna ketaatan, syaikh Abu ‘Umar berkata, “kata iman dan islam terkadang "
        "pengertiannya sama terkadang berbeda. Setiap mukmin adalah muslim dan tidak setiap muslim adalah mukmin” "
        "ia berkata, “pernyataan seperti ini sesuai dengan kebenaran” Keterangan-keterangan Al-Qur’an dan Assunnah "
        "berkenaan dengan iman dan islam sering dipahami keliru oleh orang-orang awam. Apa yang telah kami jelaskan "
        "diatas telah sesuai dengan pendirian jumhur ulama ahli hadits dan lain-lain. Wallahu a’lam.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");
    ///////////////// 3
    no=3;
    bookmark=0;
    ins_judul = "Rukun Islam";
    ins_arab = "عَنْ أَبِيْ عَبْدِ الرَّحْمَنِ عَبْدِ اللهِ بْنِ عُمَرَ بْن الخَطَّابِ رَضِيَ اللهُ عَنْهُمَا قَالَ: سَمِعْتُ النبي صلى الله عليه وسلم يَقُوْلُ: ( بُنِيَ الإِسْلامُ عَلَى خَمْسٍ: شَهَادَةِ أَنْ لاَ إِلَهَ إِلاَّ الله وَأَنَّ مُحَمَّدَاً رَسُوْلُ اللهِ، وَإِقَامِ الصَّلاةِ، وَإِيْتَاءِ الزَّكَاةِ، وَحَجِّ البِيْتِ، وَصَوْمِ رَمَضَانَ ) – رواه البخاري ومسلم";
    ins_terjemahan = "Dari Abu Abdirrahman, Abdullah bin Umar bin Al-Khathab radhiallahu ‘anhuma berkata : saya mendengar "
        "Rasulullah bersabda: “Islam didirikan diatas lima perkara yaitu bersaksi bahwa tiada sesembahan yang berhak "
        "disembah secara benar kecuali Allah dan Muhammad adalah utusan Allah, mendirikan shalat, mengeluarkan zakat, "
        "mengerjakan haji ke baitullah dan berpuasa pada bulan ramadhan”.\n \n"
    "[Bukhari no.8, Muslim no.16]";
    ins_isi = "Abul ‘Abbas Al-Qurtubi berkata : “Lima hal tersebut menjadi asas agama Islam dan landasan tegaknya Islam. "
        "Lima hal tersebut diatas disebut secara khusus tanpa menyebutkan Jihad (Padahal Jihad adalah membela agama "
        "dan mengalahkan penentang-penentang yang kafir) Karena kelima hal tersebut merupakan kewajiban yang abadi, "
        "sedangkan jihad merupakan salah satu fardhu kifayah, sehingga pada saat tertentu bisa menjadi tidak wajib."
        "\n\n"
        "Pada beberapa riwayat disebutkan, Haji lebih dahulu dari Puasa Romadhon. Hal ini adalah keraguan perawi. "
        "Wallahu A’lam (Imam Muhyidin An Nawawi dalam mensyarah hadits ini berkata, “Demikian dalam riwayat ini, "
        "Haji disebutkan lebih dahulu dari puasa. Hal ini sekedar tertib dalam menyebutkan, bukan dalam hal hukumnya, "
        "karena puasa ramadhon diwajibkan sebelum kewajiban haji. Dalam riwayat lain disebutkan puasa disebutkan lebih "
        "dahulu daripada haji”) Oleh karena itu, Ibnu Umar ketika mendengar seseorang mendahulukan menyebut haji "
        "daripada puasa, ia melarangnya lalu ia mendahulukan menyebut puasa daripada haji. Ia berkata : “Begitulah "
        "yang aku dengar dari Rosululloh ” "
        "\n\n"
        "Pada salah satu riwayat Ibnu ‘Umar disebutkan “Islam didirikan atas pengakuan bahwa engkau menyembah Allah "
        "dan mengingkari sesembahan selain-Nya dan melaksanakan Sholat….” Pada riwayat lain disebutkan : seorang "
        "laki-laki berkata kepada Ibnu ‘Umar, “Bolehkah kami berperang ?” Ia menjawab : “Aku mendengar Rosululloh "
        "bersabda, “Islam didirikan atas lima hal ….” Hadits ini merupakan dasar yang sangat utama guna mengetahui "
        "agama dan apa yang menjadi landasannya. Hadits ini telah mencakup apa yang menjadi rukun-rukun agama. wallahu a’lam";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 4
    no=4;
    bookmark=0;
    ins_judul = "Takdir Manusia Telah Ditetapkan";
    ins_arab = "عَنْ عَبْدِ اللهِ بنِ مَسْعُوْدْ رَضِيَ اللهُ عَنْهُ قَالَ: حَدَّثَنَا رَسُوْلُ اللهِ صلى الله عليه وسلم وَهُوَ الصَّادِقُ المَصْدُوْقُ: ( إِنَّ أَحَدَكُمْ يُجْمَعُ خَلْقُهُ فِيْ بَطْنِ أُمِّهِ أَرْبَعِيْنَ يَوْمَاً نُطْفَةً، ثُمَّ يَكُوْنُ عَلَقَةً مِثْلَ ذَلِكَ، ثُمَّ يَكُوْنُ مُضْغَةً مِثْلَ ذَلِكَ، ثُمَّ يُرْسَلُ إِلَيْهِ المَلَكُ فَيَنفُخُ فِيْهِ الرٌّوْحَ، وَيَؤْمَرُ بِأَرْبَعِ كَلِمَاتٍ: بِكَتْبِ رِزْقِهِ وَأَجَلِهِ وَعَمَلِهِ وَشَقِيٌّ أَوْ سَعِيْدٌ. فَوَالله الَّذِي لاَ إِلَهَ غَيْرُهُ إِنَّ أَحَدَكُمْ لَيَعْمَلُ بِعَمَلِ أَهْلِ الجَنَّةِ حَتَّى مَا يَكُوْنُ بَيْنَهُ وَبَيْنَهَا إلاذِرَاعٌ فَيَسْبِقُ عَلَيْهِ الكِتَابُ فَيَعْمَلُ بِعَمَلِ أَهْلِ النَّارِ فَيَدْخُلُهَا، وَإِنَّ أَحَدَكُمْ لَيَعْمَلُ بِعَمَلِ أَهْلِ النَّارِ حَتَّى مَايَكُونُ بَيْنَهُ وَبَيْنَهَا إلا ذِرَاعٌ فَيَسْبِقُ عَلَيْهِ الكِتَابُ فَيَعْمَلُ بِعَمَلِ أَهْلِ الجَنَّةِ فَيَدْخُلُهَا ) – رواه البخاري ومسلم";
    ins_terjemahan = "Dari Abu ‘Abdirrahman Abdullah bin Mas’ud radhiallahu ‘anh, dia berkata : "
        "bahwa Rasulullah telah bersabda, “Sesungguhnya tiap-tiap kalian dikumpulkan penciptaannya dalam "
        "rahim ibunya selama 40 hari berupa nutfah, kemudian menjadi ‘Alaqoh (segumpal darah) selama itu juga "
        "lalu menjadi Mudhghoh (segumpal daging) selama itu juga, kemudian diutuslah Malaikat untuk meniupkan "
        "ruh kepadanya lalu diperintahkan untuk menuliskan 4 kata : Rizki, Ajal, Amal dan Celaka/bahagianya. "
        "maka demi Alloh yang tiada Tuhan selainnya, ada seseorang diantara kalian yang mengerjakan amalan ahli "
        "surga sehingga tidak ada jarak antara dirinya dan surga kecuali sehasta saja. kemudian ia didahului oleh "
        "ketetapan Alloh lalu ia melakukan perbuatan ahli neraka dan ia masuk neraka. Ada diantara kalian yang "
        "mengerjakan amalan ahli neraka sehingga tidak ada lagi jarak antara dirinya dan neraka kecuali sehasta saja. "
        "kemudian ia didahului oleh ketetapan Alloh lalu ia melakukan perbuatan ahli surga dan ia masuk surga."
        "\n\n "
        "[Bukhari no. 3208, Muslim no. 2643]";
    ins_isi = "Kalimat, “Sesungguhnya tiap-tiap kalian dikumpulkan penciptaannya dalam rahim ibunya ” maksudnya yaitu Air mani yang memancar kedalam rahim, lalu Allah pertemukan dalam rahim tersebut selama 40 hari. Diriwayatkan dari Ibnu Mas’ud bahwa dia menafsirkan kalimat diatas dengan menyatakan, “Nutfah yang memancar kedalam rahim bila Allah menghendaki untuk dijadikan seorang manusia, maka nutfah tersebut mengalir pada seluruh pembuluh darah perempuan sampai kepada kuku dan rambut kepalanya, kemudian tinggal selama 40 hari, lalu berubah menjadi darah yang tinggal didalam rahim. Itulah yang dimaksud dengan Allah mengumpulkannya” Setelah 40 hari Nutfah menjadi ‘Alaqah (segumpal darah) "
        "\n\n"
        "Kalimat, “kemudian diutuslah Malaikat untuk meniupkan ruh kepadanya” yaitu Malaikat yang mengurus rahim "
        "\n\n"
        "Kalimat “Sesungguhnya ada seseorang diantara kamu melakukan amalan ahli surga……..” secara tersurat menunjukkan bahwa orang tersebut melakukan amalan yang benar dan amal itu mendekatkan pelakunya ke surga sehingga dia hampir dapat masuk ke surga kurang satu hasta. Ia ternyata terhalang untuk memasukinya karena taqdir yang telah ditetapkan bagi dirinya di akhir masa hayatnya dengan melakukan perbuatan ahli neraka. Dengan demikian, perhitungan semua amal baik itu tergantung pada apa yang telah dilakukannya. Akan tetapi, bila ternyata pada akhirnya tertutup dengan amal buruk, maka seperti yang dikatakan pada sebuah hadits: “Segala amal perbuatan itu perhitungannya tergantung pada amal terakhirnya.” Maksudnya, menurut kami hanya menyangkut orang-orang tertentu dan keadaan tertentu. Adapun hadits yang disebut oleh Imam Muslim dalam Kitabul Iman dari kitab shahihnya bahwa Rasulullah berkata: ” Seseorang melakukan amalan ahli surga dalam pandangan manusia, tetapi sebenarnya dia adalah ahli neraka.” Menunjukkan bahwa perbuatan yang dilakukannya semata-mata untuk mendapatkan pujian/popularitas. Yang perlu diperhatikan adalah niat pelakunya bukan perbuatan lahiriyahnya, orang yang selamat dari riya’ semata-mata karena karunia dan rahmat Allah Ta’ala. "
        "\n\n"
        "Kalimat ” maka demi Allah yang tiada Tuhan selain Dia, sesungguhnya ada seseorang diantara kamu melakukan amalan ahli surga sehingga tidak ada jarak antara dirinya dan surga kecuali sehasta saja. kemudian ia didahului oleh ketetapan Alloh lalu ia melakukan perbuatan ahli neraka dan ia masuk neraka. ” Maksudnya bahwa, hal semacam ini bisa saja terjadi namun sangat jarang dan bukan merupakan hal yang umum. Karena kemurahan, keluasan dan rahmat Allah kepada manusia. Yang banyak terjadi manusia yang tidak baik berubah menjadi baik dan jarang orang baik menjadi tidak baik."
        "\n\n"
        "Firman Allah, “Rahmat-Ku mendahului kemurkaan-Ku” menunjukkan adanya kepastian taqdir sebagaimana pendirian ahlussunnah bahwa segala kejadian berlangsung dengan ketetapan Allah dan taqdir-Nya, dalam hal keburukan dan kebaikan juga dalam hal bermanfaat dan berbahaya. Firman Allah, QS. Al-Anbiya’ : 23, “Dan Dia tidak dimintai tanggung jawab atas segala tindakan-Nya tetapi mereka akan dimintai tanggung jawab” menyatakan bahwa kekuasaan Allah tidak tertandingi dan Dia melakukan apa saja yang dikehendaki dengan kekuasaa-Nya itu. "
        "\n\n"
        "Imam Sam’ani berkata : “Cara untuk dapat memahami pengertian semacam ini adalah dengan menggabungkan apa yang tersebut dalam Al Qur’an dan Sunnah, bukan semata-mata dengan qiyas dan akal. Barang siapa yang menyimpang dari cara ini dalam memahami pengertian di atas, maka dia akan sesat dan berada dalam kebingungan, dia tidak akan memperoleh kepuasan hati dan ketentraman. Hal ini karena taqdir merupakan salah satu rahasia Allah yang tertutup untuk diketahui oleh manusia dengan akal ataupun pengetahuannya. Kita wajib mengikuti saja apa yang telah dijelaskan kepada kita tanpa boleh mempersoalkannya. Allah telah menutup makhluk dari kemampuan mengetahui taqdir, karena itu para malaikat dan para nabi sekalipun tidak ada yang mengetahuinya”. "
        "\n\n"
        "Ada pendapat yang mengatakan : “Rahasia taqdir akan diketahui oleh makhluk ketika mereka menjadi penghuni surga, tetapi sebelumnya tidak dapat diketahui”."
        "\n\n"
        "Beberapa Hadits telah menetapkan larangan kepada seseorang yang tdak mau melakukan sesuatu amal dengan alasan telah ditetapkan taqdirnya. Bahkan, semua amal dan perintah yang tersebut dalam syari’at harus dikerjakan. Setiap orang akan diberi jalan yang mudah menuju kepada taqdir yang telah ditetapkan untuk dirinya. Orang yang ditaqdirkan masuk golongan yang beruntung maka ia akan mudah melakukan perbuatan-perbuatan golongan yang beruntung sebaliknya orang-orang yang ditaqdirkan masuk golongan yang celaka maka ia akan mudah melakukan perbuatan-perbuatan golongan celaka sebagaimana tersebut dalam Firman Allah :“Maka Kami akan mudahkan dia untuk memperoleh keberuntungan”.(QS. Al Lail :7) "
        "\n\n"
        "“Kemudian Kami akan mudahkan dia untuk memperoleh kesusahan”.(QS.Al Lail :10) "
        "\n\n"
        "Para ulama berkata : “Al Qur’an, lembaran, dan penanya, semuanya wajib diimani begitu saja, tanpa mempersoalkan corak dan sifat dari benda-benda tersebut, karena hanya Allah yang mengetahui”."
        "\n\n"
        "Allah berfirman : “Manusia tidak sedikit pun mengetahui ilmu Allah, kecuali yang Allah kehendaki”.(QS. Al Baqarah : 255).";


    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 5
    no=5;
    bookmark=0;
    ins_judul = "Semua Perbuatan Bid`ah Tertolak";
    ins_arab = "عَنْ أُمِّ المُؤمِنِينَ أُمِّ عَبْدِ اللهِ عَائِشَةَ – رَضِيَ اللهُ عَنْهَا – قَالَتْ: قَالَ رَسُوْلُ اللهِ: ( مَنْ أَحْدَثَ فِيْ أَمْرِنَا هَذَا مَا لَيْسَ مِنْهُ فَهُوَ رَدٌّ ) – رواه البخاري ومسلم، وفي رواية لمسلم : مَنْ عَمِلَ عَمَلاً لَيْسَ عَلَيْهِ أَمْرُنَا فَهُوَ رَدٌّ";
    ins_terjemahan = "Dari Ummul mukminin, Ummu ‘Abdillah, ‘Aisyah radhiallahu ‘anha, ia berkata bahwa Rasulullah bersabda: "
        "“Barangsiapa yang mengada-adakan sesuatu dalam urusan agama kami ini yang bukan dari kami, maka dia "
        "tertolak”."
        "\n"
        "(Bukhari dan Muslim. Dalam riwayat Muslim : “Barangsiapa melakukan suatu amal yang tidak sesuai urusan kami, "
        "maka dia tertolak”) "
        "\n \n"
        "[Bukhari no. 2697, Muslim no. 1718]";
    ins_isi = "Kata “Raddun” menurut ahli bahasa maksudnya tertolak atau tidak sah. Kalimat “bukan dari urusan kami” "
        "maksudnya bukan dari hukum kami. Hadits ini merupakan salah satu pedoman penting dalam agama Islam yang "
        "merupakan kalimat pendek yang penuh arti yang dikaruniakan kepada Rasulullah. Hadits ini dengan tegas "
        "menolak setiap perkara bid’ah dan setiap perkara (dalam urusan agama) yang direkayasa. Sebagian ahli ushul "
        "fiqih menjadikan hadits ini sebagai dasar kaidah bahwa setiap yang terlarang dinyatakan sebagai hal yang merusak."
        "\n\n"
        "Pada riwayat imam muslim diatas disebutkan, “Barangsiapa melakukan suatu amal yang tidak sesuai urusan kami, "
        "maka dia tertolak” dengan jelas menyatakan keharusan meninggalkan setiap perkara bid’ah, baik ia ciptakan "
        "sendiri atau hanya mengikuti orang sebelumnya. Sebagian orang yang ingkar (ahli bid’ah) menjadikan hadits "
        "ini sebagai alas an bila ia melakukan suatu perbuatan bid’ah, dia mengatakan : “Bukan saya yang menciptakannya” "
        "maka pendapat tersebut terbantah oleh hadits diatas."
        "\n\n"
        "Hadits ini patut dihafal, disebarluaskan, dan digunakan sebagai bantahan terhadap kaum yang ingkar karena "
        "isinya mencakup semua hal. Adapun hal-hal yang tidak merupakan pokok agama sehingga tidak diatur dalam sunnah, "
        "maka tidak tercakup dalam larangan ini, seperti menulis Al-Qur’an dalam Mushaf dan pembukuan pendapat para ahli "
        "fiqih yang bertaraf mujtahid yang menerangkan permasalahan-permasalahan furu’ dari pokoknya, yaitu sabda Rosululloh . "
        "Demikian juga mengarang kitab-kitab nahwu, ilmu hitung, faraid dan sebagainya yang semuanya bersandar kepada sabda "
        "Rasulullah dan perintahnya. Kesemua usaha ini tidak termasuk dalam ancamanhadits diatas.Wallahu a’lam";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 6
    no=6;
    bookmark=0;
    ins_judul = "Halal dan Haram Telah Jelas";
    ins_arab = "عَنْ أَبِيْ عَبْدِ اللهِ النُّعْمَانِ بْنِ بِشِيْر رضي الله عنهما قَالَ: سَمِعْتُ رَسُوْلَ اللهِ صلى الله عليه وسلم يَقُوْلُ: ( إِنَّ الحَلالَ بَيِّنٌ وَإِنَّ الحَرَامَ بَيِّنٌ وَبَيْنَهُمَا أُمُوْرٌ مُشْتَبِهَات لاَ يَعْلَمُهُنَّ كَثِيْرٌ مِنَ النَّاس، ِ فَمَنِ اتَّقَى الشُّبُهَاتِ فَقَدِ اسْتَبْرأَ لِدِيْنِهِ وعِرْضِه، وَمَنْ وَقَعَ فِي الشُّبُهَاتِ وَقَعَ فِي الحَرَامِ كَالرَّاعِي يَرْعَى حَوْلَ الحِمَى يُوشِكُ أَنْ يَقَعَ فِيْهِ. أَلا وَإِنَّ لِكُلِّ مَلِكٍ حِمَىً. أَلا وَإِنَّ حِمَى اللهِ مَحَارِمُهُ، أَلا وإِنَّ فِي الجَسَدِ مُضْغَةً إِذَا صَلَحَتْ صَلَحَ الجَسَدُ كُلُّهُ وإذَا فَسَدَت فَسَدَ الجَسَدُ كُلُّهُ أَلا وَهيَ القَلْبُ ) – رواه البخاري ومسلم";
    ins_terjemahan = "Dari Abu ‘Abdillah An-Nu’man bin Basyir radhiallahu ‘anhuma berkata,”Aku mendengar Rasulullah bersabda: "
        "“Sesungguhnya yang Halal itu jelas dan yang haram itu jelas, dan diantara keduanya ada perkara yang samar-samar, "
        "kebanyakan manusia tidak mengetahuinya, maka barangsiapa menjaga dirinya dari yang samar-samar itu, berarti ia "
        "telah menyelamatkan agama dan kehormatannya, dan barangsiapa terjerumus dalam wilayah samar-samar maka ia telah "
        "terjerumus kedalam wilayah yang haram, seperti penggembala yang menggembala di sekitar daerah terlarang maka "
        "hampir-hampir dia terjerumus kedalamnya. Ingatlah setiap raja memiliki larangan dan ingatlah bahwa larangan "
        "Alloh apa-apa yang diharamkan-Nya. Ingatlah bahwa dalam jasad ada sekerat daging jika ia baik maka baiklah "
        "seluruh jasadnya dan jika ia rusak maka rusaklah seluruh jasadnya. Ketahuilah bahwa segumpal daging itu adalah hati”."
        "\n\n"
        "[Bukhari no. 52, Muslim no. 1599]";
    ins_isi = "Hadits ini merupakan salah satu pokok syari’at Islam. Abu Dawud As Sijistani berkata, “Islam bersumber pada empat (4) hadits.” Dia sebutkan diantaranya adalah hadits ini. Para ulama telah sepakat atas keagungan dan banyaknya manfaat hadits ini."
        "\n\n"
        "Kalimat, “Sesungguhnya yang Halal itu jelas dan yang haram itu jelas, dan diantara keduanya ada perkara yang samar-samar” maksudnya segala sesuatu terbagi kepada tiga macam hokum. Sesuatu yang ditegaskan halalnya oleh Allah, maka dia adalah halal, seperti firman Allah (QS. Al-Maa’idah 5 : 5),”Aku Halalkan bagi kamu hal-hal yang baik dan makanan (sembelihan) ahli kitab halal bagi kamu” dan firman-Nya dalam (QS. An-Nisaa 4:24), “Dan dihalalkan bagi kamu selain dari yang tersebut itu” dan lain-lainnya. Adapun yang Allah nyatakan dengan tegas haramnya, maka dia menjadi haram, seperti firman Allah dalam (QS. An-Nisaa’ 4:23), “Diharamkan bagi kamu (menikahi) ibu-ibu kamu, anak-anak perempuan kamu …..” dan firman Allah (QS. Al-Maa’idah 5:96), “Diharamkan bagi kamu memburu hewan didarat selama kamu ihram”. Juga diharamkan perbuatan keji yang terang-terangan maupun yang tersembunyi. Setiap perbuatan yang Allah mengancamnya dengan hukuman tertentuatau siksaan atau ancaman keras, maka perbuatan itu haram."
        "\n\n"
        "Adapun yang syubhat (samar) yaitu setiap hal yang dalilnya masih dalam pembicaraan atau pertentangan, maka menjauhi perbuatan semacam itu termasuk wara’. Para Ulama berbeda pendapat mengenai pengertian syubhat yang diisyaratkan oleh Rasulullah . Pada hadits tersebut, sebagian Ulama berpendapat bahwa hal semacam itu haram hukumnya berdasarkan sabda Rasulullah, “barangsiapa menjaga dirinya dari yang samar-samar itu, berarti ia telah menyelamatkan agama dan kehormatannya”. Barangsiapa tidak menyelamatkan agama dan kehormatannya, berarti dia telah terjerumus kedalam perbuatan haram. Sebagian yang lain berpendapat bahwa hal yang syubhat itu hukumnya halal dengan alas an sabda Rasulullah, “seperti penggembala yang menggembala di sekitar daerah terlarang” kalimat ini menunjukkan bahwa syubhat itu halal, tetapi meninggalkan yang syubhat adalah sifat yang wara’. Sebagian lain lagi berkata bahwa syubhat yang tersebut pada hadits ini tidak dapat dikatakan halal atau haram, karena Rasulullah menempatkannya diantara halal dan haram, oleh karena itu kita memilih diam saja, dan hal itu termasuk sifat wara’ juga."
        "\n\n"
        "Dalam shahih Bukhari dan Muslim disebutkan sebuah hadits dari ‘Aisyah, ia berkata : “Sa’ad bin Abu Waqash dan ‘Abd bin Zam’ah mengadu kepada Rasulullah tentang seorang anak laki-laki. Sa’ad berkata : Wahai Rasulullah anak laki-laki ini adalah anak saudara laki-lakiku.’Utbah bin Abu Waqash. Ia (‘Utbah) mengaku bahwa anak laki-laki itu adalah anaknya. Lihatlah kemiripannya” sedangkan ‘Abd bin Zam’ah berkata; “ Wahai Rasulullah, Ia adalah saudara laki-lakiku, Ia dilahirkan ditempat tidur ayahku oleh budak perempuan milik ayahku”, lalu Rasulullah memperhatikan wajah anak itu (dan melihat kemiripannya dengan ‘Utbah) maka beliau Rasulullah bersabda : “Anak laki-laki ini untukmu wahai ‘Abd bin Zam’ah, anak itu milik laki-laki yang menjadi suami perempuan yang melahirkannya dan bagi orang yang berzina hukumannya rajam. Dan wahai Saudah, berhijablah kamu dari anak laki-laki ini” sejak saat itu Saudah tidak pernah melihat anak laki-laki itu untuk seterusnya."
        "\n\n"
        "Rasulullah telah menetapkan bahwa anak itu menjadi hak suami dari perempuan yang melahirkannya, secara formal anak laki-laki itu menjadi anak Zam’ah. ‘Abd bin Zam’ah adalah saudara laki-laki Saudah, istri Rasulullah , karena Saudah putrid Zam’ah. Ketetapan semacam ini berdasarkan suatu dugaan yang kuat bukan suatu kepastian. Kemudian Rasulullah menyuruh Saudah untuk berhijab dari anak laki-laki itu karena adanya syubhat dalam masalah itu. Jadi tindakan ini bersifat kehati-hatian. Hal itu termasuk perbuatan takut kepada Allah SWT, sebab jika memang pasti dalam pandangan Rasulullah anak laki-laki itu adalah anak Zam’ah, tentulah Rasulullah tidak menyuruh Saudah berhijab dari saudara laki-lakinya yang lain, yaitu ‘Abd bin Zam’ah dan saudaranya yang lain.\n"
        "Pada Hadits ‘Adi bin Hatim, ia berkata : “Wahai Rasulullah, saya melepas anjing saya dengan ucapan Bismillah untuk berburu, kemudian saya dapati ada anjing lain yang melakukan perburuan” Rasulullah bersabda, “Janganlah kamu makan (hewan buruan yang kamu dapat) karena yang kamu sebutkan Bismillah hanyalah anjingmu saja, sedang anjing yang lain tidak”. Rasulullah memberi fatwa semacam ini dalam masalah syubhat karena beliau khawatir bila anjing yang menerkam hewan buruan tersebut adalah anjing yang dilepas tanpa menyebut Bismillah. Jadi seolah-olah hewan itu disembelih dengan cara diluar aturan Allah. Allah berfirman, “Sesungguhnya hal itu adalah perbuatan fasiq” (QS. Al-An’am 6:121)"
        "\n\n"
        "Dalam fatwa ini Rasulullah menunjukkan sifat kehati-hatian terhadap hal-hal yang masih samar tentang halal atau haramnya, karena sebab-sebab yang masih belum jelas. Inilah yang dimaksud dengan sabda Rasulullah , “Tinggalkanlah sesuatu yang meragukan kamu untuk berpegang pada sesuatu yang tidak meragukan kamu”"
        "\n\n"
        "Sebagian Ulama berpendapat, syubhat itu ada tiga macam : \n 1. Sesuatu yang sudah diketahui haramnya oleh manusia tetapi orang itu ragu apakah masih haram hukumnya atau tidak. à misalnya makan daging hewan yang tidak pasti cara penyembelihannya, maka daging semacam ini haram hukumnya kecuali terbukti dengan yakin telah disembelih (sesuai aturan Allah). Dasar dari sikap ini adalah hadits ‘Adi bin Hatim seperti tersebut diatas. \n 2. Sesuatu yang halal tetapi masih diragukan kehalalannya, à seperti seorang laki-laki yang punya istri namun ia ragu-ragu, apakah dia telah menjatuhkan thalaq kepada istrinya atau belum, ataukah istrinya seorang perempuan budak atau sudah dimerdekakan. Hal seperti ini hukumnya mubah hingga diketahui kepastian haramnya, dasarnya adalah hadits ‘Abdullah bin Zaid yang ragu-ragu tentang hadats, padahal sebelumnya ia yakin telah bersuci. \n 3. Seseorang ragu-ragu tentang sesuatu dan tidak tahu apakah hal itu haram atau halal, dan kedua kemungkinan ini bisa terjadi sedangkan tidak ada petunjuk yang menguatkan salah satunya. Hal semacam ini sebaiknya dihindari, sebagaimana Rasulullah pernah melakukannya pada kasus sebuah kurma yang jatuh yang beliau temukan dirumahnya, lalu Rasulullah bersabda : “Kalau saya tidak takut kurma ini dari barang zakat, tentulah saya telah memakannya” "
        "\n\n"
        "Adapun orang yang mengambil sikap hati-hati yang berlebihan, seperti tidak menggunakan air bekas yang masih suci karena khawatir terkena najis, atau tidak mau sholat disuatu tempat yang bersih karena khawatir ada bekas air kencing yang sudah kering, mencuci pakaian karena khawatir pakaiannya terkena najis yang tidak diketahuinya dan sebagainya, sikap semacam ini tidak perlu diikuti, sebab kehati-hatian yang berlebihan tanda adanya halusinasi dan bisikan setan, karena dalam masalah tersebut tidak ada masalah syubhat sedikitpun. Wallahu a’lam. "
        "\n\n"
        "Kalimat, “kebanyakan manusia tidak mengetahuinya” maksudnya tidak mengetahui tentang halal dan haramnya, atau orang yang mengetahui hal syubhat tersebut didalam dirinya masih tetap menghadapi keraguan antara dua hal tersebut, jika ia mengetahui sebenarnya atau kepastiannya, maka keraguannya menjadi hilang sehingga hukumnya pasti halal atau haram. Hal ini menunjukkan bahwa masalah syubhat mempunyai hokum tersendiri yang diterangkan oleh syari’at sehingga sebagian orang ada yang berhasil mengetahui hukumnya dengan benar. "
        "\n\n"
        "Kalimat, “maka barangsiapa menjaga dirinya dari yang samar-samar itu, berarti ia telah menyelamatkan agama dan kehormatannya” maksudnya menjaga dari perkara yang syubhat. "
        "\n\n"
        "Kalimat, “barangsiapa terjerumus dalam wilayah samar-samar maka ia telah terjerumus kedalam wilayah yang haram” hal ini dapat terjadi dalam dua hal :\n 1. Orang yang tidak bertaqwa kepada Allah dan tidak memperdulikan perkara syubhat maka hal semacam itu akan menjerumuskannya kedalam perkara haram, atau karena sikap sembrononya membuat dia berani melakukan hal yang haram, seperti kata sebagian orang : “Dosa-dosa kecil dapat mendorong perbuatan dosa besar dan dosa besar mendorong pada kekafiran” \n 2. Orang yang sering melakukan perkara syubhat berarti telah menzhalimi hatinya, karena hilangnya cahaya ilmu dan sifat wara’ kedalam hatinya, sehingga tanpa disadari dia telah terjerumus kedalam perkara haram. Terkadang hal seperti itu menjadikan perbuatan dosa jika menyebabkan pelanggaran syari’at."
        "\n\n"
        "Rasulullah bersabda : “seperti penggembala yang menggembala di sekitar daerah terlarang maka hampir-hampir dia terjerumus kedalamnya” ini adalah kalimat perumpamaan bagi orang-orang yang melanggar larangan-larangan Allah. Dahulu orang arab biasa membuat pagar agar hewan peliharaannya tidak masuk ke daerah terlarang dan membuat ancaman kepada siapapun yang mendekati daerah terlarang tersebut. Orang yang takut mendapatkan hukuman dari penguasa akan menjauhkan gembalaannya dari daerah tersebut, karena kalau mendekati wilayah itu biasanya terjerumus. Dan terkadang penggembala hanya seorang diri hingga tidak mampu mengawasi seluruh binatang gembalaannya. Untuk kehati-hatian maka ia membuat pagar agar gembalaannya tidak mendekati wilayah terlarang sehingga terhindar dari hukuman. Begitu juga dengan larangan Allah seperti membunuh, mencuri, riba, minum khamr, qadzaf, menggunjing, mengadu domba dan sebagainya adalah hal-hal yang tidak patut didekati karena khawatir terjerumus dalam perbuatan itu."
        "\n\n"
        "Kalimat, “Ingatlah bahwa dalam jasad ada sekerat daging jika ia baik maka baiklah seluruh jasadnya” yang dimaksud adalah hati, betapa pentingnya daging ini walaupun bentuknya kecil, daging ini disebut Al-Qalb (hati) yang merupakan anggota tubuh yang paling terhormat, karena ditempat inilah terjadi perubahan gagasan, sebagian penyair bersenandung, “Tidak dinamakan hati kecuali karena menjadi tempat terjadinya perubahan gagasan, karena itu waspadalah terhadap hati dari perubahannya”\n Allah menyebutkan bahwa manusia dan hewan memiliki hati yang menjadi pengatur kebaikan-kebaikan yang diinginkan. Hewan dan manusia dalam segala jenisnya mampu melihat yang baik dan buruk, kemudian Allah mengistimewakan manusia dengan karunia akal disamping dikaruniai hati sehingga berbeda dari hewan. Allah berfirman, “Tidakkah mereka mau berkelana dimuka bumi karena mereka mempunyai hati untuk berpikir, atau telinga untuk mendengar…” (QS. Al-Hajj 22:46). Allah telah melengkapi dengan anggota tubuh lainnya yang dijadikan tunduk dan patuh kepada akal. Apa yang sudah dipertimbangkan akal, anggota tubuh tinggal melaksanakan keputusan akal itu, jika akalnya baik maka perbuatannya baik, jika akalnya jelek, perbuatannya juga jelek. "
        "\n\n"
        "Bila kita telah memahami hal diatas, maka kita bisa menangkap dengan jelas sabda Rasulullah , “Ingatlah bahwa dalam jasad ada sekerat daging jika ia baik maka baiklah seluruh jasadnya dan jika ia rusak maka rusaklah seluruh jasadnya. Ketahuilah bahwa segumpal daging itu adalah hati”. "
        "\n\n"
        "Kita memohon kepada Allah semoga Dia menjadikan hati kita yang jelek menjadi baik, wahai Tuhan pemutar balik hati, teguhkanlah hati kami pada agama-Mu, wahai Tuhan pengendali hati, arahkanlah hati kami untuk taat kepada-Mu.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 7
    no=7;
    bookmark=0;
    ins_judul = "Agama Adalah Nasehat";
    ins_arab = "عَنْ أَبِيْ رُقَيَّةَ تَمِيْم بْنِ أَوْسٍ الدَّارِيِّ رضي الله عنه أَنَّ النبي صلى الله عليه وسلم قَالَ: ( الدِّيْنُ النَّصِيْحَةُ قُلْنَا: لِمَنْ يَارَسُولَ اللهِ؟ قَالَ: للهِ، ولكتابه، ولِرَسُوْلِهِ، وَلأَئِمَّةِ المُسْلِمِيْنَ، وَعَامَّتِهِمْ ) – رواه مسلم";
    ins_terjemahan = "Dari Abu Ruqayyah Tamiim bin Aus Ad Daari radhiallahu ‘anh, “Sesungguhnya Rasulullah telah bersabda "
        ": Agama itu adalah Nasehat , Kami bertanya : Untuk Siapa ?, Beliau bersabda : Untuk Allah, Kitab-Nya, "
        "Rasul-Nya, para pemimpin umat Islam, dan bagi seluruh kaum muslim”\n\n[Muslim no. 55]";
    ins_isi = "Tamim Ad Daari hanya meriwayatkan hadits ini, kata nasihat merupakan sebuah kata singkat penuh isi,"
        " maksudnya ialah segala hal yang baik. Dalam bahasa arab tidak ada kata lain yang pengertiannya setara dengan "
        "kata nasihat, sebagaimana disebutkan oleh para ulama bahasa arab tentang kata Al Fallaah yang tidak memiliki "
        "padanan setara, yang mencakup makna kebaikan dunia dan akhirat."
        "\n\n"
        "Kalimat, “Agama adalah Nasihat” maksudnya adalah sebagai tiang dan penopang agama, sebagaimana sabda Rasulullah, “Haji adalah arafah”, maksudnya wukuf di arafah adalah tiang dan bagian terpenting haji."
        "\n\n"
        "Tentang penafsiran kata nasihat dan berbagai cabangnya, Khathabi dan ulama-ulama lain mengatakan :\n"
        "1. Nasihat untuk Allah à maksudnya beriman semata-mata kepada-Nya, menjauhkan diri dari syirik dan sikap ingkar terhadap sifat-sifat-Nya, memberikan kepada Allah sifat-sifat sempurna dan segala keagungan, mensucikan-Nya dari segala sifat kekurangan, menaati-Nya, menjauhkan diri dari perbuatan dosa, mencintai dan membenci sesuatu semata karena-Nya, berjihad menghadapi orang-orang kafir, mengakui dan bersyukur atas segala nikmat-Nya, berlaku ikhlas dalam segala urusan, mengajak melakukan segala kebaikan, menganjurkan orang berbuat kebaikan, bersikap lemah lembut kepada sesama manusia. Khathabi berkata : “Secara prinsip, sifat-sifat baik tersebut, kebaikannya kembali kepada pelakunya sendiri, karena Allah tidak memerlukan kebaikan dari siapapun”\n"
        "2. Nasihat untuk kitab-Nya à maksudnya beriman kepada firman-firman Allah dan diturunkan-Nya firman-firman itu kepada Rasul-Nya, mengakui bahwa itu semua tidak sama dengan perkataan manusia dan tidak pula dapat dibandingkan dengan perkataan siapapun, kemudian menghormati firman Allah, membacanya dengan sungguh-sungguh, melafazhkan dengan baik dengan sikap rendah hati dalam membacanya, menjaganya dari takwilan orang-orang yang menyimpang, membenarkan segala isinya, mengikuti hokum-hukumnya, memahami berbagai macam ilmunya dan kalimat-kalimat perumpamaannya, mengambilnya sebagai pelajaran, merenungkan segala keajaibannya, mengamalkan dan menerima apa adanya tentang ayat-ayat mutasyabih, mengkaji ayat-ayat yang bersifat umum, dan mengajak manusia pada hal-hal sebagaimana tersebut diatas dan menimani Kitabullah\n"
        "3. Nasihat untuk Rasul-Nya maksudnya membenarkan ajaran-ajarannya, mengimani semua yang dibawanya, menaati perintah dan larangannya, membelanya semasa hidup maupun setelah wafat, melawan para musuhnya, membela para pengikutnya, menghormati hak-haknya, memuliakannya, menghidupkan sunnahnya, mengikuti seruannya, menyebarluaskan tuntunannya, tidak menuduhnya melakukan hal yang tidak baik, menyebarluaskan ilmunya dan memahami segala arti dari ilmu-ilmunya dan mengajak manusia pada ajarannya, berlaku santun dalam mengajarkannya, mengagungkannya dan berlaku baik ketika membaca sunnah-sunnahnya, tidak membicarakan sesuatu yang tidak diketahui sunnahnya, memuliakan para pengikut sunnahnya, meniru akhlak dan kesopanannya, mencintai keluarganya, para sahabatnya, meninggalkan orang yang melakukan perkara bid’ah dan orang yang tidak mengakui salah satu sahabatnya dan lain sebagainya.\n"
        "4. Nasihat untuk para pemimpin umat islam maksudnya menolong mereka dalam kebenaran, menaati perintah mereka dan memperingatkan kesalahan mereka dengan lemah lembut, memberitahu mereka jika mereka lupa, memberitahu mereka apa yang menjadi hak kaum muslim, tidak melawan mereka dengan senjata, mempersatukan hati umat untuk taat kepada mereka (tidak untuk maksiat kepada Allah dan Rasul-Nya), dan makmum shalat dibelakang mereka, berjihad bersama mereka dan mendo’akan mereka agar mereka mendapatkan kebaikan.\n"
        "5. Nasihat untuk seluruh kaum muslim à maksudnya memberikan bimbingan kepada mereka apa yang dapat memberikan kebaikan bagi merela dalam urusan dunia dan akhirat, memberikan bantuan kepada mereka, menutup aib dan cacat mereka, menghindarkan diri dari hal-hal yang membahayakan dan mengusahakan kebaikan bagi mereka, menyuruh mereka berbuat ma’ruf dan mencegah mereka berbuat kemungkaran dengan sikap santun, ikhlas dan kasih sayang kepada mereka, memuliakan yang tua dan menyayangi yang muda, memberikan nasihat yang baik kepada mereka, menjauhi kebencian dan kedengkian, mencintai sesuatu yang menjadi hak mereka seperti mencintai sesuatu yang menjadi hak miliknya sendiri, tidak menyukai sesuatu yang tidak mereka sukai sebagaimana dia sendiri tidak menyukainya, melindungi harta dan kehormatan mereka dan sebagainya baik dengan ucapan maupun perbuatan serta menganjurkan kepada mereka menerapkan perilaku-perilaku tersebut diatas. Wallahu a’lam\n\n"
        "Memberi nasihat merupakan fardu kifayah, jika telah ada yang melaksanakannya, maka yang lain terlepas dari kewajiban ini. Hal ini merupakan keharusan yang dikerjakan sesuai kemampuan. Nasihat dalam bahasa arab artinya membersihkan atau memurnikan seperti pada kalimat nashahtul ‘asala artinya saya membersihkan madu hingga tersisa yang murni, namun ada juga yang mengatakan kata nasihat memiliki makna lain. Wallahu a’lam";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 8
    no=8;
    bookmark=0;
    ins_judul = "Kehormatan Seorang Muslim";
    ins_arab = "عَنِ ابْنِ عُمَرَ رَضِيَ اللهُ عَنْهُمَا أَنَّ رَسُوْلَ اللهِ قَالَ: ( أُمِرْتُ أَنْ أُقَاتِلَ النَّاسَ حَتَّى يَشْهَدُوا أَنْ لاَ إِلَهَ إِلاَّ اللهُ وَأَنَّ مُحَمَّدَاً رَسُوْلُ اللهِ وَيُقِيْمُوْا الصَّلاةَ وَيُؤْتُوا الزَّكَاةَ فَإِذَا فَعَلُوا ذَلِكَ عَصَمُوا مِنِّي دِمَاءهَمْ وَأَمْوَالَهُمْ إِلاَّ بِحَقِّ الإِسْلامِ وَحِسَابُهُمْ عَلَى اللهِ تَعَالَى ) – رواه البخاري ومسلم";
    ins_terjemahan = "Dari Ibnu ‘Umar radhiallahu ‘anhuma, sesungguhnya Rasulullah telah bersabda : "
        "“Aku diperintah untuk memerangi manusia sampai ia mengucapkan laa ilaaha illallaah, menegakkan "
        "shalat dan mengeluarkan zakat. Barangsiapa telah mengucapkannya, maka ia telah memelihara harta dan "
        "jiwanya dari aku kecuali karena alasan yang hak dan kelak perhitungannya terserah kepada Allah Ta’ala”."
        "\n\n"
        "[Bukhari no. 25, Muslim no. 22]";
    ins_isi = "Hadits ini amat berharga dan termasuk salah satu prinsip Islam. Hadits yang semakna juga diriwayatkan "
        "oleh Anas, Rasulullah bersabda : “Sampai mereka bersaksi bahwa tidak ada Tuhan selain Allah dan Muhammad "
        "adalah hamba dan rasul-Nya, menghadap kepada kiblat kita, memakan sembelihan kita dan melaksanakan shalat kita. "
        "Jika mereka melakukan hal itu, maka darah mereka dan harta mereka haram kita sentuh kecuali karena hak. "
        "Bagi mereka hak sebagaimana yang diperoleh kaum muslim dam mereka memikul kewajiban sebagaimana yang menjadi "
        "kewajiban kaum muslimin”. "
        "\n\n"
        "Dalam Shahih Muslim dari Abu Hurairah disebutkan sabda beliau : “Sampai mereka bersaksi tidak ada Tuhan "
        "kecuali Allah dan beriman kepadaku dan apa yang aku bawa“."
        "\n\n"
        "Hal ini sesuai dengan kandungan Hadits riwayat dari ‘Umar diatas.\n"
        "Tentang maksud hadits ini para ulama mengartikannya berdasarkan sejarah, yaitu tatkala Rasulullah wafat dan "
        "Abu Bakar Ash Shiddiq diangkat sebagai khalifah untuk menggantikannya, sebagian dari orang Arab menjadi kafir. "
        "Abu Bakar bertekad untuk memerangi mereka sekalipun di antara mereka ada yang tidak kafir tetapi menolak membayar "
        "zakat. Abu Bakar lalu mengemukakan alasan perbuatannya itu, tetapi ‘Umar berkata kepadanya : “Bagaimana engkau "
        "akan memerangi manusia sedangkan mereka mengucapakan laa ilaaha illallaah dan Rasulullah bersabda : “Aku diperintah "
        "untuk memerangi manusia sampai ia mengucapkan laa ilaaha illallaah … dan kelak perhitungannya terserah kepada "
        "Allah Ta’ala”. Abu Bakar lalu menjawab : “Sesungguhnya zakat itu adalah kewajiban yang bersifat kebendaan”. "
        "Lalu katanya : “Demi Allah, kalau mereka merintangiku untuk mengambil seutas tali unta yang mereka dahulu "
        "serahkan sebagai zakat kepada Rasulullah niscaya aku perangi mereka karena penolakannya itu”.Maka kemudian "
        "Umar mengikuti jejak Abu Bakar untuk memerangi kaum tersebut."
        "\n\n"
        "Kalimat “Aku diperintah untuk memerangi manusia sampai ia mengucapkan laa ilaaha illallaah, dan barangsiapa "
        "telah mengucapkannya, maka ia telah memelihara harta dan jiwanya dari aku kecuali karena alasan yang hak dan "
        "kelak perhitungannya terserah kepada Allah”. Khatabi dan lain-lain bekata : “Yang dimaksud oleh Hadits ini "
        "ialah kaum penyembah berhala dan kaum Musyrik Arab serta orang yang tidak beriman, bukan golongan Ahli kitab "
        "dan mereka yang mengakui keesaan Allah”. Untuk terpeliharanya orang-orang semacam itu tidak cukup dengan "
        "mengucapkan laa ilaaha illallaah saja, karena sebelumnya mereka sudah mengatakan kalimat tersebut semasa masih "
        "sebagai orang kafir dan hal itu sudah menjadi keimanannya. Tersebut juga didalam hadits lain kalimat “dan "
        "sesungguhnya aku adalah rasul Allah, mereka melaksanakan shalat, dan mengeluarkan zakat”."
        "\n\n"
        "Syaikh Muhyidin An Nawawi berkata : “Di samping mengucapkan hal semacam ini ia juga harus mengimani semua ajaran "
        "yang dibawa Rasulullah seperti tersebut pada riwayat lain dari Abu Hurairah, yaitu kalimat, “sampai mereka "
        "bersaksi tidak ada Tuhan kecuali Allah, beriman kepadaku dan apasaja yang aku bawa”\nKalimat, “Dan perhitungannya "
        "terserah kepada Allah” maksudnya ialah tentang hal-hal yang mereka rahasiakan atau mereka sembunyikan, bukan "
        "meninggalkan perbuatan-perbuatan lahiriah yang wajib. Demikian disebutkan oleh khathabi. Khathabi berkata : "
        "Orang yang secara lahiriah menyatakan keislamannya, sedang hatinya menyimpan kekafiran, secara formal "
        "keislamannya diterima” ini adalah pendapat sebagian besar ulama. Imam Malik berkata : “Tobat orang yang "
        "secara lahiriah menyatakan keislaman tetapi menyimpan kekafiran dalam hatinya (zindiq) tidak diterima” "
        "ini juga merupakan pendapat yang diriwayatkan dari Imam Ahmad."
        "\n\n"
        "Kalimat, “aku diperintah memerangi manusia sampai mereka bersaksi tidak ada tuhan kecuali Allah dan mereka "
        "beriman kepadaku dan apa yang aku bawa” menjadi alasan yang tegas dari mazhab salaf bahwa manusia apabila "
        "meyakini islam dengan sungguh-sungguh tanpa sedikitpun keraguan, maka hal itu sudah cukup bagi dirinya. "
        "Dia tidak perlu mempelajari berbagai dalil ahli ilmu kalam dan mengenal Allah dengan dalil-dalil semacam itu. "
        "Hal ini berbeda dengan mereka yang berpendapat bahwa orang tersebut wajib mempelajari dalil-dalil semacam itu"
        " dan dijadikannya sebagai syarat masuk Islam. Pendapat ini jelas sekali kesalahannya, sebab yang dimaksud oleh "
        "hadits diatas, adanya keyakinan yang sungguh-sungguh dalam diri seseorang. Hal ini sudah dapat terpenuhi tanpa "
        "harus mempelajari dalil-dalil semacam itu, sebab Rasulullah mencukupkan dengan mempercayai ajaran apa saja yang "
        "beliau bawa tanpa mensyaratkan mengetahui dalil-dalilnya. Didalam hal ini terdapat beberapa hadits shahih yang "
        "jumlah sanadnya mencapai derajat mutawatir dan bernilai pengetahuan yang pasti. Wallahu a’lam";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 9
    no=9;
    bookmark=0;
    ins_judul = "Melaksanakan Perintah Sesuai Kemampuan";
    ins_arab = "عَنْ أَبِي هُرَيْرَةَ عَبْدِ الرَّحْمَنِ بْنِ صَخْرٍ رَضِيَ الله تَعَالَى عَنْهُ قَالَ: سَمِعْتُ رَسُوْلَ اللهِ صلى الله عليه وسلم يَقُوْلُ: ( مَا نَهَيْتُكُمْ عَنْهُ فَاجْتَنِبُوهُ وَمَا أَمَرْتُكُمْ بِهِ فأْتُوا مِنْهُ مَا اسْتَطَعْتُمْ؛ فَإِنَّمَا أَهْلَكَ الَّذِيْنَ مِنْ قَبْلِكُمْ كَثْرَةُ مَسَائِلِهِمْ وَاخْتِلافُهُمْ عَلَى أَنْبِيَائِهِمْ ) – رواه البخاري ومسلم";
    ins_terjemahan = "Dari Abu Hurairah, ‘Abdurrahman bin Shakhr radhiallahu ‘anh, ia berkata : Aku mendengar "
        "Rasulullah bersabda : “Apa saja yang aku larang kamu melaksanakannya, hendaklah kamu jauhi "
        "dan apa saja yang aku perintahkan kepadamu, maka lakukanlah menurut kemampuan kamu. "
        "Sesungguhnya kehancuran umat-umat sebelum kamu adalah karena banyak bertanya dan "
        "menyalahi nabi-nabi mereka (tidak mau taat dan patuh)”"
        "\n\n"
        "[Bukhari no. 7288, Muslim no. 1337]";
    ins_isi = "Hadits ini terdapat dalam kitab Muslim dari Abu Hurairah, ia berkata : “Rasulullah berkhutbah dihadapan kami, "
        "sabda beliau : Wahai manusia, Allah telah mewajibkan kepada kamu haji, karena itu berhajilah, lalu seseorang "
        "bertanya : Wahai Rasulullah… apakah setiap tahun ?, Rasulullah diam, sampai orang itu bertanya tiga kali, "
        "lalu Rasulullah bersabda : Kalau aku katakana “ya” niscaya menjadi wajib dan kamu tidak akan sanggup melakukannya, "
        "kemudian beliau bersabda lagi :Biarkanlah aku dengan apa yang aku diamkan, karena kehancuran umat-umat sebelum kamu "
        "adalah karena banyak bertanya dan menyalahi nabi-nabi mereka. Maka jika aku perintahkan melakukan sesuatu, "
        "kerjakanlah menurut kemampuan kamu, tetapi jika aku melarang kamu melakukan sesuatu, maka tinggalkanlah. "
        "Laki-laki yang bertanya kepada Rasulullah adalah Aqra’ bin Habits, demikianlah menurut suatu riwayat."
        "\n\n"
        "Para ahli ushul fiqh mempersoalkan perintah dalam agama, apakah perintah itu harus dilakukan berulang-ulang "
        "ataukah tidak. Sebagian besar ahli fiqh dan ahli ilmu kalam menyatakan tidak wajib berulang-ulang. Akan tetapi "
        "yang lain tidak menyatakan setuju atau menolak, tetapi menunggu penjelasan selanjutnya. Hadits ini dijadikan "
        "dalil bagi mereka yang bersikap menanti (netral), karena sahabat tersebut bertanya “Apakah setiap tahun?” "
        "sekiranya perintah itu dengan sendirinya mengharuskan pelaksanaan berulang-ulang atau tidak, tentu Rasulullah "
        "tidak menjawab dengan kata-kata “Kalau aku katakan “ya”, niscaya menjadi wajib dan kamu tidak akan sanggup "
        "melakukannya” Bahkan tidak ada gunanya hal tersebut ditanyakan. Akan tetapi secara umum perintah itu mengandung "
        "pengertian tidak perlu dilaksanakan berulang-ulang. Kaum muslim sepakat bahwa menurut agama, bahwa haji itu hanya "
        "wajib dilakukan satu kali seumur hidup."
        "\n\n"
        "Kalimat, “Biarkanlah aku dengan apa yang aku diamkan” secara formal menunjukkan bahwa setiap perintah agama "
        "tidaklah wajib dilaksanakan berulang-ulang, kalimat ini juga menunjukkan bahwa pada asalnya tidak ada kewajiban "
        "melaksanakan ibadah sampai datang keterangan agama. Hal ini merupakan prinsip yang benar dalam pandangan sebagian "
        "besar ahli fiqh."
        "\n\n"
        "Kalimat, “Kalau aku katakan “ya” tentu menjadi wajib” menjadi alasan bagi pemahaman para salafush sholih bahwa "
        "Rasulullah mempunyai wewenang berijtihad dalam masalah hukum dan tidak diisyaratkan keputusan hukum itu harus dengan wahyu."
        "\n\n"
        "Kalimat, “apa saja yang aku perintahkan kepadamu, maka lakukanlah menurut kemampuan kamu” merupakan kalimat "
        "yang singkat namun padat dan menjadi salah satu prinsip penting dalam Islam, termasuk dalam prinsip ini adalah"
        " masalah-masalah hukum yang tidak terhitung banyaknya, diantaranya adalah sholat, contohnya pada ibadah sholat, "
        "bila seseorang tidak mampu melaksanakan sebagian dari rukun atau sebagian dari syaratnya, maka hendaklah ia "
        "lakukan apa yang dia mampu. Begitu pula dalam membayar zakat fitrah untuk orang-orang yang menjadi tanggungannya, "
        "bila tidak bisa membayar semuanya, maka hendaklah ia keluarkan semampunya, juga dalam memberantas kemungkaran, "
        "jika tidak dapat memberantas semuanya, maka hendaklah ia lakukan semampunya dan masalah-masalah lain yang tidak "
        "terbatas banyaknya. Pembahasan semacam ini telah populer didalam kitab-kitab fiqh. Hadits diatas sejalan dengan "
        "firman Allah, QS. At-Taghabun 64:16, “Maka bertaqwalah kepada Allah menurut kemampuan kamu” Adapun firman Allah, "
        "QS. Ali ‘Imraan 3:102, “Wahai orang-orang yang beriman, bertaqwalah kepada Allah dengan taqwa yang sungguh-sungguh” "
        "ada yang berpendapat telah terhapus oleh ayat diatas. Sebagian ulama berkata : Yang benar ayat tersebut tidak "
        "terhapus bahkan menjelaskan dan menafsirkan apa yang dimaksud dengan taqwa yang sungguh-sungguh, yaitu "
        "melaksanakan perintah Allah dan menjauhi larangan Allah, dan Allah memerintahkan melakukan sesuatu menurut "
        "kemampuan, karena Allah berfirman, QS. Al-Baqarah 2:286, “Allah tidak membebani seseorang diluar kemampuannya” "
        "dan firman Allah dalam QS. Al-Hajj 22:78, “Allah tidak membebankan kesulitan kepada kamu dalam menjalankan agama”"
        "\n\n"
        "Kalimat, “apasaja yang aku larang kamu melaksanakannya, hendaklah kamu jauhi” maka hal ini menunjukkan "
        "adanya sifat mutlak, kecuali apabila seseorang mengalami rintangan /udzur dibolehkan melanggarnya, "
        "seperti dibolehkan makan bangkai dalam keadaan darurat, dalam keadaan seperti ini perbuatan semacam itu "
        "menjadi tidak dilarang. Akan tetapi dalam keadaan tidak darurat hal tersebut harus dijauhi karena ada "
        "larangan. Seseorang tidak dapat dikatakan menjauhi larangan jika hanya menjauhi larangan tersebut dalam "
        "selang waktu tertentu saja, berbeda dengan hal melaksanakan perintah, yang mana sekali saja dilaksanakan "
        "sudah terpenuhi. Inilah prinsip yang berlaku dalam memahami perintah secara umum, apakah suatu perintah "
        "harus segera dilakukan atau boleh ditunda, atau cukup sekali atau berulang kali, maka hadits ini mengandung "
        "berbagai macam pembahasan fiqh."
        "\n\n"
        "Kalimat, “Sesungguhnya kehancuran umat-umat sebelum kamu adalah karena banyak bertanya dan menyalahi nabi-nabi "
        "mereka” disebutkan setelah kalimat, “biarkanlah aku dengan apa yang aku diamkan kepada kamu” maksudnya ialah "
        "kamu jangan banyak bertanya sehingga menimbulkan jawaban yang bermacam-macam, menyerupai peristiwa yang "
        "terjadi pada bani Israil, tatkala mereka diperintahkan menyembelih seekor sapi yang seandainya mereka mengikuti "
        "perintah itu dan segera menyembelih sapi seadanya, niscaya mereka dikatakan telah menaatinya.\nAkan tetapi, "
        "karena mereka banyak bertanya dan mempersulit diri sendiri, maka mereka akhirnya dipersulit dan dicela. "
        "Rasulullah shallallahu ‘alaihi wasallam khawatir hal semacam ini terjadi pada umatnya.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 10
    no=10;
    bookmark=0;
    ins_judul = "Makan Dari Rizki Yang Halal";
    ins_arab = "عَنْ أَبِيْ هُرَيْرَةَ رَضِيَ اللهُ تَعَالَى عَنْهُ قَالَ: قَالَ رَسُوْلُ اللهِ: ( إِنَّ اللهَ تَعَالَى طَيِّبٌ لاَ يَقْبَلُ إِلاَّ طَيِّبَاً وَإِنَّ اللهَ أَمَرَ المُؤْمِنِيْنَ بِمَا أَمَرَ بِهِ المُرْسَلِيْنَ فَقَالَ: (يَا أَيُّهَا الرُّسُلُ كُلُوا مِنَ الطَّيِّبَاتِ وَاعْمَلُوا صَالِحاً) (المؤمنون: الآية51) ، وَقَالَ: ( يَا أَيُّهَا الَّذِينَ آمَنُوا كُلُوا مِنْ طَيِّبَاتِ مَا رَزَقْنَاكُمْ ) (البقرة: الآية172) ثُمَّ ذَكَرَ الرَّجُلَ يُطِيْلُ السَّفَرَ أَشْعَثَ أَغْبَرَ، يَمُدُّ يَدَيْهِ إِلَى السَّمَاء، ِ يَا رَبِّ يَا رَبِّ، وَمَطْعَمُهُ حَرَامٌ، وَمَشْرَبُهُ حَرَامٌ، وَغُذِيَ بِالحَرَامِ فَأَنَّى يُسْتَجَابُ لذلك ) – رواه مسلم";
    ins_terjemahan = "Dari Abu Hurairah radhiallahu ‘anh, ia berkata : “Telah bersabda Rasululloh : “ Sesungguhnya Allah itu baik, tidak menerima sesuatu kecuali yang baik. Dan sesungguhnya Allah telah memerintahkan kepada orang-orang mukmin (seperti) apa yang telah diperintahkan kepada para rasul, maka Allah telah berfirman: Wahai para Rasul, makanlah dari segala sesuatu yang baik dan kerjakanlah amal shalih. Dan Dia berfirman: Wahai orang-orang yang beriman, makanlah dari apa-apa yang baik yang telah Kami berikan kepadamu.’ Kemudian beliau menceritakan kisah seorang laki-laki yang melakukan perjalanan jauh, berambut kusut, dan berdebu menengadahkan kedua tangannya ke langit seraya berdo’a: “Wahai Tuhan, wahai Tuhan” , sedangkan makanannya haram, minumannya haram, pakaiannya haram dan dikenyangkan dengan makanan haram, maka bagaimana orang seperti ini dikabulkan do’anya”."
        "\n\n"
        "[Muslim no. 1015]";
    ins_isi = "Kata “thayyib (baik)” berkenaan dengan sifat Allah maksudnya ialah bersih dari segala kekurangan. Hadits ini merupakan salah satu dasar dan landasan pembinaan hukum Islam. Hadits ini berisi anjuran membelanjakan sebagian dari harta yang halal dan melarang membelanjakan harta yang haram. Makanan, minuman, pakaian dan sebagainya hendaknya benar-benar yang halal tanpa bercampur yang syubhat."
        "\n\n"
        "Orang yang ingin memohon kepada Allah hendaklah memperhatikan persyaratan yang tersebut pada Hadits ini. Hadits ini juga menyatakan bahwa seseorang yang membelanjakan hartanya dalam kebaikan berarti ia telah membersihkan dan menumbuhkan hartanya. Makanan yang enak tetapi tidak halal menjadi malapetaka bagi yang memakannya dan Allah tidak akan menerima amal kebajikannya."
        "\n\n"
        "Kalimat “kemudian beliau menceritakan kisah seorang laki-laki yang melakukan perjalanan jauh, berambut kusut, dan berdebu”, maksudnya ialah menempuh perjalanan jauh untuk melaksanakan kebaikan seperti haji, jihad, dan perbuatan baik lainnya. Amal kebajikan tersebut tidak akan diterima oleh Allah bila yang bersangkutan makan, minum dan berpakaian dari hasil yang haram. Lalu bagaimana lagi nasib orang-orang yang berbuat dosa di dunia atau berlaku zhalim kepada orang lain atau mengabaikan ibadah dan amal kebajikan?"
        "\n\n"
        "Kalimat “menengadahkan kedua tangannya” maksudnya berdo’a kepada Allah memohon sesuatu, namun dia tetap berbuat dosa dan melanggar aturan agama."
        "\n\n"
        "Kalimat “makanannya haram…, maka bagaimana orang seperti ini dikabulkan do’anya”, maksudnya bagaimana orang yang perbuatannya semacam itu akan dikabulkan do’anya, karena dia bukanlah orang yang layak dikabulkan do’anya. Akan tetapi walaupun demikian, boleh saja Allah mengabulkannya sebagai tanda kemurahan, kasih sayang dan pemberian karunia. Wallaahu a’lam.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 11
    no=11;
    bookmark=0;
    ins_judul = "Tinggalkan Keragu-raguan";
    ins_arab = "عَنْ أَبِي مُحَمَّدٍ الحَسَنِ بنِ عَلِيّ بنِ أبِي طالبٍ سِبْطِ رَسُولِ اللهِ صلى الله عليه وسلم وَرَيْحَانَتِهِ رَضِيَ اللهُ عَنْهُمَا قَالَ: حَفِظْتَ مِنْ رَسُوْلِ اللهِ صلى الله عليه وسلم: (دَعْ مَا يَرِيْبُكَ إِلَى مَا لاَ يَرِيْبُكَ) – رواه الترمذي والنسائي وقال الترمذي: حديث حسن صحيح";
    ins_terjemahan = "Dari Abu Muhammad, Al Hasan bin ‘Ali bin Abu Thalib, cucu Rasululloh Shallallahu ‘alaihi wa Sallam dan kesayangan beliau radhiallahu ‘anhuma telah berkata : “Aku telah menghafal (sabda) dari Rasululloh Shallallahu ‘alaihi wa Sallam: “Tinggalkanlah apa-apa yang meragukan kamu, bergantilah kepada apa yang tidak meragukan kamu “."
        "\n"
        "(HR. Tirmidzi dan berkata Tirmidzi : Ini adalah Hadits Hasan Shahih) "
        "\n\n"
        "[Tirmidzi no. 2520, dan An-Nasa-i no. 5711]";
    ins_isi = "Kalimat “yang meragukan kamu” maksudnya tinggalkanlah sesuatu yang menjadikan kamu ragu-ragu dan bergantilah kepada hal yang tidak meragukan. Hadits ini kembali kepada pengertian Hadits keenam, yaitu sabda Nabi Shallallahu ‘alaihi wa Sallam: “Sesungguhnya yang halal itu jelas dan yang haram itu jelas, dan di antara keduanya banyak perkara syubhat”."
        "\n\n"
        "Pada hadits lain disebutkan bahwa Nabi Shallallahu ‘alaihi wa Sallam bersabda : “Seseorang tidak akan mencapai derajat taqwa sebelum ia meninggalkan hal-hal yang tidak berguna karena khawatir berbuat sia-sia”.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 12
    no=12;
    bookmark=0;
    ins_judul = "Meninggalkan Yang Tidak Bermanfaat";
    ins_arab = "عَنْ أَبِيْ هُرَيْرَةَ رَضِيَ اللهُ عَنْهُ قَالَ: قَالَ رَسُوْلُ اللهِ صلى الله عليه وسلم: (مِنْ حُسْنِ إِسْلامِ المَرْءِ تَرْكُهُ مَا لاَيَعْنِيْهِ) – حديثٌ حسنٌ، رواه الترمذي وغيره هكذا";
    ins_terjemahan = "Dari Abu Hurairah radhiyallahu anhu, ia berkata : “Telah bersabda Rasulullah Shallallahu ‘alaihi wa Sallam : “Sebagian dari kebaikan keislaman seseorang ialah meninggalkan sesuatu yang tidak berguna baginya” “."
        "\n\n"
        "[Tirmidzi no. 2318, Ibnu Majah no. 3976]";
    ins_isi = "Hadits di atas juga diriwayatkan oleh Qurrah bin ‘abdurrahman dari Zuhri dari Abu Salamah dari Abu Hurairah dan sanad-sanadnya ia nyatakan shahih. Tentang Hadits ini ia berkata : “Hadits ini kalimatnya pendek tetapi padat berisi”. Semakna dengan Hadits ini adalah ucapan Abu Dzar pada beberapa riwayatnya: “Barang siapa yang menilai ucapan dengan perbuatannya, maka dia akan sedikit bicara dalam hal yang tidak berguna bagi dirinya”."
        "\n\n"
        "Imam Malik menyebutkan bahwa sampai kepadanya keterangan bahwa seseorang berkata kepada Luqman : “Apa yang menjadikan engkau mencapai derajat yang kami saksikan sekarang?” Jawabnya : “Berkata benar, menunaikan amanat dan meninggalkan apa saja yang tidak berguna bagi diriku”."
        "\n\n"
        "Diriwayatkan dari Imam Al Hasan, ia berkata : “Tanda bahwa Allah menjauh dari seseorang yaitu apabila orang itu sibuk dengan hal-hal yang tidak berguna bagi kepentingan akhiratnya”. Ia berkata bahwa Abu Dawud berkata : “Ada 4 Hadits yang menjadi dasar bagi tiap-tiap perbuatan, salah satunya adalah Hadits ini”.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 13
    no=13;
    bookmark=0;
    ins_judul = "Kesempurnaan Iman";
    ins_arab = "عَنْ أَبِيْ حَمْزَة أَنَسِ بنِ مَالِكٍ رَضِيَ اللهُ تَعَالَى عَنْهُ خَادِمِ رَسُوْلِ اللهِ صلى الله عليه وسلم عَن النبي صلى الله عليه وسلم قَالَ: (لاَ يُؤمِنُ أَحَدُكُمْ حَتَّى يُحِبَّ لأَخِيْهِ مَا يُحِبُّ لِنَفْسِهِ) – رواه البخاري ومسلم";
    ins_terjemahan = "Dari Abu Hamzah, Anas bin Malik radhiyallahu anhu, pelayan Rasulullah Shallallahu ‘alaihi wa Sallam, dari Nabi Shalallahu ‘alaihi wasallam, beliau bersabda: “Tidak beriman seseorang di antara kamu sehingga ia mencintai milik saudaranya (sesama muslim) seperti ia mencintai miliknya sendiri”."
        "\n\n"
        "[Bukhari no. 13, Muslim no. 45]";
    ins_isi = "Demikianlah di dalam Shahih Bukhari, digunakan kalimat “milik saudaranya” tanpa kata yang menunjukkan keraguan. Di dalam Shahih Muslim disebutkan “milik saudaranya atau tetangganya” dengan kata yang menunjukkan keraguan."
        "\n"
        "Para ulama berkata bahwa “tidak beriman” yang dimaksudkan ialah imannya tidak sempurna karena bila tidak dimaksudkan demikian, maka berarti seseorang tidak memiliki iman sama sekali bila tidak mempunyai sifat seperti itu. Maksud kalimat “mencintai milik saudaranya” adalah mencintai hal-hal kebajikan atau hal yang mubah. Hal ini ditunjukkan oleh riwayat Nasa’i yang berbunyi :"
        "\n"
        "“Sampai ia mencintai kebaikan untuk saudaranya seperti mencintainya untuk dirinya sendiri”."
        ""
        "Abu ‘Amr bin Shalah berkata : “ Perbuatan semacam ini terkadang dianggap sulit sehingga tidak mungkin dilakukan seseorang. Padahal tidak demikian, karena yang dimaksudkan ialah bahwa seseorang imannya tidak sempurna sampai ia mencintai kebaikan untuk saudaranya sesama muslim seperti mencintai kebaikan untuk dirinya sendiri. Hal tersebut dapat dilaksanakan dengan melakukan sesuatu hal yang baik bagi diriya, misalnya tidak berdesak-desakkan di tempat ramai atau tidak mau mengurangi kenikmatan yang menjadi milik orang lain. Hal-hal semacam itu sebenarnya gampang dilakukan oleh orang yang berhati baik, tetapi sulit dilakukan orang yang berhati jahat”. Semoga Allah memaafkan kami dan saudara kami semua."
        "\n\n"
        "Abu Zinad berkata : “Secara tersurat Hadits ini menyatakan hak persaman, tetapi sebenarnya manusia itu punya sifat mengutamakan dirinya, karena sifat manusia suka melebihkan dirinya. Jika seseorang memperlakukan orang lain seperti memperlakukan dirinya sendiri, maka ia merasa dirinya berada di bawah orang yang diperlakukannya demikian. Bukankah sesungguhnya manusia itu senang haknya dipenuhi dan tidak dizhalimi? Sesungguhnya iman yang dikatakan paling sempurna ketika seseorang berlaku zhalim kepada orang lain atau ada hak orang lain pada dirinya, ia segera menginsafi perbuatannya sekalipun hal itu berat dilakukan."
        "\n\n"
        "Diriwayatkan bahwa Fudhail bin ‘Iyadz, berkata kepada Sufyan bin ‘Uyainah : “Jika anda menginginkan orang lain menjadi baik seperti anda, mengapa anda tidak menasihati orang itu karena Allah. Bagaimana lagi kalau anda menginginkan orang itu di bawah anda?” (tentunya anda tidak akan menasihatinya)."
        "\n\n"
        "Sebagian ulama berpendapat : “Hadits ini mengandung makna bahwa seorang mukmin dengan mukmin lainnya laksana satu tubuh. Oleh karena itu, ia harus mencintai saudaranya sendiri sebagai tanda bahwa dua orang itu menyatu”."
        "\nSeperti tersebut pada Hadits lain :"
        "\n“Orang-orang mukmin laksana satu tubuh, bila satu dari anggotanya sakit, maka seluruh tubuh turut mengeluh kesakitan dengan merasa demam dan tidak bisa tidur malam hari”.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 14
    no=14;
    bookmark=0;
    ins_judul = "Kehormatan Jiwa Seorang Muslim";
    ins_arab = "عَنِ ابْنِ مَسْعُودٍ رضي الله عنه قَالَ: قَالَ رَسُولُ اللهِ: (لا يَحِلُّ دَمُ امْرِئٍ مُسْلِمٍ إِلاَّ بإِحْدَى ثَلاثٍ: الثَّيِّبُ الزَّانِيْ، وَالنَّفْسُ بِالنَّفْسِ، وَالتَّاركُ لِدِيْنِهِ المُفَارِقُ للجمَاعَةِ) – رواه البخاري ومسلم";
    ins_terjemahan = "Ibnu Mas’ud radhiyallahu anhu, ia berkata : “Rasulullah Shallallahu ‘alaihi wa Sallam bersabda : ‘Tidak halal darah seorang muslim kecuali Karena salah satu di antara tiga perkara : orang yang telah kawin berzina, jiwa dengan jiwa, dan orang yang meninggalkan agamanya yaitu merusak jama’ah’ “."
        "\n\n"
        "[Bukhari no. 6878, Muslim no. 1676]";
    ins_isi = "Pada beberapa riwayat disebutkan :\n"
        "“Tidak halal darah seorang muslim yang telah bersaksi bahwa tiada sesembahan yang berhak disembah secara benar kecuali Allah dan sesungguhnya aku adalah rasul Allah, kecuali karena salah satu dari tiga hal”."
        "\n\n"
        "Kalimat “telah bersaksi bahwa tiada sesembahan yang berhak disembah secara benar kecuali Allah dan sesungguhnya aku adalah rasul Allah” merupakan penjelasan dari kata “muslim”. Kalimat “yang merusak jama’ah” adalah penjelasan dari kata “yang meninggalkan agamanya”."
        "\n\n"
        "Ketiga golongan ini darahnya dihalalkan berdasarkan nash. Yang dimaksud dengan “jama’ah” adalah kaum muslim dan yang dimaksud dengan “merusak jama’ah” adalah keluar dari agama. Inilah yang menyebabkan darahnya dihalalkan."
        "\n\n"
        "Kalimat “yang meninggalkan agamanya yaitu merusak jama’ah” adalah kalimat umum yang mencakup setiap orang yang keluar dari agama Islam dalam bentuk apapun, maka ia wajib dibunuh kalau tidak mau kembali kepada Islam."
        "\n\n"
        "Para ulama berkata : “Kalimat tersebut juga mencakup setiap orang yang menyimpang dari kaum muslim dengan berbuat bid’ah, merusak, atau lainnya”. Wallahu a‘lam."
        "\n\n"
        "Secara tersurat, kalimat yang umum tersebut dikhususkan kepada orang yang melakukan penyerangan atau semacamnya terhadap kaum muslim, maka untuk mengatasi gangguannya itu dia boleh dibunuh, karena perbuatan semacam itu termasuk kategori merusak kaum muslim. Juga yang dimaksud oleh Hadits di atas ialah seorang muslim tidak boleh dengan sengaja dibunuh terkecuali karena dia melakukan salah satu dari tiga hal di atas."
        "\n\n"
        "Sebagian ulama menjadikan Hadits ini sebagai dalil bahwa orang yang meninggalkan shalat boleh dibunuh, karena perbuatannya itu termasuk salah satu dari tiga perbuatan di atas. Dalam masalah ini para ulama berbeda pendapat, sebagian menyatakannya kafir dan sebagian lagi menyatakan tidak kafir. Pendapat yang menyatakan kafir berdalil dengan Hadits lain yaitu sabda Rasululah Shalallahu ‘alaihi wasallam : “Aku diperintahkan untuk memerangi manusia sampai mereka bersaksi tidak ada Tuhan kecuali Allah dan sesungguhnya aku adalah rasul Allah, mereka melakukan shalat dan mengeluarkan zakat”."
        "\n\n"
        "Maksud dari dalil ini ialah bahwa perlindungan itu diberikan kepada orang yang mengucapakan syahadat, melaksanakan shalat dan mengeluarkan zakat secara utuh dan meninggalkan salah satunya berarti membatalkannya. Pemahaman seperti ini berlaku jika dalil diatas di pegang secara harfiah, yaitu kalimat “aku diperintah untuk memerangi manusia….” Dipahami bahwa perintah memerangi ini berlaku bagi semua yang melanggar apa yang disebutkan. Pemahaman seperti ini dianggap lemah Karena tidak membedakan antara memerangi dan membunuh, sedangkan memerangi berarti tindakan dua pihak yang saling membunuh. Kewajiban memerangi orang yang meninggalkan shalat tidak dengan sendirinya menyatakan kewajiban membunuh selama orang itu tidak memerangi kita. Wallaahu a’lam."
        "\n\n"
        "Kalimat “orang yang telah kawin berzina” mencakup laki-laki dan perempuan. Hadits ini menjadi dasar kesepakatan kaum muslim bahwa orang yang berzina semacam itu dirajam dengan syarat-syarat yang dijelaskan dalam kitab fiqih."
        "\n\n"
        "Kalimat “jiwa dengan jiwa” sejalan dengan firman Allah: “Dan Kami telah tetapkan mereka di dalam Taurat bahwa jiwa dengan jiwa”. (QS. Al Maidah : 45)"
        "\n\n"
        "Yaitu berlaku sepadan antara orang-orang yang sama-sama Islam atau sama-sama merdeka. Hal ini berdasarkan sabda Rasulullah Shalallahu ‘alaihi wasallam : “Seorang muslim tidak dibunuh karena membunuh seorang kafir”."
        "\n\n"
        "Begitu juga syarat merdeka, berlaku sebagaimana pendapat Imam Malik, Imam Syafi’I dan Imam Ahmad. Akan tetapi, para pengikut ahli ra’yu (Imam Abu Hanifah) berpendapat seorang muslim dihukum bunuh karena membunuh kafir dzimmi dan orang merdeka dibunuh karena membunuh budak, dan mereka berdalil dengan Hadits ini juga. Akan tetapi kebanyakan ulama berbeda dengan pendapat tersebut.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 15
    no=15;
    bookmark=0;
    ins_judul = "Berkata Baik, Memuliakan Tetangga dan Tamu";
    ins_arab = "عَن أَبِي هُرَيْرَةَ رضي الله عنه أَنَّ رَسُولَ اللهِ صلى الله عليه وسلم قَالَ: (مَنْ كَانَ يُؤمِنُ بِاللهِ وَاليَوْمِ الآخِرِ فَلْيَقُلْ خَيْرَاً أَو لِيَصْمُتْ، وَمَنْ كَانَ يُؤمِنُ بِاللهِ وَاليَومِ الآخِرِ فَلْيُكْرِمْ جَارَهُ، ومَنْ كَانَ يُؤمِنُ بِاللهِ واليَومِ الآخِرِ فَلْيُكْرِمْ ضَيْفَهُ) – رواه البخاري ومسلم";
    ins_terjemahan = "Dari Abu Hurairah radhiyallahu anhu, sesungguhnya Rasulullah Shallallahu ‘alaihi wa Sallam telah bersabda : “Barang siapa yang beriman kepada Allah dan hari akhirat, maka hendaklah ia berkata baik atau diam, barang siapa yang beriman kepada Allah dan hari akhirat, maka hendaklah ia memuliakan tetangga dan barang siapa yang beriman kepada Allah dan hari akhirat, maka hendaklah ia memuliakan tamunya”."
        "\n\n"
        "[Bukhari no. 6018, Muslim no. 47]";
    ins_isi = "Kalimat “barang siapa yang beriman kepada Allah dan hari akhirat”, maksudnya adalah barang siapa beriman dengan keimanan yang sempurna, yang (keimanannya itu) menyelamatkannya dari adzab Allah dan membawanya mendapatkan ridha Allah, “maka hendaklah ia berkata baik atau diam” karena orang yang beriman kepada Allah dengan sebenar-benarnya tentu dia takut kepada ancaman-Nya, mengharapkan pahala-Nya, bersungguh-sungguh melaksanakan perintah dan meninggalkan larangan-Nya. Yang terpenting dari semuanya itu ialah mengendalikan gerak-gerik seluruh anggota badannya karena kelak dia akan dimintai tanggung jawab atas perbuatan semua anggota badannya, sebagaimana tersebut pada firman Allah :"
        "\n"
        "“Sesungguhnya pendengaran, penglihatan, dan hati semuanya kelak pasti akan dimintai tanggung jawabnya”. (QS. Al Isra’ : 36)"
        "\n "
        "dan firman-Nya:"
        "\n"
        "“Apapun kata yang terucap pasti disaksikan oleh Raqib dan ‘Atid”. (QS. Qaff : 18)"
        "\n"
        "Bahaya lisan itu sangat banyak. Rasulullah Shallallahu ‘alaihi wa Sallam juga bersabda:"
        "\n"
        "“Bukankah manusia terjerumus ke dalam neraka karena tidak dapat mengendalikan lidahnya”."
        "\n"
        "Beliau juga bersabda :"
        "\n“Tiap ucapan anak Adam menjadi tanggung jawabnya, kecuali menyebut nama Allah, menyuruh berbuat ma’ruf dan mencegah kemungkaran”."
        "\n\n"
        "Barang siapa memahami hal ini dan beriman kepada-Nya dengan keimanan yang sungguh-sungguh, maka Allah akan memelihara lidahnya sehingga dia tidak akan berkata kecuali perkataan yang baik atau diam."
        "\n\n"
        "Sebagian ulama berkata: “Seluruh adab yang baik itu bersumber pada empat Hadits, antara lain adalah Hadits “barang siapa yang beriman kepada Allah dan hari akhirat, maka hendaklah ia berkata baik atau diam”. Sebagian ulama memaknakan Hadits ini dengan pengertian; “Apabila seseorang ingin berkata, maka jika yang ia katakan itu baik lagi benar, dia diberi pahala. Oleh karena itu, ia mengatakan hal yang baik itu. Jika tidak, hendaklah dia menahan diri, baik perkataan itu hukumnya haram, makruh, atau mubah”. Dalam hal ini maka perkataan yang mubah diperintahkan untuk ditinggalkan atau dianjurkan untuk dijauhi Karena takut terjerumus kepada yang haram atau makruh dan seringkali hal semacam inilah yang banyak terjadi pada manusia."
        "\n"
        "Allah berfirman :"
        "\n"
        "“Apapun kata yang terucapkan pasti disaksikan oleh Raqib dan ‘Atid”. (QS.Qaaf : 18)"
        "\n\n"
        "Para ulama berbeda pendapat, apakah semua yang diucapkan manusia itu dicatat oleh malaikat, sekalipun hal itu mubah, ataukah tidak dicatat kecuali perkataan yang akan memperoleh pahala atau siksa. Ibnu ‘Abbas dan lain-lain mengikuti pendapat yang kedua. Menurut pendapat ini maka ayat di atas berlaku khusus, yaitu pada setiap perkataan yang diucapkan seseorang yang berakibat orang tersebut mendapat pembalasan."
        "\n\n"
        "Kalimat “hendaklah ia memuliakan tetangganya…….., maka hendaklah ia memuliakan tamunya” , menyatakan adanya hak tetangga dan tamu, keharusan berlaku baik kepada mereka dan menjauhi perilaku yang tidak baik terhadap mereka. Allah telah menetapkan di dalam Al Qur’an keharusan berbuat baik kepada tetangga dan Rasulullah Shallallahu ‘alaihi wa Sallam bersabda :"
        "\n"
        "“Jibril selalu menasehati diriku tentang urusan tetangga, sampai-sampai aku beranggapan bahwa tetangga itu dapat mewarisi harta tetangganya”."
        "\n\n"
        "Bertamu itu merupakan ajaran Islam, kebiasaan para nabi dan orang-orang shalih. Sebagian ulama mewajibkan menghormati tamu tetapi sebagian besar dari mereka berpendapat hanya merupakan bagian dari akhlaq yang terpuji."
        "\n\n"
        "Pengarang kitab Al Ifshah mengatakan : “Hadits ini mengandung hukum, hendaklah kita berkeyakinan bahwa menghormati tamu itu suatu ibadah yang tidak boleh dikurangi nilai ibadahnya, apakah tamunya itu orang kaya atau yang lain. Juga anjuran untuk menjamu tamunya dengan apa saja yang ada pada dirinya walaupun sedikit. Menghormati tamu itu dilakukan dengan cara segera menyambutnya dengan wajah senang, perkataan yang baik, dan menghidangkan makanan. Hendaklah ia segera memberi pelayanan yang mudah dilakukannya tanpa memaksakan diri”. Pengarang juga menyebutkan perkataan dalam menyambut tamu."
        "\n\n"
        "Selanjutnya ia berkata : Adapun sabda Nabi Shallallahu ‘alaihi wa Sallam “maka hendaklah ia berkata baik atau diam” , menunjukkan bahwa perkatan yang baik itu lebih utama daripada diam, dan diam itu lebih utama daripada berkata buruk. Demikian itu karena Rasulullah Shallallahu ‘alaihi wa Sallam dalam sabdanya menggunakan kata-kata “hendaklah untuk berkata benar” didahulukan dari perkataan “diam”. Berkata baik dalam Hadits ini mencakup menyampaikan ajaran Allah dan rasul-Nya dan memberikan pengajaran kepada kaum muslim, amar ma’ruf dan nahi mungkar berdasarkan ilmu, mendamaikan orang yang berselisih, berkata yang baik kepada orang lain. Dan yang terbaik dari semuanya itu adalah menyampaikan perkataan yang benar di hadapan orang yang ditakuti kekejamannya atau diharapkan pemberiannya.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 16
    no=16;
    bookmark=0;
    ins_judul = "Jangan Marah";
    ins_arab = "عَنْ أَبِي هُرَيْرَةَ رَضِيَ اللهُ عَنْهُ أَنَّ رَجُلاً قَالَ لِلنَّبيِّ صلى الله عليه وسلم: أَوصِنِيْ، قَال: ( لاَ تَغْضَبْ ) فردد مراراً قال: ( لاَ تَغْضَبْ ) – رواه البخاري";
    ins_terjemahan = "Dari Abu Hurairah radhiyallahu ‘anhu, bahwa ada seorang laki-laki berkata kepada Nabi Shallallahu ‘alaihi wa Sallam: “Berilah wasiat kepadaku”. Sabda Nabi Shallallahu ‘alaihi wa sallam : “Janganlah engkau mudah marah”. Maka diulanginya permintaan itu beberapa kali. Sabda beliau : “Janganlah engkau mudah marah”."
        "\n\n"
        "[Bukhari no. 6116]";
    ins_isi = "Pengarang kitab Al Ifshah berkata : “Boleh jadi Nabi mengetahui laki-laki tersebut sering marah, sehingga nasihat ini ditujukan khusus kepadanya. Nabi Shallallahu ‘alaihi wa Sallam memuji orang yang dapat mengendalikan hawa nafsunya ketika marah”. Sabda beliau : “Bukanlah dikatakan orang yang kuat karena dapat membanting lawannya, tetapi orang yang kuat ialah orang yang mampu mengendalikan hawa nafsunya di waktu marah”."
        "\n\n"
        "Allah juga memuji orang yang dapat mengendalikan nafsunya ketika marah dan suka memberi maaf kepada orang lain. Diriwayatkan dari Nabi Shalallahu ‘alaihi wa sallam bahwa beliau bersabda : “Barang siapa menahan marahnya padahal ia sanggup untuk melampiaskannya, maka kelak Allah akan memanggilnya pada hari kiamat di hadapan segala makhluk, sehingga ia diberi hak memilih bidadari yang disukainya”"
        "\n\n"
        "Tersebut pada Hadits lain : “Marah itu dari setan”."
        "\n\n"
        "Oleh karena itu, orang yang marah menyimpang dari keadaan normal, berkata yang bathil, berbuat yang tercela, menginginkan kedengkian, perseteruan dan perbuatan-perbuatan tercela. Semua itu adalah akibat dari rasa marah. Semoga Allah melindungi kita dari rasa marah. Tersebut pada Hadits Sulaiman bin Shard : “Sesungguhnya mengucapkan ‘a’udzuubillaahi minasy syaithanirrajiim’ dapat menghilangkan rasa marah”."
        "\n\n"
        "Karena sesungguhnya setanlah yang mendorong marah. Setiap orang yang menginginkan hal-hal yang terpuji, setan selalu membelokkannya dan menjauhkannya dari keridhaan Allah, maka mengucapkan “a’udzuubillaahi minasy syaithanirrajiim” merupakan senjata yang paling kuat untuk menolak tipu daya setan ini.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 17
    no=17;
    bookmark=0;
    ins_judul = "Berbuat Baik Dalam Segala Urusan";
    ins_arab = "عَنْ أَبِي يَعْلَى شَدَّادِ بنِ أَوْسٍ رَضِيَ اللهُ تَعَالَى عَنْهُ عَنْ رَسُولِ اللهِ صلى الله عليه وسلم قَالَ: (إِنَّ اللهَ كَتَبَ الإِحْسَانَ عَلَى كُلِّ شَيءٍ. فَإِذَا قَتَلْتُمْ فَأَحْسِنُوا القِتْلَةَ، وَإِذَا ذَبَحْتُمْ فَأَحْسِنُوا الذِّبْحَةَ، وَلْيُحِدَّ أَحَدُكُمْ شَفْرَتَهُ، وَلْيُرِحْ ذَبِيْحَتَهُ) – رواه مسلم";
    ins_terjemahan = "Dari Abu Ya’la, Syaddad bin Aus radhiyallahu ‘anhu, dari Rasulullah Shallallahu ‘alaihi wa Sallam beliau telah bersabda : “ Sesungguhnya Allah mewajibkan berlaku baik pada segala hal, maka jika kamu membunuh hendaklah membunuh dengan cara yang baik dan jika kamu menyembelih maka sembelihlah dengan cara yang baik dan hendaklah menajamkan pisau dan menyenangkan hewan yang disembelihnya”."
        "\n\n"
        "[Muslim no. 1955]";
    ins_isi = "Kalimat “hendaklah membunuh dengan cara yang baik” berlaku umum mencakup menyembelih, membunuh dalam Qishash, ataupun hukuman pidana lainnya. Hadits ini termasuk salah satu Hadits yang mengandung berbagai macam prinsip atau kaidah. Membunuh dengan cara yang baik itu ialah membunuh tanpa sedikit pun unsur penganiayaan atau penyiksaan. Menyembelih dengan cara yang baik yaitu menyembelih hewan dengan lemah lembut, tidak merebahkannya ketanah dengan keras dan juga tidak menyeretnya, menghadapkannya ke kiblat, membaca basmalah dan hamdalah, memotong urat nadi lehernya dan membiarkannya sampai mati baru dikuliti, mengakui nikmat dan mensyukuri pemberian Allah, karena Allah telah menundukkannya kepada kita, padahal Dia berkuasa untuk menjadikannya sebagai musuh kita dan telah menghalalkan dagingnya untuk kita, padahal Dia berkuasa untuk mengharamkannya.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 18
    no=18;
    bookmark=0;
    ins_judul = "Bertakwa Dimana Saja Berada";
    ins_arab = "عَنْ أَبِيْ ذَرٍّ جُنْدُبِ بنِ جُنَادَةَ وَأَبِي عَبْدِ الرَّحْمَنِ مُعَاذِ بِنِ جَبَلٍ رَضِيَ اللهُ عَنْهُمَا عَنْ رَسُولِ اللهِ صلى الله عليه وسلم قَالَ: (اتَّقِ اللهَ حَيْثُمَا كُنْتَ، وَأَتْبِعِ السَّيِّئَةَ الحَسَنَةَ تَمْحُهَا، وَخَالِقِ النَّاسَ بِخُلُقٍ حَسَنٍ) – رواه الترمذي وقال: حديث حسن. وفي بعض النسخ: حسنٌ صحيح";
    ins_terjemahan = "Dari Abu Dzar, Jundub bin Junadah dan Abu ‘Abdurrahman, Mu’adz bin Jabal radhiyallahu ‘anhuma, dari Rasulullah Shallallahu ‘alaihi wa Sallam, beliau bersabda : “Bertaqwalah kepada Allah di mana saja engkau berada dan susullah sesuatu perbuatan dosa dengan kebaikan, pasti akan menghapuskannya dan bergaullah sesama manusia dengan akhlaq yang baik”."
        "\n"
        "(HR. Tirmidzi, ia telah berkata : Hadits ini hasan, pada lafazh lain derajatnya hasan shahih)"
        "\n\n"
        "[Tirmidzi no. 1987]";
    ins_isi = "Riwayat hidup Abu Dzar itu banyak. Ia masuk Islam ketika Rasulullah Shallallahu ‘alaihi wa Sallam masih di Makkah dan beliau menyuruhnya kembali kepada kaumnya. Namun ketika Rasulullah Shalallahu ‘alaihi wasallam menyaksikan tekadnya untuk tinggal di Makkah bersama beliau, maka Rasulullah Shalallahu ‘alaihi wasallam tidak mampu lagi mencegahnya."
        "\n"
        "Sabda Rasulullah Shalallahu ‘alaihi wasallam kepada Abu Dzar “Bertaqwalah kepada Allah di mana saja engkau berada dan susullah sesuatu perbuatan dosa dengan kebaikan, pasti akan menghapuskannya”."
        "\n"
        "Hal ini sejalan dengan firman Allah : “Sesungguhnya segala amal kebajikan menghapus segala perbuatan dosa”. (QS. Huud : 114)"
        "\n\n"
        "Sabda beliau “bergaullah sesama manusia dengan akhlaq yang baik” maksudnya bergaullah dengan manusia dengan cara-cara yang kamu merasa senang bila diperlakukan oleh mereka dengan cara seperti itu. Ketahuilah bahwa yang paling berat timbangannya di akhirat kelak adalah akhlaq yang baik. Rasulullah Shallallahu ‘alaihi wa Sallam bersabda : “Sesungguhnya orang yang paling aku cintai di antara kamu dan yang paling dekat kepadaku posisinya pada hari kiamat adalah orang yang paling baik akhlaqnya diantara kamu”."
        "\n\n"
        "Akhlaq yang baik adalah sifat para nabi, para rasul dan orang-orang mukmin pilihan. Perbuatan buruk hendaklah tidak di balas dengan keburukan, tetapi dimaafkan dan diampuni serta dibalas dengan kebaikan.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 19
    no=19;
    bookmark=0;
    ins_judul = "Wasiat Rasulullah Kepada Ibnu Abbas";
    ins_arab = "عَنْ أَبِي عَبَّاسٍ عَبْدِ اللهِ بنِ عَبَّاسٍ رضي الله عنهما قَالَ: كُنْتُ خَلْفَ النبي صلى الله عليه وسلم يَومَاً فَقَالَ: (يَا غُلاَمُ إِنّي أُعَلِّمُكَ كَلِمَاتٍ: احْفَظِ اللهَ يَحفَظك، احْفَظِ اللهَ تَجِدهُ تُجَاهَكَ، إِذَاَ سَأَلْتَ فَاسْأَلِ اللهَ، وَإِذَاَ اسْتَعَنتَ فَاسْتَعِن بِاللهِ، وَاعْلَم أَنَّ الأُمّة لو اجْتَمَعَت عَلَى أن يَنفَعُوكَ بِشيءٍ لَمْ يَنْفَعُوكَ إِلا بِشيءٍ قَد كَتَبَهُ اللهُ لَك، وإِن اِجْتَمَعوا عَلَى أَنْ يَضُرُّوكَ بِشيءٍ لَمْ يَضروك إلا بشيءٍ قَد كَتَبَهُ اللهُ عَلَيْكَ، رُفعَت الأَقْلامُ، وَجَفّتِ الصُّحُفُ) – رواه الترمذي وقال: حديث حسن صحيح – وفي رواية – غير الترمذي: اِحفظِ اللهَ تَجٍدْهُ أَمَامَكَ، تَعَرَّفْ إلى اللهِ في الرَّخاءِ يَعرِفْكَ في الشّدةِ، وَاعْلَم أن مَا أَخطأكَ لَمْ يَكُن لِيُصيبكَ، وَمَا أَصَابَكَ لَمْ يَكُن لِيُخطِئكَ، وَاعْلَمْ أنَّ النَّصْرَ مَعَ الصَّبْرِ، وَأَنَّ الفَرَجَ مَعَ الكَربِ، وَأَنَّ مَعَ العُسرِ يُسراً";
    ins_terjemahan = "Dari Abu Al ‘Abbas, ‘Abdullah bin ‘Abbas radhiyallahu anhu, ia berkata : Pada suatu hari saya pernah berada di belakang Nabi Shallallahu ‘alaihi wa Sallam, beliau bersabda : “Wahai anak muda, aku akan mengajarkan kepadamu beberapa kalimat : Jagalah Allah, niscaya Dia akan menjaga kamu. Jagalah Allah, niscaya kamu akan mendapati Dia di hadapanmu. Jika kamu minta, mintalah kepada Allah. Jika kamu minta tolong, mintalah tolong juga kepada Allah. Ketahuilah, sekiranya semua umat berkumpul untuk memberikan kepadamu sesuatu keuntungan, maka hal itu tidak akan kamu peroleh selain dari apa yang sudah Allah tetapkan untuk dirimu. Sekiranya mereka pun berkumpul untuk melakukan sesuatu yang membahayakan kamu, niscaya tidak akan membahayakan kamu kecuali apa yang telah Allah tetapkan untuk dirimu. Segenap pena telah diangkat dan lembaran-lembaran telah kering.” (HR. Tirmidzi, ia telah berkata : Hadits ini hasan, pada lafazh lain hasan shahih. Dalam riwayat selain Tirmidzi : “Hendaklah kamu selalu mengingat Allah, pasti kamu mendapati-Nya di hadapanmu. Hendaklah kamu mengingat Allah di waktu lapang (senang), niscaya Allah akan mengingat kamu di waktu sempit (susah). Ketahuilah bahwa apa yang semestinya tidak menimpa kamu, tidak akan menimpamu, dan apa yang semestinya menimpamu tidak akan terhindar darimu. Ketahuilah sesungguhnya kemenangan menyertai kesabaran dan sesungguhnya kesenangan menyertai kesusahan dan kesulitan”)"
        "\n\n"
        "[Tirmidzi no. 2516]";
    ins_isi = "Riwayat hidup ‘Abdullah bin ‘Abbas sudah banyak dikenal. Nabi Shallallahu ‘alaihi wa Sallam mendo’akannya dengan sabdanya :"
        "\n"
        "“Ya Allah, jadikanlah dia paham tentang agamanya dan ajarkanlah kepadanya penafsiran Al Qur’an”."
        "\n\n"
        "Nabi juga mendo’akannya agar diberi hikmah dua kali. Ada riwayat yang sah dari dirinya bahwa dia pernah melihat Jibril dua kali. Ia adalah ulama yang kaya ilmu di kalangan umat Islam. Rasulullah Shallallahu ‘alaihi wa Sallam melihatnya sebagai seorang anak yang patut menerima pesan beliau."
        "\n\n"
        "Nabi Shallallahu ‘alaihi wa Sallam bersabda kepadanya : “Jagalah Allah, niscaya Dia akan menjaga kamu”, maksudnya hendaklah kamu menjadi orang yang taat kepada Tuhanmu, melaksanakan semua perintah-Nya, dan menjauhi semua larangan-Nya."
        "\n\n"
        "Sabda Rasulullah Shallallahu ‘alaihi wa Sallam : “Jagalah Allah, niscaya kamu akan mendapati Dia di hadapanmu”, maksudnya hendaklah beramal karena-Nya dengan penuh ketaatan sehingga Allah tidak memandangmu sebagai orang yang menyalahi perintah-Nya, niscaya kamu akan mendapati Allah menjadi penolongmu di saat situasi sulit, seperti yang pernah terjadi pada kisah tiga orang yang tertimpa hujan lebat lalu mereka berlindung di dalam gua, kemudian pintu gua tertutup batu. Pada saat itu mereka berkata kepada sesamanya : “Ingatlah kebaikan yang pernah kamu lakukan, lalu mohonlah kepada Allah dengan kebaikan itu supaya kamu diselamatkan”. Kemudian masing-masing menyebut kebaikan yang pernah dilakukan, maka batu penutup gua itu kemudian terbuka lalu mereka dapat keluar. Kisah mereka ini popular dan terdapat pada Hadits shahih."
        "\n\n"
        "Sabda Nabi Shallallahu ‘alaihi wa Sallam : “Jika kamu minta, mintalah kepada Allah. Jika kamu minta tolong, mintalah tolong juga kepada Allah”, memberikan petunjuk supaya bertawakkal kepada Allah, tidak bertuhan kepada selain-Nya, tidak menggantungkan nasibnya kepada siapa pun baik sedikit ataupun banyak."
        "\n\n"
        "Allah berfirman :"
        "\n"
        "“Dan barang siapa bertawakkal kepada Allah maka Allah pasti akan memberinya kecukupan”. (QS. Ath Thalaq : 3)"
        "\n\n"
        "Berapa besar ketergantungan seseorang kepada selain Allah baik dalam hatinya maupun dalam angan-angannya, maka sebesar itu pula ia telah menjauhkan diri dari Allah untuk bergantung kepada sesuatu yang tidak kuasa memberinya manfaat atau kerugian. Begitu juga takut kepada selain Allah."
        "\n\n"
        "Dalam hal ini Rasulullah Shallallahu ‘alaihi wa Sallam menegaskan dengan sabdanya : “Ketahuilah, sekiranya semua umat berkumpul untuk memberikan kepadamu sesuatu keuntungan, maka hal itu tidak akan kamu peroleh selain dari apa yang sudah Allah tetapkan untuk dirimu”."
        "\n\n"
        "Begitu pula dalam hal kerugian, “niscaya tidak akan membahayakan kamu kecuali apa yang telah Allah tetapkan untuk dirimu”. Inilah yang disebut iman kepada taqdir."
        "\n\n"
        "Iman kepada taqdir adalah wajib, baik taqdir yang baik maupun yang buruk. Apabila seorang mukmin telah yakin dengan hal ini, maka apa perlunya dia meminta kepada selain Allah atau memohon pertolongan kepada yang lain. Begitu pula jawaban Nabi Muhammad Shallallahu ‘alaihi wa Sallam kepada malaikat Jibril ketika ia bertanya kepada beliau saat berada di langit (ketika mi’raj) : “Apakah engkau membutuhkan pertolongan?” Beliau menjawab : “Kalau kepadamu tidak”."
        "\n\n"
        "Sabda Nabi Shallallahu ‘alaihi wa Sallam : “Segenap pena telah diangkat dan lembaran-lembaran telah kering”, menguatkan keterangan tersebut diatas, maksudnya tidak berlawanan dengan apa yang telah dijelaskan sebelumnya."
        "\n\n"
        "Kemudian sabda beliau : “Ketahuilah sesungguhnya kemenangan menyertai kesabaran dan sesungguhnya kesenangan menyertai kesusahan dan kesulitan”, maksudnya beliau mengingatkan kepada manusia di dunia ini, terutama orang-orang shalih bahwa mereka itu selalu dihadapkan kepada ujian dan cobaan sebagaimana firman Allah :"
        "\n"
        "“Sungguh Kami pasti memberi cobaan kepada kamu sekalian dengan sesuatu berupa rasa takut, kelaparan, berkurangnya harta, jiwa dan buah-buahan. Dan gembirakanlah orang-orang yang bersabar, yaitu mereka yang bila ditimpa musibah, mereka berkata : ‘Sungguh kami semua adalah milik Allah dan sungguh hanya kepada-Nyalah kami kembali’. Mereka itulah orang-orang yang mendapatkan limpahan karunia dan rahmat dari Tuhan mereka dan mereka itulah orang-orang yang terpimpin”. (QS. 2 : 155-157)"
        "\n\n"
        "Allah berfirman :"
        "\n“Sesungguhnya orang-orang yang bersabar itu pastilah dipenuhi pahala mereka tanpa batas”. (QS. Az Zumar : 10)";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 20
    no=20;
    bookmark=0;
    ins_judul = "Anjuran Memiliki Rasa Malu";
    ins_arab = "عَنْ أَبيْ مَسْعُوْدٍ عُقبَة بنِ عَمْرٍو الأَنْصَارِيِّ البَدْرِيِّ رضي الله عنه قَالَ: قَالَ رَسُوْلُ اللهِ صلى الله عليه وسلم (إِنَّ مِمَّا أَدرَكَ النَاسُ مِن كَلاَمِ النُّبُوَّةِ الأُولَى إِذا لَم تَستَحْيِ فاصْنَعْ مَا شِئتَ) – رواه البخاري";
    ins_terjemahan = "Dari Abu Mas’ud, ‘Uqbah bin ‘Amr Al Anshari Al Badri radhiyallahu anhu, ia berkata : Rasulullah Shallallahu ‘alaihi wa Sallam telah bersabda : “Sesungguhnya diantara yang didapat manusia dari kalimat kenabian yang pertama ialah : Jika engkau tidak malu, berbuatlah sekehendakmu.” (HR. Bukhari)"
        "\n\n"
        "[Bukhari no. 3483]";
    ins_isi = "Sabdanya “kalimat kenabian yang pertama”, maksudnya ialah bahwa rasa malu selalu terpuji dan dipandang baik, selalu diperintahkan oleh setiap nabi dan tidak pernah dihapuskan dari syari’at para nabi sejak dahulu."
        "\n"
        "Sabda beliau : “berbuatlah sekehendakmu”, mengandung dua pengertian, yaitu : pertama, berarti ancaman dan peringatan keras, bukan merupakan perintah, sebagaimana sabda beliau : “Lakukanlah sesuka kamu”"
        "\n"
        "Yang juga berarti ancaman, sebab kepada mereka telah diajarkan apa yang harus ditinggalkan. Demikian juga sabda Nabi Shallallahu ‘alaihi wa Sallam : “Barang siapa yang menjual khamr maka hendaklah dia memotong-motong daging babi”."
        "\n\n"
        "Tidak berarti bahwa beliau membenarkan melakukan hal semacam itu."
        "\n\n"
        "Pengertian kedua ialah hendaklah melakukan apa saja yang kamu tidak malu melakukannya, seperti halnya sabda Nabi Shallallahu ‘alaihi wa Sallam : “Malu itu sebagian dari Iman”."
        "\n\n"
        "Maksud malu di sini adalah malu yang dapat menjauhkan dirinya dari perbuatan keji dan mendorongnya berbuat kebajikan. Demikian juga bila malu dapat mendorong seseorang meninggalkan perbuatan keji kemudian melakukan perbuatan-perbuatan baik, maka malu semacam ini sederajat dengan iman karena kesamaan pengaruhnya pada seseorang. Wallaahu a’lam.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 21
    no=21;
    bookmark=0;
    ins_judul = "Istiqomah";
    ins_arab = "عَنِ أَبيْ عَمْرٍو، وَقِيْلَ، أَبيْ عمْرَةَ سُفْيَانَ بنِ عَبْدِ اللهِ رضي الله عنه قَالَ: قُلْتُ يَارَسُوْلَ اللهِ قُلْ لِيْ فِي الإِسْلامِ قَوْلاً لاَ أَسْأَلُ عَنْهُ أَحَدَاً غَيْرَكَ؟ قَالَ: قُلْ آمَنْتُ باللهِ ثُمَّ استَقِمْ – رواه مسلم";
    ins_terjemahan = "Dari Abu ‘Amrah Sufyan bin ‘Abdullah radhiyallahu anhu, ia berkata : ” Aku telah berkata : ‘Wahai Rasulullah, katakanlah kepadaku tentang Islam, suatu perkataan yang aku tak akan dapat menanyakannya kepada seorang pun kecuali kepadamu’. Bersabdalah Rasululloh Shallallahu ‘alaihi wa Sallam : ‘Katakanlah : Aku telah beriman kepada Allah, kemudian beristiqamalah kamu’ “."
        "\n\n"
        "[Muslim no. 38]";
    ins_isi = "Kalimat “katakanlah kepadaku tentang Islam, suatu perkataan yang aku tak akan dapat menanyakannya kepada seorang pun kecuali kepadamu”, maksudnya adalah ajarkanlah kepadaku satu kalimat yang pendek, padat berisi tentang pengertian Islam yang mudah saya mengerti, sehingga saya tidak lagi perlu penjelasan orang lain untuk menjadi dasar saya beramal. Maka Rasulullah Shallallahu ‘alaihi wa Sallam menjawab : “Katakanlah : ‘Aku telah beriman kepada Allah, kemudian beristiqamalah kamu’ “. Ini adalah kalimat pendek, padat berisi yang Allah berikan kepada Rasulullah Shallallahu ‘alaihi wa Sallam."
        "\n\n"
        "Dalam dua kalimat ini telah terpenuhi pengertian iman dan Islam secara utuh. Beliau menyuruh orang tersebut untuk selalu memperbarui imannya dengan ucapan lisan dan mengingat di dalam hati, serta menyuruh dia secara teguh melaksanakan amal-amal shalih dan menjauhi semua dosa. Hal ini karena seseorang tidak dikatakan istiqamah jika ia menyimpang walaupun hanya sebentar. Hal ini sejalan dengan firman Allah : “Sesungguhnya mereka yang berkata : Allah adalah Tuhan kami kemudian mereka istiqamah……”.(QS. Fushshilat : 30)"
        "\n"
        "yaitu iman kepada Allah semata-mata kemudian hatinya tetap teguh pada keyakinannya itu dan taat kepada Allah sampai mati."
        "\n\n"
        "‘Umar bin khaththab berkata : “Mereka (para sahabat) istiqamah demi Allah dalam menaati Allah dan tidak sedikit pun mereka itu berpaling, sekalipun seperti berpalingnya musang”. Maksudnya, mereka lurus dan teguh dalam melaksanakan sebagian besar ketaatannya kepada Allah, baik dalam keyakinan, ucapan, maupun perbuatan dan mereka terus-menerus berbuat begitu (sampai mati). Demikianlah pendapat sebagian besar para musafir. Inilah makna hadits tersebut, Insya Allah."
        "\n"
        "Begitu pula firman Allah : “Maka hendaklah kamu beristiqamah seperti yang diperintahkan kepadamu”.(QS. Hud : 112)"
        "\n\n"
        "Menurut Ibnu ‘Abbas, tidak satu pun ayat Al Qur’an yang turun kepada Nabi Shallallahu ‘alaihi wa Sallam yang dirasakan lebih berat dari ayat ini. Oleh karena itu, Nabi Shallallahu ‘alaihi wa Sallam pernah bersabda :"
        "\n"
        "“Aku menjadi beruban karena turunnya Surat Hud dan sejenisnya”."
        "\n\n"
        "Abul Qasim Al Qusyairi berkata : “Istiqamah adalah satu tingkatan yang menjadi penyempurna dan pelengkap semua urusan. Dengan istiqamah, segala kebaikan dengan semua aturannya dapat diwujudkan. Orang yang tidak istiqamah di dalam melakukan usahanya, pasti sia-sia dan gagal”. Ia berkata pula : “Ada yang berpendapat bahwa istiqamah itu hanyalah bisa dijalankan oleh orang-orang besar, karena istiqamah adalah menyimpang dari kebiasaan, menyalahi adat dan kebiasaan sehari-hari, teguh di hadapan Allah dengan kesungguhan dan kejujuran. Oleh karena itu, Nabi Shallallahu ‘alaihi wa Sallam bersabda : ‘Istiqamahlah kamu sekalian, maka kamu akan selalu diperhitungkan orang’."
        "\n\n"
        "Al Washiti berkata : “Istiqamah adalah sifat yang dapat menyempurnakan kepribadian seseorang dan tidak adanya sifat ini rusaklah kepribadian seseorang”. Wallaahu a’lam.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 22
    no=22;
    bookmark=0;
    ins_judul = "Melaksanakan Syariat Islam Dengan Benar";
    ins_arab = "عَنْ أَبيْ عَبْدِ اللهِ جَابِرِ بنِ عَبْدِ اللهِ الأَنْصَارِيِّ رضي الله عنه أَنَّ رَجُلاً سَأَلَ النبي صلى الله عليه وسلم فَقَالَ: أَرَأَيتَ إِذا صَلَّيْتُ المَكْتُوبَاتِ، وَصُمْتُ رَمَضانَ، وَأَحلَلتُ الحَلاَلَ، وَحَرَّمْتُ الحَرَامَ، وَلَمْ أَزِدْ عَلى ذَلِكَ شَيئاً أَدخُلُ الجَنَّة؟ قَالَ: نَعَمْ – رواه مسلم";
    ins_terjemahan = "Dari Abu ‘Abdullah, Jabir bin ‘Abdullah Al Anshari radhiyallahu anhuma, sungguh ada seorang laki-laki bertanya kepada Rasululloh Shallallahu ‘alaihi wa Sallam : “Bagaimana pendapatmu jika aku melakukan shalat fardhu, puasa pada bulan Ramadhan, menghalalkan yang halal (melaksanakannya dengan penuh keyakinan), mengharamkan yang haram (menjauhinya) dan aku tidak menambahkan selain itu sedikit pun, apakah aku akan masuk surga?” Nabi Shallallahu ‘alaihi wa Sallam menjawab : ” Ya”"
        "\n\n"
        "[Muslim no. 15]";
    ins_isi = "Sahabat yang bertanya kepada Rasulullah Shallallahu ‘alaihi wa Sallam ini bernama Nu’man bin Qauqal Abu ‘Amr bin Shalah mengatakan bahwa secara zhahir yang dimaksud dengan perkataan “aku mengharamkan yang haram” mencakup dua hal, yaitu meyakini bahwa sesuatu itu benar-benar haram dan tidak melanggarnya. Hal ini berbeda dengan perkataan “menghalalkan yang halal”, yang mana cukup meyakini bahwa sesuatu benar-benar halal saja."
        "\n"
        "Pengarang kitab Al Mufhim mengatakan secara umum bahwa Nabi Shallallahu ‘alaihi wa Sallam tidak mengatakan kepada penanya di dalam Hadits ini sesuatu yang bersifat tathawwu’ (sunnah). Hal ini menunjukkan bahwa secara umum boleh meninggalkan yang sunnah. Akan tetapi, orang yang meninggalkan yang sunnah dan tidak mau melakukannya sedikit pun, maka ia tidak memperoleh keuntungan yang besar dan pahala yang banyak. Akan tetapi, barang siapa terus-menerus meninggalkan hal-hal yang sunnah, berarti telah berkurang bobot agamanya dan berkurang pula nilai kesungguhannya dalam beragama. Barang siapa meninggalkan yang sunnah karena sikap meremehkan atau membencinya, maka hal itu merupakan perbuatan fasik yang patut dicela."
        "\n\n"
        "Para ulama kita berpendapat : “Bila penduduk suatu negeri bersepakat meninggalkan hal yang sunnah, maka mereka itu boleh diperangi sampai mereka sadar. Hal ini karena pada masa sahabat dan sesudahnya, mereka sangat tekun melakukan perbuatan-perbuatan sunnah dan perbuatan-perbuatan yang dipandang utama untuk menyempurnakan perbuatan-perbuatan wajib. Mereka tidak membedakan antara yang sunnah dan yang fiqih dalam memperbanyak pahala. Para imam ahli fiqih perlu menjelaskan perbedaan antara sunnah dan wajib hanya untuk menjelaskan konsekuensi hukum antara yang sunnah dan yang wajib jika hal itu ditinggalkan. Rasulullah Shallallahu ‘alaihi wa Sallam tidak menjelaskan perbedaan sunnah dan wajib adalah untuk memudahkan dan melapangkan, karena kaum muslim masih baru dengan Islamnya sehingga dikhawatirkan membuat mereka lari dari Islam. Ketika telah diketahui kemantapannya di dalam Islam dan kerelaan hatinya berpegang kepada agama ini, barulah Nabi Shallallahu ‘alaihi wa Sallam menggalakkan perbuatan-perbuatan sunnah. Demikian juga dengan urusan yang lain. Atau dimaksudkan agar orang tidak beranggapan bahwa amalan tambahan dan amalan utama keduanya merupakan hal yang wajib, sehingga jika meninggalkan konsekuensinya sama. Sebagaimana yang diriwayatkan pada Hadits lain bahwa ada seorang sahabat bertanya kepada Nabi Shallallahu ‘alaihi wa Sallam tentang shalat, kemudian Nabi Shallallahu ‘alaihi wa Sallam memberitahukan bahwa shalat itu lima waktu. Lalu orang itu bertanya : “Apakah ada kewajiban bagiku selain itu?” Beliau menjawab : “Tidak, kecuali engkau melakukan (shalat yang lain) dengan kemauan sendiri”."
        "\n"
        "Orang itu kemudian bertanya tentanng puasa, haji dan beberapa hukum lain, lalu beliau jawab semuanya. Kemudian, di akhir pembicaraan orang itu berkata : “Demi Allah, aku tidak akan menambah atau mengurangi sedikitpun dari semua itu”. Nabi Shallallahu ‘alaihi wa Sallam lalu bersabda :"
        "\n"
        "“Dia akan beruntung jika benar”."
        "\n"
        "“Jika ia berpegang dengan apa yang telah diperintahkan kepadanya, niscaya ia masuk surga”."
        "\n"
        "Artinya, bila ia memelihara hal-hal yang diwajibkan, melaksanakan dan mengerjakan tepat pada waktunya, tanpa mengubahnya, maka dia mendapatkan keselamatan dan keberuntungan yang besar. Alangkah baiknya bila kita dapat berbuat seperti itu. Barang siapa dapat mengerjakan yang wajib lalu diiringi dengan yang sunnah, niscaya dia akan mendapatkan keberuntungan yang lebih besar."
        "\n\n"
        "Perbuatan sunnah yang disyari’atkan untuk menyempurnakan yang wajib. Sahabat yang bertanya tersebut dan sahabat lain sebelumnya, dibiarkan Nabi Shallallahu ‘alaihi wa Sallam dalam keadaan seperti itu untuk memberikan kemudahan kepada kedua orang itu sampai hatinya mantap dan terbuka memahaminya dengan baik serta memiliki semangat kuat untuk melaksanakan hal-hal yang sunnah, sehingga dirinya menjadi ringan melaksanakannya.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 23
    no=23;
    bookmark=0;
    ins_judul = "Suci Itu Bagian Dari Iman";
    ins_arab = "عَنْ أَبِي مَالِكٍ الحَارِثِ بنِ عَاصِم الأَشْعَرِيِّ رَضِيَ اللهُ عَنْهُ قَالَ: قَالَ رَسُولُ اللهِ صلى الله عليه وسلم: (الطُّهُورُ شَطْرُ الإِيْمَانِ، والحَمْدُ للهِ تَمْلأُ الميزانَ، وسُبْحَانَ اللهِ والحَمْدُ للهِ تَمْلآنِ – أَو تَمْلأُ – مَا بَيْنَ السَّمَاءِ والأَرْضِ، وَالصَّلاةُ نُورٌ، والصَّدَقَةُ بُرْهَانٌ، وَالصَّبْرُ ضِيَاءٌ، وَالقُرْآنُ حُجَّةٌ لَكَ أَو عَلَيْكَ، كُلُّ النَّاسِ يَغْدُو فَبَائِعٌ نَفْسَهُ فَمُعْتِقُهَا أَو مُوبِقُهَا) – رواه مسلم";
    ins_terjemahan = "Dari Abu Malik, Al Harits bin Al Asy’ari radhiyallahu ‘anhu, ia berkata : “Telah bersabda Rasulullah Shallallahu ‘alaihi wa Sallam : ‘Suci itu sebagian dari iman, (bacaan) alhamdulillaah memenuhi timbangan, (bacaan) subhaanallaah dan alhamdulillaah keduanya memenuhi ruang yang ada di antara langit dan bumi. Shalat itu adalah nur, shadaqah adalah pembela, sabar adalah cahaya, dan Al-Qur’an menjadi pembela kamu atau musuh kamu. Setiap manusia bekerja, lalu dia menjual dirinya, kemudian pekerjaan itu dapat menyelamatkannya atau mencelakakannya”."
        "\n\n"
        "[Muslim no. 223]";
    ins_isi = "Hadits ini memuat salah satu pokok Islam dan memuat salah satu dari kaidah penting Islam dan agama. Adapun yang dimaksud dengan kata “suci” ialah perbuatan bersuci."
        "\n"
        "Terdapat perbedaan pendapat tentang maksud kalimat “suci itu sebagian dari iman” yaitu: pahala suci merupakan sebagian dari pahala iman, sedangkan yang lain mengatakan bahwa yang dimaksud dengan iman di sini adalah shalat, sebagaimana firman Allah :"
        "\n"
        "“Allah tidak menyia-nyiakan iman (shalat) kamu”.(QS. 2: 143)"
        "\n"
        "Thaharah atau bersuci merupakan salah satu dari syarat sahnya shalat. Jadi, bersuci merupakan sebagian pekerjaan shalat. Kata “satrun” tidaklah mesti berarti betul-betul setengah, sekalipun ada yang berpendapat betul-betul setengah."
        "\n"
        "Sabda Nabi Shallallahu ‘alaihi wa Sallam “(bacaan) alhamdulillaah memenuhi timbangan”, maksudnya besar pahalanya memenuhi timbangan orang yang mengucapkannya. Dalam Al Qur’an dan Sunnah diterangkan tentang timbangan amal, berat dan ringannya. Begitu juga sabda Nabi Shallallahu ‘alaihi wa Sallam “(bacaan) subhaanallaah dan alhamdulillaah keduanya memenuhi ruang yang ada di antara langit dan bumi”. Hal ini karena besarnya keutamaan ucapan tersebut yang berisi menyucikan Allah dari segala sifat kekurangan dan cacat."
        "\n\n"
        "Sabda Nabi Shallallahu ‘alaihi wa Sallam “Shalat itu adalah nur “ maksudnya ialah shalat itu mencegah perbuatan maksiat, merintangi perbuatan-perbuatan keji dan mungkar, serta menunjukkan ke jalan yang benar, sebagaimana cahaya yang dijadikan orang sebagai penunjuk jalan. Sebagaian yang lain berpendapat bahwa yang dimaksudkan, shalat itu kelak akan menjadi petunjuk jalan bagi pelakunya di hari kiamat. Sedangkan sebagian yang lain lagi berpendapat bahwa shalat seseorang kelak akan menjadi cahaya yang memancar di wajahnya di hari kiamat, dan ketika di dunia menjadikan wajah pelakunya cemerlang, yang mana hal ini tidak diperoleh orang-orang yang tidak shalat. Wallaahu a’lam."
        "\n\n"
        "Tentang sabda Nabi Shallallahu ‘alaihi wa Sallam “ shadaqah adalah pembela ”, pengarang kitab At Tajrid mengatakan, maksudnya ialah dia akan membutuhkan pembelaan dari shadaqah (zakat)nya, sebagaimana ia membutuhkan pembelaan dengan berbagai bukti-bukti yang dapat menyelamatkannya dari hukuman. Seolah-olah seseorang jika kelak di hari kiamat dimintai tanggung jawab dalam membelanjakan hartanya, maka shadaqah (zakat)nya dapat menjadi pembela bagi dirinya dalam memberikan jawaban, misalnya ia berkata : “ Aku gunakan hartaku untuk membayar zakat ”."
        "\n"
        "Pendapat yang lain mengatakan bahwa maksudnya ialah shadaqah (zakat)nya menjadi bukti keimanan pelakunya. Hal ini karena orang munafik tidak mau mengeluarkan zakat karena tidak meyakininya. Barang siapa yang mengeluarkan zakat, hal itu menunjukkan kekuatan imannya. Wallaahu a’lam."
        "\n\n"
        "Sabda Nabi Shallallahu ‘alaihi wa Sallam “ sabar adalah cahaya ” maksudnya sabar itu sifat yang terpuji dalam agama, yaitu sabar dalam melaksanakan ketaatan dan dalam menjauhi kemaksiatan. Demikian juga sabar menghadapi hal yang tidak disenangi di dunia ini. Maksudnya, sabar itu sifat terpuji yang selalu membuat pelakunya memperoleh petunjuk untuk mendapatkan kebenaran."
        "\n\n"
        "Ibrahim Al Khawash berkata : “ Sabar yaitu teguh berpegang kepada Al Qur’an dan Sunnah ”. Ada yang berkata : “ Sabar yaitu teguh menghadapi segala macam cobaan dengan sikap dan perilaku yang baik ”."
        "\n\n"
        "Abu ‘Ali Ad Daqqaq berkata : “ Sabar yaitu sikap tidak mencela taqdir. Akan tetapi, sekedar menyatakan keluhan ketika menghadapi cobaan tidaklah dikatakan menyalahi sifat sabar ”. Allah berfirman tentang kasus Nabi Ayyub : “ Sungguh Kami mendapati dia seorang yang sabar, hamba yang sangat baik, dan orang yang suka bertobat ”. (QS. Shaad : 44) Padahal Nabi Ayyub pernah mengeluh dengan berkata : “ Sungguh bencana telah menimpaku dan Engkau (Ya Allah) adalah Tuhan yang paling berbelas kasih ”. (QS. Al Anbiya’ : 83)Wallaahu a’lam."
        "\n\n"
        "Sabda Nabi Shallallahu ‘alaihi wa Sallam “Al Qur’an menjadi pembela kamu atau musuh kamu” maksudnya jelas, yaitu bermanfaat jika kamu baca dan kamu amalkan, tetapi jika tidak, akan menjadi musuh kamu."
        "\n\n"
        "Sabda Nabi Shallallahu ‘alaihi wa Sallam “Setiap manusia bekerja, lalu dia menjual dirinya, kemudian pekerjaan itu dapat menyelamatkannya atau mencelakakannya” maksudnya setiap orang bekerja untuk dirinya. Ada orang yang menjual dirinya kepada Allah dengan berbuat ketaatan kepada-Nya sehingga dirinya selamat dari adzab, seperti Allah firmankan : “Sungguh Allah membeli dari orang-orang mukmin jiwa dan harta mereka, sehingga mereka mendapatkan surga”. (QS. 9 : 111)"
        "\n"
        "Ada orang yang menjual dirinya kepada setan dan hawa nafsunya dengan mengikuti bisikan-bisikannya sehingga dirinya menjadi celaka. Ya Allah, berilah kami taufiq untuk melakukan amal ketaatan kepada-Mu dan jauhkanlah kami sehingga diri kami dapat terjauh dari perbuatan-perbuatan melawan perintah-Mu.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 24
    no=24;
    bookmark=0;
    ins_judul = "Haramnya Berbuat Zalim";
    ins_arab = "عَنْ أَبي ذرٍّ الغِفَارْي رضي الله عنه عَن النبي صلى الله عليه وسلم فيمَا يَرْويه عَنْ رَبِِّهِ عزَّ وجل أَنَّهُ قَالَ: (يَا عِبَادِيْ إِنِّيْ حَرَّمْتُ الظُّلْمَ عَلَى نَفْسِيْ وَجَعَلْتُهُ بَيْنَكُمْ مُحَرَّمَاً فَلا تَظَالَمُوْا، يَا عِبَادِيْ كُلُّكُمْ ضَالٌّ إِلاَّ مَنْ هَدَيْتُهُ فَاسْتَهْدُوْنِي أَهْدِكُمْ، يَاعِبَادِيْ كُلُّكُمْ جَائِعٌ إِلاَّ مَنْ أَطْعَمْتُهُ فاَسْتَطْعِمُونِي أُطْعِمْكُمْ، يَا عِبَادِيْ كُلُّكُمْ عَارٍ إِلاَّ مَنْ كَسَوْتُهُ فَاسْتَكْسُوْنِيْ أَكْسُكُمْ، يَا عِبَادِيْ إِنَّكُمْ تُخْطِئُوْنَ بِاللَّيْلِ وَالنَّهَارِ وَأَنَا أَغْفِرُ الذُّنُوْبَ جَمِيْعَاً فَاسْتَغْفِرُوْنِيْ أَغْفِرْ لَكُمْ، يَا عِبَادِيْ إِنَّكُمْ لَنْ تَبْلُغُوْا ضَرِّيْ فَتَضُرُّوْنِيْ وَلَنْ تَبْلُغُوْا نَفْعِيْ فَتَنْفَعُوْنِيْ، يَاعِبَادِيْ لَوْ أَنَّ أَوَّلَكُمْ وَآخِرَكُمْ وَإِنْسَكُمْ وَجِنَّكُمْ كَانُوْا عَلَى أَتْقَى قَلْبِ رَجُلٍ وَاحِدٍ مِنْكُمْ مَا زَادَ ذَلِكَ فَيْ مُلْكِيْ شَيْئَاً. يَا عِبَادِيْ لَوْ أَنَّ أَوَّلَكُمْ وَآخِرَكُمْ وَإِنْسَكُمْ وَجِنَّكُمْ كَانُوْا عَلَى أَفْجَرِ قَلْبِ رَجُلٍ وَاحِدٍ مِنْكُمْ مَا نَقَصَ ذَلِكَ مِنْ مُلْكِيْ شَيْئَاً، يَا عِبَادِيْ لَوْ أنَّ أَوَّلَكُمْ وَآخِرَكُمْ وَإنْسَكُمْ وَجِنَّكُمْ قَامُوْا فِيْ صَعِيْدٍ وَاحِدٍ فَسَأَلُوْنِيْ فَأَعْطَيْتُ كُلَّ وَاحِدٍ مَسْأَلَتَهُ مَا نَقَصَ ذَلِكَ مِمَّا عِنْدِيْ إِلاَّ كَمَا يَنْقُصُ المِخْيَطُ إَذَا أُدْخِلَ البَحْرَ، يَا عِبَادِيْ إِنَّمَا هِيَ أَعْمَالُكُمْ أُحْصِيْهَا لَكُمْ ثُمَّ أُوَفِّيْكُمْ إِيَّاهَا فَمَنْ وَجَدَ خَيْرَاً فَليَحْمَدِ اللهَ وَمَنْ وَجَدَ غَيْرَ ذَلِكَ فَلاَ يَلُوْمَنَّ إِلاَّ نَفْسَهُ) – رواه مسلم";
    ins_terjemahan = "Dari Abu Dzar Al-Ghifari radhiyallahu anhu, dari Nabi Shallallahu ‘alaihi wa Sallam, beliau meriwayatkan dari Allah ‘azza wa Jalla, sesungguhnya Allah telah berfirman: “Wahai hamba-Ku, sesungguhnya Aku mengharamkan (berlaku) zhalim atas diri-Ku dan Aku menjadikannya di antaramu haram, maka janganlah kamu saling menzhalimi. Wahai hamba-Ku, kamu semua sesat kecuali orang yang telah Kami beri petunjuk, maka hendaklah kamu minta petunjuk kepada-Ku, pasti Aku memberinya. Kamu semua adalah orang yang lapar, kecuali orang yang Aku beri makan, maka hendaklah kamu minta makan kepada-Ku, pasti Aku memberinya. Wahai hamba-Ku, kamu semua asalnya telanjang, kecuali yang telah Aku beri pakaian, maka hendaklah kamu minta pakaian kepada-Ku, pasti Aku memberinya. Wahai hamba-Ku, sesungguhnya kamu melakukan perbuatan dosa di waktu siang dan malam, dan Aku mengampuni dosa-dosa itu semuanya, maka mintalah ampun kepada-Ku , pasti Aku mengampuni kamu. Wahai hamba-Ku, sesungguhnya kamu tidak akan dapat membinasakan Aku dan kamu tak akan dapat memberikan manfaat kepada Aku. Wahai hamba-Ku, kalau orang-orang terdahulu dan yang terakhir diantaramu, sekalian manusia dan jin, mereka itu bertaqwa seperti orang yang paling bertaqwa di antaramu, tidak akan menambah kekuasaan-Ku sedikit pun, jika orang-orang yang terdahulu dan yang terakhir di antaramu, sekalian manusia dan jin, mereka itu berhati jahat seperti orang yang paling jahat di antara kamu, tidak akan mengurangi kekuasaan-Ku sedikit pun juga. Wahai hamba-Ku, jika orang-orang terdahulu dan yang terakhir di antaramu, sekalian manusia dan jin yang tinggal di bumi ini meminta kepada-Ku, lalu Aku memenuhi seluruh permintaan mereka, tidaklah hal itu mengurangi apa yang ada pada-Ku, kecuali sebagaimana sebatang jarum yang dimasukkan ke laut. Wahai hamba-Ku, sesungguhnya itu semua adalah amal perbuatanmu. Aku catat semuanya untukmu, kemudian Kami membalasnya. Maka barang siapa yang mendapatkan kebaikan, hendaklah bersyukur kepada Allah dan barang siapa mendapatkan selain dari itu, maka janganlah sekali-kali ia menyalahkan kecuali dirinya sendiri”."
        "\n\n"
        "[Muslim no. 2577]";
    ins_isi = "Kalimat “sesungguhnya Aku mengharamkan (berlaku) zhalim atas diri-Ku dan Aku menjadikannya di antaramu haram”, sebagian ulama mengatakan maksudnya ialah Allah tidak patut dan tidak akan berbuat zhalim seperti tersebut pada firman-Nya :"
        "\n"
        "“ Tidak patut bagi Tuhan yang Maha Pemurah mengambil anak ”. (QS. 19 : 92)"
        "\n"
        "Jadi, zhalim bagi Allah adalah sesuatu yang mustahil. Sebagian lain berpendapat , maksudnya ialah seseorang tidak boleh meminta kepada Allah untuk menghukum musuhnya atas namanya kecuali dalam hal yang benar, seperti tersebut dalam firman-Nya dalam Hadits di atas : “Sungguh Aku mengharamkan diri-Ku untuk berbuat zhalim”. Jadi, Allah tidak akan berbuat zhalim kepada hamba-Nya. Oleh karena itu, bagaimana orang bisa mempunyai anggapan bahwa Allah berbuat zhalim kepada hamba-hamba-Nya untuk kepentingan tertentu?"
        "\n\n"
        "Begitu pula kalimat “janganlah kamu saling menzhalimi” maksudnya bahwa janganlah orang yang dizhalimi membalas orang yang menzhaliminya."
        "\n\n"
        "Dan kalimat “Wahai hamba-Ku, kamu semua sesat kecuali orang yang telah Kami beri petunjuk, maka hendaklah kamu minta petunjuk kepada-Ku, pasti Aku memberinya”, mengingat betapa kita ini lemah dan fakir untuk memenuhi kepentingan kita dan untuk melenyapkan gangguan-gangguan terhadap diri kita kecuali dengan pertolongan Allah semata. Makna ini berpangkal pada pengertian kalimat : “Tiada daya dan kekuatan kecuali dengan pertolongan Allah”. (QS. 18 : 39)"
        "\n\n"
        "Hendaklah orang menyadari bila ia melihat adanya nikmat pada dirinya, maka semua itu dari Allah dan Allah lah yang memberikan kepadanya. Hendaklah ia juga bersyukur kepada Allah, dan setiap kali nikmat itu bertambah, hendaklah ia bertambah juga dalam memuji dan bersyukur kepada Allah."
        "\n\n"
        "Kalimat “maka hendaklah kamu minta petunjuk kepada-Ku, pasti Aku memberinya” yaitu mintalah petunjuk kepada-Ku, niscaya Aku memberi petunjuk kepadamu. Kalimat ini hendaknya membuat hamba menyadari bahwa seharusnyalah ia meminta hidayah kepada Tuhannya, sehingga Dia memberinya hidayah. Sekiranya dia diberi hidayah sebelum meminta, barangkali dia akan berkata : “Semua yang aku dapat ini adalah karena pengetahuan yang aku miliki”."
        "\n\n"
        "Begitu pula kalimat “kamu semua adalah orang yang lapar, kecuali orang yang Aku beri makan, maka hendaklah kamu minta makan kepada-Ku, pasti Aku memberinya”, maksudnya ialah Allah menciptakan semua makhluk-Nya berkebutuhan kepada makanan, setiap orang yang makan niscaya akan lapar kembali sampai Allah memberinya makan dengan mendatangkan rezeki kepadanya, menyiapkan alat-alat yang diperlukannya untuk dapat makan. Oleh karena itu, orang yang kaya jangan beranggapan bahwa rezeki yang ada di tangannya dan makanan yang disuapkan ke mulutnya diberikan kepadanya oleh selain Allah. Hadits ini juga mengandung adab kesopanan berperilaku kepada orang fakir. Seolah-olah Allah berfirman : “Janganlah kamu meminta makanan kepada selain Aku, karena orang-orang yang kamu mintai itu mendapatkan makanan dari Aku. Oleh karena itu, hendaklah kamu minta makan kepada-Ku, niscaya Aku akan memberikannya kepada kamu”. Begitu juga dengan kalimat selanjutnya."
        "\n\n"
        "Kalimat “sesungguhnya kamu melakukan perbuatan dosa di waktu siang dan malam”. Kalimat semacam ini merupakan nada celaan yang seharusnya setiap mukmin malu terhadap celaan ini. Demikian pula bahwa sesungguhnya Allah menciptakan malam sebagai waktu untuk berbuat ketaatan dan menyiapkan diri berbuat ikhlas, karena pada malam hari itulah pada umumnya orang beramal jauh dari sifat riya’ dan nifaq. Oleh karena itu, tidaklah seorang mukmin merasa malu bila tidak menggunakan waktu malam hari untuk beramal karena pada waktu tersebut umumnya orang beramal jauh dari sifat riya’ dan nifaq. Tidaklah pula seorang mukmin merasa malu bila tidak menggunakan malam dan siang untuk beramal karena kedua waktu itu diciptakan menjadi saksi bagi manusia sehingga setiap orang yang berakal sepatutnya taat kepada Allah dan tidak tolong-menolong dalam perbuatan menyalahi perintah Allah."
        "\n\n"
        "Bagaimana seorang mukmin patut berbuat dosa terang-terangan atau tersembunyi padahal Allah telah menyatakan “Aku mengampuni semua dosa”. Disebutkannya dengan kata “semua dosa” adalah karena hal itu dinyatakan sebelum adanya perintah kepada kita untuk memohon ampun, agar tidak seorang pun merasa putus asa dan pengampunan Allah karena dosa yang dilakukannya sudah banyak."
        "\n\n"
        "Kalimat “kalau orang-orang terdahulu dan yang terakhir diantaramu, sekalian manusia dan jin, mereka itu bertaqwa seperti orang yang paling bertaqwa di antaramu, tidak akan menambah kekuasaan-Ku sedikit pun” menunjukkan bahwa ketaqwaan seseorang kepada Allah itu adalah rahmat bagi mereka. Hal itu tidak menambah kekuasaan Allah sedikit pun."
        "\n\n"
        "Kalimat “jika orang-orang terdahulu dan yang terakhir di antaramu, sekalian manusia dan jin yang tinggal di bumi ini meminta kepada-Ku, lalu Aku memenuhi seluruh permintaan mereka, tidaklah hal itu mengurangi apa yang ada pada-Ku, kecuali sebagaimana sebatang jarum yang dimasukkan ke laut”, berisikan peringatan kepada segenap makhluk agar mereka banyak-banyak meminta dan tidak seorang pun membatasi dirinya dalam meminta dan tidak seorang pun membatasi dirinya dalam meminta karena milik Allah tidak akan berkurang sedikit pun, perbendaharaan-Nya tidak akan habis, sehingga tidak ada seorang pun patut beranggapan bahwa apa yang ada di sisi Allah menjadi berkurang karena diberikan kepada hamba-Nya, sebagaimana disabdakan"
        "\n"
        "Rasulullah Shallallahu ‘alaihi wa Sallam pada Hadits lain : “Tangan Allah itu penuh, tidak menjadi berkurang perbendaraan yang dikeluarkan sepanjang malam dan siang. Tidakkah engkau pikirkan apa yang telah Allah belanjakan sejak mula mencipta langit dan bumi. Sesungguhnya Allah tidak pernah kehabisan apa yang ada di tangan kanannya”."
        "\n\n"
        "Rahasia dari perkataan ini ialah bahwa kekuasaan-Nya mampu mencipta selama-lamanya, sama sekali Dia tidak patut disentuh oleh kelemahan dan kekurangan. Segala kemungkinan senantiasa tidak terbatas atau terhenti. Kalimat “kecuali sebagaimana sebatang jarum yang dimasukkan ke laut” ini adalah kalimat perumpamaan untuk memudahkan memahami persoalan tersebut dengan cara mengemukakan hal yang dapat kita saksikan dengan nyata. Maksudnya ialah kekayaan yang ada di tangan Allah itu sedikit pun tidak akan berkurang."
        "\n\n"
        "Kalimat “sesungguhnya itu semua adalah amal perbuatanmu. Aku catat semuanya untukmu, kemudian Kami membalasnya. Maka barang siapa yang mendapatkan kebaikan, hendaklah bersyukur kepada Allah” maksudnya janganlah orang beranggapan bahwa ketaatan dan ibadahnya merupakan hasil usahanya sendiri, tetapi hendaklah ia menyadari bahwa hal ini merupakan pertolongan dari Allah dan karena itu hendaklah ia bersyukur kepada Allah."
        "\n\n"
        "Kalimat “dan barang siapa mendapatkan selain dari itu”. Di sini tidak digunakan kalimat “mendapati kejahatan (keburukan)”, maksudnya barang siapa yang menemukan sesuatu yang tidak baik, maka hendaklah ia mencela dirinya sendiri."
        "\n"
        "Penggunaan kata penegasan dengan “janganlah sekali-kali” merupakan peringatan agar jangan sampai terlintas di dalam hati orang yang mendapati sesuatu yang tidak baik ada keinginan menyalahkan orang lain, tetapi hendaklah ia menyalahkan dirinya sendiri. Wallaahu a’lam.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    ///////////////// 25
    no=25;
    bookmark=0;
    ins_judul = "Shadaqah";
    ins_arab = "عَنْ أَبي ذَرٍّ رضي الله عنه أَيضَاً أَنَّ أُنَاسَاً مِنْ أَصحَابِ رَسُولِ اللهِ صلى الله عليه وسلم قَالوا للنَّبي صلى الله عليه وسلم يَارَسُولَ الله: ذَهَبَ أَهلُ الدثورِ بِالأُجورِ، يُصَلُّوْنَ كَمَا نُصَلِّيْ، وَيَصُوْمُوْنَ كَمَا نَصُوْمُ، وَيَتَصَدَّقُوْنَ بفُضُوْلِ أَمْوَالِهِمْ، قَالَ: (أَوَ لَيْسَ قَدْ جَعَلَ اللهُ لَكُمْ مَا تَصَّدَّقُوْنَ؟ إِنَّ بِكُلِّ تَسْبِيْحَةٍ صَدَقَة. وَكُلِّ تَكْبِيْرَةٍ صَدَقَةً وَكُلِّ تَحْمَيْدَةٍ صَدَقَةً وَكُلِّ تَهْلِيْلَةٍ صَدَقَةٌ وَأَمْرٌ بالِمَعْرُوْفٍ صَدَقَةٌ وَنَهْيٌ عَنْ مُنْكَرٍ صَدَقَةٌ وَفِيْ بُضْعِ أَحَدِكُمْ صَدَقَةٌ قَالُوا: يَا رَسُوْلَ اللهِ أَيَأْتِيْ أَحَدُنَا شَهْوَتَهُ وَيَكُوْنُ لَهُ فِيْهَا أَجْرٌ؟ قَالَ: أَرَأَيْتُمْ لَوْ وَضَعَهَا فَيْ حَرَامٍ أَكَانَ عَلَيْهِ وِزْرٌ؟ فَكَذَلِكَ إِذَا وَضَعَهَا فَي الحَلالِ كَانَ لَهُ أَجْرٌ) – رَوَاهُ مُسْلِمٌ";
    ins_terjemahan = "Dari Abu Dzar radhiallahu ‘anhu, dari Nabi Shallallahu ‘alaihi wa Sallam, ia berkata: Sesungguhnya sebagian dari para sahabat Rasulullah Shallallahu ‘alaihi wa Sallam berkata kepada Nabi Shallallahu ‘alaihi wa Sallam : “Wahai Rasulullah, orang-orang kaya lebih banyak mendapat pahala, mereka mengerjakan shalat sebagaimana kami shalat, mereka berpuasa sebagaimana kami berpuasa, dan mereka bershadaqah dengan kelebihan harta mereka”. Nabi bersabda : “Bukankah Allah telah menjadikan bagi kamu sesuatu untuk bershadaqah ? Sesungguhnya tiap-tiap tasbih adalah shadaqah, tiap-tiap tahmid adalah shadaqah, tiap-tiap tahlil adalah shadaqah, menyuruh kepada kebaikan adalah shadaqah, mencegah kemungkaran adalah shadaqah dan persetubuhan salah seorang di antara kamu (dengan istrinya) adalah shadaqah “. Mereka bertanya : “ Wahai Rasulullah, apakah (jika) salah seorang di antara kami memenuhi syahwatnya, ia mendapat pahala?” Rasulullah Shallallahu ‘alaihi wa Sallam menjawab : “Tahukah engkau jika seseorang memenuhi syahwatnya pada yang haram, dia berdosa, demikian pula jika ia memenuhi syahwatnya itu pada yang halal, ia mendapat pahala”."
        "\n\n"
        "[Muslim no. 1006]";
    ins_isi = "Hadits ini menerangkan keutamaan tasbih dan semua macam dzikir, amar ma’ruf nahi mungkar, berniat karena Allah dalam hal-hal mubah, karena semua perbuatan dinilai sebagai ibadah bila dengan niat yang ikhlas. Hadits ini juga menunjukkan dibenarkannya seseorang bertanya tentang sesuatu yang tidak diketahuinya kepada orang yang berilmu, bila ia mengetahui bahwa orang yang ditanya itu menunjukkan sikap senang terhadap permasalahan yang ditanyakan dan tidak dilakukan dengan cara yang buruk, dan orang yang berilmu akan menerangkan kepadanya apa yang tidak diketahuinya itu."
        "\n\n"
        "Sabda Nabi Shallallahu ‘alaihi wa Sallam “menyuruh kepada kebaikan adalah shadaqah, mencegah kemungkaran adalah shadaqah” menyatakan pengakuan bahwa setiap orang yan melakukan amar ma’ruf dan nahi mungkar dipandang melakukan shadaqah, yang hal ini akan memperjelas makna tasbih dan hal-hal yang disebut sebelumnya, karena amar ma’ruf dan nahi mungkar adalah fardhu kifayah, sekalipun bisa juga menjadi fardhu ‘ain. Berbeda halnya dengan dzikir yang merupakan perbuatan sunnah, pahala atas perbuatan wajib lebih banyak daripada perbuatan sunnah, seperti yang disebutkan dalam sebuah Hadits Qudsi yang diriwayatkan oleh Bukhari, Allah berfirman : “Tidaklah hamba-Ku mendekatkan diri kepada-Ku dengan perbuatan yang Aku cintai yang Aku wajibkan kepadanya”."
        "\n\n"
        "Sebagian ulama berkata : “Pahala atas perbuatan wajib tujuh puluh derajat di atas perbuatan sunnah, berdasarkan suatu Hadits”."
        "\n\n"
        "Sabda Nabi Shallallahu ‘alaihi wa Sallam “persetubuhan salah seorang di antara kamu (dengan istrinya) adalah shadaqah “. Telah disebutkan di atas bahwa perbuatan-perbuatan mubah yang dilakukan dengan niat menaati aturan Allah adalah shadaqah. Jadi, persetubuhan dinilai sebagai ibadah apabila diniatkan oleh seseorang untuk memenuhi hak dan kewajiban suami istri secara ma’ruf atau untuk mendapatkan anak yang shalih atau menjauhkan diri dari zina atau untuk tujuan-tujuan baik lainnya."
        "\n\n"
        "Pertanyaan shahabat : “Wahai Rasulullah, apakah (jika) salah seorang di antara kami memenuhi syahwatnya, ia mendapat pahala?” Rasulullah Shallallahu ‘alaihi wa Sallam menjawab : “Tahukah engkau jika seseorang memenuhi syahwatnya pada yang haram, dia berdosa, demikian pula jika ia memenuhi syahwatnya itu pada yang halal, ia mendapat pahala” mengandung isyarat dibenarkannya melakukan qiyas dalam hukum. Demikianlah pendapat para ulama pada umumnya kecuali aliran Zhahiri."
        "\n\n"
        "Tentang riwayat yang diperoleh dari para tabi’in dan lain-lain mengenai celaan terhadap qiyas dalam hukum, maka yang dimaksud bukanlah qiyas yang populer dikenal oleh para ahli fiqih mujtahid. Qiyas yang dimaksud adalah qiyasul ‘aksi (qiyas sebaliknya, atau mafhum mukhalafah). Para ahli ushul berbeda pendapat dalam mempraktekkan qiyas ini, tetapi Hadits di atas mendukung pendapat yang menjadikan qiyas ini sebagai satu cara menetapkan hukum.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");


    ///////////////// 26
    no=26;
    bookmark=0;
    ins_judul = "Perbuatan Baik Adalah Shadaqah";
    ins_arab = "عَنْ أَبِي هُرَيْرَةَ رضي الله عنه قَالَ: قَالَ رَسُولُ اللهِ صلى الله عليه وسلم: ( كُلُّ سُلامَى مِنَ النَّاسِ عَلَيْهِ صَدَقَةٌ كُلُّ يَومٍ تَطْلُعُ فِيْهِ الشَّمْسُ: تَعْدِلُ بَيْنَ اثْنَيْنِ صَدَقَةٌ، وَتُعِيْنُ الرَّجُلَ في دَابَّتِهِ فَتَحْمِلُ لَهُ عَلَيْهَا أَو تَرْفَعُ لَهُ عَلَيْهَا مَتَاعَهُ صَدَقَةٌ، وَالكَلِمَةُ الطَّيِّبَةُ صَدَقَةٌ، وَبِكُلِّ خُطْوَةٍ تَمْشِيْهَا إِلَى الصَّلاةِ صَدَقَةٌ، وَتُمِيْطُ الأَذى عَنِ الطَّرِيْقِ صَدَقَةٌ ) – رواه البخاري ومسلم";
    ins_terjemahan = "Dari Abu Hurairah radhiyallahu ‘anhu, ia berkata : “Telah bersabda Rasulullah Shallallahu ‘alaihi wa Sallam : ‘Setiap anggota badan manusia diwajibkan bershadaqah setiap hari selama matahari masih terbit. Kamu mendamaikan antara dua orang (yang berselisih) adalah shadaqah, kamu menolong seseorang naik ke atas kendaraannya atau mengangkat barang-barangnya ke atas kendaraannya adalah shadaqah, berkata yang baik itu adalah shadaqah, setiap langkah berjalan untuk shalat adalah shadaqah, dan menyingkirkan suatu rintangan dari jalan adalah shadaqah ”."
        "\n\n"
        "[Bukhari no. 2989, Muslim no. 1009]";
    ins_isi = "Dalam shahih Muslim disebut jumlah anggota badan ada tiga ratus enam puluh. Qadhi ‘Iyadh berkata : “Pada asalnya kata “sulaama” bermakna tulang, telapak tangan, jari-jari dan kaki, kemudian kata tersebut biasa dipakai dengan arti seluruh anggota badan”."
        "\n"
        "Sebagian ulama berkata : “Yang dimaksud di sini adalah shadaqah anjuran atau peringatan, bukan berarti shadaqah yang wajib. Sabda beliau “kamu mendamaikan antara dua orang (yang berselisih) adalah shadaqah” yaitu mendamaikan keduanya secara adil."
        "\n\n"
        "Pada Hadits lain riwayat Muslim disebutkan :"
        "\n"
        "“Setiap anggota badan dari seseorang di antara kamu dapat berbuat shadaqah. Setiap tasbih adalah shadaqah, setiap tahmid adalah shadaqah, setiap tahlil adalah shadaqah, setiap takbir adalah shadaqah, amar ma’ruf adalah shadaqah, tetapi semuanya itu bisa dicukupkan dengan (melakukan) dua raka’at shalat Dhuha”."
        "\n\n"
        "Maksudnya, semua shadaqah yang dilakukan oleh anggota badan tersebut dapat diganti dengan dua raka’at shalat Dhuha, karena shalat merupakan kerja dari semua anggota badan. Jika seseorang shalat, maka seluruh anggota badannya menjalankan fungsinya masing-masing. Wallahu a’lam.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");


    ///////////////// 27
    no=27;
    bookmark=0;
    ins_judul = "Menjauhi Perbuatan Meresahkan";
    ins_arab = "عَنْ النَّوَّاسِ بْنِ سَمْعَانَ – رضي الله عنه – عَنْ النَّبِيِّ – صلى الله عليه وسلم – قَالَ: ( الْبِرُّ حُسْنُ الْخُلُقِ، وَالْإِثْمُ مَا حَاكَ فِي صَدْرِك، وَكَرِهْت أَنْ يَطَّلِعَ عَلَيْهِ النَّاسُ ) رَوَاهُ مُسْلِمٌ . وَعَنْ وَابِصَةَ بْنِ مَعْبَدٍ – رضي الله عنه – قَالَ: أَتَيْت رَسُولَ اللَّهِ – صلى الله عليه وسلم – فَقَالَ: ( جِئْتَ تَسْأَلُ عَنْ الْبِرِّ؟ قُلْت: نَعَمْ. فقَالَ: استفت قلبك، الْبِرُّ مَا اطْمَأَنَّتْ إلَيْهِ النَّفْسُ، وَاطْمَأَنَّ إلَيْهِ الْقَلْبُ، وَالْإِثْمُ مَا حَاكَ فِي النَّفْسِ وَتَرَدَّدَ فِي الصَّدْرِ، وَإِنْ أَفْتَاك النَّاسُ وَأَفْتَوْك ) . حَدِيثٌ حَسَنٌ، رَوَيْنَاهُ في مُسْنَدَي الْإِمَامَيْنِ أَحْمَدَ بْنِ حَنْبَلٍ وَالدَّارِمِيّ بِإِسْنَادٍ حَسَنٍ";
    ins_terjemahan = "Dari An Nawas bin Sam’an radhiyallahu anhu, dari Nabi Shallallahu ‘alaihi wa Sallam, beliau bersabda: “Kebajikan itu keluhuran akhlaq sedangkan dosa adalah apa-apa yang dirimu merasa ragu-ragu dan kamu tidak suka jika orang lain mengetahuinya”. (HR. Muslim)"
        "\n"
        "Dan dari Wabishah bin Ma’bad radhiyallahu anhu, ia berkata : “Aku telah datang kepada Rasulullah Shallallahu ‘alaihi wa Sallam, lalu beliau bersabda : ‘Apakah engkau datang untuk bertanya tentang kebajikan ?’ Aku menjawab : ‘Benar’. Beliau bersabda : ‘Mintalah fatwa dari hatimu. Kebajikan itu adalah apa-apa yang menentramkan jiwa dan menenangkan hati dan dosa itu adalah apa-apa yang meragukan jiwa dan meresahkan hati, walaupun orang-orang memberikan fatwa kepadamu dan mereka membenarkannya”. (HR. Imam Ahmad bin Hanbal dan Ad-Darimi, Hadits hasan)"
        "\n\n"
        "[Imam Ahmad bin Hanbal no. 4/227, Ad-Darimi no. 2/246]";
    ins_isi = "Sabda beliau “Kebajikan itu keluhuran akhlaq”, maksudnya ialah bahwa keluhuran akhlaq adalah sebaik-baik kebajikan, sebagaimana sabda beliau “Haji adalah Arafah”. Adapun kebajikan adalah perbuatan yang menjadikan pelakunya menjadi baik, selalu berupaya mengikuti orang-orang yang berbuat baik, dan taat kepada Allah yang Maha Mulia lagi Maha Tinggi."
        "\n\n"
        "Yang dimaksud dengan berakhlaq baik yaitu jujur dalam bermuamalah, santun dalam berusaha, adil dalam hukum, bersungguh-sungguh dalam berbuat kebajikan, dan beberapa sifat orang-orang mukmin yang Allah sebutkan di dalam surah Al Anfal :"
        "\n"
        "“Orang-orang mukmin yaitu orang-orang yang ketika nama Allah disebut, hati mereka gemetar, dan ketika ayat-ayat-Nya dibacakan kepada mereka, iman mereka bertambah, dan hanya kepada Tuhanlah mereka bertawakkal. (Yaitu) mereka yang melaksanakan shalat dan mengeluarkan infaq dari sebagian harta yang Kami berikan kepada mereka. Mereka itulah orang-orang yang benar-benar mukmin”. (QS. 8 : 2-4)"
        "\n\n"
        "Dan firman-Nya :"
        "\n"
        "“Orang-orang yang bertobat, yang beribadah, yang memuji (Allah), yang mengembara (di jalan Allah), yang ruku’, yang sujud, yang menyuruh berbuat ma’ruf dan mencegah berbuat mungkar, serta yang memelihara hukum-hukum Allah. Dan gembirakanlah orang-orang mukmin itu”. (QS. 9 : 112)"
        "\n\n"
        "Dan firman-Nya :"
        "\n"
        "“Sungguh beruntung orang-orang mukmin. (Yaitu) orang-orang yang khusyu’ dalam shalatnya dan orang-orang yang menunaikan zakat dan orang-orang yang menjaga kemaluannya, kecuali terhadap istri-istri mereka atau terhadap budak yang mereka miliki, maka sesungguhnya mereka dalam hal ini tiada tercela. Barang siapa mencari selain dari itu, maka mereka itulah orang-orang yang melampaui batas. Dan orang-orang yang memeliharaa amanat-amanat (yang diberikan kepadanya) dan janjinya dan orang-orang yang akan mewarisi (Yaitu) mewarisi (surga) firdaus, mereka kekal di dalamnya”. (QS. 23 : 1-10)"
        "\n\n"
        "Dan firman-Nya :"
        "\n"
        "“Hamba-hamba Tuhan yang Maha Pengasih adalah mereka yang berjalan di atas bumi dengan rasa rendah hati dan apabila orang-orang jahil menyapa mereka, mereka menanggapinya dengan kata-kata yang baik”. (QS. 25 : 63)"
        "\n\n"
        "Barang siapa yang merasa belum jelas mengenai sifat dirinya, maka hendaklah bercermin pada ayat-ayat tersebut. Dengan adanya semua sifat itu pada dirinya pertanda bahwa dia berakhlaq baik. Sebaliknya, jika semuanya tidak ada pada dirinya pertanda dia berakhlaq buruk. Bila terdapat sebagian saja, maka hendaklah ia bersungguh-sungguh memelihara yang ada itu dan mengupayakan yang belum ada pada dirinya. Janganlah seseorang menganggap bahwa akhlaq baik itu hanyalah bersifat lemah lembut kepada orang lain dan meninggalkan perbuatan-perbuatan keji dan dosa saja, sebaliknya orang yang tidak seperti itu dianggap rusak akhlaqnya. Akan tetapi, yang disebut akhlaq baik yaitu seperti yang telah kami sebutkan mengenai sifat-sifat orang mukmin dan perilaku mereka. Termasuk akhlaq baik ialah sabar menghadapi gangguan dalam menjalankan agama."
        "\n\n"
        "Dalam Hadits riwayat Bukhari dan Muslim disebutkan bahwa seorang Arab gunung menarik selendang sutera Nabi Shallallahu ‘alaihi wa Sallam sehingga memekas pada bahu beliau, dan orang itu berkata : “Wahai Muhammad, serahkanlah kepadaku harta Allah yang ada di tanganmu”. Kemudian Nabi Shallallahu ‘alaihi wa Sallam menoleh kepada orang itu, beliau kemudian tertawa dan menyuruh untuk memberi kepada orang itu."
        "\n"
        "Sabda Nabi Shallallahu ‘alaihi wa Sallam “dosa adalah apa-apa yang dirimu merasa ragu-ragu dan kamu tidak suka jika orang lain mengetahuinya” maksudnya adalah perbuatan yang ditolak oleh hati nurani. Ini merupakan suatu pedoman untuk membedakan antara dosa dan kebaikan. Dosa menimbulkan keraguan dalam hati dan tidak senang jika orang lain mengetahuinya. Yang dimaksud dengan “orang lain” di sini adalah orang-orang baik, bukan orang-orang yang telah rusak akhlaqnya. Demikianlah yan disebut dosa, karena itu tinggalkanlah perbuatan tersebut. Wallaahu a’lam.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");


    ///////////////// 28
    no=28;
    bookmark=0;
    ins_judul = "Berpegang Teguh Pada Sunnah";
    ins_arab = "عَن أَبي نَجِيحٍ العربَاضِ بنِ سَاريَةَ رضي الله عنه قَالَ: وَعَظَنا رَسُولُ اللهِ مَوعِظَةً وَجِلَت مِنهَا القُلُوبُ وَذَرَفَت مِنهَا العُيون. فَقُلْنَا: يَارَسُولَ اللهِ كَأَنَّهَا مَوْعِظَةُ مُوَدِّعٍ فَأَوصِنَا، قَالَ: (أُوْصِيْكُمْ بِتَقْوَى اللهِ عز وجل وَالسَّمعِ وَالطَّاعَةِ وَإِنْ تَأَمَّرَ عَلَيْكُمْ عَبْدٌ، فَإِنَّهُ مَنْ يَعِشْ مِنْكُمْ فَسَيَرَى اخْتِلافَاً كَثِيرَاً؛ فَعَلَيكُمْ بِسُنَّتِيْ وَسُنَّةِ الخُلَفَاءِ الرَّاشِدِينَ المّهْدِيِّينَ عَضُّوا عَلَيْهَا بِالنَّوَاجِذِ وَإِيَّاكُمْ وَمُحْدَثَاتِ الأُمُورِ فإنَّ كلّ مُحدثةٍ بدعة، وكُلَّ بِدْعَةٍ ضَلالَةٌ) – رواه أبو داود والترمذي وقال: حديث حسن صحيح";
    ins_terjemahan = "Abu Najih, Al ‘Irbad bin Sariyah ra. ia berkata : “Rasulullah telah memberi nasehat kepada kami dengan satu nasehat yang menggetarkan hati dan membuat airmata bercucuran”. kami bertanya ,”Wahai Rasulullah, nasihat itu seakan-akan nasihat dari orang yang akan berpisah selamanya (meninggal), maka berilah kami wasiat” Rasulullah bersabda, “Saya memberi wasiat kepadamu agar tetap bertaqwa kepada Alloh yang Maha Tinggi lagi Maha Mulia, tetap mendengar dan ta’at walaupun yang memerintahmu seorang hamba sahaya (budak). Sesungguhnya barangsiapa diantara kalian masih hidup niscaya bakal menyaksikan banyak perselisihan. karena itu berpegang teguhlah kepada sunnahku dan sunnah Khulafaur Rasyidin yang lurus (mendapat petunjuk) dan gigitlah dengan gigi geraham kalian. Dan jauhilah olehmu hal-hal baru karena sesungguhnya semua bid’ah itu sesat.” (HR. Abu Daud dan At Tirmidzi, Hadits Hasan Shahih)"
        "\n\n"
        "[Abu Dawud no. 4607, Tirmidzi no. 2676]"
        "\n\n"
        "Pada sebagian sanad diriwayatkan dengan kalimat"
        "\n\n"
        "“Sesungguhnya ini adalah nasihat dari orang yang akan berpisah selamanya (meninggal). Lalu apa yang akan engkau pesankan kepada kami ?” Beliau bersabda, “Aku tinggalkan kamu dalam keadaan terang benderang, malamnya seperti siang. Tidak ada yang menyimpang melainkan ia pasti binasa”";
    ins_isi = "Perkataan, “nasihat yang mengena” maksudnya adalah mengena kepada diri kita dan membekas dihati kita. Perkataan, “yang menggetarkan hati kita” maksudnya menjadikan orang takut. Perkataan,”yang mencucurkan air mata” maksudnya seolah-olah nasihat itu bertindak sebagai sesuatu yang menakutkan dan mengancam."
        "\n"
        "Sabda Rasulullah, “Aku memberi wasiat kepadamu supaya tetap bertaqwa kepada Allah yang Maha Tinggi lagi Maha Mulia, tetap mendengar dan mentaati” maksudnya kepada para pemegang kekuasaan. Sabda Beliau, “Walaupun yang memerintah kamu seorang budak”, pada sebagian riwayat disebutkan budak habsyi."
        "\n"
        "Sebagian Ulama berkata, “Seorang budak tidak dapat menjadi penguasa” kalimat tersebut sekedar perumpamaan, sekalipun hal itu tidak menjadi kenyataan, seperti halnya sabda Rasulullah, “Barangsiapa membangun masjid sekalipun seperti sangkar burung karena Allah, niscaya Allah akan membangukan untuknya sebuah rumah di surga”. Sudah tentu sangkar burung tidak dapat menjadi masjid, tetapi kalimat perumpaan seperti itu biasa dipakai."
        "\n\n"
        "Mungkin sekali Rasulullah memberitahukan bahwa akan terjadinya kerusakan sehingga sesuatu urusan dipegang orang yang bukan ahlinya, yang akibatnya seorang budak bisa menjadi penguasa. Jika hal itu terjadi, maka dengarlah dan taatilah untuk menghindari mudharat yang lebih besar serta bersabar menerima kekuasaan dari orang yang tidak dibenarkan memegang kekuasaan, supaya tidak menimbulkan fitnah yang lebih besar."
        "\n\n"
        "Sabda Rasulullah, “Sungguh, orang yang masih hidup diantaramu nanti akan melihat banyak perselisihan” ini termasuk salah satu mukjizat beliau yang mengabarkan kepada para shohabatnya akan terjadinya perselisihan dan meluasnya kemungkaran sepeninggal beliau. Beliau telah mengetahui hal itu secara rinci , tetapi beliau tidak menceritakan hal itu secara rinci kepada setiap orang, namun hanya menjelaskan secara global. Dalam beberapa hadits ahad disebtukan beliau menerangkan hal semacam itu kepada Hudzaifah dan Abu Hurairah yang menunjukkan bahwa kedua orang itu memiliki posisi dan tempat yang penting disisi Rosululloh ."
        "\n"
        "Sabda Beliau, “Maka wajib atas kamu memegang teguh sunnahku” sunnah ialah jalan lurus yang berjalan pada aturan-aturan tertentu, yaitu jalan yang jelas."
        "\n"
        "Sabda Beliau, “dan sunnah Khulafaur Rasyidin yang mendapatkan petunjuk” maksudnya mereka yang senantiasa diberi petunjuk. Mereka itu ada 4 orang, sebagaimana ijma’ para ulama, yaitu Abu Bakar, ‘Umar, ‘Utsman dan Ali ra. Rasululloh menyuruh kita teguh mengikuti sunnah Khulafaur Rasyidin karena dua perkara : Pertama, bagi yang tidak mampu berpikir cukup dengan mengikuti mereka."
        "\n"
        "Kedua, menjadikan pendapat mereka menjadi pilihan utama bila terjadi perselisihan pendapat diantara para shahabat."
        "\n"
        "Sabdanya “ Jauhilah olehmu perkara-perkara yang baru “. Ketahuilah bahwa perkara yang baru itu ada dua macam."
        "\n\n"
        "Pertama, perkara baru yang tidak punya dasar syari’at, hal semacam ini bathil lagi tercela."
        "\n\n"
        "Kedua, perkara baru yang dilakukan dengan membandingkan dua pendapat yang setara, perkara baru semacam ini tidak tercela. Kata-kata “perkara baru atau bid’ah” arti asalnya bukanlah perbuatan yang tercela. Akan tetapi, bila pengertiannya ialah menyalahi Sunnah dan menuju kepada kesesatan, maka dengan pengertian semacam itu menjadi tercela, sekalipun secara harfiah makna kata tersebut sama sekali tidak tercela, karena Allah pun di dalam firman-Nya menyatakan : “Tidak datang kepada mereka suatu ayat Al Qur’an pun yang baru dari Tuhan mereka” (QS. Al Anbiyaa’ :2)"
        "\n"
        "Juga perkatan ‘Umar radhiallahu ‘anhu : “Bid’ah yang sebaik-baiknya adalah ini”, yaitu shalat tarawih berjama’ah. Wallaahu a’lam.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");


    ///////////////// 29
    no=29;
    bookmark=0;
    ins_judul = "Menjaga Lisan";
    ins_arab = "عَن مُعَاذ بن جَبَلٍ رضي الله عنه قَالَ: قُلتُ يَا رَسُولَ الله أَخبِرنِي بِعَمَلٍٍ يُدخِلُني الجَنَّةَ وَيُبَاعدني منٍ النار قَالَ: (لَقَدْ سَأَلْتَ عَنْ عَظِيْمٍ وَإِنَّهُ لَيَسِيْرٌ عَلَى مَنْ يَسَّرَهُ اللهُ تَعَالَى عَلَيْهِ: تَعْبُدُ اللهَ لاَتُشْرِكُ بِهِ شَيْئَا، وَتُقِيْمُ الصَّلاة، وَتُؤتِي الزَّكَاة، وَتَصُومُ رَمَضَانَ، وَتَحُجُّ البَيْتَ. ثُمَّ قَالَ: أَلاَ أَدُلُّكَ عَلَى أَبْوَابِ الخَيْرِ: الصَّوْمُ جُنَّةٌ، وَالصَّدَقَةُ تُطْفِئُ الخَطِيْئَةَ كَمَا يُطْفِئُ المَاءُ النَّارَ، وَصَلاةُ الرَّجُلِ فِي جَوْفِ اللَّيْلِ ثُمَّ تَلا: (تَتَجَافَى جُنُوبُهُمْ عَنِ الْمَضَاجِعِ) حَتَّى بَلَغَ: (يَعْلَمُونْ) (السجدة: 16-17) ثُمَّ قَالَ: أَلا أُخْبِرُكَ بِرَأْسِ الأَمْرِ وَعَمُودِهِ وَذِرْوَةِ سَنَامِهِ؟ قُلْتُ: بَلَى يَارَسُولَ اللهِ، قَالَ: رَأْسُ الأَمْرِ الإِسْلامُ وَعَمُودُهُ الصَّلاةُ وَذروَةُ سَنَامِهِ الجِهَادُ ثُمَّ قَالَ: أَلا أُخبِرُكَ بِملاكِ ذَلِكَ كُلِّهِ؟ قُلْتُ: بَلَى يَارَسُولَ اللهِ. فَأَخَذَ بِلِسَانِهِ وَقَالَ: كُفَّ عَلَيْكَ هَذَا. قُلْتُ يَانَبِيَّ اللهِ وَإِنَّا لَمُؤَاخَذُونَ بِمَا نَتَكَلَّمُ بِهِ؟ فَقَالَ: ثَكِلَتْكَ أُمُّكَ يَامُعَاذُ. وَهَلْ يَكُبُّ النَّاسَ فِي النَّارِ عَلَى وُجُوهِهِمْ أَو قَالَ: عَلَى مَنَاخِرِهِمْ إِلاَّ حَصَائِدُ أَلسِنَتِهِمْ) – رواه الترمذي وقال: حديث حسن صحيح";
    ins_terjemahan = "Dari Mu’adz bin Jabal radhiallahu ‘anhu, ia berkata : Aku berkata : “Ya Rasulullah, beritahukanlah kepadaku suatu amal yang dapat memasukkan aku ke dalam surga dan menjauhkan aku dari neraka”. Nabi Shallallahu ‘alaihi wa Sallam menjawab, “Engkau telah bertanya tentang perkara yang besar, dan sesungguhnya itu adalah ringan bagi orang yang digampangkan oleh Allah ta’ala. Engkau menyembah Allah dan jangan menyekutukan sesuatu dengan-Nya, mengerjakan shalat, mengeluarkan zakat, berpuasa pada bulan Ramadhan, dan mengerjakan haji ke Baitullah”. Kemudian beliau bersabda : “Inginkah kuberi petunjuk kepadamu pintu-pintu kebaikan? Puasa itu adalah perisai, shadaqah itu menghapuskan kesalahan sebagaimana air memadamkan api, dan shalat seseorang di tengah malam”. Kemudian beliau membaca ayat : “Tatajaafa junuubuhum ‘an madhaaji’… hingga …ya’maluun“. Kemudian beliau bersabda: “Maukah bila aku beritahukan kepadamu pokok amal tiang-tiangnya dan puncak-puncaknya?” Aku menjawab : “Ya, wahai Rasulullah”. Rasulullah bersabda : “Pokok amal adalah Islam, tiang-tiangnya adalah shalat, dan puncaknya adalah jihad”. Kemudian beliau bersabda : “Maukah kuberitahukan kepadamu tentang kunci semua perkara itu?” Jawabku : “Ya, wahai Rasulullah”. Maka beliau memegang lidahnya dan bersabda : “Jagalah ini”. Aku bertanya : “Wahai Rasulullah, apakah kami dituntut (disiksa) karena apa yang kami katakan?” Maka beliau bersabda : “Semoga engkau selamat. Adakah yang menjadikan orang menyungkurkan mukanya (atau ada yang meriwayatkan batang hidungnya) di dalam neraka, selain ucapan lidah mereka?” (HR. Tirmidzi, ia berkata : “Hadits ini hasan shahih)"
        "\n\n"
        "[Tirmidzi no. 2616]";
    ins_isi = "Sabda beliau “engkau telah bertanya tentang perkara yang besar, dan sesungguhnya itu adalah ringan bagi orang yang digampangkan oleh Allah ta’ala”, maksudnya bagi orang yang diberi taufiq oleh Allah kemudian diberi petunjuk untuk beribadah kepada-Nya dengan menjalankan agama secara benar, yaitu menyembah kepada Allah tanpa sedikit pun menyekutukan-Nya dengan yang lain."
        "\n\n"
        "Kemudian sabda beliau “mengerjakan shalat”, yaitu melaksanakannya dengan cara dan keadaan paling sempurna. Kemudian beliau menyebutkan syari’at-syari’at Islam yang lain, seperti zakat, puasa dan haji."
        "\n\n"
        "Kemudian sabda beliau “inginkah kuberi petunjuk kepadamu pintu-pintu kebaikan? Puasa itu adalah perisai”, maksudnya adalah selain puasa Ramadhan, karena puasa yang wajib telah diterangkan sebelumnya. Jadi, maksudnya ialah banyak berpuasa sunnat. Perisai maksudnya ialah puasa itu menjadi tirai dan penjaga dirimu dari siksa neraka."
        "\n\n"
        "Kemudian sabda beliau “shadaqah itu menghapuskan kesalahan”. Maksud shadaqah di sini adalah zakat."
        "\n\n"
        "Sabda beliau “shalat seseorang di tengah malam”."
        "\n\n"
        "Kemudian beliau membaca ayat :"
        "\n"
        "“Lambung mereka jauh dari tempat tidurnya, sedang mereka berdo’a kepada Tuhannya dengan rasa takut dan harap, dan mereka menafkahkan sebagian dari rezki yang kami berikan kepada mereka. Maka suatu jiwa tidak dapat mengetahui apa yang dirahasiakan untuk mereka, yaitu balasan yang menyejukkan mata, sebagai ganjaran dari amal yang telah mereka lakukan”."
        "\n"
        "(QS. As Sajadah 32 : 16-17)"
        "\n\n"
        "maksudnya orang yang shalat tengah malam, dia mengorbankan kenikmatan tidurnya dan lebih mengutamakan shalat karena semata-mata mengharapkan pahala dari Tuhannya, seperti tersebut pada firman-Nya : “Maka suatu jiwa tidak dapat mengetahui apa yang dirahasiakan untuk mereka, yaitu balasan yang menyejukkan mata, sebagai ganjaran dari amal yang telah mereka lakukan”. Dalam beberapa riwayat disebutkan bahwa Allah sangat membanggakan orang-orang yang melakukan shalat malam di saat gelap dengan firman-Nya dalam sebuah Hadits Qudsi : “Lihatlah hamba-hamba-Ku ini. Mereka berdiri shalat di gelap malam saat tidak ada siapa pun melihatnya selain Aku. Aku persaksikan kepada kamu sekalian (para malaikat) sungguh Aku sediakan untuk mereka negeri kehormatan-Ku”."
        "\n\n"
        "Sabda beliau : “Maukah kuberitahukan kepadamu tentang kunci semua perkara itu?” Jawabku : “Ya, wahai Rasulullah”. Maka beliau memegang lidahnya dan bersabda : “Jagalah ini”. Aku bertanya : “Wahai Rasulullah, apakah kami dituntut (disiksa) karena apa yang kami katakan?” Maka beliau bersabda : “Semoga engkau selamat. Adakah yang menjadikan orang menyungkurkan mukanya (atau ada yang meriwayatkan batang hidungnya) di dalam neraka, selain ucapan lidah mereka?” Rasulullah Shallallahu ‘alaihi wa Sallam mengumpamakan perkara ini dengan unta jantan dan Islam dengan kepala unta, sedangkan hewan tidak akan hidup tanpa kepala."
        "\n\n"
        "Kemudian sabda beliau “tiang-tiangnya adalah shalat”. Tiang suatu bangunan adalah alat penyangga yang menegakkan bangunan tersebut, karena bangunan tidak akan dapat berdiri tegak tanpa tiang."
        "\n\n"
        "Sabdanya “puncaknya adalah jihad”, artinya jihad itu tidak tertandingi oleh amal-amal lainnya, sebagaimana diriwayatkan oleh Abu Hurairah. Ia berkata bahwa ada seseorang lelaki datang kepada Rasulullah Shallallahu ‘alaihi wa Sallam lalu berkata :"
        "\n"
        "“Tunjukkan kepadaku amal yang sepadan dengan jihad”. Sabda beliau : “Tidak aku temukan”. Kemudian sabda beliau : “Adakah engkau sanggup masuk ke dalam masjid, lalu kamu melakukan shalat Lail tanpa henti dan puasa tanpa berbuka selama seorang mujahid pergi (berperang)?” Orang itu menjawab : “Siapa yang sanggup berbuat begitu!”"
        "\n\n"
        "Sabdanya : “maukah kuberitahukan kepadamu tentang kunci semua perkara itu?” Jawabku : “Ya, wahai Rasullah”. Maka beliau memegang lidahnya dan bersabda : “Jagalah ini”, maksudnya Nabi Shallallahu ‘alaihi wa Sallam menggalakkan dia pertama kali untuk berjihad melawan orang kafir, kemudian dialihkan kepada jihad yang lebih besar, yaitu jihad melawan hawa nafsu, menahan perkataan yang menyakitkan atau menimbulkan kerusakan karena sebagian besar manusia masuk neraka karena lidahnya."
        "\n\n"
        "Sabda Nabi Shallallahu ‘alaihi wa Sallam : “Semoga engkau selamat. Adakah yang menjadikan orang menyungkurkan mukanya (atau ada yang meriwayatkan batang hidungnya) di dalam neraka, selain ucapan lidah mereka?” Penjelasannya telah ada pada Hadits riwayat Bukhari dan Muslim yang berbunyi :"
        "\n"
        "“Barang siapa beriman kepada Allah dan hari akhirat hendaklah ia berkata baik atau diam”."
        "\n\n"
        "Demikian juga pada Hadits lain disebutkan :"
        "\n"
        "“Barang siapa memberi jaminan kepadaku untuk menjaga apa yang ada di antara kedua bibirnya dan apa yang ada di antara kedua pahanya, maka aku jamin dia masuk surga”";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");


    ///////////////// 30
    no=30;
    bookmark=0;
    ins_judul = "Melaksanakan Perintah dan Menjauhi Larangan";
    ins_arab = "عَنْ أَبِيْ ثَعْلَبَةَ الخُشَنِيِّ جُرثُومِ بنِ نَاشِرٍ رضي الله عنه عَن رَسُولِ اللهِ صلى الله عليه وسلم قَالَ: (إِنَّ اللهَ فَرَضَ فَرَائِضَ فَلا تُضَيِّعُوهَا، وَحَدَّ حُدُودَاً فَلا تَعْتَدُوهَا وَحَرَّمَ أَشْيَاءَ فَلا تَنْتَهِكُوهَا، وَسَكَتَ عَنْ أَشْيَاءَ رَحْمَةً لَكُمْ غَيْرَ نِسْيَانٍ فَلا تَبْحَثُوا عَنْهَا) – حديث حسن رواه الدارقطني وغيره";
    ins_terjemahan = "Dari Abu Tsa’labah Al Khusyani, jurtsum bin Nasyir radhiallahu ‘anhu, dari Rasulullah Shallallahu ‘alaihi wa Sallam, beliau telah bersabda : “ Sesungguhnya Allah ta’ala telah mewajibkan beberapa perkara, maka janganlah kamu meninggalkannya dan telah menetapkan beberapa batas, maka janganlah kamu melampauinya dan telah mengharamkan beberapa perkara maka janganlah kamu melanggarnya dan Dia telah mendiamkan beberapa perkara sebagai rahmat bagimu bukan karena lupa, maka janganlah kamu membicarakannya”. (HR. Daraquthni, Hadits hasan)"
        "\n"
        "[Daruquthni dalam Sunannya no. 4/184]"
        "\n\n"
        "Hadits ini dikatagorikan sebagai hadits dho’if. Lihat Qowa’id wa Fawa’id Minal Arbain An Nawawiah, karangan Nazim Muhammad Sulthan, hal. 262. Lihat pula Misykatul Mashabih, takhrij Syaikh Al Albani, hadits no. 197, juz 1. Lihat pula Jami’ Al Ulum wal Hikam, oleh Ibnu Rajab";
    ins_isi = "Larangan membicarakan hal-hal yang didiamkan oleh Allah sejalan dengan sabda Nabi Shallallahu ‘alaihi wa Sallam :"
        "\n"
        "“Biarkanlah aku dengan apa yang telah aku biarkan kepada kamu sekalian, karena sesungguhnya hancurnya umat sebelum kamu disebabkan mereka banyak bertanya dan menyalahi nabi-nabi mereka”."
        "\n"
        "Sebagian ulama berkata : “Bani Israil dahulu banyak bertanya, lalu diberi jawaban dan mereka diberi apa yang menjadi keinginan mereka, sampai hal itu menjadi fitnah bagi mereka , karena itulah mereka menjadi binasa. Para sahabat Nabi Shallallahu ‘alaihi wa Sallam memahami hal tersebut dan menahan diri untuk tidak bertanya kecuali hal-hal yang sangat penting. Mereka heran menyaksikan orang-orang Arab gunung bertanya kepada Rasulullah Shallallahu ‘alaihi wa Sallam, lalu mereka mendengarkan jawabannya dan memperhatikannya dengan seksama."
        "\n\n"
        "Ada suatu kaum yang sikapnya berlebih-lebihan, sampai mereka berkata : “Tidak boleh bertanya kepada ulama mengenai suatu kasus sampai kasus tersebut benar-benar terjadi”. Ulama salaf ada juga yang berpendapat seperti itu. Mereka berkata : “Biarkanlah suatu masalah sampai benar-benar telah terjadi”. Akan tetapi, ketika para ulama merasa khawatir ilmu agama ini lenyap, maka mereka kemudian membahas masalah-masalah ushul (pokok), menguraikan masalah-masalah furu’ (cabang), memperluas dan menjelaskan berbagai hal."
        "\n\n"
        "Para ulama berselisih pendapat dalam banyak perkara yang agama belum menetapkan hukumnya. Apakah perkara tersebut termasuk yang haram atau mubah atau didiamkan. Ada tiga pendapat dalam hal ini, dan semuanya itu dibicarakan dalam kitab-kitab Ushul.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");


    ///////////////// 31
    no=31;
    bookmark=0;
    ins_judul = "Zuhud";
    ins_arab = "عَنْ أَبي العَباس سَعدِ بنِ سَهلٍ السَّاعِدي رضي الله عنه قَالَ: جَاءَ رَجُلٌ إِلَى النبي صلى الله عليه وسلم فَقَالَ: يَا رَسُول الله: دُلَّني عَلَى عَمَلٍ إِذَا عَمَلتُهُ أَحَبَّني اللهُ، وَأَحبَّني النَاسُ؟ فَقَالَ: (ازهَد في الدُّنيَا يُحِبَّكَ اللهُ، وازهَد فيمَا عِندَ النَّاسِ يُحِبَّكَ النَّاسُ) – حديث حسن رواه ابن ماجة وغيره بأسانيد حسنة";
    ins_terjemahan = "Dari Abul ‘Abbas, Sahl bin Sa’ad As-Sa’idi radhiallahu ‘anhu, ia berkata: “Seorang laki-laki datang kepada Nabi Shallallahu ‘alaihi wa Sallam lalu berkata: ‘Wahai Rasulullah, tunjukkanlah kepadaku suatu perbuatan yang jika aku mengerjakannya, maka aku dicintai Allah dan dicintai manusia’. Maka sabda beliau : ‘Zuhudlah engkau pada dunia, pasti Allah mencintaimu dan zuhudlah engkau pada apa yang dicintai manusia, pasti manusia mencintaimu”. (HR. Ibnu Majah dan yang lainnya, Hadits hasan)"
        "\n\n"
        "[Ibnu Majah no. 4102]";
    ins_isi = "Ketahuilah, sesungguhnya Rasulullah Shallallahu ‘alaihi wa Sallam menganjurkan supaya menahan diri dari memperbanyak harta dunia dan bersikap zuhud."
        "\n"
        "Sabda beliau :"
        "\n"
        "“Jadilah kamu di dunia ini laksana orang asing atau pengembara”."
        "\n\n"
        "Sabda beliau pula :"
        "\n"
        "“Cinta kepada dunia menjadi pangkal segala perbuatan dosa”."
        "\n\n"
        "Sabda beliau ;"
        "\n"
        "“Orang yang zuhud dari segala kesenangan dunia menjadikan hatinya nyaman di dunia dan di akhirat. Sedangkan orang yang mencintai dunia hatinya menjadi resah di dunia dan di akhirat”."
        "\n\n"
        "Ketahuilah bahwa orang yang tinggal di dunia ini adalah tamu dan kekayaan yang di tangannya adalah pinjaman. Sedangkan tamu itu akan pergi dan barang pinjaman harus dikembalikan. Dunia ini bekal yang bisa digunakan oleh orang baik dan orang jahat. Dunia ini dibenci oleh orang yang mencintai Allah, tetapi dicintai oleh para penggemar dunia. Maka siapa yang bergabung bersama pecinta dunia, dia akan dibenci oleh pecinta Allah."
        "\n\n"
        "Beliau menasihatkan kepada penanya agar menjauhkan diri dari menginginkan sesuatu yang dimiliki orang lain. Jika seseorang ingin dicintai lalu meninggalkan kecintaannya kepada dunia, maka mereka tidak mau berebut dan bermusuhan hanya karena mengejar kesenangan dunia."
        "\n\n"
        "Rasulullah Shallallahu ‘alaihi wa Sallam bersabda :"
        "\n\n"
        "“Barang siapa yang menjadikan akhirat sebagai cita-citanya, maka Allah akan menyatukan kemauannya, hatinya dijadikan merasa kaya dan dunia datang kepadanya dengan memaksa. Sedangkan barang siapa yang bercita-cita mendapatkan dunia, maka Allah menjadikan kemauannya berantakan, kemiskinan senantiasa membayang di pelupuk matanya, dan dunia hanya didapatnya sekadar apa yang telah ditaqdirkan baginya”."
        "\n\n"
        "Orang yang beruntung yaitu orang yang memilih kenikmatan abadi daripada kehancuran yang ternyata adzabnya tiada habis-habisnya.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");


    ///////////////// 32
    no=32;
    bookmark=0;
    ins_judul = "Tidak Boleh Berbuat Kerusakan";
    ins_arab = "عنْ أَبي سَعيدٍ سَعدِ بنِ مَالِك بنِ سِنَانٍ الخُدريِّ رضي الله عنه أَنَّ رَسُولَ الله صلى الله عليه وسلم قَالَ: (لاَ ضَرَرَ وَلاَ ضِرَارَ) – حَدِيْث حَسَنٌ رَوَاهُ ابْنُ مَاجَةَ، وَالدَّارَقطْنِيّ وَغَيْرُهُمَا مُسْنَدَاً، وَرَوَاَهُ مَالِكٌ في المُوَطَّأِ مُرْسَلاً عَنْ عَمْرو بنِ يَحْيَى عَنْ أَبِيْهِ عَن النبي صلى الله عليه وسلم فَأَسْقَطَ أَبَا سَعِيْدٍ، وَلَهُ طُرُقٌ يُقَوِّيْ بَعْضُهَا بَعْضَاً";
    ins_terjemahan = "Dari Abu Sa’id, Sa’ad bin Malik bin Sinan Al Khudri radhiyallahu anhu, sesungguhnya Rasulullah Shallallahu ‘alaihi wa Sallam telah bersabda : “Janganlah engkau membahayakan dan saling merugikan”."
        "\n"
        "(HR. Ibnu Majah, Daraquthni dan lain-lainnya, Hadits hasan. Hadits ini juga diriwayatkan oleh Imam Malik dalam Al Muwaththa sebagai Hadits mursal dari Amr bin Yahya dari bapaknya dari Nabi Shallallahu ‘alaihi wa Sallam tanpa menyebut Abu Sa’id. Hadits ini mempunyai beberapa jalan yang saling menguatkan)"
        "\n\n"
        "[Ibnu Majah no. 2341, Daruquthni no. 4/228, Imam Malik (Muwaththo 2/746)]";
    ins_isi = "Ketahuilah, bahwa orang yang merugikan saudaranya dikatakan telah menzhaliminya. Sedangkan berbuat zhalim adalah haram, sebagaimana telah dijelaskan pada Hadits Abu Dzar :"
        "\n"
        "“Wahai hamba-Ku, sesungguhnya Aku telah mengharamkan diriku berbuat zhalim dan menjadikannya haram juga diantara kamu, maka janganlah kamu berbuat zhalim”"
        "\n"
        "Nabi Shallallahu ‘alaihi wa Sallam bersabda :"
        "\n"
        "“Sesungguhnya darah kamu, harta kamu dan kehormatan kamu adalah haram bagi kamu”adapun sabda beliau : “Janganlah engkau saling membahayakan dan saling merugikan” sebagian ulama mengatakan “Dua kata tersebut sebenarnya semakna dan kebanyakan dari mereka menyatakan bahwa penggunaan dua kata tersebut berarti penegasan”."
        "\n"
        "Al Mahasini berkata : “Bahwa yang dimaksud dengan merugikan adalah melakukan sesuatu yang bermanfaat bagi dirinya, tetapi menyebabkan orang lain mendapatkan mudharat”. Ini adalah pendapat yang benar."
        "\n"
        "Sebagian ulama berkata : “Yang dimaksud dengan kamu membahayakan yaitu engkau merugikan orang yang tidak merugikan kamu. Sedangkan yang dimaksud saling merugikan yaitu engkau membalas orang yang merugikan kamu dengan hal yang tidak setara dan tidak untuk membela kebenaran”."
        "\n\n"
        "Hadits ini sama dengan sabda Nabi Shallallahu ‘alaihi wa Sallam : “Tunaikanlah amanat kepada orang yang memberi amanat kepadamu, dan janganlah kamu berkhianat kepada orang yang berkhianat kepadamu”."
        "\n\n"
        "Menurut sebagian ulama, Hadits ini maksudnya adalah janganlah kamu berkhianat kepada orang yang mengkhianati kamu setelah kamu mendapat kemenangan atas pengkhianatannya. Seolah-olah larangan ini berlaku terhadap orang yang memulai, sedangkan bagi orang yang melakukan pembalasan yang setimpal dan menuntut haknya tidak dikatakan berkhianat. Yang dikatakan berkhianat hanyalah orang yang mengambil sesuatu yang bukan haknya atau mengambil lebih dari haknya."
        "\n\n"
        "Para ahli fiqih berselisih paham tentang orang yang mengingkari hak orang lain, kemudian fihak yang diingkari mengambil harta yang diamanatkan pengingkar kepadanya atau hal lain yang serupa. Sebagian ahli fiqih berkata : “Orang semacam itu tidak berhak mengambil haknya dari orang tersebut, karena zhahir sabda Nab Shallallahu ‘alaihi wa Sallam “tunaikanlah amanat dan janganlah engkau berkhianat kepada orang yang mengkhianatimu”. Yang lain berpendapat: “Dia boleh mengambil haknya dan berhak mendapatkan pertolongan dalam rangka mengambilnya dari orang yang menguasainya”. Mereka berdalil dengan Hadits ‘Aisyah dalam kasus Hindun dengan suaminya, Abu Sufyan. Para ahli fiqih dalam masalah ini mempunyai berbagai pendapat dan alasan yang tidak tepat untuk dibicarakan di sini. Akan tetapi, pendapat yang benar ialah seseorang tidak boleh membahayakan saudaranya baik hal itu merugikan atau tidak, namun dia berhak untuk diberi pembelaan dan pelakunya diberi hukuman sesuai dengan ketentuan hukum. Hal itu tidak dikatakan zhalim atau membahayakan selama sesuai dengan ketentuan yang dibenarkan oleh Sunnah."
        "\n\n"
        "Syaikh Abu ‘Amr bin Shalah berkata : “ Daraquthni menyebutkan sanad Hadits ini dari beberapa jalan yang secara keseluruhan menjadikan hadits ini kuat dan hasan. Sejumlah besar ulama menukil Hadits ini dan menjadikannya sebagai hujah. Dari Abu Dawud, ia berkata : “Fiqih itu berkisar pada lima Hadits dan ia menyebut Hadits ini adalah salah satu di antaranya”. Syaikh Abu ‘Amr berkata : “Hadits diriwayatkan Abu Dawud ini termasuk dalam lima Hadits itu”. Ucapannya ini mengisyaratkan bahwa menurut pendapatnya Hadits ini tidak dha’if.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");


    ///////////////// 33
    no=33;
    bookmark=0;
    ins_judul = "Penuduh Wajib Membawa Bukti dan Tertuduh Cukup Bersumpah";
    ins_arab = "عنِ ابْنِ عَبَّاسٍ رَضِيَ اللهُ عَنْهُمَا أَنَّ رَسُولَ اللهِ صلى الله عليه وسلم قَالَ: ( لَوْ يُعْطَى النَّاسُ بِدعوَاهُمْ لادَّعَى رِجَالٌ أَمْوَال قَومٍ وَدِمَاءهُمْ، وَلَكِنِ البَينَةُ عَلَى المُدَّعِي، وَاليَمينُ عَلَى مَن أَنكَر ) – حديث حسن رواه البيهقي هكذا بعضه في الصحيحين";
    ins_terjemahan = "Dari Ibnu ‘Abbas radhiallahu ‘anhuma, sesungguhnya Rasulullah Shallallahu ‘alaihi wa Sallam bersabda : “Sekiranya setiap tuntutan orang dikabulkan begitu saja, niscaya orang-orang akan menuntut darah orang lain atau hartanya. Akan tetapi, haruslah ada bukti atau saksi bagi yang menuntut dan bersumpah bagi yang mengingkari (dakwaan)”."
        "\n"
        "(HR. Baihaqi, hadits Hasan, sebagian lafazhnya ada pada riwayat Bukhari dan Muslim)"
        "\n\n"
        "[Baihaqi (Sunan Baihaqi 10/252), dan yang lain, juga sebagian lafaznya ada di shahih Bukhari dan Muslim]";
    ins_isi = "Hadits ini pada riwayat Bukhari dan Muslim disebutkan bahwa Ibnu Abu Mulaikah mengatakan :"
        "\n"
        "“Ibnu ‘Abbas menulis bahwa sesungguhnya Nabi Shallallahu ‘alaihi wa Sallam telah menetapkan sumpah untuk orang yang menyangkal dakwaan”."
        "\n\n"
        "Pada riwayat lain disebutkan sesungguhnya Nabi Shallallahu ‘alaihi wa Sallam bersabda :"
        "\n"
        "“Sekiranya manusia dikabulkan apa saja yang menjadi pengakuannya, niscaya orang-orang akan mudah menuntut darah orang lain, harta orang lain. Akan tetapi, sumpah itu untuk orang yang menyangkal dakwaan”."
        "\n\n"
        "Penulis kitab Al Arbain berkata : “Hadits ini diriwayatkan Bukhari dan Muslim dalam Kitab Shahihnya dengan sanad bersambung dari riwayat Ibnu ‘Abbas. Begitu pula riwayat para penyusun Kitab Sunnan dan lain-lainnya”. Ushaili berkata : “Bila marfu’nya Hadits ini dengan kesaksian Imam Bukhari dan Imam Muslim, maka tidaklah ada artinya anggapan bahwa Hadits ini mauquf”. Penilain semacam itu tidak berarti berlawanan dan tidak juga menyalahi."
        "\n\n"
        "Hadits ini merupakan salah satu pokok hukum Islam dan sumber pegangan yang terpenting di kala terjadi perselisihan dan permusuhan antara orang-orang yang bersengketa. Suatu perkara tidak boleh diputuskan semata-mata berdasarkan pengakuan atau tuntutan dari seseorang."
        "\n\n"
        "Sabda beliau “niscaya orang-orang akan menuntut darah orang lain atau hartanya” dipakai oleh sebagian orang sebagai dasar untuk membatalkan pendapat Imam Malik, yang mengatakan perlunya mendengarkan pengaduan korban yang mengatakan bahwa seseorang telah melukai saya atau saya mempunyai tuntutan darah kepada seseorang. Sebab, jika orang yang sedang sakit mengadu “Seseorang mempunyai pinjaman kepadaku satu dinar atau satu dirham” Tidak boleh diperhatikan, maka pengaduan korban “Saya mempunyai tuntutan darah kepada orang lain” lebih patut untuk tidak diperhatikan. Dengan demikian, alasan tersebut tidak benar untuk membantah pendapat Imam Malik dalam masalah ini karena Imam Malik tidak mendasarkan pelaksaan qishash atau denda hanya pada perkataan penggugat atau sumpah korban, tetapi menjadikan pengakuan korban “Saya mempunyai tuntutan darah kepada sseorang” sebagai keterangan tambahan yang menguatkan bukti penggugat, sampai orang yang digugat berani bersumpah ketika ia mengingkarinya, sebagaimana yang berlaku pada berbagai macam keterangan tambahan."
        "\n\n"
        "Sabda beliau : “Akan tetapi, sumpah itu untuk orang yang menyangkal (dakwaan)” menjadi kesepakatan para ulama untuk menyumpah penyangkalan orang yang didakwa dalam urusan harta. Akan tetapi, dalam urusan lain mereka masih berbeda pendapat. Sebagian ulama menyatakan hal ini wajib berlaku kepada setiap orang yang menyangkal dakwaan di dalam sesuatu hak, dalam thalaq, dalam pernikahan, atau dalam pembebasan budak berdasarkan pada keumuman Hadits ini. Jika orang yang didakwa tidak mau bersumpah, maka tuduhannya dipenuhi."
        "\n\n"
        "Abu Hanifah berkata : “Sumpah itu diberlakukan dalam kasus thalaq, nikah, dan pembebasan budak. Jika tidak mau bersumpah, maka tuduhannya dipenuhi”. Dan dia berkata : “Dalam kasus pidana tidak boleh digunakan sumpah (sebagai alat bukti)”.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");


    ///////////////// 34
    no=34;
    bookmark=0;
    ins_judul = "Amar Makruf Nahi Munkar";
    ins_arab = "عَنْ أَبي سَعيدٍ الخُدريِّ رضي الله عنه قَالَ: سَمِعتُ رِسُولَ اللهِ صلى الله عليه وسلم يَقولُ: (مَن رَأى مِنكُم مُنكَرَاً فَليُغَيِّرْهُ بِيَدِهِ، فَإِنْ لَمْ يَستَطعْ فَبِلِسَانِهِ، فَإِنْ لَمْ يَستَطعْ فَبِقَلبِه وَذَلِكَ أَضْعَفُ الإيمَانِ) – رواه مسلم";
    ins_terjemahan = "Dari Abu Sa’id Al Khudri radhiyallahu anhu, ia berkata : Aku mendengar Rasulullah Shallallahu ‘alaihi wa Sallam bersabda : “Barang siapa di antaramu melihat kemungkaran, hendaklah ia merubahnya (mencegahnya) dengan tangannya (kekuasaannya) ; jika ia tak sanggup, maka dengan lidahnya (menasihatinya) ; dan jika tak sanggup juga, maka dengan hatinya (merasa tidak senang dan tidak setuju) , dan demikian itu adalah selemah-lemah iman”."
        "\n\n"
        "[Muslim no. 49]";
    ins_isi = "Muslim meriwayatkan Hadits ini dari jalan Thariq bin Syihab, ia berkata : Orang yang pertama kali mendahulukan khutbah pada hari raya sebelum shalat adalah Marwan. Lalu seorang laki-laki datang kepadanya, kemudian berkata : “Shalat sebelum khutbah?”. Lalu (laki-laki tersebut) berkata : “Orang itu (Marwan) telah meninggalkan yang ada di sana (Sunnah Nabi Shallallahu ‘alaihi wa Sallam)”. Abu Sa’id berkata : “Adapun dalam hal semacam ini telah ada ketentuannya. Saya mendengar Rasulullah Shallallahu ‘alaihi wa Sallam bersabda : ‘Barang siapa di antaramu melihat kemungkaran hendaklah ia merubahnya (mencegahnya) dengan tangannya (kekuasaannya) ; jika ia tak sanggup, maka dengan lidahnya (menasihatinya); dan jika tak sanggup juga, maka dengan hatinya (merasa tidak senang dan tidak setuju), dan demikian itu adalah selemah-lemah iman’ “. Hadits ini menunjukkan bahwa perbuatan semacam itu belum pernah dilakukan oleh siapa pun sebelum Marwan."
        "\n"
        "Jika ada yang bertanya : “Mengapa Abu Sa’id terlambat mencegah kemungkaran ini, sampai laki-laki tersebut mencegahnya?” Ada yang menjawab : “Mungkin Abu Sa’id belum hadir ketika Marwan berkhutbah sebelum shalat. Lelaki itu tidak menyetujui perbuatan tersebut, lalu Abu Sa’id datang ketika kedua orang tersebut sedang berdebat. Atau mungkin Abu Sa’id sudah hadir tetapi ia merasa takut untuk mencegahnya, karena khawatir timbul fitnah akibat pencegahannya itu, sehingga tidak dilakukan. Atau mungkin Abu Sa’id sudah berniat mencegah, tetapi lelaki itu mendahuluinya, kemudian Abu Sa’id mendukungnya”."
        "\n"
        "Wallaahu a’lam."
        "\n\n"
        "Pada Hadits lain yang disepakati oleh Bukhari dan Muslim dalam Bab Shalat Hari Raya, disebutkan bahwa Abu Sa’id menarik tangan Marwan ketika ia hendak naik ke atas mimbar. Ketika keduanya berhadapan, Marwan menolak peringatan Abu Sa’id sebagaimana penolakannya terhadap seorang laki-laki seperti yang dikisahkan pada Hadits di atas, atau mungkin kasus ini terjadinya berlainan waktu."
        "\n\n"
        "Kalimat “hendaklah ia merubahnya (mencegahnya)” dipahami sebagai perintah wajib oleh segenap kaum muslim. Dalam Al Qur’an dan Sunnah telah ditetapkan kewajiban amar ma’ruf dan nahi mungkar. Ini termasuk nasihat dan merupakan urusan agama. Adapun firman Allah :"
        "\n"
        "“Jagalah diri kamu sekalian, tidaklah merugikan kamu orang yang sesat, jika kamu telah mendapat petunjuk”. (QS. Al Maidah : 105)"
        "\n\n"
        "tidaklah bertentangan dengan apa yang telah kami jelaskan, karena paham yang benar menurut para ulama ahli tahqiq adalah bahwa makna ayat tersebut ialah jika kamu sekalian melaksanakan apa yang dibebankan kepadamu, maka kamu tidak akan menjadi rugi bila orang lain menyalahi kamu."
        "\n"
        "Hal ini semakna dengan firman Allah :"
        "\n"
        "“Seseorang tidaklah menanggung dosa orang lain”. (QS. 6 : 164)"
        "\n\n"
        "Dengan demikian, amar ma’ruf dan nahi mungkar yang dibebankan kepada setiap muslim, jika ia telah menjalankannya, sedangkan orang yang diperingatkan tidak melaksanakannya, maka pemberi peringatan telah terlepas dari celaan, sebab ia hanya diperintah menjalankan amar ma’ruf dan nahi mungkar, tidak harus sampai bisa diterima oleh yang diberi peringatan. Wallaahu a’lam."
        "\n\n"
        "Kemudian, amar ma’ruf dan nahi mungkar merupakan perbuatan wajib kifayah, sehingga jika telah ada yang menjalankannya, maka yang lain terbebas. Jika semua orang meninggalkannya, maka berdosalah semua orang yang mampu melaksanakannya, terkecuali yang ada udzur. Kemudian ada kalanya menjadi wajib ‘ain bagi seseorang. Misalnya, jika di suatu tempat yang tidak ada orang lain yang mengetahui kemungkaran itu selain dia, atau kemungkaran itu hanya bisa dicegah oleh dia sendiri, misalnya seseorang yang melihat istri, anak, atau pembantunya melakukan kemungkaran atau kurang dalam melaksanakan kewajibannya."
        "\n\n"
        "Para ulama berkata : “Tanggung jawab amar ma’ruf dan nahi mungkar itu tidaklah terlepas dari diri seseorang hanya Karena ia beranggapan bahwa peringatannya tidak akan diterima. Dalam keadaan demikian ia tetap saja wajib menjalankannya. Allah berfirman :"
        "\n"
        "“Berilah peringatan, karena peringatan itu bermanfaat bagi orang-orang mukmin”. (QS. 51 : 55)"
        "\n\n"
        "Telah disebutkan di atas bahwa setiap orang berkewajiban melakukan amar ma’ruf nahi mungkar, tetapi tidak diwajibkan sampai peringatannya itu diterima."
        "\n"
        "Allah berfirman :"
        "\n"
        "“Tiadalah kewajiban bagi seorang Rasul melainkan hanya menyampaikan peringatan”. (QS. 5 : 99)"
        "\n\n"
        "Para ulama berkata : “Orang yang menyampaikan amar ma’ruf nahi mungkar tidaklah diharuskan dirinya telah sempurna melaksanakan semua yang menjadi perintah agama dan meninggalkan semua yang menjadi larangannya. Ia tetap wajib menjalankan amar ma’ruf nahi mungkar sekalipun perbuatannya sendiri menyalahi hal itu. Hal ini Karena seseorang wajib melakukan dua perkara, yaitu menjalankan amar ma’ruf nahi mungkar kepada diri sendiri dan kepada orang lain. Jika yang satu (amar ma’ruf nahi mungkar kepada diri sendiri) dikerjakan, tidak berarti yang satunya (amar ma’ruf nahi mungkar kepada orang lain) gugur”."
        "\n\n"
        "Para ulama berkata : “Tugas amar ma’ruf dan nahi mungkar tidak hanya menjadi kewajiban para penguasa, tetapi tugas setiap muslim”. Yang diperintahkan melakukan amar ma’ruf nahi mungkar adalah orang mengetahui tentang apa yang dinilai sebagai hal yang ma’ruf atau mungkar. Bila berkaitan dengan hal-hal yang jelas, seperti shalat, puasa, zina, minum khamr, dan semacamnya, maka setiap muslim wajib mencegahnya karena ia sudah mengetahui hal ini. Akan tetapi, dalam perbuatan atau perkataan yang rumit dan hal-hal yang berkaitan dengan ijtihad yang golongan awam tidak banyak mengetahuinya, maka mereka tidaklah punya wewenang untuk melakukan nahi mungkar. Hal ini menjadi wewenang ulama. Dan para ulama hanya dapat mencegah kemungkaran yang sudah jelas ijma’nya. Adapun dalam hal yang masih diperselisihkan, maka dalam hal semacam ini tidak dapat dilakukan nahi mungkar, sebab setiap orang berhak memilih salah satu dari dua macam paham hasil ijtihad. Sedang pendapat setiap mujtahid itu dinilai benar sesuai keyakinannya masing-masing. Inilah pendapat yang dipilih oleh sebagian besar ulama tahqiq. Pendapat lain mengatakan bahwa yang benar itu hanya satu dan yang salah bisa banyak, tetapi mujtahid yang salah itu tidak berdosa. Sekalipun demikian, dinasihatkan supaya kita menjauhi persoalan yang diperselisihkan. Hal ini adalah satu sikap yang baik. Kita dianjurkan untuk melaksanakan nahi mungkar ini dengan santun."
        "\n\n"
        "Syaikh Muhyidin berkata : “Ketahuilah bahwa sejak lama amar ma’ruf nahi mungkar ini oleh sebagian besar orang telah diabaikan. Pada masa-masa ini hanyalah tinggal dalam tulisan yang amat sedikit, padahal ini merupakan hal yang amat besar peranannya bagi tegaknya urusan umat dan kekuasaan. Apabila perbuatan-perbuatan buruk merajalela, maka orang-orang shalih maupun orang-orang jahat semuanya akan tertimpa adzab. Jika orang yang shalih tidak mau menahan tangan orang yang zhalim, maka nyaris adzab Allah akan menimpa mereka semua. Allah berfirman :"
        "\n"
        "“Hendaklah orang-orang yang menyalahi perintah rasul-Nya khawatir tertimpa fitnah atau adzab yang pedih”. (QS. 24 : 63)"
        "\n\n"
        "Oleh karena itu, sepatutnya para pencari akhirat dan orang yang berusaha mendapatkan keridhaan Allah memperhatikan masalah ini. Hal ini karena kemanfaatannya amat besar, apalagi sebagian besar orang sudah tidak peduli, dan orang yanng melakukan pencegahan kemungkaran tidak lagi ditakuti, karena martabatnya yang rendah. Allah berfirman :"
        "\n"
        "“Sungguh, Allah pasti menolong orang yang menolong-Nya”. (QS. 22 :40)"
        "\n\n"
        "Oleh karena itu, ketahuilah bahwa pahala itu diberikan sesuai dengan usahanya dan tidak boleh meninggalkan nahi mungkar ini hanya karena ikatan persahabatan atau kecintaan, sebab sahabat yang jujur ialah orang yang membantu saudaranya untuk memajukan kepentingan akhiratnya, sekalipun hal itu dapat menimbulkan kerugian dalam urusan dunianya. Adapun orang yang menjadi musuh ialah orang yang berusaha merugikan usaha untuk kepentingan akhiratnya atau menguranginya sekalipun sikapnya seperti dapat membawa keuntungan duniawinya."
        "\n\n"
        "Bagi orang yang melakukan amar ma’ruf nahi mungkar seyogyanya dilakukan dengan sikap santun agar dapat lebih mendekatkan kepada tujuan. Imam Syafi’i berkata : “Orang yang menasihati saudaranya dengan cara tertutup, maka orang itu telah benar-benar menasihatinya dan berbuat baik kepadanya. Akan tetapi orang yang menasihatinya secara terbuka, maka sesungguhnya ia telah menistakannya dan merendahkannya”."
        "\n\n"
        "Hal yang sering diabaikan orang dalam hal ini, yaitu ketika mereka melihat seseorang menjual barang atau hewan yang mengandung cacat tetapi ia tidak mau menjelaskannya, ternyata mereka tidak mau menegur dan memberitahukan kepada pembeli atas cacat yang ada pada barang itu. Orang-orang semacam itu bertanggung jawab terhadap kemungkaran tersebut, karena agama itu adalah nasihat (kejujuran), maka barang siapa tidak mau berlaku jujur atau memberi nasihat, berarti ia telah berlaku curang."
        "\n\n"
        "Kalimat “hendaklah ia merubahnya (mencegahnya) dengan tangannya (kekuasaannya) ; jika ia tak sanggup, maka dengan lidahnya (menasihatinya) ; dan jika tak sanggup juga, maka dengan hatinya” , maksudnya hendaklah ia mengingkari perbuatan itu dalam hatinya. Hal semacam itu tidaklah dikatakan telah merubah atau melenyapkan, tetapi itulah yang sanggup ia kerjakan. Dan kalimat “demikian itu adalah selemah-lemah iman” maksudnya ialah – Wallaahu a’lam – paling sedikit hasilnya (pengaruhnya)."
        "\n\n"
        "Orang yang melakukan amar ma’ruf dan nahi mungkar tidaklah punya hak untuk mencari-cari, mengontrol, memata-matai, dan menyebarkan prasangka, tetapi jika ia menyaksikan orang lain berbuat mungkar, hendaklah ia mencegahnya. Al Mawardi berkata : “Orang yang melakukan amar ma’ruf nahi mungkar tidaklah punya hak untuk menyebarkan praduga atau memata-matai, kecuali memberitahukan kepada orang yang bisa dipercaya”. Bila ada seseorang yang membawa orang lain ke tempat sunyi untuk dibunuh, atau membawa seorang perempuan ke tempat sunyi untuk dizinai, maka dalam keadaan semacam ini, bolehlah ia memata-matai, mengawasi dan mengintai karena khawatir terdahului oleh kejadiannya."
        "\n\n"
        "Disebutkan bahwa kalimat “demikian itu adalah selemah-lemah iman” maksudnya ialah hasilnya (pengaruhnya) sangat sedikit. Tersebut dalam riwayat lain :"
        "\n"
        "“Selain dari itu tidak lagi ada iman sekalipun sebesar biji sawi”."
        "\n\n"
        "Artinya selain dari tiga macam sikap tersebut tidak lagi ada sikap lain yang ada nilainya dari segi keimanan. Iman yang dimaksud dalam Hadits ini adalah dengan makna islam."
        "\n\n"
        "Hadits ini menyatakan bahwa orang yang takut pembunuhan atau pemukulan, ia terbebas dari melakukan pencegahan kemungkaran. Inilah pendapat para ulama ahli tahqiq zaman salaf maupun khalaf. Sebagian dari golongan yang ekstrim berpendapat bahwa sekalipun seseorang takut, tidaklah ia terbebas dari kewajiban mencegah kemungkaran.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");


    ///////////////// 35
    no=35;
    bookmark=0;
    ins_judul = "Persaudaraan Islam";
    ins_arab = "عَنْ أَبي هُرَيرَةَ رضي الله عنه قَالَ: قَالَ رَسُولُ اللهِ صلى الله عليه وسلم: ( لاَ تَحَاسَدوا، وَلاَتَنَاجَشوا، وَلاَ تَبَاغَضوا، وَلاَ تَدَابَروا، وَلاَ يَبِع بَعضُكُم عَلَى بَيعِ بَعضٍ، وَكونوا عِبَادَ اللهِ إِخوَانَاً، المُسلِمُ أَخو المُسلم، لاَ يَظلِمهُ، وَلاَ يَخذُلُهُ، وَلا يكْذِبُهُ، وَلايَحْقِرُهُ، التَّقوَى هَاهُنَا – وَيُشيرُ إِلَى صَدرِهِ ثَلاَثَ مَراتٍ – بِحَسْبِ امرىء مِن الشَّرأَن يَحْقِرَ أَخَاهُ المُسلِمَ، كُلُّ المُسِلمِ عَلَى المُسلِمِ حَرَام دَمُهُ وَمَالُه وَعِرضُه ) – رواه مسلم";
    ins_terjemahan = "Dari Abu Hurairah radhiallahu ‘anhu, ia berkata : “Rasulullah Shallallahu ‘alaihi wa Sallam bersabda : “Kamu sekalian, satu sama lain Janganlah saling mendengki, saling menipu, saling membenci, saling menjauhi dan janganlah membeli barang yang sedang ditawar orang lain. Dan jadilah kamu sekalian hamba-hamba Allah yang bersaudara. Seorang muslim itu adalah saudara bagi muslim yang lain, maka tidak boleh menzhaliminya, menelantarkannya, mendustainya dan menghinakannya. Taqwa itu ada di sini (seraya menunjuk dada beliau tiga kali). Seseorang telah dikatakan berbuat jahat jika ia menghina saudaranya sesama muslim. Setiap muslim haram darahnya bagi muslim yang lain, demikian juga harta dan kehormatannya”."
        "\n\n"
        "[Muslim no. 2564]";
    ins_isi = "Kalimat “janganlah saling mendengki” maksudnya jangan mengharapkan hilangnya nikmat dari orang lain. Hal ini adalah haram. Pada Hadits lain disebutkan:"
        "\n"
        "“Jauhilah olehmu sekalian sifat dengki, karena dengki itu memakan segala kebaikan seperti api memakan kayu”."
        "\n\n"
        "Adapun iri hati ialah tidak ingin orang lain mendapatkan nikmat, tetapi ada maksud untuk menghilangkannya. Terkadang kata denngki dipakai dengan arti iri hati, karena kedua kata ini memang pengertiannya hampir sama, seperti sabda Nabi Shallallahu ‘alaihi wa Sallam dalam sebuah Hadits riwayat Bukhari dan Muslim dari Ibnu Mas’ud :"
        "\n"
        "“Tidaklah boleh ada dengki kecuali dalam dua perkara”."
        "\n\n"
        "Dengki yang dimaksud dalam Hadits ini adalah iri hati."
        "n\n"
        "Kalimat “jangan kamu saling menipu” , yaitu memperdaya. Seorang pemburu disebut penipu, karena dia memperdayakan mangsanya."
        "\n\n"
        "Kalimat “jangan kamu saling membenci” maksudnya jangan saling melakukan hal-hal yang dapat menimbulkan kebencian. Cinta dan benci adalah hal yang berkenaan dengan hati, da manusia tidak sanggup untuk mengendalikannya sendiri. Hal itu sebagaimana sabda Nabi Shallallahu ‘alaihi wa Sallam :"
        "\n"
        "“Ini adalah bagianku yang aku tidak sanggup menguasainya, Karena itu janganlah Engkau menghukumku dalam urusan yang Engkau kuasai tetapi aku tidak menguasainya”."
        "\n\n"
        "Yaitu berkenaan dengan cinta dan benci."
        "\n\n"
        "Kalimat “jangan kamu saling menjauh” dalam bahasa arab adalah tadaabur, yaitu saling bermusuhan atau saling memutus tali persaudaraan. Antara satu dengan yang lain saling membelakangi atau menjauhi."
        "\n\n"
        "Kalimat “janganlah membeli barang yang sudah ditawar orang lain” yaitu berkata kepada pembeli barang pada saat sedang terjadi transaksi barang, misalnya dengan kata-kata : “Batalkanlah penjualan ini dan aku akan membelinya dengna harga yang sama atau lebih mahal”. Atau dua orang yang melakukan jual beli telah sepakat dengan suatu harga dan tinggal akad saja, lalu salah satunya meminta tambahan atau pengurangan harga. Perbuatan semacam ini haram, karena penetapan harga sudah disepakati. Adapun sebelum ada kesepakatan, tidak haram."
        "\n\n"
        "Kalimat “jadilah kamu sekalian hamba-hamba Allah yang bersaudara” maksudnya hendaklah kamu saling bergaul dan memperlakukan orang lain sebagai saudara dalam kecintaan, kasih sayang, keramahan, kelembutan, dan tolong-menolong dalam kebaikan dengan hati ikhlas dan jujur dalam segala hal."
        "\n\n"
        "Kalimat “seorang muslim itu adalah saudara bagi muslim yang lain, maka tidak boleh menzhaliminya, menelantarkannya, mendustainya dan menghinakannya”. Yang dimaksud menelantarkan yaitu tidak memberi bantuan dan pertolongan. Maksudnya jika ia meminta tolong untuk melawan kezhaliman, maka menjadi keharusan saudaranya sesama muslim untuk menolongnya jika mampu dan tidak ada halangan syar’i."
        "\n\n"
        "Kalimat “tidak menghinakannya” yaitu tidak menyombongkan diri pada orang lain dan tidak menganggap orang lain rendah. Qadhi ‘Iyadh berkata : “Yang dimaksud dengan menghinakannya yaitu tidak mempermainkan atau membatalkan janji kepadanya”. Pendapat yang benar adalah pendapat yang pertama."
        "\n\n"
        "Kalimat “taqwa itu ada di sini (seraya menunjuk dada beliau tiga kali)”. Pada riwayat lain disebutkan :"
        "\n"
        "“Allah tidak melihat jasad kamu dan rupa kamu, tetapi melihat hati kamu”."
        "\n\n"
        "Maksudnya, perbuatan-perbuatan lahiriyah tidak akan mendapatkan pahala tanpa taqwa. Taqwa itu adalah rasa yang ada dalam hati terhadap keagungan Allah, takut kepada-Nya, dan merasa selalu diawasi. Pengertian, “Allah melihat” ialah Allah mengetahui segala-galanya. Maksud Hadits ini ialah Allah akan memberinya balasan dan mengadili, dan semua perbuatan itu dinilai berdasarkan niatnya di dalam hati. Wallaahu a’lam."
        "\n\n"
        "Kalimat “seseorang telah dikatakan berbuat jahat jika ia menghina saudaranya sesama muslim” berisikan peringatan keras terhadap perbuatan menghina. Allah tidak menghinakan seorang mukmin karena telah menciptakannya dan memberinya rezeki, kemudian Allah ciptakan dalam bentuk yang sebaik-baiknya, dan semua yang ada di langit dan bumi ditundukkan bagi kepentingannya. Apabila ada peluang bagi orang mukmin dan orang bukan mukmin, maka orang mukmin diprioritaskan. Kemudian Allah, menamakan seorang manusia dengan muslim, mukmin, dan hamba, kemudian mengirimkan Rasul Muhammad Shallallahu ‘alaihi wa Sallam kepadanya. Maka siapa pun yang menghinakan seorang muslim, berarti dia telah menghinakan orang yang dimuliakan Allah."
        "\n\n"
        "Termasuk perbuatan menghinakan seorang muslim ialah tidak memberinya salam ketika bertemu, tidak menjawab salam bila diberi salam, menganggapnya sebagai orang yang tidak akan dimasukkan ke dalam surga oleh Allah atau tidak akan dijauhkan dari siksa neraka. Adapun kecaman seorang muslim yang berilmu terhadap orang muslim yang jahil, orang adil terhadap orang fasik tidaklah termasuk menghina seorang muslim, tetapi hanya menyatakan sifatnya saja. Jika orang itu meninggalkan kejahilan atau kefasikannya, maka ketinggian martabatnya kembali.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");


    ///////////////// 36
    no=36;
    bookmark=0;
    ins_judul = "Membantu Sesama Muslim";
    ins_arab = "عَنْ أَبي هُرَيرَة رضي الله عنه عَنِ النبي صلى الله عليه وسلم قَالَ: ( مَنْ نَفَّسَ عَنْ مُؤمِن كُربَةً مِن كُرَبِ الدُّنيَا نَفَّسَ اللهُ عَنهُ كُربَةً مِنْ كرَبِ يَوم القيامَةِ، وَمَنْ يَسَّرَ على مُعسرٍ يَسَّرَ الله عَلَيهِ في الدُّنيَا والآخِرَة، وَمَنْ سَتَرَ مُسلِمَاً سَتَرَهُ الله في الدُّنيَا وَالآخِرَة، وَاللهُ في عَونِ العَبدِ مَا كَانَ العَبدُ في عَونِ أخيهِ، وَمَنْ سَلَكَ طَريقَاً يَلتَمِسُ فيهِ عِلمَاً سَهَّلَ اللهُ لهُ بِهِ طَريقَاً إِلَى الجَنَّةِ، وَمَا اجتَمَعَ قَومٌ في بَيتٍ مِنْ بيوتِ اللهِ يَتلونَ كِتابِ اللهِ وَيتَدارَسونهَ بَينَهُم إِلا نَزَلَت عَلَيهُم السَّكينَة وَغَشيَتهم الرَّحمَة وحَفَتهُمُ المَلائِكة وَذَكَرهُم اللهُ فيمَن عِندَهُ، وَمَنْ بَطَّأ بِهِ عَمَلُهُ لَمْ يُسْرِعْ بهِ نَسَبُهُ ) – رواه مسلم بهذا اللفظ";
    ins_terjemahan = "Dari Abu Hurairah radhiallahu ‘anhu dari Nabi Shallallahu ‘alaihi wa Sallam, beliau bersabda : “Barang siapa yang melepaskan satu kesusahan seorang mukmin, pasti Allah akan melepaskan darinya satu kesusahan pada hari kiamat. Barang siapa yang menjadikan mudah urusan orang lain, pasti Allah akan memudahkannya di dunia dan di akhirat. Barang siapa yang menutup aib seorang muslim, pasti Allah akan menutupi aibnya di dunia dan di akhirat. Allah senantiasa menolong hamba-Nya selama hamba-Nya itu suka menolong saudaranya. Barang siapa menempuh suatu jalan untuk mencari ilmu, pasti Allah memudahkan baginya jalan ke surga. Apabila berkumpul suatu kaum di salah satu masjid untuk membaca Al Qur’an secara bergantian dan mempelajarinya, niscaya mereka akan diliputi sakinah (ketenangan), diliputi rahmat, dan dinaungi malaikat, dan Allah menyebut nama-nama mereka di hadapan makhluk-makhluk lain di sisi-Nya. Barangsiapa yang lambat amalannya, maka tidak akan dipercepat kenaikan derajatnya”. (Lafazh riwayat Muslim)"
        "\n\n"
        "[Muslim no. 2699]";
    ins_isi = "Hadits ini amat berharga, mencakup berbagai ilmu, prinsip-prinsip agama, dan akhlaq. Hadits ini memuat keutamaan memenuhi kebutuhan-kebutuhan orang mukmin, memberi manfaat kepada mereka dengan fasilitas imu, harta, bimbingan atau petunjuk yang baik, atau nasihat dan sebagainya."
        "\n"
        "Kalimat “barang siapa yang menutup aib seorang muslim” , maksudnya menutupi kesalahan orang-orang yang baik, bukan orang-orang yang sudah dikenal suka berbuat kerusakan. Hal ini berlaku dalam menutup perbuatan dosa yang terjadi. Adapun bila diketahui seseorang berbuat maksiat, tetapi dia meragukan kemaksiatannya, maka hendaklah ia segera dicegah dan dihalangi. Jika tidak mampu mencegahnya, hendaklah diadukan kepada penguasa, sekiranya langkah ini tidak menimbulkan kerugian yang lebih besar. Adapun orang yang sudah tahu bahwa hal itu maksiat tetapi tetap melanggarnya, hal itu tidak perlu ditutupi, Karena menutup kesalahannya dapat mendorong dia melakukan kerusakan dan tindakan menyakiti orang lain serta melanggar hal-hal yang haram dan menarik orang lain untuk berbuat serupa. Dalam hal semacam in dianjurkan untuk mengadukannya kepada penguasa, jika yang bersangkutan tidak khawatir terjadi bahaya. Begitu pula halnya dengan tindakan mencela rawi hadits, para saksi, pemungut zakat, pengurus waqaf, pengurus anak yatim, dan sebagainya, wajib dilakukan jika diperlukan. Tidaklah dibenarkan menutupi cacat mereka jika terbukti mereka tercela kejujurannya. Perbuatan semacam itu bukanlah termasuk menggunjing yang diharamkan, tetapi termasuk nasihat yang diwajibkan."
        "\n\n"
        "Kalimat “Allah senantiasa menolong hamba-Nya selama hamba-Nya itu suka menolong saudaranya”. Kalimat umum ini maksudnya ialah bahwa seseorang apabila punya keinginan kuat untuk menolong saudaranya, maka sepatutnya harus dikerjakan, baik dalam bentuk kata-kata ataupunpembelaan atas kebenaran, didasari rasa iman kepada Allah ketika melaksanakannya. Dalam sebuah hadits disebutkan tentang keutamaan memberikan kemudahan kepada orang yang berada dalam kesulitan dan keutamaan seseorang yang menuntut ilmu. Hal itu menyatakan keutamaan orang yang menyibukkan diri menuntut ilmu. Adapun ilmu yang dimaksud disini adalah ilmu syar’i dengan syarat niatnya adalah mencari keridhaan Allah, sekalipun syarat ini juga berlaku dalam setiap perbuatan ibadah."
        "\n\n"
        "Kalimat “Apabila berkumpul suatu kaum disalah satu masjid untuk membaca Al-Qur’an secara bergantian dan mempelajarinya” menunjukkan keutamaan berkumpul untuk membaca Al-Qur’an bersama-sama di Masjid."
        "\n\n"
        "Kata-kata “sakinah” dalam hadits, ada yang berpendapat maksudnya adalah rahmat, akan tetapi pendapat ini lemah karena kata rahmat juga disebutkan dalam hadits ini."
        "\n\n"
        "Pada kalimat “Apabila berkumpul suatu kaum” kata “kaum” disebutkan dalam bentuk nakiroh, maksudnya kaum apasaja yang berkumpul untuk melakukan hal seperti itu, akan mendapatkan keutamaan. Nabi Shallallahu ‘alaihi wa Sallam tidak mensyaratkan kaum tertentu misalnya ulama, golongan zuhud atau orang-orang yeng berkedudukan terpandang. Makna kalimat “Malaikat menaungi mereka” maksudnya mengelilingi dan mengitari sekelilingnya, seolah-olah para malaikat dekat dengan mereka sehingga menaungi mereka, tidak ada satu celah pun yang dapat disusupi setan. Kalimat “diliputi rahmat “ maksudnya dipayungi rahmat dari segala segi. Syaikh Syihabuddin bin Faraj berkata : “menurut pendapatku diliputi rahmat itu maksudnya ialah dosa-dosa yang telah lalu diampuni, Insya Allah”"
        "\n\n"
        "Kalimat “Allah menyebut nama-nama mereka di hadapan makhluk-makhluk lain disisi-Nya” mengisyaratkan bahwa, Allah menyebutkan nama-nama mereka dilingkungan para Nabi dan para Malaikat yang utama. Wallaahu a’lam.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");


    ///////////////// 37
    no=37;
    bookmark=0;
    ins_judul = "Pahala Kebaikan Berlipat Ganda";
    ins_arab = "عَن ابْنِ عَبَّاسٍ رَضِيَ اللهُ عَنْهُمَا عَنِ النبي صلى الله عليه وسلم فِيْمَا يَرْوِيْهِ عَنْ رَبِّهِ تَبَارَكَ وَتَعَالى أَنَّهُ قَالَ: ( إِنَّ الله كَتَبَ الحَسَنَاتِ وَالسَّيئَاتِ ثُمَّ بَيَّنَ ذَلِكَ؛ فَمَنْ هَمَّ بِحَسَنَةٍ فَلَمْ يَعْمَلْهَا كَتَبَهَا اللهُ عِنْدَهُ حَسَنَةً كَامِلَةً، وَإِنْ هَمَّ بِهَا فَعَمِلَهَا كَتَبَهَا اللهُ عِنْدَهُ عَشْرَ حَسَنَاتٍ إِلَى سَبْعِمائَةِ ضِعْفٍ إِلىَ أَضْعَاف كَثِيْرَةٍ. وَإِنْ هَمَّ بِسَيِّئَةٍ فَلَمْ يَعْمَلْهَا كَتَبَهَا اللهُ عِنْدَهُ حَسَنَةً كَامِلَةً، وَإِنْ هَمَّ بِهَا فَعَمِلَهَا كَتَبَهَا اللهُ سَيِّئَةً وَاحِدَةً ) – رَوَاهُ البُخَارِيُّ وَمُسْلِمٌ في صَحِيْحَيْهِمَا بِهَذِهِ الحُرُوْفِ";
    ins_terjemahan = "Dari Ibnu ‘Abbas radhiallahu ‘anhu, dari Rasulullah Shallallahu ‘alaihi wa Sallam, beliau meriwayatkan dari Tuhannya, Tabaaraka wa ta’aala. Firman-Nya : “Sesungguhnya Allah telah menetapkan nilai kebaikan dan kejahatan, kemudian Dia menjelaskannya. Maka barangsiapa berniat mengerjakan kebaikan tetapi tidak dikerjakannya, Allah mencatatnya sebagai satu kebaikan yang sempurna. Jika ia berniat untuk berbuat kebaikan lalu ia mengerjakannya, Allah mencatatnya sebagai 10 sampai 700 kali kebaikan atau lebih banyak lagi. Jika ia berniat melakukan kejahatan, tetapi ia tidak mengerjakannya, Allah mencatatkan padanya satu kebaikan yang sempurna. Jika ia berniat melakukan kejahatan lalu dikerjakannya, Allah mencatatnya sebagai satu kejahatan”."
        "\n"
        "(HR. Bukhari dan Muslim dalam Kitab Shahihnya dengan lafazh ini)"
        "\n\n"
        "[Bukhari no. 6491, Muslim no. 131]";
    ins_isi = "Pensyarah Hadits ini berkata : Ini adalah Hadits yang sangat mulia dan berharga. Nabi Shallallahu ‘alaihi wa Sallam menjelaskan betapa banyak kelebihan yang Allah berikan kepada makhluk-Nya. Di antaranya yaitu orang yang berniat melakukan kebaikan sekalipun belum dilaksanakan mendapat satu pahala, sedangkan orang yang berniat berbuat dosa tetapi tidak jadi dikerjakan, mendapat satu pahala, dan bila ia laksanakan mendapat satu dosa. Orang yang berniat baik kemudian melaksanakannya, Allah tetapkan baginya sepuluh kali pahala. Ini adalah suatu keutamaan yang sangat besar, yaitu dengan melipat gandakan pahala kebaikan, tetapi tidak melipat gandakan siksa atas perbuatan dosa. Allah tetapkan keinginan berbuat baik sebagai suatu kebaikan, karena keinginan berbuat baik itu merupakan perbuatan hati yang ditekadkannya."
        "\n\n"
        "Berdasarkan sabda ini ada yang berpendapat, seharusnya orang yang berniat berbuat dosa tetapi belum melaksanakannya dicatat sebagai satu dosa, karena keinginan melakukan sesuatu merupakan bagian dari pekerjaan hati. Ada pula yang berpendapat tidak seperti itu, sebab orang yang mengurungkan berbuat dosa dan menghapus keinginannya untuk berbuat dosa dan menggantinya dengan keinginan lain yang baik. Dengan demikian dia diberi pahala satu kebaikan. Tersebut pada Hadits lain : “ ia meninggalkan niat jeleknya itu karena takut kepada-Ku”"
        "\n"
        "Hadits ini semakna dengan sabda Nabi Shallallahu ‘alaihi wa Sallam : “Setiap muslim punya shadaqah”. Mereka (para sahabat) bertanya : “Sekalipun dia tidak melakukannya?” Sabda beliau : “Hendaklah dia mengurungkan niat jahatnya, maka hal itu menjadi sadaqah bagi dirinya”. (riwayat Bukhari dalam Kitab Adab)"
        "\n"
        "Adapun orang yang meninggalkan niat jahatnya karena dipaksa atau tidak sanggup menjalankannya, maka tidaklah dicatat sebagai suatu kebaikan (yang mendapat pahala) dan tidak termasuk dalam pembicaraan Hadits ini."
        "\n\n"
        "Thabari berkata : “Hadits ini membenarkan pendapat yang mengatakan : ’Pembatalan niat seseorang dalam melakukan kebaikan atau keburukan tetap dicatat oleh malaikat, asalkan dia menyadari apa yang diniatkan itu”. Ia membantah pendapat yang beranggapan bahwa malaikat hanya mencatat pembatalan pada perbuatan-perbuatan yang zhahir atau sesuatu yang dapat didengar. Ini berarti dua malaikat yang ditugasi mengawasi manusia mengetahui apa yang diniatkan oleh seseorang. Boleh juga Allah memberikan cara kepada para malaikat itu untuk mengetahui hal itu sebagaimana Allah telah memberikan jalan kepada sebagian besar nabi-Nya dalam beberapa perkara ghaib. Allah telah berfirman berkenaan dengan Isa ketika ia berkata kepeda Bani Israil : “Aku mengabarkan kepada kamu apa yang kamu makan dan apa yang kamu simpan di rumah-rumah kamu”. (QS. 3 : 49)"
        "\n\n"
        "Nabi Shallallahu ‘alaihi wa Sallam juga telah mengabarkan banyak perkara ghaib. Maka dapat saja Allah memberikan kepada dua malaikat itu cara untuk mengetahui niat baik atau niat buruk seseorang lalu dia mencatatnya, bila orang tersebut telah menjadikannya sebagai tekad. Ada pula yang berpendapat malaikat mengetahuinya dari angin yang keluar dari hati seseorang."
        "\n\n"
        "Para ulama salaf berselisih paham tentang dzikir manakah yang lebih baik, dzikir dalam hati atau dzikir dengan lisan. Ini semua adalah pendapat Ibnu Khalaf yang dikenal dengan nama Ibnu Bathal. Pengarang kitab Al Ifshah dalam salah satu pernyataannya mengatakan : Sesungguhnya tatkala Allah mengurangi umur umat Muhammad Shallallahu ‘alaihi wa Sallam, Allah mengganti kependekan umurnya itu dengan melipat gandakan pahala amalnya”. Barang siapa berniat berbuat baik maka dengan niatnya itu ia mendapatkan satu kebaikan penuh, sekalipun sekadar niat. Allah jadikan niatnya itu sebagai kebaikan penuh agar orang tidak beranggapan bahwa niat semata-mata mengurangi kebaikan atau sia-sia. Oleh karena itu, Nabi Shallallahu ‘alaihi wa Sallam menjelaskan dengan kata “kebaikan sempurna”. Jika seseorang berniat baik lalu melaksanakannya, hal itu berarti telah keluar dari lingkup niat menjelma kepada amal. Niat baiknya ditulis sebagai suatu kebaikan, kemudian perbuatan baiknya digandakan. Hal ini semua tergantung pada ikhlas atau tidaknya niat pada masing-masing perbuatan."
        "\n\n"
        "Selanjutnya pada kalimat “sampai dilipatgandakan banyak sekali” , digunakan bentuk kata nakirah (tidak terbatas) yang maknanya lebih luas daripada bentuk kata ma’rifah (terbatas). Kalimat semacam ini menunjukkan adanya pengertian pembalasan yang tidak terhingga banyaknya."
        "\n\n"
        "Kalimat janji Allah semacam ini dapat mencakup pernyataan : “Apabila seorang manusia mengeluarkan sedekah sebutir gandum, maka akan diberi pahala atas perbuatannya itu karena rahmat Allah. Sekiranya butiran gandum tersebut ditaburkan lalu tumbuh di tanah yang subur dan dipelihara, disiangi sesuai dengan kebutuhannya, lalu dipanen, maka akan tampak hasilnya. Kemudian hasilnya dapat ditanam lagi pada tanah yang subur lalu dipelihara seperti tanaman sebelumnya. Kemudian terus berjalan semacam itu pada tahun kedua, ketiga, keempat, dan seterusnya. Kemudian hal ini terus berlangsung sampai hari kiamat, sehingga sebutir gandum, sebutir biji sawi, atau sebatang rumput akhirnya dapat menjadi bertumpuk banyak setinggi gunung. Sekiranya sadaqah yang dikeluarkan hanya sebutir jagung karena iman, maka ia kelak akan melihat keuntungan atas sadaqahnya di waktu itu. Dan dihitung-hitung, jika dijual di pasar yang paling laris di negeri yang paling besar, tentulah barang semacam itu merupakan barang yang sangat laris. Kemudian bertambah berlipat ganda dan terus berjalan sampai hari kiamat, maka sebutir gandum tadi tumbuh sebagai benda yang besarnya sebesar dunia ini seluruhnya. Demikianlah balasan Allah atas semua amal kebaikan yang dilakukan, jika didasarkan pada niat yang ikhlas dan muncul dari hati yang ikhlas”."
        "\n\n"
        "Sesungguhnya Allah dengan rahmat-Nya berlipat ganda dalam memberi pahala kepada seseorang yang memberikan shadaqah satu dirham kepada orang fakir, lalu si fakir itu memberikannya kepada fakir lain yang lebih melarat dari dirinya, kemudian fakir lain tersebut memberikannya kepada fakir yang ketiga, dan yang ketiga memberikan kepada yang keempat, dan seterusnya. Dari kejadian seperti di atas, Allah akan memberi pahala kepada pemberi shadaqah pertama, dengan sepuluh kali. Bila fakir pertama yang memberikannya kepada fakir yang kedua, maka fakir pertama ini mendapat pahala sepuluh kali, dan pemberi shadaqah pertama mendapat pahala seratus kali (sepuluh kali sepuluh). Kemudian fakir kedua memberikannya kepada fakir ketiga, maka fakir kedua mendapat pahala sepuluh kali, fakir pertama mendapat pahala seratus kali, sedang pemberi shadaqah pertama pahala seratus kali, sedang pemberi shadaqah pertama mendapat pahala seribu kali. Bila fakir ketiga menshadaqahkan kapada fakir keempat, maka fakir ketiga mendapat sepuluh kali, fakir kedua mendapat pahala seratus kali, pemberi shadaqah pertama mendapat pahala sepuluh ribu kali sampai berlipat ganda sehingga tidak ada yang dapat menghitungnya kecuali Allah. Oleh karena itu, bila kelak Allah mengadili hamba-Nya yang muslim di hari kiamat, kebaikan mereka bertingkat-tingkat nilai ketinggiannya dan ada pula yang kurang nilainya, maka dengan kemurahan dan rahmat-Nya Allah akan memperhitungkan semua amal kebaikannya lebih besar daripada perbedaan nilai antara dua kebaikan. Allah berfirman : “Sungguh Kami pasti memberi pahala kepada mereka dengan yang lebih baik dari apa yang telah mereka lakukan”. (QS. 16 : 97)"
        "\n\n"
        "Sebagaimana seseorang yang berada di salah satu pasar kaum muslim mengucapkan kalimat “laailaaha illallaah wahdah, laa syariikalah …” dengan suara yang tinggi, maka Allah akan mencatat perbuatannya itu dengan memberi pahala seribu kebaikan dan dihapuskan dari orang itu seribu dosanya, serta ia akan diberi sebuah rumah di surga seperti yang tersebut pada sebuah Hadits. Kami terangkan di sini hanyalah apa yang kami ketahui saja, bukan berdasarkan kadar rahmat Allah yang sebenarnya, sebab Allah itu jauh lebih agung dari apa yang dapat digambarkan oleh makhluk. Wallahu a’lam";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");


    ///////////////// 38
    no=38;
    bookmark=0;
    ins_judul = "Ibadah Kepada Allah Adalah Jalan Taqorrub dan Cinta";
    ins_arab = "عَنْ أَبِي هُرَيْرَةَ رضي الله عنه قَالَ: قَالَ رَسُولُ اللهِ صلى الله عليه وسلم: ( إِنَّ اللهَ تَعَالَى قَالَ: مَنْ عَادَى لِي وَلِيَّاً فَقَدْ آذَنْتُهُ بِالحَرْبِ. وَمَا تَقَرَّبَ إِلِيَّ عَبْدِيْ بِشَيءٍ أَحَبَّ إِلِيَّ مِمَّا افْتَرَضْتُهُ عَلَيْهِ. ولايَزَالُ عَبْدِيْ يَتَقَرَّبُ إِلَيَّ بِالنَّوَافِلِ حَتَّى أُحِبَّهُ، فَإِذَا أَحْبَبتُهُ كُنْتُ سَمْعَهُ الَّذِيْ يَسْمَعُ بِهِ، وَبَصَرَهُ الَّذِيْ يُبْصِرُ بِهِ، وَيَدَهُ الَّتِي يَبْطِشُ بِهَا، وَرِجْلَهُ الَّتِي يَمْشِيْ بِهَا. وَلَئِنْ سَأَلَنِيْ لأُعطِيَنَّهُ، وَلَئِنْ اسْتَعَاذَنِيْ لأُعِيْذَنَّهُ ) – رواه البخاري";
    ins_terjemahan = "Dari Abu Hurairah radhiallahu ‘anh, ia berkata : Rasulullah Shallallahu ‘alaihi wa Sallam “Sesungguhnya Allah ta’ala telah berfirman : ‘Barang siapa memusuhi wali-Ku, maka sesungguhnya Aku menyatakan perang terhadapnya. Hamba-Ku senantiasa (bertaqorrub) mendekatkan diri kepada-Ku dengan suatu (perbuatan) yang Aku sukai seperti bila ia melakukan yang fardhu yang Aku perintahkan kepadanya. Hamba-Ku senantiasa (bertaqorrub) mendekatkan diri kepada-Ku dengan amalan-amalan sunah hingga Aku mencintainya. Jika Aku telah mencintainya, maka jadilah Aku sebagai pendengarannya yang ia gunakan untuk mendengar, sebagai penglihatannya yang ia gunakan untuk melihat, sebagai tangannya yang ia gunakan untuk memegang, sebagai kakinya yang ia gunakan untuk berjalan. Jika ia memohon sesuatu kepada-Ku, pasti Aku mengabulkannya dan jika ia memohon perlindungan, pasti akan Aku berikan kepadanya.”"
        "\n\n"
        "[Bukhari no. 6502]";
    ins_isi = "Pengarang Kitab Al-Ifshah berkata : “Hadits ini mengandung pengertian bahwa Allah menyampaikan ancaman kepada setiap orang yang memusuhi wali-Nya. Allah mengumumkan bahwa Dia-lah yang memerangi orang yang menjadi wali-Nya. Wali Allah yaitu orang yang mengikuti syari’at-Nya, oleh karena itu hendaklah manusia takut untuk berbuat menyakiti hati wali-wali Allah. Memusuhi disini berarti menjadikan wali Allah sebagai musuh, yaitu memusuhi seseorang karena dia menjadi wali Alloh. Adapun jika terjadi perselisihan antara wali Alloh karena memperebutkan hak, maka hal semacam ini tidak termasuk dalam makna memusuhi yang dimaksud dalam hadits ini, sebab pernah terjadi perselisihan antara Abu Bakar dan Umar, Abbas dan Ali dan banyak lagi sahabat yang lain, padahal mereka semua adalah wali-wali Alloh”"
        "\n"
        "Kalimat, “Hamba-Ku senantiasa (bertaqorrub) mendekatkan diri kepada-Ku dengan suatu (perbuatan) yang Aku sukai seperti bila ia melakukan yang fardhu yang Aku perintahkan kepadanya” menyatakan bahwa yang sunnah tidak boleh didahulukan dari yang wajib. Suatu perbuatan sunnah mestinya dilakukan apabila yang wajib sudah dilakukan, dan tidak disebut menjalankan yang sunnah sebelum yang wajib dilakukan. Hal ini ditunjukkan oleh kalimat, “Hamba-Ku senantiasa (bertaqorrub) mendekatkan diri kepada-Ku dengan amalan-amalan sunah hingga Aku mencintainya” yaitu karena ia bertaqorrub dengan amalan yang sunnah yang mengiringi amalan yang wajib. Bila seorang hamba selalu , mendekatkan diri dengan amalan yang sunnah, maka hal itu akan menjadikannya orang yang dicintai Alloh."
        "\n\n"
        "Kemudian kalimat, “Jika Aku telah mencintainya, maka jadilah Aku sebagai pendengarannya yang ia gunakan untuk mendengar, sebagai penglihatannya yang ia gunakan untuk melihat, sebagai tangannya yang ia gunakan untuk memegang, sebagai kakinya yang ia gunakan untuk berjalan” Hal ini merupakan tanda kecintaan Alloh terhadap orang yang dicintai-Nya, maksudnya orang itu tidak akan mau mendengar hal-hal yang dilarang oleh syari’at, tidak mau melihat hal-hal yang tidak dibenarkan oleh syari’at, tidak mau mengulurkan tangannya memegang sesuatu yang tidak dibenarkan oleh syari’at dan tidak mau melangkahkan kakinya kecuali hanya kepada hal-hal yang dibenarkan oleh syari’at. Inilah pokok permasalahannya."
        "\n"
        "Akan tetapi, seringkali ketika seseorang menyebut nama Alloh hingga disebut sebagai ahli dzikir, sampai ia tidak mau mendengar perkataan orang yang berbicara dengannya, kemudian orang yang bukan ahli dzikir berusaha mendekat kepada orang yang ahli dzikir ini, karena ingin menjadikannya sebagai perantara, agar Alloh mendengarkan permohonan mereka. Begitu pula dengan mubashirot (orang yang merasa dirinya bisa melihat Alloh), mutanawilat (orang yang merasa dirinya mampu menjangkau Alloh) dan mas’aa ilaih (orang yang merasa dirinya telah melangkah menuju Alloh) Semuanya itu adalah sifat yang mulia. Kita memohon kepada Alloh semoga kita termasuk kedalam golongan (yang dicintai Alloh) ini."
        "\n\n"
        "Kalimat, “Jika ia memohon sesuatu kepada-Ku, pasti Aku mengabulkannya dan jika ia memohon perlindungan, pasti akan Aku berikan kepadanya” menunjukkan bahwa seseorang yang telah menjadi golongan yang dicintai Alloh, maka permohonan kepada Alloh tidak akan terintangi dan Alloh akan memberikan perlindungan kepadanya dari siapa saja yang menakutinya. Alloh Maha Kuasa untuk memberikan sesuatu kepadanya sebelum ia memintanya dan memberi perlindungan sebelum ia memohon. Akan tetapi Alloh senantiasa mendekat kepada hamba-Nya dengan memberi sesuatu kepada orang-orang yang meminta dan melindungi orang-orang yang meminta perlindungan."
        "\n\n"
        "Kalimat pada awal hadits, “maka sesungguhnya Aku menyatakan perang terhadapnya” maksudnya Aku menyatakan kepada orang yang seperti itu bahwa dia telah memerangi Aku. Wallahu a’lam.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");


    ///////////////// 39
    no=39;
    bookmark=0;
    ins_judul = "Perilaku Yang Dimaafkan";
    ins_arab = "عَنِ ابْنِ عَبَّاسٍ رَضِيَ اللهُ عَنْهُمَا أَنَّ رَسُولَ اللهِ صلى الله عليه وسلم قَال: ( إِنَّ اللهَ تَجَاوَزَ لِي عَنْ أُمَّتِي الخَطَأَ وَالنِّسْيَانَ وَمَا اسْتُكْرِهُوا عَلَيْهِ ) – حديث حسن رواه ابن ماجه والبيهقي وغيرهما";
    ins_terjemahan = "Dari Ibnu Abbas radhiyallahu anhuma, sesungguhnya Rasululloh Shallallahu ‘alaihi wa Sallam telah bersabda : ” Sesungguhnya Allah telah mema’afkan kesalahan-kesalahan uamt-Ku yang tidak disengaja, karena lupa dan yang dipaksa melakukannya” (HR. Ibnu Majah, Baihaqi dll, hadits hasan)"
        "\n\n"
        "[Ibnu Majah no. 2405, Baihaqi (As-Sunan no. 7/356), dan yang lain]";
    ins_isi = "Hadits ini disebutkan dalam tafsir ayat : “Jika kamu melahirkan apa yang ada dihati kamu atau kamu sembunyikan, maka Allah akan mengadili kamu dengan apa yang kamu lakukan itu” (QS. 2 : 284)"
        "\n\n"
        "Ayat ini menyebabkan para sahabat merasa tertekan. Oleh karena itu, Abu Bakar, ‘Umar, ‘Abdurrahman bin ‘Auf, dan Mu’adz bin Jabal beberapa orang mendatangi Rasulullah Shallallahu ‘alaihi wa Sallam dan mereka berkata : “Kami dibebani amal yang tak sanggup kami memikulnya. Sesungguhnya seseorang di antara kami dalam hatinya ada bisikan yang tidak disenanginya, sekalipun bisikan itu menjanjikan dunia. Nabi Shallallahu ‘alaihi wa Sallam lalu menjawab : “Boleh jadi kamu mengucapkan kalimat seperti yang diucapkan Bani Israil, yaitu kami mau mendengar tetapi kami akan menentangnya. Karena itu katakanlah : ‘Kami mau mendengar dan mau menaati”. Hal itu membuat mereka merasa tertekan dan mereka diam untuk sementara. Lalu Allah memberikan kelonggaran dan rahmat-Nya dengan berfirman : “Allah tidak membebani seseorang kecuali sesuai kemampuannya. Ia akan mendapatkan pahala atas usahanya dan mendapatkan siksa atas kesalahannya, (lalu ia berdo’a) : ‘Ya Tuhan kami, janganlah Engkau hukum kami jika kami lupa atau tersalah”. (QS. 2 : 286)"
        "\n\n"
        "Allah memberikan keringanan dan mansukh (terhapus)lah ayat yang pertama di atas. Imam Baihaqi berkata bahwa Imam Syafi’i berkata : “Allah berfirman : Kecuali orang yang dipaksa, sedang hatinya merasa tentram dengan imannya (maka orang semacam ini tidak berdosa)”."
        "\n\n"
        "Ada beberapa hukum bagi sikap kekafiran ketika Allah menyatakan bahwa kekufuran tidak terdapat pada orang yang dipaksa, maksudnya bahwa menyatakan kekufuran secara lisan karena dipaksa tidak dianggap kufur. Jika sesuatu yang lebih berat dianggap gugur, maka yang lebih ringan lebih patut untuk gugur. Kemudian disebutkan adanya riwayat dari Ibnu ‘Abbas dari Rasulullah Shallallahu ‘alaihi wa Sallam : “Sesungguhnya Allah membebaskan umatku (dari dosa) karena keliru atau lupa atau dipaksa”."
        "\n"
        "Dan diriwayatkan dari ‘Aisyah, dari Nabi Shallallahu ‘alaihi wa Sallam, bahwa beliau bersabda : “Tidak ada thalaq dan pembebasan budak karena pemaksaan”."
        "\n"
        "Demikianlah pendapat ‘Umar, Ibnu ‘Umar dan Ibnu Zubai."
        "\n\n"
        "Tsabit bin Al Ahnaf menikahi perempuan budak yang melahirkan anak milik ‘Abdurrahman bin Zaid bin Khathab. Lalu ‘Abdurrahman memaksa Tsabit dengan teror dan cemeti untuk menceraikan istrinya pada masa khalifah Ibnu Zubair. Ibnu ‘Umar berkata kepadanya : “Perempuan itu belum terthalaq dari kamu, karena itu kembalilah kepada istrimu”. Saat itu Ibnu Zubair di Makkah, maka ia disusul, lalu ia menulis surat kepada gubernurnya di Madinah. Isi surat tersebut, supaya Tsabit dikembalikan kepada istrinya dan ‘Abdurrahman bin Zaid dikenai hukuman. Kemudian Shafiyah binti Abu ‘Ubaid, istri ‘Abdullah bin ‘Umar, mempersiapkan upacara walimahnya dan ‘Abdullah bin ‘Umar menghadiri walimah ini. Wallaahu a’lam.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");


    ///////////////// 40
    no=40;
    bookmark=0;
    ins_judul = "Dunia Adalah Jalan dan Ladang Akhirat";
    ins_arab = "عَنِ ابْنِ عُمَرَ رَضِيَ اللهُ عَنْهُمَا قَالَ: أَخَذَ رَسُولُ اللهِ صلى الله عليه وسلم بِمنْكبيَّ فَقَالَ: ( كُنْ فِي الدُّنْيَا كَأَنَّكَ غَرِيْبٌ أَوْ عَابِرُ سَبِيْلٍ ) وَكَانَ ابْنُ عُمَرَ رَضِيَ اللهُ عَنْهُمَا يَقُوْلُ: إِذَا أَمْسَيْتَ فَلا تَنْتَظِرِ الصَّبَاحَ، وَإِذَا أَصْبَحْتَ فَلا تَنْتَظِرِ المَسَاءَ. وَخُذْ مِنْ صِحَّتِكَ لِمَرَضِكَ، وَمِنْ حَيَاتِكَ لمَوْتِكَ. – رواه البخاري";
    ins_terjemahan = "Dari Ibnu Umar radhiallahu ‘anhuma, ia berkata : “Rasulullah Shallallahu ‘alaihi wa Sallam memegang pundakku, lalu bersabda : Jadilah engkau di dunia ini seakan-akan sebagai orang asing atau pengembara. Lalu Ibnu Umar radhiyallahu anhuma berkata : “Jika engkau di waktu sore, maka janganlah engkau menunggu pagi dan jika engkau di waktu pagi, maka janganlah menunggu sore dan pergunakanlah waktu sehatmu sebelum kamu sakit dan waktu hidupmu sebelum kamu mati”."
        "\n\n"
        "[Bukhari no. 6416]";
    ins_isi = "Imam Abul Hasan Ali bin Khalaf dalam syarah Bukhari berkata bahwa Abu Zinad berkata : “Hadits ini bermakna menganjurkan agar sedikit bergaul dan sedikit berkumpul dengan banyak orang serta bersikap zuhud kepada dunia”. Abul Hasan berkata : “Maksud dari Hadits ini ialah orang asing biasanya sedikit berkumpul dengan orang lain sehingga dia terasing dari mereka, karena hampir-hampir dia hanya berkumpul dan bergaul dengan orang ini saja. Ia menjadi orang yang merasa lemah dan takut. Begitu pula seorang pengembara, ia hanya mau melakukan perjalanan sebatas kekuatannya. Dia hanya membawa beban yang ringan agar dia tidak terbebani untuk menempuh perjalanannya. Dia hanya membawa bekal dan kendaraan sebatas untuk mencapai tujuannya. Hal ini menunjukkan bahwa sikap zuhud terhadap dunia dimaksudkan untuk dapat sampai kepada tujuan dan mencegah kegagalan, seperti halnya seorang pengembara yang hanya membawa bekal sekadarnya agar sampai ke tempat yang dituju. Begitu pula halnya dengan seorang mukmin dalam kehidupan di dunia ini hanyalah membutuhkan sekadar untuk mencapai tujuan hidupnya."
        "\n"
        "Al ‘Iz ‘Ala’uddin bin Yahya bin Hubairah berkata : “Hadits ini menunjukkan bahwa Rasulullah Shallallahu ‘alaihi wa Sallam menganjurkan untuk meniru perilaku orang asing, karena orang asing yang baru tiba di suatu negeri tidaklah mau berlomba di tempat yang disinggahinya dengan penghuninya dan tidak ingin mengejutkan orang lain dengan melakukan hal-hal yang menyalahi kebiasaan mereka misalnya dalam berpakaian, dan tidak pula menginginkan perselisihan dengan mereka. Begitu pula para pengembara tidak mau membuat rumah atau tidak pula mau membuat permusuhan dengan orang lain, karena ia menyadari bahwa dia tinggal bersama mereka hanya beberapa hari. Keadaan orang merantau dan pengembara semacam ini dianjurkan untuk menjadi sikap seorang mukmin ketika hidup di dunia, karena dunia bukan merupakan tanah air bagi dirinya, juga karena dunia membatasi dirinya dari negerinya yang sebenarnya dan menjadi tabir antara dirinya dengan tempat tinggalnya yang abadi."
        "\n\n"
        "Adapun perkataan Ibnu Umar “Jika engkau di waktu sore, maka janganlah engkau menunggu pagi dan jika engkau di waktu pagi, maka janganlah menunggu sore” merupakan anjuran agar setiap mukmin senantiasa siap menghadapi kematian, dan kematian itu dihadapi dengan bekal amal shalih. Ia juga menganjurkan untuk mempersedikit angan-angan. Janganlah menunda amal yang dapat dilakukan pada malam hari sampai datang pagi hari, tetapi hendaklah segera dilaksanakan. Begitu pula jika berada di pagi hari, janganlah berbiat menunda sampai datang sore hari dan menunda amal di pagi hari samapi datang malam hari."
        "\n\n"
        "Kalimat “pergunakanlah waktu sehatmu sebelum kamu sakit” menganjurkan agar mempergunakan saat sehatnya dan berusaha dengan penuh kesungguhan selama masa itu karena khawatir bertemu dengan masa sakit yang dapat merintangi upaya beramal. Begitu pula “waktu hidupmu sebelum kamu mati” mengingatkan agar mempergunakan masa hidupnya, karena angan-angannya lenyap, serta akan muncul penyesalan yang berat karena kelengahannya sampai dia meninggalkan kebaikan. Hendaklah ia menyadari bahwa dia akan menghadapi masa yang panjang di alam kubur tanpa dapat beramal apa-apa dan tidak mungkin dapat mengingat Allah. Oleh karena itu, hendaklah ia memanfaatkan seluruh masa hidupnya itu untuk berbuat kebajikan. Alangkah padatnya Hadits ini, karena mengandung makna-makna yang baik dan sangat berharga."
        "\n\n"
        "Sebagian ulama berkata : “Allah mencela angan-angan dan orang yang panjang angan-angan”."
        "\n"
        "Firman-Nya : “Biarkanlah mereka (orang-orang kafir) makan dan bersenang-senang serta dilengahkan oleh angan-angan, maka kelak mereka akan mengetahui akibatnya”. (QS. 15 : 3)"
        "\n"
        "Ali bin Abu Thalib berkata : “Dunia berjalan meninggalkan (manusia) sedangkan akhirat berjalan menjemput (manusia) dan masing-masingnya punya penggemar, karena itu jadilah kamu penggemar akhirat dan jangan menjadi penggemar dunia. Sesungguhnya masa ini (hidup di dunia) adalah masa beramal bukan masa peradilan, sedangkan besok (hari akhirat) adalah masa peradilan bukan masa beramal”."
        "\n"
        "Anas berkata bahwa Nabi Shallallahu ‘alaihi wa Sallam pernah membuat beberapa garis, lalu beliau bersabda : “Ini adalah mannusia dan ini adalah angan-angannya dan ini adalah ajalnya ketika ia berada dalam angan-angan tiba-tiba datang kepadanya garisnya yang paling dekat (yaitu ajalnya)”."
        "\n"
        "Hadits ini memperingatkan agar orang mempersedikit angan-angan karena takut kedatangan ajalnya yang tiba-tiba dan selalu ingat bahwa ajalnya telah dekat. Barang siapa yang mengabaikan ajalnya, maka patutlah dia didatangi ajalnya dengan tiba-tiba dan diserang ketika ia dalam keadaan terperdaya dan lengah, karena manusia itu sering terperdaya oleh angan-angannya."
        "\n\n"
        "Abdullah bin Umar berkata : “Rasulullah Shallallahu ‘alaihi wa Sallam melihat aku ketika aku dan ibuku sedang memperbaiki salah satu pagar milikku. Beliau bertanya:"
        "\n"
        "‘sedang melakukan apa ini wahai Abdullah?’"
        "\n"
        "Saya jawab : ‘Wahai Rasulullah, telah rapuh pagar ini, karena itu kami memperbaikinya’. Lalu beliau bersabda : ‘Kehidupan ini lebih cepat dari rapuhnya pagar ini’."
        "\n\n"
        "Kita memohon kepada Allah semoga kita dirahmati dan dijadikan orang yang zuhud terhadap kehidupan dunia dan menjadikan kita bersemangat mengejar apa yang ada di sisi-Nya dan menjadikan kita memperoleh kesenangan di hari kiamat. Sesungguhnya Dia adalah Tuhan yang Maha Dermawan, Maha Pemurah, Maha Pengampun dan Maha Belaskasih. Wallahu a’lam";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");


    ///////////////// 41
    no=41;
    bookmark=0;
    ins_judul = "Menundukkan Hawa Nafsu";
    ins_arab = "عَنْ أَبِيْ مُحَمَّدٍ عَبْدِ اللهِ بِنِ عمْرِو بْنِ العَاصِ رَضِيَ اللهُ عَنْهُمَا قَالَ: قَالَ رَسُولُ اللهِ صلى الله عليه وسلم: ( لاَيُؤْمِنُ أَحَدُكُمْ حَتَّى يَكُونَ هَواهُ تَبَعَاً لِمَا جِئْتُ بِهِ ) – حَدِيْثٌ حَسَنٌ صَحِيْحٌ رَوَيْنَاهُ فِي كِتَابِ الحُجَّةِ بِإِسْنَادٍ صَحِيْحٍ";
    ins_terjemahan = "Dari Abu Muhammad, Abdullah bin Amr bin Al ‘Ash radhiallahu ‘anhuma, ia berkata : Rasulullah Shallallahu ‘alaihi wa Sallam telah bersabda : “Tidak sempurna iman seseorang di antara kamu sehingga hawa nafsunya tunduk kepada apa yang telah aku sampaikan”. (Hadits hasan shahih dalam kitab Al Hujjah)"
        "\n\n"
        "Hadits ini tergolong dho’if. Lihat Qowa’id Wa Fawa’id minal Arba’in An Nawawiyah, karangan Nazim Muhammad Sulthan hal.355, Misykatul Mashabih takhrij Syaikh Al Albani, hadits no.167,juz 1, jami’ Al Ulum wal Hikam oleh ibnu Rajab";
    ins_isi = "Hadits ini semakna dengan firman Allah : “Demi Tuhanmu, mereka tidak dikatakan beriman sebelum mereka berhukum kepada kamu mengenai perselisihan sesama mereka dan mereka tidak merasa berat hati atas keputusan kamu serta menerima dengan pasrah sepenuhnya”. (QS. 4 : 65)"
        "\n\n"
        "Sebab turunnya ayat ini ialah karena Zubair bersengketa dengan seorang sahabat dari golongan Anshar dalam perkara air. Kedua orang ini datang kepada Rasulullah Shallallahu ‘alaihi wa Sallam untuk mendapatkan keputusan. Lalu Nabi Shallallahu ‘alaihi wa Sallam bersabda : “Wahai Zubair, alirkanlah dan tuangkanlah air kepada tetanggamu itu”. Nabi Shallallahu ‘alaihi wa Sallam menganjurkan kepada Zubair untuk bersikap memudahkan dan toleransi. Akan tetapi, sahabat Anshar itu berkata : “Apakah karena dia anak bibimu?” Maka merahlah wajah Rasulullah Shallallahu ‘alaihi wa Sallam kemudian sabda beliau : “Wahai Zubair, tutuplah alirannya sampai airnya naik ke atas pagar kemudian biarkanlah hingga tumpah”. Rasulullah Shallallahu ‘alaihi wa Sallam melakukan hal semacam itu untuk memberi isyarat kepada Zubair bahwa apa yang diputuskan beliau mengandung mashlahat bagi golongan Anshar. Tatkala orang Ashar memahami sabda Nab Shallallahu ‘alaihi wa Sallam itu, maka Zubair menyadari apa yang menjadi hak dan kewajibannya. Karena kejadian itulah ayat ini turun."
        "\n\n"
        "Hadits yang shahih dari Nabi , beliau bersabda : “Demi diriku yang ada di dalam kekuasaan-Nya, seseorang di antara kamu tidak dikatakan beriman sebelum ia mencintai aku lebih dari cintanya kepada bapaknya, anaknya, dan semua manusia”. Abu Zinad berkata : “Hadits ini termasuk kalimat pendek yang padat berisi, karena di dalam kalimat ini digunakan kalimat yang singkat tetapi maknanya luas. Cinta itu ada tiga macam, yaitu cinta yang didorong oleh rasa menghormati dan memuliakan seperti cinta kepada orang tua, cinta didorong oleh kasih sayang seperti mencintai anak dan cinta karena saling mengharapkan kebaikan seperti mencintai orang lain”."
        "\n\n"
        "Ibnu Bathal berkata : “Hadits di atas maksudnya —Wallaahu a’lam— adalah barang siapa yang ingin imannya menjadi sempurna, maka ia harus mengetahui bahwa hak dan keutamaan Rasulullah Shallallahu ‘alaihi wa Sallam lebih besar daripada hak bapaknya, anaknya dan semua manusia, karena melalui Rasulullah Shallallahu ‘alaihi wa Sallam inilah Allah menyelamatkan dirinya dari neraka dan memberinya petunjuk sehingga terjauh dari kesesatan. Jadi, maksud Hadits di atas adalah mengorbankan diri dan jiwa untuk membela Rasulullah Shallallahu ‘alaihi wa Sallam berperang melawan bapak mereka atau anak mereka atau saudara mereka (yang melawan Rasulullah Shallallahu ‘alaihi wa Sallam). Abu Ubaidah telah membunuh bapaknya karena menyakiti Rasulullah Shallallahu ‘alaihi wa Sallam. Abu Bakar menghadapi anaknya, Abdurrahman, dalam perang Badar dan hampir saja anak itu dibunuhnya. Barang siapa melakukan hal semacam ini, sungguh ia dapat dikatakan kemauan-kemauannya tunduk kepada apa yang diajarkan Nabi Shallallahu ‘alaihi wa Sallam kepadanya.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");


    ///////////////// 42
    no=42;
    bookmark=0;
    ins_judul = "Luasnya Ampunan Allah";
    ins_arab = "عَنْ أَنَسِ بْنِ مَالِكٍ رضي الله عنه قَالَ: سَمِعْتُ رَسُولَ اللهِ يَقُولُ: قَالَ اللهُ تَعَالَى: ( يَا ابْنَ آَدَمَ إِنَّكَ مَا دَعَوتَنِيْ وَرَجَوتَنِيْ غَفَرْتُ لَكَ عَلَى مَا كَانَ مِنْكَ وَلا أُبَالِيْ، يَا ابْنَ آَدَمَ لَو بَلَغَتْ ذُنُوبُكَ عَنَانَ السَّمَاءِ ثُمَّ استَغْفَرْتَنِيْ غَفَرْتُ لَكَ، يَا ابْنَ آَدَمَ إِنَّكَ لَو أَتَيْتَنِيْ بِقِرَابِ الأَرْضِ خَطَايَا ثُمَّ لقِيْتَنِيْ لاَتُشْرِك بِيْ شَيْئَاً لأَتَيْتُكَ بِقِرَابِهَا مَغفِرَةً ) – رَوَاهُ التِّرْمِذِيُّ وَقَالَ: حَدِيْثٌ حَسَنٌ صَحَيْحٌ";
    ins_terjemahan = "Dari Anas radhiallahu ‘anhu, ia berkata : Saya telah mendengar Rasulullah Shallallahu ‘alaihi wa Sallam bersabda : Allah ta’ala telah berfirman : “Wahai anak Adam, selagi engkau meminta dan berharap kepada-Ku, maka Aku akan mengampuni dosamu dan Aku tidak pedulikan lagi. Wahai anak Adam, walaupun dosamu sampai setinggi langit, bila engkau mohon ampun kepada-Ku, niscaya Aku memberi ampun kepadamu. Wahai anak Adam, jika engkau menemui Aku dengan membawa dosa sebanyak isi bumi, tetapi engkau tiada menyekutukan sesuatu dengan Aku, niscaya Aku datang kepadamu dengan (memberi) ampunan sepenuh bumi pula”. (HR. Tirmidzi, Hadits hasan shahih)"
        "\n\n"
        "[Tirmidzi no. 3540]";
    ins_isi = "Hadits ini berisikan kabar gembira, belas kasih dan kemurahan yang besar. Tidak terhitung banyaknya karunia, kebaikan, belas kasih dan pemberian Allah kepada hamba-Nya. Yang semakna dengan Hadits ini adalah sabda Nabi Shallallahu ‘alaihi wa Sallam : “Allah lebih bergembira atas tobat seorang hamba-Nya daripada (kegembiraan) seseorang di antara kamu yang menemukan kembali hewannya yang hilang”."
        "\n"
        "Dari Abu Ayyub ketika ia hendak wafat ia berkata : Saya telah merahasiakan dari kalian sesuatu yang pernah aku dengar dari Rasulullah Shallallahu ‘alaihi wa Sallam, yaitu saya mendengar beliau bersabda : “Sekiranya kamu sekalian tidak mau berbuat dosa, niscaya Allah akan menggantinya dengan makhluk lain yang mau berbuat dosa, lalu Allah memberi ampun kepada mereka”."
        "\n\n"
        "Juga banyak Hadits lain yang semakna dengan Hadits ini."
        "\n"
        "Sabda beliau “wahai anak Adam, selagi engkau meminta dan berharap kepada-Ku” semakna dengan sabda beliau : “Aku senantiasa mengikuti anggapan hamba-Ku kepada-Ku. Oleh karena itu, hendaknya ia mempunyai anggapan kepada-Ku sesuai kesukaannya”."
        "\n\n"
        "Telah disebutkan bahwa bila seorang hamba (manusia) telah berbuat dosa kemudian menyesal, misalnya dengan mengatakan : “Wahai Tuhanku, aku telah berbuat dosa, karena itu ampunilah aku. Tidak ada yang dapat mengampuni dosa-dosaku kecuali Engkau”. Maka Allah akan menjawab : “Hamba-Ku mengakui bahwa dia mempunyai Tuhan yang mengampuni dosanya dan menghukum kesalahannya, karena itu Aku persaksikan kepada kamu sekalian bahwa Aku telah memberikan ampunan kepadanya”. Kemudian hamba itu berbuat seperti itu kedua atau ketiga kalinya, lalu Allah menjawab seperti itu setiap kali terulang kejadian itu. Kemudian Allah berfirman: “Berbuatlah sesukamu, karena Aku telah mengampuni kamu” maksudnya ketika kamu berbuat dosa kemudian kamu mohon ampun."
        "\n\n"
        "Ketahuilah, syarat bertobat itu ada tiga, yaitu meninggalkan perbuatan maksiatnya, menyesali yang sudah terjadi dan bertekad tidak akan mengulangi. Jika kesalahan itu berkaitan dengan sesama manusia, maka hendaklah ia segera menunaikan apa yang menjadi hak orang lain atau minta dihalalkan. Jika berkaitan dengan Allah, sedangkan di dalam urusan tersebut ada sanksi kafarat, maka hendaklah ia segera menunaikan pembayaran kafarat. Ini adalah syarat keempat. Sekiranya seseorang mengulangi dosanya berkali-kali dalam satu hari dan ia melakukan tibat sesuai dengan syarat tersebut, maka Allah akan mengampuni dosanya."
        "\n\n"
        "Sabda beliau (Allah berfirman) : “maka Aku akan mengampuni dosamu dan Aku tidak pedulikan lagi” maksudnya engkau mengulangi perbuatan dosa kamu dan Aku tidak mempermasalahkan dosa-dosamu itu."
        "\n\n"
        "Sabda beliau (Allah berfirman) : “Wahai anak Adam, walaupun dosamu sampai setinggi langit, bila engkau mohon ampun kepada-Ku, niscaya Aku memberi ampun kepadamu” maksudnya adalah sekiranya dosa beberapa orang dikumpulkan, kemudian memenuhi ruang antara langit dan bumi. Hal ini menunjukkan seberapa pun besarnya dosa, tetapi kemurahan, belas kasih Allah pengampunan-Nya jauh lebih luas dan lebih besar, sehingga tidak berimbang antara dosa dan pengampunan dan siat keagungan Allah ini tidak terhingga, sehingga dosa yang memenuhi alam ini tidak mengalahkan sifat pemurah dan pengampunan-Nya."
        "\n\n"
        "Sabda beliau (Allah berfirman) : “Wahai anak Adam, jika engkau menemui Aku dengan membawa dosa sebanyak isi bumi, tetapi engkau tiada menyekutukan sesuatu dengan Aku, niscaya Aku datang kepadamu dengan (memberi) ampunan sepenuh bumi pula” maksudnya adalah engkau datang kepada-Ku dengan membawa dosa-dosa sebesar bumi."
        "\n\n"
        "Kalimat “kemudian engkau menemui Aku” maksudnya engkau mati dalam keadaan beriman, tanpa sedikit pun menyekutukan Aku dengan apa pun tiada rasa senang bagi orang mukmin yang melebihi rasa senangnya saat ia bertemu Tuhannya. Allah berfirman : “Sungguh, Allah tidak mengampuni orang yang menyekutukan-Nya, tetapi mengampuni dosa selain dari itu kepada siapa yang dikehendaki”. (QS 4 : 48)"
        "\n\n"
        "Rasulullah Shallallahu ‘alaihi wa Sallam bersabda : “Tidaklah dikatakan terus-menerus berbuat dosa orang yang mau meminta ampun, sekalipun dia mengulangi tujuh puluh kali dalam sehari”."
        "\n"
        "Abu Hurairah berkata bahwa Rasulullah Shallallahu ‘alaihi wa Sallam bersabda : “Mempunyai anggapan baik kepada Allah termasuk beribadah yang baik kepada Allah”.";

    res = await db.rawUpdate("INSERT INTO $tb_hadits VALUES($no,'$ins_judul','$ins_arab','$ins_terjemahan','$ins_isi',$bookmark)");
    print("id $no = $res");

    print("DB Created");
  }

  Future<List>getData(String query)async{
    var dbClient = await db;
    List<Map> list;

    if(query.isEmpty){
      list = await dbClient.rawQuery("SELECT * FROM $tb_hadits");
    }else{
      list = await dbClient.rawQuery("SELECT * FROM $tb_hadits WHERE "
          "$_judul  LIKE  '%$query%'  OR "
          "$_terjemahan LIKE  '%$query%'  OR "
          "$_isi LIKE  '%$query%' ");
    }
    return list;
  }

  Future<List>getDatabyID(String id)async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM $tb_hadits WHERE $_id=$id");
    return list;
  }

  Future<int>setBookmarks(String bookmark, String id)async{
    var dbClient = await db;
    int res = await dbClient.rawUpdate("UPDATE $tb_hadits SET $_bookmark=$bookmark WHERE $_id=$id");
    return res;
  }

  Future<List>getBookmark()async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM $tb_hadits WHERE $_bookmark=1");
    return list;
  }

  Future<int>getLastRead()async{
    var dbClient = await db;
    List<Map> list =await dbClient.rawQuery("SELECT * FROM $tb_set WHERE $_nm_set='last_read'");
    int angka = int.parse(list[0]['$_angka_set']);
    return angka;
  }

  Future<List>getDataLastRead(int id)async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM $tb_hadits WHERE $_id=$id");
    return list;
  }

  Future<int>setLastRead(int setLast)async{
    var dbClient = await db;
    int res = await dbClient.rawUpdate("UPDATE $tb_set SET $_angka_set='$setLast' WHERE $_nm_set='last_read'");
    return res;
  }

  Future<int>getFontSize()async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM $tb_set WHERE $_nm_set='font_size'");
    int angka = int.parse(list[0]['$_angka_set']);
    return angka;
  }

  Future<int>setFontSize(int setfont)async{
    var dbClient = await db;
    int res = await dbClient.rawUpdate("UPDATE $tb_set SET $_angka_set='$setfont' WHERE $_nm_set='font_size'");
    return res;
  }

  Future<int>getIdWarna()async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM $tb_set WHERE $_nm_set='tema'");
    int angka = int.parse(list[0]['$_angka_set']);
    return angka;
  }

  Future<List>getWarnaSelected(int idWarna)async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM $tb_warna WHERE $_id='$idWarna'");
    return list;
  }

  Future<List>getAllWarna()async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM $tb_warna");
    return list;
  }

  Future<int>setWarna(String id)async{
    var dbClient = await db;
    int res = await dbClient.rawUpdate("UPDATE $tb_set SET $_angka_set='$id' WHERE $_nm_set='tema'");
    return res;
  }


}