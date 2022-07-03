import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_app/api/api.dart';

import '../models/basket_model.dart';
import '../models/category_model.dart';
import '../models/user_model.dart';

class ApiService extends BaseAPI{

  Future<List<Category>> fetchCategories(String token) async {
    final response = await http.get(Uri.parse(super.categoriesPath),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if(response.statusCode==200){
      print(response.body);
      List<Category> _model =categoryModelFromJson(response.body);
      return _model;
    }
    else{
      throw Exception('Failed to load categories!');
    }
  }

  Future<List<User>> searchCategories(String token, int id) async {
    final response = await http.get(Uri.parse(super.searchCategoriesPath + "/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if(response.statusCode==200){
      print(response.body);
      List<User> _model =shopModelFromJson(response.body);
      return _model;
    }
    else{
      print(response.body);
      throw Exception('Failed to load search!');
    }
  }

  Future<List<User>> fetchProviders(String token) async {
    final response = await http.get(Uri.parse(super.providersPath),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if(response.statusCode==200){
      print(response.body);
      List<User> _model =shopModelFromJson(response.body);
      return _model;
    }
    else{
      throw Exception('Failed to load providers!');
    }
  }

  Future<User> fetchDetails(String token, int id) async {
    final response = await http.get(Uri.parse(super.detailsPath + "/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if(response.statusCode==200){
      print(response.body);
      User _model =detailsModelFromJson(response.body);
      return _model;
    }
    else{
      print(response.body);
      throw Exception('Failed to load details!');
    }
  }
  Future <List<Basket>> fetchOrders(String token) async {
    final response = await http.get(Uri.parse(super.getOrdersPath),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if(response.statusCode==200){
      print(response.body);
      List<Basket> _model =basketFromJson(response.body);
      return _model;
    }
    else{
      print(response.body);
      throw Exception('Failed to load details!');
    }
  }

  Future<http.Response> postOrders(String token, int id, int quantity ) async {
    // var jsonString =
    //     {"product":{"id": $id, "quantity": $quantity}};
   var body =  jsonEncode({"product":{"id": id, "quantity": quantity}}).replaceAll(r'\', r'');
    print(body);
    http.Response response = await http.post(Uri.parse(super.postOrdersPath),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      body:
      body,
    );
print(jsonDecode(response.body));
      return response;
  }

}