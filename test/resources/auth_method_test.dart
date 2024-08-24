import 'dart:convert';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tictactoe/resources/auth_methods.dart';
import 'package:tictactoe/utils/http_error_handler.dart';
import 'auth_method_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late AuthMethods authMethods;
  late http.Client client;

  setUp(() {
    client = MockClient();
    authMethods = AuthMethods(client: client);
  });

  group("AuthMethods class testing", () {
    test("login method testing", () async {
      final Map<String, dynamic> responseData = {"token": "some_token"};
      final responseJson = jsonEncode(responseData);

      when(client.post(
        Uri.parse("http://127.0.0.1:3000/user/login"),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async {
        return http.Response(responseJson, 200);
      });

      final Data loginData = await authMethods.login(
          email: "test@example.com", password: "password");

      expect(loginData.successData, responseData);
      expect(loginData.isError, false);
      expect(loginData.errorData, null);
    });
    test("login method failure test", () async {
      when(client.post(
        Uri.parse("http://127.0.0.1:3000/user/login"),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async {
        return http.Response("", 400);
      });

      final Data loginData = await authMethods.login(
          email: "test@example.com", password: "password");
      expect(loginData.isError, true);
      expect(loginData.successData, null);
      expect(loginData.errorData, "Empty fields");
    });

    test("login method failure test", () async {
      when(client.post(
        Uri.parse("http://127.0.0.1:3000/user/login"),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async {
        return http.Response("", 400);
      });

      final Data loginData = await authMethods.login(
          email: "test@example.com", password: "password");
      expect(loginData.isError, true);
      expect(loginData.successData, null);
      expect(loginData.errorData, "Empty fields");
    });

    test("login method exception test", () async {
      when(client.post(
        Uri.parse("http://127.0.0.1:3000/user/login"),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenThrow(http.ClientException);
      final Data loginData = await authMethods.login(
          email: "test@example.com", password: "password");
      expect(loginData.isError, true);
      expect(loginData.successData, null);
      expect(loginData.errorData, "Something went wrong");
    });

    test("login method wrong status code test", () async {
      when(client.post(
        Uri.parse("http://127.0.0.1:3000/user/login"),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async {
        return http.Response("", 600);
      });

      final Data loginData = await authMethods.login(
          email: "test@example.com", password: "password");
      expect(loginData.isError, true);
      expect(loginData.successData, null);
      expect(loginData.errorData, "Unexpected error");
    });
  });
}
