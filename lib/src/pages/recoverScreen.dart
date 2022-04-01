import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tfgapp/src/pages/homeScreen.dart';
import 'package:tfgapp/src/storage/secure_storage.dart';

class RecoverPage extends StatefulWidget {
  @override
  _RecoverPageState createState() => _RecoverPageState();
}

class _RecoverPageState extends State<RecoverPage> {
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
                        flex: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 25, sigmaX: 25),
                            child: SizedBox(
                              width: size.width * .9,
                              child: Column(
                                /*mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,*/
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),

                                  Icon(
                                    (Icons.lock),
                                    color: Colors.yellow.shade300,
                                    size: 100,
                                  ),

                                  SizedBox(height: 20),

                                  Text(
                                    'Restablecer',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white.withOpacity(.8),
                                    ),
                                  ),
                                  Text(
                                    'contraseña',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white.withOpacity(.8),
                                    ),
                                  ),
                                  SizedBox(height: 18),

                                  Text(
                                    ('Introduzca el correo electrónico asociado a su cuenta'),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white54,
                                    ),
                                  ),

                                  SizedBox(height: 40),

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
                                  SizedBox(height: 20),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () => email != '' ||
                                            name != '' ||
                                            lastname != '' ||
                                            nickname != '' ||
                                            pwd != ''
                                        ? setState(() {
                                            print('entrando');
                                            //_submitSignup();
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
                                        'Restablecer contraseña',
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
