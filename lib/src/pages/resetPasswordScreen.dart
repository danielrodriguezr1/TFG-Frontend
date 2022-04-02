import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tfgapp/src/pages/homeScreen.dart';

class ResetPasswordPage extends StatefulWidget {
  String codi;
  String token;

  ResetPasswordPage(this.codi, this.token);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  static String newPwd = '';
  static String code = '';

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
                        flex: 5,
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
                                    ('Revise su bandeja de entrada para introducir el código recibido.'),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white54,
                                    ),
                                  ),
                                  SizedBox(height: 30),
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
                                          code = val;
                                          print(code);
                                          //debugPrint(nickname);
                                        }),
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.textsms_rounded,
                                              color: Colors.white70, size: 25),
                                          border: InputBorder.none,
                                          hintText: 'Código',
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
                                          newPwd = val;
                                          print(newPwd);
                                          //debugPrint(nickname);
                                        }),
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.lock_rounded,
                                              color: Colors.white70, size: 25),
                                          border: InputBorder.none,
                                          hintText: 'Nueva contraseña',
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
                                    onTap: () => code != '' || newPwd != ''
                                        ? setState(() {
                                            print('entrando');
                                            HapticFeedback.lightImpact();

                                            if (code == widget.codi)
                                              _submitNewPassword(code);
                                            else
                                              Fluttertoast.showToast(
                                                msg: 'El código es incorrecto',
                                              );
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

  void _submitNewPassword(String code) {
    print("intento");
    print(widget.codi);
    print(widget.token);

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'reset': widget.token
    };

    final msg = jsonEncode({"newPassword": newPwd});

    var url =
        Uri.parse('https://api-danielrodriguez.herokuapp.com/new-password');
    http.put(url, headers: requestHeaders, body: msg).then((res) async {
      Map<String, dynamic> body = await jsonDecode(res.body);
      var message = body["message"];
      print(message);
      if (message == "Contraseña cambiada") {
        print('enviado');

        Navigator.push(context,
            PageRouteBuilder(pageBuilder: (_, __, ___) => HomeScreen()));
      } else if (res.statusCode == 401) {
        Fluttertoast.showToast(
          msg: 'Credenciales incorrectas',
        );
      } else {
        Fluttertoast.showToast(msg: 'Error de red');
      }
    });
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
