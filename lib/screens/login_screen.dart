import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/screens/menu_screen.dart';
import 'package:tictactoe/screens/signup_screen.dart';
import 'package:tictactoe/state_management/login_bloc/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";
  
  const LoginScreen({super.key, });
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
          debugPrint(state.token);
          Navigator.of(context).popAndPushNamed(MenuScreen.routeName);
        }
        if (state is UserLoginFailedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 600,
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null) {
                            return "Please enter email";
                          }
                          if (value.isEmpty) {
                            return "Please enter email";
                          }
                          return null;
                        },
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Email",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null) {
                            return "Please enter password";
                          }
                          if (value.isEmpty) {
                            return "Please enter password";
                          }
                          if (value.length < 8) {
                            return "Password must be 8 chars long";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Password",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          var validator = _formKey.currentState!;
                          if (validator.validate()) {
                            loginBloc.add(
                              UserLoginEvent(
                                password: _passwordController.text,
                                email: _emailController.text,
                              ),
                            );
                          }
                        },
                        child: const Text("Login"),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("New here "),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                SignupScreen.routeName,
                                (route) {
                                  return false;
                                },
                              );
                            },
                            child: const Text(
                              " Signup",
                              style: TextStyle(
                                color: Colors.purple,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
