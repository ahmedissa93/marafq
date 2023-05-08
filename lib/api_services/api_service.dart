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

class ApiService {
  Future<bool> login(username, password) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.LoginEndpoint);
      final headers = {"Content-type": "application/json"};
      final jsonRe = {'username': username, 'password': password};
      var response =
          await http.post(url, headers: headers, body: jsonEncode(jsonRe));
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        String username = body['data']['username'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        print(body['data']);
        String user = jsonEncode(UserModel.fromJson(body['data']));
        prefs.setString('userData', user);
        // prefs.setString('user', body['data']);
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> register(username, password, email, name) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.RegisterEndpoint);
      final headers = {"Content-type": "application/json"};
      final jsonRe = {
        'username': username,
        'password': password,
        'email': email,
        'name': name
      };
      var response =
          await http.post(url, headers: headers, body: jsonEncode(jsonRe));
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<List<ReportModel>> getReportByUserID([String? status]) async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    var url =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.reportByUserIDEndpoint);

    SharedPreferences pref = await SharedPreferences.getInstance();
    final userData = json.decode(pref.getString('userData').toString());
    final headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${userData['token']}"
    };
    final jsonRe = {'reporter_id': userData['id'], 'status': status ?? 1};
    var response =
        await http.post(url, headers: headers, body: jsonEncode(jsonRe));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      List<ReportModel> reports = [];
      for (var u in jsonResponse["data"]) {
        var date = u['date'];
        date = DateTime.parse(date);
        date = dateFormat.format(date);
        // print(u["class_number"]);
        ReportModel report = ReportModel(
          id: u['id'],
          service: u['service'],
          status: u['status'],
          reporter_by: u['reporter_by'],
          report_number: u['report_number'],
          date: date,
        );
        reports.add(report);
      }
      return reports;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }

  Future<bool> addReport(data) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.addReportEndpoint);
      final headers = {"Content-type": "application/json"};
      var response =
          await http.post(url, headers: headers, body: jsonEncode(data));
      print(response.body);

      if (response.statusCode == 200) {
        print("done");
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }
}
