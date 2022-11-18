import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:login_register/model/user_model.dart';
import 'package:login_register/utilty/const.dart';

class AuthProvider extends ChangeNotifier {
  bool authLoading = false;
  
  UserModel? userModel;

  login({required String email, required String password}) async {
    authLoading = true;
    notifyListeners();
    try {
      http.Response response = await http.post(
        Uri.parse('${BASE_URL}$LOGIN'),
        body: {
          'email': email,
          'password': password,
        },
      );
      if (json.decode(response.body)['status']==true) {
        print('Done');
        userModel = UserModel.fromJson(json: json.decode(response.body)['data']);
        print(userModel!.name);
        Fluttertoast.showToast(
          msg: '${json.decode(response.body)['message']}',
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        authLoading = false;
        notifyListeners();
      } else {
        print('${json.decode(response.body)['message']}');
        Fluttertoast.showToast(
          msg: '${json.decode(response.body)['message']}',
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        authLoading = false;
        notifyListeners();
      }
    } on SocketException {
      print('Internet Error');
      Fluttertoast.showToast(
        msg: 'Internet Error',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      authLoading = false;
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      authLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }

  register({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) async {
    authLoading = true;
    notifyListeners();
    try {
      http.Response response = await http.post(
        Uri.parse('${BASE_URL}$REGISTER'),
        body: {
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
          'image':''
        },
      );
      if (json.decode(response.body)['status']==true) {
        print('Done');
        userModel = UserModel.fromJson(json: json.decode(response.body)['data']);
        print(userModel!.name);
        Fluttertoast.showToast(
          msg: '${json.decode(response.body)['message']}',
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        authLoading = false;
        notifyListeners();
      } else {
        Fluttertoast.showToast(
          msg: '${json.decode(response.body)['message']}',
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        authLoading = false;
        notifyListeners();
      }
    } on SocketException {
      Fluttertoast.showToast(
        msg: 'Internet Error',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      authLoading = false;
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      authLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }
}
