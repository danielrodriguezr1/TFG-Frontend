import 'package:flutter/material.dart';
import 'package:tfgapp/src/storage/secure_storage.dart';
import 'package:tfgapp/src/pages/loginScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* AppBar
      appBar: AppBar(
        title: Text('Hola mundo $currentPage'),
        elevation: 0,
      ),

      //* Tabs

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (index) {
          print("logout");

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
                  content: SingleChildScrollView(
                      child: ListBody(
                    children: <Widget>[
                      Text(("Seguro que quieres cerrar sesión?"),
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  )),
                  actions: <Widget>[
                    TextButton(
                      child: Text(("Cancelar"),
                          style: TextStyle(
                              color: Colors.white,
                              backgroundColor: Colors.grey)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text(("Cerrar sesión"),
                          style: TextStyle(
                              color: Colors.white,
                              backgroundColor: Colors.red)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        SecureStorage.deleteSecureStorage().then((val) {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) => LoginPage()),
                          );
                        });
                      },
                    ),
                  ],
                );
              });

          currentPage = index;

          setState(() {});
        },
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.verified_user_outlined), label: 'User'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class CustomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Custom Screen'),
      ),
    );
  }
}
