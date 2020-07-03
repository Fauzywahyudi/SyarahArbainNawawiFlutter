import 'package:flutter/material.dart';
import 'package:hadits_syarah_arbain_nawawi/database/DBHelper.dart';

class Pengaturan extends StatefulWidget {
  @override
  _PengaturanState createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  int font_size = 20;
  int _value = 15;
  String dropdownValue = "One";
  bool _set_font = false;

  String warna = "0xFF4CAF5";
  String warna_font = "0xFFFFFFFF";
  String nm_warna = "";

  @override
  void initState() {
    _getWarnaSelected();
    _getFontSize();
    setState(() {
      _value = font_size;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{return false;},
      child: Scaffold(
        appBar: _appBar(),
        body: _body(),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      iconTheme: new IconThemeData(color: Color(int.parse(warna_font))),
      actionsIconTheme: IconThemeData(color: Color(int.parse(warna_font))),
      backgroundColor: Color(int.parse(warna)),
      leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/home');
      }),
      title: Text("Pengaturan",style: TextStyle(color: Color(int.parse(warna_font))),),
    );
  }

  Widget _body() {
    return Container(
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                  onTap: () {
                    setState(() {
                      _set_font = true;
                    });
                  },
                  title: Text(
                    "Ukuran Tulisan",
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    "size : $font_size",
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Icon(
                    Icons.navigate_next,
                    size: 25, color: _set_font ? Colors.white : Colors.grey,
                  )),
              _set_font
                  ? Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      Center(
                          child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.format_size,
                                  size: 30,
                                ),
                                new Expanded(
                                    child: Slider(
                                        value: _value.toDouble(),
                                        min: 15.0,
                                        max: 25.0,
                                        divisions: 10,
                                        activeColor: Colors.red,
                                        inactiveColor: Colors.black,
                                        label: '${_value.toString()}',
                                        onChanged: (double newValue) {
                                          setState(() {
                                            _value = newValue.round();
                                            font_size = _value;
                                          });
                                          _setFontSize(font_size);
                                        },
                                        semanticFormatterCallback:
                                            (double newValue) {
                                          return '${newValue.round()} dollars';
                                        })),
                              ])),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "سَمِعْتُ رَسُولَ اللهِ يَقُول:",
                              textDirection: TextDirection.rtl,
                              style:
                              TextStyle(fontSize: font_size.toDouble()),
                            ),
                            Text(
                                "Aku mendengar Rasulullah shallallahu ‘alaihi wa sallam bersabda:",
                                style: TextStyle(
                                    fontSize: font_size.toDouble())),
                          ],
                        ),
                      ),
                      Container(
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _set_font = false;
                              });
                            },
                            child: Icon(Icons.keyboard_arrow_up, size: 25,),
                          ),
                        ),
                      )
                    ],
                  ))
                  : Container(),
            ],
          ),
          Divider(
            indent: 15,
          ),
          ListTile(
            title: Text(
              "Tema",
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text(nm_warna),
            trailing: Container(
              height: 40,
              width: 65,
              color: Color(int.parse(warna)),
            ),
            onTap: () {
              _selectWarna(warna);
            },
          ),
          Divider(
            indent: 15,
          ),
        ],
      ),
    );
  }

  Future<int> _getFontSize() async {
    var db = new DBHelper();
    int res = await db.getFontSize();
    setState(() {
      font_size = res;
      _value = res;
    });
    print("Font Size adalah $res");
  }

  Future<int> _setFontSize(int sizefont) async {
    var db = new DBHelper();
    int res = await db.setFontSize(sizefont);
  }

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

  Future<List> _getAllWarna() async {
    var db = new DBHelper();
    List<Map> list = await db.getAllWarna();
    return list;
  }

  Future<List> _selectWarna(String oldWarna) async {
    showDialog(context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("Pilih Warna"),
              content: Container(
                width: MediaQuery.of(context).size.width*0.6,
                height: MediaQuery.of(context).size.height*0.6,
                child: FutureBuilder<List>(future: _getAllWarna(),builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData ?
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: snapshot.data.length == null ? 0 : snapshot.data
                        .length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            warna = snapshot.data[i]['warna'];
                            nm_warna = snapshot.data[i]['nm_warna'];
                            warna_font = snapshot.data[i]['warna_font'];
                          });
                          _setWarna(snapshot.data[i]['_id'].toString());
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          color: snapshot.data[i]['warna'] == warna ? Colors.black : Colors.white,
                          height: 50,
                          width: 60,
                          padding: EdgeInsets.all(5),
                          child: Container(
                            height: 30,
                            width: 50,
                            color: Color(int.parse(snapshot.data[i]['warna'])),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(snapshot.data[i]['nm_warna'],
                                  style: TextStyle(color: Color(int.parse(
                                      snapshot.data[i]['warna_font']))),)
                              ],
                            ),
                          ),
                        ),
                      );
                    },)
                      : Center(child: CircularProgressIndicator(),);
                }),
              ),
            ));
  }

  Future<int>_setWarna(String idWarna)async{
    var db = new DBHelper();
    int res = await db.setWarna(idWarna);
    if(res==1){
      print("sukses set warna");
    }else{
      print("gagal set warna");
    }
  }
}
