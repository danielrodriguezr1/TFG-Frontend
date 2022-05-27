import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tfgapp/src/pages/recommendationScreen.dart';
import 'package:tfgapp/src/pages/searchScreen.dart';
import 'package:tfgapp/src/pages/userProfile.dart';
import 'package:tfgapp/src/service/API-User-Service.dart';
import 'package:tfgapp/src/storage/secure_storage.dart';

import 'homeScreen.dart';

// ignore: must_be_immutable
class SearchUserScreen extends StatefulWidget {
  String nickname;
  SearchUserScreen(this.nickname);

  @override
  _SearchUserScreenState createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  int _paginaActual = 4;
  String _idCurrentUser = "";
  @override
  void initState() {
    super.initState();
    if (mounted) {
      SecureStorage.readSecureStorage('App_UserID').then((id) {
        _idCurrentUser = id;
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
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 160,
          child: FutureBuilder(
              future: getUsers(widget.nickname),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> users = snapshot.data;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 25),
                      GestureDetector(
                        onTap: () {
                          if (users["user"]["_id"] == _idCurrentUser) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserProfileScreen("0"),
                                ));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UserProfileScreen(users["user"]["_id"]),
                                ));
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 45,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    NetworkImage(users["user"]["profileImage"]),
                              ),
                              SizedBox(width: 15),
                              Column(
                                children: [
                                  Text(
                                    "${users["user"]["name"]} ${users["user"]["lastname"]}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(height: 5),
                                  SizedBox(height: 10),
                                  Text(
                                    users["user"]["nickname"],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white60,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              }),
        )
      ],
    ));
  }

  Future<Map<String, dynamic>> getUsers(String nickname) async {
    Map<String, dynamic> users =
        await APIUserService().getUserByNickname(nickname);
    print("GET USER BY NICKNAME");
    print(users["user"]["email"]);
    return users;
  }
}
