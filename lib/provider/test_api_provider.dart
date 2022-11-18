import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_register/model/Product_model.dart';
import 'package:login_register/utilty/const.dart';

class TestAPIProvider extends ChangeNotifier {
  List<ProductModel> productModel = [];

  getData() async {
    print('Start');
    try {
      http.Response response = await http.get(
        Uri.parse('${BASE_URL_2}$PRODUCTS'),
      );
      if (response.statusCode == 200) {
        print('Success');
        print(json.decode(response.body));
        json.decode(response.body)['products'].forEach((item) {
          productModel.add(
            ProductModel.fromJson(item),
          );
        });
        notifyListeners();
        print('Product : =============${productModel[0].title}');
      } else {
        print('Else');
      }
    } on SocketException {
      print('Network error');
    } catch (e) {
      print(e.toString());
    }
    print('End');
  }

  postData() async {
    print('Start');
    try {
      http.Response response = await http.post(
        Uri.parse('${BASE_URL_2}$PRODUCTS$ADD'),
        body: json.encode(
          {'title': 'Malek', 'description': 'OC Member'},
        ),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print('Success');
        print(json.decode(response.body));
        notifyListeners();
      } else {
        print('Else');
      }
    } on SocketException {
      print('Network error');
    } catch (e) {
      print(e.toString());
    }
    print('End');
  }

  updateData({
    required int id,
  }) async {
    print('Start');
    try {
      http.Response response = await http.patch(
        Uri.parse('${BASE_URL_2}$PRODUCTS/$id'),
        body: json.encode(
          {
            'title': 'Malek',
            'description': 'OC Member',
            'rating':20
          },
        ),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print('Success');
        print(json.decode(response.body));
        notifyListeners();
      } else {
        print('Else');
      }
    } on SocketException {
      print('Network error');
    } catch (e) {
      print(e.toString());
    }
    print('End');
  }

  deleteData({
    required int id,
  }) async {
    print('Start');
    try {
      http.Response response = await http.delete(
        Uri.parse('${BASE_URL_2}$PRODUCTS/$id'),
      );
      if (response.statusCode == 200) {
        print('Success');
        print(json.decode(response.body));
        notifyListeners();
      } else {
        print('Else');
      }
    } on SocketException {
      print('Network error');
    } catch (e) {
      print(e.toString());
    }
    print('End');
  }
}
