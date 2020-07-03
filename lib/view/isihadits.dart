import 'package:flutter/material.dart';
import 'package:hadits_syarah_arbain_nawawi/database/DBHelper.dart';
import 'dart:async';
import 'dart:io';

class IsiHadits extends StatefulWidget {
  final String id;

  IsiHadits({Key key, this.id}) : super(key: key);

  @override
  _IsiHaditsState createState() => _IsiHaditsState();
}

class _IsiHaditsState extends State<IsiHadits> {
  String title ="";
  String bookmark ="";
  String arab ="";
  String terjemah ="";
  String isi ="";
  int _fontSize =15;
  String warna = "0xFF4CAF50";
  String warna_font = "0xFFFFFFFF";

  Future<List> _getData(String id) async {
    var db = new DBHelper();
    List<Map> list = await db.getDatabyID(id);

    setState(() {
      title = list[0]['judul'];
      bookmark = list[0]['bookmark'].toString();
      arab = list[0]['arab'];
      terjemah = list[0]['terjemahan'];
      isi = list[0]['isi'];
    });
//    print(list.toString());
  }

  Future<int> _setBookmarks(String bookmarks, String id)async{
    var db = new DBHelper();
    int res = await db.setBookmarks(bookmarks,widget.id);
    if(res ==1 && bookmarks=="1"){
      print("bookmark dibuat");
      setState(() {
        bookmark="1";
      });
    }else if(res==1 && bookmarks=="0"){
      print("bookmark dibatalkan");
      setState(() {
        bookmark="0";
      });
    }else{
      print("error query");
    }
  }

  Future<int>_setLastRead()async{
    var db = new DBHelper();
    int res = await db.setLastRead(int.parse(widget.id));
    if(res==0){
      print("gagal set last ${widget.id}");
    }else{
      print("sukses set last ${widget.id}");
    }
  }

  Future<int> _getFontSize() async {
    var db = new DBHelper();
    int res = await db.getFontSize();
    setState(() {
      _fontSize = res;
    });
    print("Font Size adalah $res");
  }

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
    _getFontSize();
    _getData(widget.id);
    _setLastRead();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse(warna)),
        iconTheme: new IconThemeData(color: Color(int.parse(warna_font))),
        actionsIconTheme: IconThemeData(color: Color(int.parse(warna_font))),
        title: Text(title,style: TextStyle(color: Color(int.parse(warna_font))),),
        actions: <Widget>[
          IconButton(
            icon: bookmark == "0"
                ? Icon(
                    Icons.star_border,
                    color: Color(int.parse(warna_font)),
                    size: 30,
                  )
                : Icon(
                    Icons.star,
                    color: warna =="0xFFFFEB3B" ? Colors.red: Colors.yellowAccent,

                    size: 30,
                  ),
            onPressed: (){
              if(bookmark=="0"){
                _setBookmarks("1",widget.id);
              }else{
                _setBookmarks("0",widget.id);
              }
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        "${widget.id}. " + title,
                        style: TextStyle(fontSize: _fontSize.toDouble(),fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      arab,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: _fontSize.toDouble()),
                    ),
                  ),
                ],
              ),),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Terjemahan",
                        style: TextStyle(fontSize: _fontSize.toDouble(),fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        terjemah,
                        style: TextStyle(fontSize: _fontSize.toDouble()),textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Tafsiran",
                        style: TextStyle(fontSize: _fontSize.toDouble(),fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        isi,
                        style: TextStyle(fontSize: _fontSize.toDouble(),),textAlign: TextAlign.justify,
                      ),
                    ),

                  ],
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
