import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:tfgapp/src/pages/loginScreen.dart';
import 'package:tfgapp/src/pages/userProfile.dart';
import 'package:tfgapp/src/service/API-User-Service.dart';
import 'package:tfgapp/src/storage/secure_storage.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  String name, lastname, nickname, email, about, profileImage;
  EditProfileScreen(this.name, this.lastname, this.nickname, this.email,
      this.about, this.profileImage);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool changeProfile = false;

  File profileImage;
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
      padding: EdgeInsets.only(left: 16, top: 25, right: 16),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            Text(
              "Editar perfil",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  child: Center(
                    child: Stack(
                      children: [
                        GestureDetector(
                          //PROFILE IMAGE
                          onTap: () async {
                            try {
                              print("profile");
                              final profileImage = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (profileImage == null) return;
                              final imageTemporary = File(profileImage.path);
                              setState(() {
                                this.profileImage = imageTemporary;
                                changeProfile = true;
                              });
                            } on PlatformException catch (e) {
                              print("Failed to pick image: $e");
                            }
                          },
                          child: Container(
                            width: 150,
                            height: 200,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: changeProfile
                                        ? FileImage(profileImage)
                                        : NetworkImage(
                                            widget.profileImage,
                                          ))),
                          ),
                        ),
                        Positioned(
                            bottom: 40,
                            right: 20,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  color: Color(0xFFF4C10F)),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            buildTextField("Nombre", "${widget.name}"),
            buildTextField("Apellido", "${widget.lastname}"),
            buildTextField("Nombre de usuario", "${widget.nickname}"),
            buildTextField("Correo electrónico", "${widget.email}"),
            buildTextField("Biografia", "${widget.about}"),
            SizedBox(
              height: 35,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF7a7a7a), Color(0xffd6d6d6)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 150.0, maxHeight: 40.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Cancelar",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () {
                    _submitProfile(widget.name, widget.lastname,
                        widget.nickname, widget.email, widget.about);
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
                        "Guardar",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () {
                    _submitCerrarSesion(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFAA4A44), Color(0xFFEE4B2B)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 150.0, maxHeight: 40.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Cerrar sesión",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () {
                    _submitEliminarCuenta(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF880808), Color(0xFFAA4A44)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 150.0, maxHeight: 40.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Eliminar cuenta",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _submitEliminarCuenta(BuildContext context) async {
    await APIUserService().deleteUser();
    Navigator.of(context).pop();
    Navigator.push(
      context,
      PageRouteBuilder(pageBuilder: (_, __, ___) => LoginPage()),
    );
    SecureStorage.deleteSecureStorage().then((val) {
      Navigator.push(
        context,
        PageRouteBuilder(pageBuilder: (_, __, ___) => LoginPage()),
      );
    });
  }

  void _submitCerrarSesion(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.push(
      context,
      PageRouteBuilder(pageBuilder: (_, __, ___) => LoginPage()),
    );
    SecureStorage.deleteSecureStorage().then((val) {
      Navigator.push(
        context,
        PageRouteBuilder(pageBuilder: (_, __, ___) => LoginPage()),
      );
    });
  }

  Future<void> _submitProfile(String name, String lastname, String nickname,
      String email, String about) async {
    Future<String> status = APIUserService()
        .updateUser(name, lastname, nickname, email, about, profileImage);
    print(status);
    Navigator.push(context,
        PageRouteBuilder(pageBuilder: (_, __, ___) => UserProfileScreen()));
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        onChanged: (value) {
          if (labelText == "Nombre")
            widget.name = value;
          else if (labelText == "Apellido")
            widget.lastname = value;
          else if (labelText == "Nombre de usuario")
            widget.nickname = value;
          else if (labelText == "Correo electrónico")
            widget.email = value;
          else if (labelText == "Biografia") widget.about = value;
        },
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white60,
            )),
      ),
    );
  }
}
