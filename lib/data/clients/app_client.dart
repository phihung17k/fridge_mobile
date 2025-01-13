import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'api_path.dart';

class AppClient {
  String? parseToString(Response response) {
    return response.body;
  }

  List<dynamic>? parseToList(Response response) {
    return jsonDecode(response.body) as List<dynamic>;
  }

  Map<String, dynamic>? parseToMap(Response response) {
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  void logResponse(Response response) {
    // log("Response: ${response.toString()}");
    log("Status Code: ${response.statusCode}");
    log("Headers: ${response.headers}");
    log("Body: ${response.body}");
  }

  Future<Response> getAsync(Uri uri) async {
    log("------------------start------------------");
    log('GET Request: $uri');
    Response response = await get(
      uri,
      headers: {
        "Content-Type": "application/json",
        // "charset": "utf-8",
        // "Accept": "*/*",
        // "Access-Control-Allow-Origin": "*",
        // "Access-Control-Allow-Credentials":
        //     "true", // Required for cookies, authorization headers with HTTPS
        // "Access-Control-Allow-Headers":
        //     "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        // "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, DELETE",
      },
    );
    logResponse(response);
    log("-------------------end-------------------");
    return response;
  }

  // Future<Response> postAsync(String url, {dynamic body}) async {
  //   return post(url, body: body);
  // }

  // Future<Response> put(String url, {dynamic body}) async {
  //   return put(url, body: body);
  // }

  // Future<Response> delete(String url) async {
  //   return delete(url);
  // }

  // Future<Response> patch(String url, {dynamic body}) async {
  //   return patch(url, body: body);
  // }

  // Future<Response> multipart(String url,
  //     {Map<String, dynamic>? fields, Map<String, Uint8List>? files}) async {
  //   var request = MultipartRequest('POST', Uri.parse(url));
  //   if (fields != null) {
  //     fields.forEach((key, value) {
  //       request.fields[key] = value.toString();
  //     });
  //   }
  //   if (files != null) {
  //     files.forEach((key, value) {
  //       request.files.add(MultipartFile.fromBytes(key, value));
  //     });
  //   }
  //   return send(request);
  // }
}
