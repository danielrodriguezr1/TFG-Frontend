import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tfgapp/src/pages/editProfile.dart';
import 'package:tfgapp/src/pages/homeScreen.dart';
import 'package:tfgapp/src/pages/recommendationScreen.dart';
import 'package:tfgapp/src/pages/searchScreen.dart';
import 'package:tfgapp/src/pages/searchUserScreen.dart';
import 'package:tfgapp/src/service/API-User-Service.dart';
import 'package:tfgapp/src/storage/secure_storage.dart';
import 'package:http/http.dart' as http;

class UserProfileScreen extends StatefulWidget {
  final String id;
  const UserProfileScreen(this.id);
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  int _paginaActual = 4;
  String name = '';
  String lastname = '';
  String nickname = '';
  String email = '';
  String about = '';
  String profileImage = '';
  List followers = [];
  List followings = [];

  //String photoUrl = '';
  @override
  void initState() {
    super.initState();
    if (mounted) {
      if (widget.id == "0") {
        SecureStorage.readSecureStorage('App_UserID').then((id) {
          var url = Uri.parse(
              'https://api-danielrodriguez.herokuapp.com/users/' + id);
          print(url.toString());
          http.get(url).then((res) {
            print("CODEEEE ${res.statusCode}");
            if (res.statusCode == 200) {
              Map<String, dynamic> body = jsonDecode(res.body);
              Map<String, dynamic> user = body["user"];
              setState(() {
                name = user["name"];
                lastname = user["lastname"];
                nickname = user["nickname"];
                email = user["email"];
                about = user["about"];
                profileImage = user["profileImage"];
                followers = user["followers"];
                followings = user["followings"];
                print(profileImage);
                print(nickname);
                print(followers.length);
                //photoUrl = user["profileImage"];
              });
            } else {
              print(res.statusCode);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
                      content: SingleChildScrollView(
                          child: ListBody(
                        children: <Widget>[
                          Text("Error_de_xarxa",
                              style: TextStyle(fontSize: 20)),
                        ],
                      )),
                      actions: <Widget>[
                        TextButton(
                          child: Text("Acceptar",
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }
          }).catchError((err) {
            //Sale error por pantalla
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
                    content: SingleChildScrollView(
                        child: ListBody(
                      children: <Widget>[
                        Text("Error_de_xarxa",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      ],
                    )),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Acceptar",
                            style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          });
        });
      } else {
        getUserByID(widget.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF19191B),
      extendBody: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Icon(Icons.menu, color: Colors.white70),
          title: Center(
              child: Text("NOMBRE APP          ".toUpperCase(),
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: Colors.white70,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _paginaActual = index;
            if (_paginaActual == 0) {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => SearchScreen()));
            } else if (_paginaActual == 1) {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => RecommendationScreen()));
            } else if (_paginaActual == 2) {
              Navigator.push(context,
                  PageRouteBuilder(pageBuilder: (_, __, ___) => HomeScreen()));
            } else if (_paginaActual == 4) {
            } else {}
          });
        },
        backgroundColor: Color(0xFF151C26),
        selectedItemColor: Color(0xFFF4C10F),
        unselectedItemColor: Color(0xFF5A606B),
        currentIndex: _paginaActual,
        //showSelectedLabels: true,
        //showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search_rounded,
                size: 20,
              ),
              label: "Buscar"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.recommend,
                size: 20,
              ),
              label: "Recomendado"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 20,
              ),
              label: "Inicio"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 20,
              ),
              label: "Watchlist"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_rounded,
                size: 20,
              ),
              label: "Perfil"),
        ],
        selectedLabelStyle: TextStyle(fontSize: 12),
      ),
      resizeToAvoidBottomInset: false,
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(children: [
            Positioned(
              top: -100,
              left: -100,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF09FBD3),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 200,
                    sigmaY: 200,
                  ),
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              right: -88,
              child: Container(
                height: 166,
                width: 166,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFE53BB).withOpacity(0.5),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 200,
                    sigmaY: 200,
                  ),
                  child: Container(
                    height: 166,
                    width: 166,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -100,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF08F7FE).withOpacity(0.5),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 200,
                    sigmaY: 200,
                  ),
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: _buildBody(context),
            )
          ])),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(children: [
      SafeArea(
          child: Column(children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(24)),
            child: Row(children: [
              GestureDetector(
                onTap: () {
                  print("Search Me");
                },
                child: Container(
                  child: Icon(
                    Icons.search,
                    color: Colors.white70,
                  ),
                  margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                ),
              ),
              Expanded(
                  child: TextField(
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          hintText: "Buscar usuario"),
                      style: TextStyle(color: Colors.white70),
                      onSubmitted: (query) {
                        if (query.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchUserScreen(query),
                              ));
                        }
                      }))
            ])),
        Container(
          child: Container(
            width: double.infinity,
            height: 200,
            child: Container(
              alignment: Alignment(0.0, 2.5),
              child: CircleAvatar(
                backgroundImage: NetworkImage(profileImage != ''
                    ? profileImage
                    :
                    //Imagen de prueba, se colocará la imagen del usuario
                    "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg"),
                radius: 90.0,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 35,
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            "$name $lastname",
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          nickname,
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.white60,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 15),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 48),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "$about",
              style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                  fontStyle: FontStyle.italic),
            ),
          ]),
        ),
        SizedBox(
          height: 10,
        ),
        (widget.id != "0")
            ? FutureBuilder(
                future: checkIfFollow(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.data == "204") {
                    return Container(
                      child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Container(
                              height: 40.0,
                              margin: EdgeInsets.all(10),
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    followUser(widget.id);
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFA38A00),
                                          Color(0xffFFED8A)
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: 150.0, maxHeight: 40.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Seguir usuario",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ))),
                    );
                  } else
                    return Container(
                      child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Container(
                              height: 40.0,
                              margin: EdgeInsets.all(10),
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    unfollowUser(widget.id);
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFAA4A44),
                                          Color(0xFFEE4B2B)
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: 150.0, maxHeight: 40.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Dejar de seguir",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ))),
                    );
                })
            : Container(),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildButton(context, "${followings.length}", "Siguiendo"),
            Container(
                height: 25,
                child: VerticalDivider(
                  color: Colors.white,
                )),
            buildButton(context, "${followers.length}", "Seguidores"),
          ],
        ),
        SizedBox(height: 20),
      ])),
      (widget.id == "0")
          ? Container(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                // ignore: deprecated_member_use
                child: IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  color: Colors.white10.withOpacity(0.2),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                            name,
                            lastname,
                            nickname,
                            email,
                            about,
                            profileImage,
                          ),
                        ));
                  },
                ),
              ),
            )
          : Container(),
    ]);
  }

  Future<void> followUser(String id) async {
    await APIUserService().followUser(id);
    print("SEGUIDO CORRECTAMENTE");
  }

  Future<void> unfollowUser(String id) async {
    await APIUserService().unfollowUser(id);
    print("DEJADO DE SEGUIR CORRECTAMENTE");
  }

  Future<String> checkIfFollow(String id) async {
    String code = await APIUserService().checkIfFollow(id);
    print(code);
    return code;
  }

  Future<void> getUserByID(String id) async {
    Map<String, dynamic> user = await APIUserService().getUserByID(id);
    setState(() {
      name = user["user"]["name"];
      lastname = user["user"]["lastname"];
      nickname = user["user"]["nickname"];
      email = user["user"]["email"];
      about = user["user"]["about"];
      profileImage = user["user"]["profileImage"];
      followers = user["user"]["followers"];
      followings = user["user"]["followings"];
      print(profileImage);
      print(nickname);
      print(followers.length);
      //photoUrl = user["profileImage"];
    });
  }

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
}
