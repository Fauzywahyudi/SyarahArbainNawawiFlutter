import 'package:flutter/material.dart';
import 'package:hadits_syarah_arbain_nawawi/database/DBHelper.dart';

class Tentang extends StatefulWidget {
  @override
  _TentangState createState() => _TentangState();
}

class _TentangState extends State<Tentang> {
  String warna = "0xFF4CAF50";
  String warna_font = "0xFFFFFFFF";

  ScrollController _scrollController = new ScrollController();

  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (300 - kToolbarHeight);
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
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Color(int.parse(warna)),
      iconTheme: new IconThemeData(color: Color(int.parse(warna_font))),
      actionsIconTheme: IconThemeData(color: Color(int.parse(warna_font))),
      title: Text(
        "Tentang Developer",
        style: TextStyle(color: Color(int.parse(warna_font))),
      ),
    );
  }

  Widget _body() {
    return Container(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: true,
              pinned: true,
              snap: false,
              iconTheme: new IconThemeData(color: Color(int.parse(warna_font))),
              backgroundColor: Color(int.parse(warna)),
              flexibleSpace: GestureDetector(
                child: FlexibleSpaceBar(
                  title: Text("Fauzy Wahyudi",style: TextStyle(color: Color(int.parse(warna_font))),),
                    background: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.asset("assets/images/zy.jpg",fit: BoxFit.cover,),
                        Container(
                          margin: EdgeInsets.only(top: 260),
                          color: Colors.white.withOpacity(0.3),
                        )
                      ],),),
              ),
            ),
            SliverFillRemaining(
              child: Container(
                color: Colors.grey[200],
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    child: Text("Nama",style: TextStyle(fontSize: 18),),
                                  ),
                                  Container(
                                    child: Text(": Fauzy Wahyudi",style: TextStyle(fontSize: 18)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    child: Text("No BP",style: TextStyle(fontSize: 18),),
                                  ),
                                  Container(
                                    child: Text(": 16101152630059",style: TextStyle(fontSize: 18)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    child: Text("Jurusan",style: TextStyle(fontSize: 18),),
                                  ),
                                  Container(
                                    child: Text(": Teknik Informatika",style: TextStyle(fontSize: 18)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    child: Text("Kelas",style: TextStyle(fontSize: 18),),
                                  ),
                                  Container(
                                    child: Text(": IF-2",style: TextStyle(fontSize: 18)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
