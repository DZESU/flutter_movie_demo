import 'dart:convert';

import 'package:http/http.dart';

class NetworkHelper{

  NetworkHelper(this.url);
  final String url;

  Future getData() async{
    Response response = await get(url);
    String data = response.body;
    return jsonDecode(data);
  }

}