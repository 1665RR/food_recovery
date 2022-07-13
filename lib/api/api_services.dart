import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:food_app/models/menu_item_model.dart';
import 'package:http/http.dart' as http;
import 'package:food_app/api/api.dart';
import 'package:http_parser/http_parser.dart';

import '../models/basket_model.dart';
import '../models/category_model.dart';
import '../models/user_model.dart';

class ApiService extends BaseAPI {
  Future<List<Category>> fetchCategories(String token) async {
    final response = await http.get(Uri.parse(super.categoriesPath), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      print(response.body);
      List<Category> _model = categoryModelFromJson(response.body);
      return _model;
    } else {
      throw Exception('Failed to load categories!');
    }
  }

  Future<List<User>> searchCategories(String token, int id) async {
    final response = await http
        .get(Uri.parse(super.searchCategoriesPath + "/$id"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print(response.body);
      List<User> _model = shopModelFromJson(response.body);
      return _model;
    } else {
      throw Exception('Failed to load search!');
    }
  }

  Future<List<User>> fetchProviders(String token) async {
    final response = await http.get(Uri.parse(super.providersPath), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      print(response.body);
      List<User> _model = shopModelFromJson(response.body);
      return _model;
    } else {
      throw Exception('Failed to load providers!');
    }
  }

  Future<User> fetchDetails(String token, int id) async {
    final response =
        await http.get(Uri.parse(super.detailsPath + "/$id"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print(response.body);
      User _model = detailsModelFromJson(response.body);
      return _model;
    } else {
      throw Exception('Failed to load details!');
    }
  }

  Future<List<Basket>> fetchOrders(String token) async {
    final response = await http.get(Uri.parse(super.getOrdersPath), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print(response.body);
      List<Basket> _model = basketFromJson(response.body);
      return _model;
    } else {
      throw Exception('Failed to load details!');
    }
  }

  Future<http.Response> postOrders(String token, int id, int quantity) async {
    var body = jsonEncode({
      "product": {"id": id, "quantity": quantity}
    }).replaceAll(r'\', r'');
    print(body);
    http.Response response = await http.post(
      Uri.parse(super.postOrdersPath),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    print(jsonDecode(response.body));
    return response;
  }

  Future<List<MenuItem>> fetchMyProducts(String token) async {
    final response =
        await http.get(Uri.parse(super.getMyProductsPath), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print(response.body);
      List<MenuItem> _model = menuItemModelFromJson(response.body);
      return _model;
    } else {
      throw Exception('Failed to load details!');
    }
  }

  addProducts(String token, String name, String description, var expire,
      int itemsLeft, int categoryId, File productImage) async {
    var postUri = Uri.parse(super.productsPath);
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest("POST", postUri);
    request.headers.addAll(headers);
    request.fields["name"] = name;
    request.fields["description"] = description;
    request.fields["expire"] = expire;
    request.fields["itemsLeft"] = itemsLeft.toString();
    request.fields["categoryId"] = categoryId.toString();
    var multipartFile = await http.MultipartFile.fromPath(
      'productImage',
      productImage.path,
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(multipartFile);
    http.Response response =
        await http.Response.fromStream(await request.send());

    print("Result: ${jsonDecode(response.body)}");
    return response;
  }

  Future<http.Response> deleteProducts(
    String token,
    int id,
  ) async {
    final response =
        await http.delete(Uri.parse(super.productsPath + "/$id"), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      print(response.body);
      return (response);
    } else {
      print(response.body);
      throw Exception('Failed to delete product!');
    }
  }

  Future<List<Basket>> fetchOrdersByProducts(String token, int id) async {
    final response =
        await http.get(Uri.parse(super.productOrdersPath + "/$id"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print(response.body);
      List<Basket> _model = basketFromJsonUser(response.body);
      return _model;
    } else {
      print(response.body);
      throw Exception('Failed to load orders by product!');
    }
  }

  Future<http.Response> changeStatus(
    String token,
    int id,
  ) async {
    final response =
        await http.put(Uri.parse(super.changeStatusPath + "/$id"), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      print(response.body);
      return (response);
    } else {
      print(response.body);
      throw Exception('Failed to change status!');
    }
  }

  Future<List<User>> fetchUsersList(String token) async {
    final response = await http.get(Uri.parse(super.usersPath), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print(response.body);
      List<User> _model = usersFromJson(response.body);
      return _model;
    } else {
      print(response.body);
      throw Exception('Failed to load users!');
    }
  }

  addCategory(String token, String name, File icon) async {
    var postUri = Uri.parse(super.categoriesPath);
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest("POST", postUri);
    request.headers.addAll(headers);
    request.fields["name"] = name;
    var multipartFile = await http.MultipartFile.fromPath(
      'icon',
      icon.path,
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(multipartFile);
    http.Response response =
        await http.Response.fromStream(await request.send());

    print("Result: ${jsonDecode(response.body)}");
    return response;
  }

  Future<http.Response> deleteUsers(
    String token,
    int id,
  ) async {
    final response =
        await http.delete(Uri.parse(super.usersPath + "/$id"), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      print(response.body);
      return (response);
    } else {
      print(response.body);
      throw Exception('Failed to delete users!');
    }
  }

  Future<http.Response> sendEmail(String token) async {
    http.Response response =
        await http.get(Uri.parse(super.sendEmailPath), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      print(response.body);
      return (response);
    } else {
      print(response.body);
      throw Exception('Failed to send email!');
    }
  }

  Future<http.Response> addToProvider(String token, String email) async {
    var body = jsonEncode({
      "email": email,
    }).replaceAll(r'\', r'');
    print(body);
    http.Response response = await http.put(
      Uri.parse(super.addToProviderPath),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    print(jsonDecode(response.body));
    return response;
  }
}
