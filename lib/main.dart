import 'package:flutter/material.dart';
import 'package:hadits_syarah_arbain_nawawi/database/DBHelper.dart';
import 'package:hadits_syarah_arbain_nawawi/view/biografi.dart';
import 'package:hadits_syarah_arbain_nawawi/view/bookmarks.dart';
import 'package:hadits_syarah_arbain_nawawi/view/lastread.dart';
import 'package:hadits_syarah_arbain_nawawi/view/myhomepage.dart';
import 'package:hadits_syarah_arbain_nawawi/view/pengaturan.dart';
import 'package:hadits_syarah_arbain_nawawi/view/sumber.dart';
import 'package:hadits_syarah_arbain_nawawi/view/tentang.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Syarah Arba'in Nawawi",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: <String, WidgetBuilder>{
//        '/search': (BuildContext context) => new Search(title: "Cari",),
        '/bookmarks' : (BuildContext context) => new Bookmarks(),
        '/last_read' : (BuildContext context) => new LastRead(),
        '/sumber' : (BuildContext context) => new Sumber(),
        '/tentang' : (BuildContext context) => new Tentang(),
        '/pengaturan' : (BuildContext context) => new Pengaturan(),
        '/home' : (BuildContext context) => new MyHomePage(),
        '/biografi' : (BuildContext context) => new Biografi(),
      },
      home: MyHomePage(),
    );
  }
}