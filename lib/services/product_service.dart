import 'dart:convert';
import 'package:http/http.dart' as http;
import '../storage/token_storage.dart';

class ProductService {
  static const String baseUrl = "https://task.itprojects.web.id";


  static Future<List<dynamic>> getProducts() async {
    String? token = await TokenStorage.getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/api/products"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['products'];
    } else {
      throw Exception("Gagal ambil produk");
    }
  }

  static Future<bool> deleteProduct(int id) async {
    String? token = await TokenStorage.getToken();

    final response = await http.delete(
      Uri.parse("$baseUrl/api/products/$id"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    return response.statusCode == 200;
  }
}