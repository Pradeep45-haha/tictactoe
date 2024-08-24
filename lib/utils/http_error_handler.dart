import 'dart:convert';
import 'package:http/http.dart';

class Data {
  final bool isError;
  final Map<String, dynamic>? successData;
  final Object? errorData;

  Data(
      {required this.errorData,
      required this.isError,
      required this.successData});
}

Data errorHandler(Response response) {
  switch (response.statusCode) {
    case 200:
      return Data(
        isError: false,
        successData: jsonDecode(response.body) as Map<String, dynamic>,
        errorData: null,
      );
    case 400:
      return Data(
        isError: true,
        successData: null,
        errorData: "Empty fields",
      );
    case 401:
      return Data(
        isError: true,
        successData: null,
        errorData: "Wrong credentials",
      );
    case 409:
      return Data(
        isError: true,
        successData: null,
        errorData: "Account already exists",
      );
    case 500:
      return Data(
        isError: true,
        successData: null,
        errorData: "Server error",
      );
    default:
      return Data(
        isError: true,
        successData: null,
        errorData: "Unexpected error",
      );
  }
}
