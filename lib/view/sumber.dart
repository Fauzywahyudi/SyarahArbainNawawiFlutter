import 'package:flutter/material.dart';
import 'package:hadits_syarah_arbain_nawawi/database/DBHelper.dart';
import 'package:url_launcher/url_launcher.dart';

class Sumber extends StatefulWidget {
  @override
  _SumberState createState() => _SumberState();
}

class _SumberState extends State<Sumber> {

  String warna = "0xFF4CAF50";
  String warna_font = "0xFFFFFFFF";

  Future<List> _getWarnaSelected() async {
    var db = new DBHelper();
    int res = await db.getIdWarna();
    print(res);
    List<Map> list = await db.getWarnaSelected(res);
    setState(() {
      warna = list[0]['warna'];
      warna_font = list[0]['warna_font'];
    });
    print("warna : $warna , warna font : $warna_font");
    return list;
  }
  @override
  void initState() {
    _getWarnaSelected();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar(){
    return AppBar(
      backgroundColor: Color(int.parse(warna)),
      iconTheme: new IconThemeData(color: Color(int.parse(warna_font))),
      actionsIconTheme: IconThemeData(color: Color(int.parse(warna_font))),
      title: Text("Sumber Data",style: TextStyle(color: Color(int.parse(warna_font))),),
    );
  }

  Widget _body(){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
              height: 300,
              padding: EdgeInsets.all(20),
              child: Image.asset("assets/images/web.jpg",fit: BoxFit.cover,)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              padding: EdgeInsets.all(10),
              child: Container(child: Text("abbymolana.wordpress.com",style: TextStyle(fontSize: 25,color: Color(int.parse(warna_font))),)),
              onPressed: _launchURL,
              color: Color(int.parse(warna)),
            ),
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    const url = 'https://abbymolana.wordpress.com/category/hadits-arbain-nawawi';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
