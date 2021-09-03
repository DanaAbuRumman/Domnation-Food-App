import 'dart:convert';

import 'package:http/http.dart' as http;

class FirebaseApi {
  String _baseURL = 'https://final-project-c2adb-default-rtdb.firebaseio.com/';

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      var response = await http.get(Uri.parse(_baseURL + url));
      responseJson = _processedResponse(response);
    } catch (ex) {}

    return responseJson;
  }

  Future<dynamic> delete({required String url}) async {
    var responseJson;
    try {
      var response = await http.delete(
        Uri.parse(_baseURL + url),
      );
      responseJson = _processedResponse(response);
      print(responseJson);
    } catch (ex) {}

    return responseJson;
  }

  Future<dynamic> post({required String url, required String body}) async {
    var responseJson;
    try {
      var response = await http.post(
        Uri.parse(_baseURL + url),
        body: body,
      );
      responseJson = _processedResponse(response);
    } catch (ex) {}

    return responseJson;
  }

  Future<dynamic> upload(
      {required String url, required Map<String, dynamic> body}) async {
    var responseJson;
    try {
      var response = await http.patch(
        Uri.parse(_baseURL + url),
        body: jsonEncode(body),
      );

      responseJson = _processedResponse(response);
      print(responseJson);
    } catch (ex) {
      print(ex);
    }

    return responseJson;
  }

  dynamic _processedResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var jsonBody = json.decode(response.body);
        return jsonBody;

      case 500:
        throw Exception('something went wrong');
    }
  }
}
