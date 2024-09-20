import 'dart:convert';
import 'package:api_testing/Model/json_model.dart';
import 'package:http/http.dart'as http;

class fetchData {

  Future<List<Datum>?> getProducts() async {
    var baseUrl = 'http://164.68.107.70:6060/api/v1/';

    var client = http.Client();

    var url = Uri.parse('${baseUrl}ReadProduct');

    var response = await client.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic>? dataMap = jsonDecode(response.body);
      List<dynamic>? dataList = dataMap!['data'];
      List<Datum>? convertList = dataList?.map((items) => Datum.fromJson(items)).toList();
      return convertList;
    }
    return null;
  }

  Future<bool> createProduct(
      {

    required String productName,
    required String productCode,
    required String unitPrice,
    required String qty,
    required String totalPrice,
      }
  ) async {
    var baseUrl = 'http://164.68.107.70:6060/api/v1/';

    var client = http.Client();

    var url = Uri.parse('${baseUrl}CreateProduct');

    var response = await client.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "ProductName": productName,
          "ProductCode": productCode,
          "UnitPrice": double.tryParse(unitPrice) ?? 0.0,
          "Qty": int.tryParse(qty) ?? 0,
          "TotalPrice": double.tryParse(totalPrice) ?? 0.0,
          "CreatedDate": DateTime.now().toIso8601String()
        },
      ),
    );

    return response.statusCode == 200;
  }Future<bool> updateProduct(
      {
        required String id,
    required String productName,
    required String productCode,
    required String unitPrice,
    required String qty,
    required String totalPrice,
      }
  ) async {
    var baseUrl = 'http://164.68.107.70:6060/api/v1/';

    var client = http.Client();

    var url = Uri.parse('${baseUrl}UpdateProduct/$id');

    var response = await client.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "ProductName": productName,
          "ProductCode": productCode,
          "UnitPrice": double.tryParse(unitPrice) ?? 0.0,
          "Qty": int.tryParse(qty) ?? 0,
          "TotalPrice": double.tryParse(totalPrice) ?? 0.0,
          "CreatedDate": DateTime.now().toIso8601String()
        },
      ),
    );

    return response.statusCode == 200;
  }

  Future<bool> deleteProduct(String id) async {
    var baseUrl = 'http://164.68.107.70:6060/api/v1/';
    var url = Uri.parse('${baseUrl}DeleteProduct/$id');

    var response = await http.get(url, headers: {
      "Content-Type": "application/json"
    });

    return response.statusCode == 200;
  }


}

