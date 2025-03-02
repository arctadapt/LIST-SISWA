import 'dart:convert';
import 'package:list_siswa/utils/constants.dart';
import 'package:http/http.dart' as http;

class Services {
  final url = Uri.parse("${Constants.url}student");

  Future<Map<String, dynamic>> deleteData(String id) async {
    final response =
    await http.delete(Uri.parse("${Constants.url}student/$id"));
    var jsonData = await jsonDecode(response.body);
    return jsonData;
  }

  Future<Map<String, dynamic>> getData() async {
    final response = await http.get(url);
    var jsonData = await jsonDecode(response.body);
    return jsonData;
  }

  Future<Map<String, dynamic>> postData(
    String classes,
    String major,
    String firstName,
    String lastName,

  ) 
  async {
    final response = await http.post(url, headers: {
      "Accept": "application/json",
    }, body: {
      "classes": classes,
      "fname": firstName,
      "lname": lastName,
      "major": major
    });
    var jsonData = await jsonDecode(response.body);
    return {
      "data": jsonData,
      "status": response.statusCode,
    };
  }
}