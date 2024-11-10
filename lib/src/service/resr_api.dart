import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:airmid/src/service/api.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class ApiService {
  static Future<Response> loginApi(Map<String, dynamic> loginData) async {
    log("login Data: $loginData");
    Uri uri = Uri.parse(Api.login);

    // Create a custom client with bad certificate callback
    Client client = CustomHttpClient.createIOClient();

    Response response = await client.post(
      uri,
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
      },
      body: jsonEncode(loginData),
    );

    return response;
  }

  static Future<Response> procedureApiCalling({
    required Map<String, dynamic> body,
    required String procedure,
  }) async {
    Client client = CustomHttpClient.createIOClient();

    Response response = await client.post(
      Uri.parse(Api.apiBaseUrl + procedure),
      headers: {
        'accept': '/',
        'Content-Type': 'application/json-patch+json',
      },
      body: jsonEncode(body),
    );
    log("Api Boady $procedure $body");
    log("Api Response $procedure $response");

    return response;
  }

  static Future<Response> apiCalling({
    required Map<String, dynamic> body,
    required String apiName,
  }) async {
    Client client = CustomHttpClient.createIOClient();

    Response response = await client.post(
      Uri.parse(Api.baseUrl + apiName),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    log("Api url ${Uri.parse(Api.baseUrl + apiName)}");
    log("Api Boady $apiName $body");
    log("Api Response $apiName $response");

    return response;
  }
}

class CustomHttpClient {
  static HttpClient createHttpClient() {
    HttpClient client = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    return client;
  }

  static Client createIOClient() {
    return IOClient(createHttpClient());
  }
}
