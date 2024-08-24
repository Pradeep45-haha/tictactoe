import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tictactoe/utils/http_error_handler.dart';

class AuthMethods {
  final http.Client client;

  AuthMethods({required this.client});

  Future<Data> login({required String email, required String password}) async {
    try {
      http.Response response = await client.post(
        Uri.parse("http://127.0.0.1:3000/user/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ),
      );
      return errorHandler(response);
    } catch (error) {
      debugPrint(error.toString());
      if (error is http.ClientException) {
        debugPrint("got error in login method");
        return Data(isError: true, errorData: error.message, successData: null);
      }
      return Data(
          errorData: "Something went wrong", isError: true, successData: null);
    }
  }

  Future<Data> signup(
      {required String email,
      required String password,
      required String username}) async {
    try {
      debugPrint("$email $password  $username");
      http.Response response = await client.post(
        Uri.parse("http://127.0.0.1:3000/user/signup"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            {"email": email, "password": password, "username": username}),
      );
      return errorHandler(response);
    } catch (error) {
      debugPrint(error.toString());
      if (error is http.ClientException) {
        return Data(isError: true, errorData: error.message, successData: null);
      }
      return Data(
          errorData: "Something went wrong", isError: true, successData: null);
    }
  }
}
