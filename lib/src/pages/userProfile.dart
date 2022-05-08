import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tfgapp/src/pages/editProfile.dart';
import 'package:tfgapp/src/pages/homeScreen.dart';
import 'package:tfgapp/src/pages/searchScreen.dart';
import 'package:tfgapp/src/storage/secure_storage.dart';
import 'package:http/http.dart' as http;

class UserProfileScreen extends StatefulWidget {
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
  List followers = [];
  List followings = [];
  //String photoUrl = '';
  @override
  void initState() {
    super.initState();
    if (mounted) {
      SecureStorage.readSecureStorage('App_UserID').then((id) {
        var url =
            Uri.parse('https://api-danielrodriguez.herokuapp.com/users/' + id);
        http.get(url).then((res) {
          print(res.statusCode);
          if (res.statusCode == 200) {
            Map<String, dynamic> body = jsonDecode(res.body);
            Map<String, dynamic> user = body["user"];
            setState(() {
              name = user["name"];
              lastname = user["lastname"];
              nickname = user["nickname"];
              email = user["email"];
              about = user["about"];
              followers = user["followers"];
              followings = user["followings"];
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
                        Text("Error_de_xarxa", style: TextStyle(fontSize: 20)),
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
                          style: TextStyle(fontSize: 20, color: Colors.black)),
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
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.pexels.com/photos/11760521/pexels-photo-11760521.png?cs=srgb&dl=pexels-daniel-rodr%C3%ADguez-11760521.jpg&fm=jpg"),
                  fit: BoxFit.cover)),
          child: Container(
            width: double.infinity,
            height: 200,
            child: Container(
              alignment: Alignment(0.0, 2.5),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/11760521/pexels-photo-11760521.png?cs=srgb&dl=pexels-daniel-rodr%C3%ADguez-11760521.jpg&fm=jpg"),
                radius: 60.0,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 65,
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
      Container(
        child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
                height: 40.0,
                margin: EdgeInsets.all(10),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                              name, lastname, nickname, email, about),
                        ));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFA38A00), Color(0xffFFED8A)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 150.0, maxHeight: 40.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Configurar perfil",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ))),
      ),
    ]);
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
