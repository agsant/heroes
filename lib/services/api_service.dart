import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class APIService {
  final String heroURL = "https://api.opendota.com/api/herostats";
  final String baseImageURL = "https://api.opendota.com";

  Future<dynamic> getHeroes() async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(heroURL));
      responseJson = returnResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    }
    return responseJson;
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw Exception(
            'Request error with status code: ${response.statusCode}');
    }
  }

}