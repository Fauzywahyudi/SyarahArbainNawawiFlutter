import 'package:flutter/material.dart';
import 'package:hadits_syarah_arbain_nawawi/database/DBHelper.dart';

import 'isihadits.dart';

class Bookmarks extends StatefulWidget {
  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
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

  Widget _appBar() {
    return AppBar(
      backgroundColor: Color(int.parse(warna)),
      iconTheme: new IconThemeData(color: Color(int.parse(warna_font))),
      actionsIconTheme: IconThemeData(color: Color(int.parse(warna_font))),
      title: Text("Bookmarks",style: TextStyle(color: Color(int.parse(warna_font))),),
    );
  }

  Widget _body() {
    return Container(
      child: FutureBuilder<List>(
          future: _getBookmark(), builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot
            .error);
        return snapshot.hasData ?
        ListView.builder(
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (context, i) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      snapshot.data[i]['judul'],
                      style: TextStyle(fontSize: 25),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  IsiHadits(
                                    id: snapshot.data[i]['_id']
                                        .toString(),
                                  )));
                    },
                    leading: new Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(int.parse(warna))),
                      child: Center(
                          child: Text(
                            ("${snapshot.data[i]['_id'].toString()}")
                                .toString(),
                            style: TextStyle(
                                color: Color(int.parse(warna_font)),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  Divider(),
                ],
              );
            }) : Center(child: Text("Tidak Ada Data",style: TextStyle(
          fontSize: 25,color: Colors.grey
        ),),);
      }),
    );
  }

  Future<List> _getBookmark() async {
    var db = new DBHelper();
    List<Map> list = await db.getBookmark();
    return list;
  }
}
