import 'dart:io';
import 'package:tfgapp/src/storage/secure_storage.dart';
import 'package:http/http.dart' as http;

class APIUserService {
  final String myUrl = "https://api-danielrodriguez.herokuapp.com";

  Future<String> updateUser(String name, String lastname, String nickname,
      String email, String about, File profileImage) async {
    String userId = await SecureStorage.readSecureStorage('App_UserID');

    var uri = Uri.parse("$myUrl/users/$userId");

    var request = http.MultipartRequest('PATCH', uri)
      ..fields['new_name'] = name
      ..fields['new_lastname'] = lastname
      ..fields['new_nickname'] = nickname
      ..fields['new_email'] = email
      ..fields['new_about'] = about;

    if (profileImage != null) {
      // ignore: await_only_futures
      request.files.add(await http.MultipartFile('profileImage',
          profileImage.readAsBytes().asStream(), profileImage.lengthSync(),
          filename: "profileImage"));
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 201) {}
    return response.statusCode.toString();
  }

  Future<void> deleteUser() async {
    SecureStorage.readSecureStorage('App_UserID').then((id) {
      var url =
          Uri.parse("https://api-danielrodriguez.herokuapp.com/users/$id");
      http.delete(url).then((res) {
        print(res.statusCode);
        print(url.toString());

        if (res.statusCode != 400 && res.statusCode != 404) {
          print("delete");
        } else {
          print("MAAAL${res.statusCode}");
        }
      });
    });
  }
}