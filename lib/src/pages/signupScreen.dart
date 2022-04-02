import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tfgapp/src/pages/homeScreen.dart';
import 'package:tfgapp/src/storage/secure_storage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  static String nickname = '';
  static String name = '';
  static String lastname = '';
  static String email = '';
  static String pwd = '';
  bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                SizedBox(
                  height: size.height,
                  child: Image.asset(
                    'assets/images/lalaland.jpg',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 6,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 25, sigmaX: 25),
                            child: SizedBox(
                              width: size.width * .9,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: size.width * .13,
                                      bottom: size.width * .1,
                                    ),
                                    child: Text(
                                      'Únete ahora',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white.withOpacity(.8),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: size.width * .05,
                                      ),
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^[A-Za-z0-9_.]+$'))
                                        ],
                                        onChanged: (val) => setState(() {
                                          nickname = val;
                                          print(nickname);
                                          //debugPrint(nickname);
                                        }),
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.movie_rounded,
                                              color: Colors.white70, size: 25),
                                          border: InputBorder.none,
                                          hintText: 'Nombre de usuario',
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontSize: 15),
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: size.width * .05,
                                      ),
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[a-zA-Z]"))
                                        ],
                                        onChanged: (val) => setState(() {
                                          name = val;
                                          print(name);
                                          //debugPrint(nickname);
                                        }),
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.person_rounded,
                                              color: Colors.white70, size: 25),
                                          border: InputBorder.none,
                                          hintText: 'Nombre',
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontSize: 15),
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: size.width * .05,
                                      ),
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[a-zA-Z]"))
                                        ],
                                        onChanged: (val) => setState(() {
                                          lastname = val;
                                          print(lastname);
                                          //debugPrint(nickname);
                                        }),
                                        decoration: InputDecoration(
                                          icon: Icon(
                                              Icons.person_add_alt_1_rounded,
                                              color: Colors.white70,
                                              size: 25),
                                          border: InputBorder.none,
                                          hintText: 'Apellido',
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontSize: 15),
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: size.width * .05,
                                      ),
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(
                                              r'^[A-Za-z0-9!#$%&*/=?^_+-`{|}~]+$'))
                                        ],
                                        onChanged: (val) => setState(() {
                                          email = val;
                                          print(email);
                                          //debugPrint(nickname);
                                        }),
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.email,
                                              color: Colors.white70, size: 25),
                                          border: InputBorder.none,
                                          hintText: 'Correo electrónico',
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontSize: 15),
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: size.width * .05,
                                      ),
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextFormField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(
                                              r'^[A-Za-z0-9!#$%&*/=?^_+-`{|}~]+$'))
                                        ],
                                        obscureText: isHiddenPassword,
                                        onChanged: (val) => setState(() {
                                          pwd = val;
                                          print(pwd);
                                          debugPrint(pwd);
                                        }),
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.lock,
                                              color: Colors.white70, size: 25),
                                          border: InputBorder.none,
                                          suffixIcon: InkWell(
                                            onTap: _togglePasswordView,
                                            child: Icon(Icons.visibility,
                                                color: Colors.white70,
                                                size: 25),
                                          ),
                                          hintText: 'Contraseña',
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontSize: 15),
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () => email != '' ||
                                            name != '' ||
                                            lastname != '' ||
                                            nickname != '' ||
                                            pwd != ''
                                        ? setState(() {
                                            print('entrando al signup');
                                            _submitSignup();
                                          })
                                        : () {},
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: size.width * .05,
                                      ),
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Registrarse',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: 'He olvidado la contraseña',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                HapticFeedback.lightImpact();
                                                Fluttertoast.showToast(
                                                  msg:
                                                      'Forgotten password! button pressed',
                                                );
                                              },
                                          ),
                                        )
                                      ]),*/
                                  //SizedBox(height: size.width * .1),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitSignup() {
    HapticFeedback.lightImpact();
    var url = Uri.parse('https://api-danielrodriguez.herokuapp.com/signup');
    http.post(url, body: {
      'name': name,
      'lastname': lastname,
      'email': email,
      'nickname': nickname,
      'password': pwd,
    }).then((res) {
      if (res.statusCode == 201) {
        print(email);
        print('creado');

        Map<String, dynamic> body = jsonDecode(res.body);
        print(body["token"]);
        print(body["userId"]);
        SecureStorage.writeSecureStorage('App_Token', body["token"]);
        SecureStorage.writeSecureStorage('App_UserId', body["userId"]);
        print("escrito");

        Fluttertoast.showToast(
          msg: 'Usuario creado correctamente',
        );

        Navigator.push(context,
            PageRouteBuilder(pageBuilder: (_, __, ___) => HomeScreen()));
      } else if (res.statusCode == 409) {
        Fluttertoast.showToast(
          msg: 'El correo ya está en uso',
        );
      } else if (res.statusCode == 404) {
        Fluttertoast.showToast(
          msg: 'El nombre de usuario ya está en uso',
        );
      } else {
        print(res.statusCode);
        Fluttertoast.showToast(msg: 'Error de red');
      }
    });
  }

  void _togglePasswordView() {
    isHiddenPassword = !isHiddenPassword;
    setState(() {});
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
