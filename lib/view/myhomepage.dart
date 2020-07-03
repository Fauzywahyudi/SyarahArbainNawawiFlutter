import 'package:flutter/material.dart';
import 'package:hadits_syarah_arbain_nawawi/database/DBHelper.dart';
import 'dart:async';
import 'dart:io';
import 'package:hadits_syarah_arbain_nawawi/view/isihadits.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget appBarTitle = new Text(
    "Syarah Arba'in Nawawi",
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> _list;
  bool _IsSearching;
  String _searchText = "";
  String warna = "0xFF4CAF50";
  String warna_font = "0xFFFFFFFF";

  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  Future<List> _getWarnaSelected() async {
    var db = new DBHelper();
    int res = await db.getIdWarna();
    List<Map> list = await db.getWarnaSelected(res);
    setState(() {
      warna = list[0]['warna'];
      warna_font = list[0]['warna_font'];
    });
    return list;
  }

  Future<List> _getData(String search_text) async {
    var db = DBHelper();
    String query;
    List<Map> list;

    if (search_text.isEmpty) {
      query = "";
    } else {
      query = search_text;
    }
    list = await db.getData(query);

    return list;
  }

  var reloadData = 0;

  Future<Null> handleRefresh() async {
    Completer<Null> completer = new Completer<Null>();
    new Future.delayed(new Duration(milliseconds: 500)).then((_) {
      completer.complete();
      setState(() {
        if (reloadData == 0) {
          reloadData = 1;
        } else if (reloadData == 1) {
          reloadData = 0;
        }
      });
    });
    return completer.future;
  }

  @override
  void initState() {
    _getWarnaSelected();
    super.initState();
    _IsSearching = false;
  }

  @override
  Widget build(BuildContext context) {
//    _getWarnaSelected();
    return new Scaffold(
      key: key,
      appBar: buildBar(context),
      drawer: _drawer(),
      body: _body(),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: Container(
        color: Color(int.parse(warna)),
        child: SafeArea(
            child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Container(
                color: Color(int.parse(warna)),
                child: Center(
                    child: Text(
                  "Hadits \n Syarah Arba'in Nawawi",textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(
                        int.parse(warna_font),
                      ),
                      fontWeight: FontWeight.bold),
                )),
                height: 200,
              ),
              ListTile(
                title: Text("Bookmarks"),
                leading: Icon(Icons.star),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/bookmarks');
                },
              ),
              ListTile(
                title: Text("Bacaan Terakhir"),
                leading: Icon(Icons.book),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/last_read');
                },
              ),
              ListTile(
                title: Text("Biografi Imam Nawawi"),
                leading: Icon(Icons.person),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/biografi');
                },
              ),
              ListTile(
                title: Text("Sumber"),
                leading: Icon(Icons.input),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/sumber');
                },
              ),
              ListTile(
                title: Text("Pengaturan"),
                leading: Icon(Icons.settings),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/pengaturan');
                },
              ),
              ListTile(
                title: Text("Tentang"),
                leading: Icon(Icons.error),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/tentang');
                },
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _body() {
    return Container(
      child: FutureBuilder<List>(
        future: reloadData == 0 ? _getData(_searchText) : _getData(_searchText),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return RefreshIndicator(
            onRefresh: handleRefresh,
            child: snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: <Widget>[
                          ListTile(
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
                            title: Text(
                              snapshot.data[i]['judul'],
                              style: TextStyle(fontSize: 20),
                            ),
                            leading: new Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(int.parse(warna))),
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
                          Divider(
                            indent: 15,
                            height: 8,
                          )
                        ],
                      );
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        },
      ),
    );
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(
        iconTheme: new IconThemeData(color: Color(int.parse(warna_font))),
        actionsIconTheme: IconThemeData(color: Color(int.parse(warna_font))),
        backgroundColor: Color(int.parse(warna)),
        centerTitle: true,
        title: _IsSearching
            ? TextField(
                controller: _searchQuery,
                style: new TextStyle(color: Color(int.parse(warna_font))),
                onChanged: (e) {
                  _SearchListState();
                  if (reloadData == 0) {
                    setState(() {
                      reloadData = 1;
                    });
                  } else {
                    setState(() {
                      reloadData == 1;
                    });
                  }
                },
                autofocus: true,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search...",
                    hintStyle:
                        new TextStyle(color: Color(int.parse(warna_font)))),
              )
            : Text(
                "Syarah Arba'in Nawawi",
                style: TextStyle(color: Color(int.parse(warna_font))),
              ),
        actions: <Widget>[
          _IsSearching
              ? IconButton(
                  onPressed: () {
                    _handleSearchEnd();
                  },
                  icon: Icon(
                    Icons.close,
                    color: Color(int.parse(warna_font)),
                  ),
                )
              : IconButton(
                  onPressed: () {
                    _handleSearchStart();
                  },
                  icon: Icon(
                    Icons.search,
                    color: Color(int.parse(warna_font)),
                  ),
                ),
        ]);
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Syarah Arba'in Nawawi",
        style: new TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
}

//class ChildItem extends StatelessWidget {
//  final String name;
//
//  ChildItem(this.name);
//
//  @override
//  Widget build(BuildContext context) {
//    return new ListTile(title: new Text(this.name));
//  }
//}
