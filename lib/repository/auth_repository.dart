import 'package:marafq/network/network_api_services.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:marafq/api_services/constants.dart';
import 'package:marafq/model/report_model.dart';
import 'package:marafq/model/user_model.dart';
import 'package:marafq/api_services/constants.dart';
import 'package:marafq/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final NetworkAPIServices _apiServices = NetworkAPIServices();

  Future<bool> login(username, password) async {
    try {
      final jsonRe = {'username': username, 'password': password};
      dynamic response = await _apiServices.getPostApiResponse(
          ApiConstants.baseUrl + ApiConstants.LoginEndpoint, jsonRe);
      final data = response['data'];
      print(response);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      String user = jsonEncode(UserModel.fromJson(data));
      prefs.setString('userData', user);
      return true;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
