import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/screens/login_screen.dart';
import 'package:tictactoe/state_management/signup_bloc/bloc/signup_bloc.dart';

class SignupScreen extends StatefulWidget {
  static String routeName = "/signup";
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SignupBloc signupBloc = BlocProvider.of<SignupBloc>(context);
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is UserSignupSuccessfulState) {
          Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
        }
        if (state is UserSignupFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            state.errorMsg,
          )));
        }
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: 800, maxHeight: MediaQuery.of(context).size.height),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _usernameController,
                        validator: (value) {
                          if (value == null) {
                            return "Please enter username";
                          }
                          if (value.isEmpty) {
                            return "Please enter username";
                          }
                          if (value.length < 4) {
                            return "Username must be 4 chars long";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Username",
                        ),
                      ),
                    ),
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
                            signupBloc.add(
                              UserSignupEvent(
                                username: _usernameController.text,
                                password: _passwordController.text,
                                email: _emailController.text,
                              ),
                            );
                          }
                        },
                        child: const Text("Signup"),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account"),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  LoginScreen.routeName,
                                  (route) {
                                    return false;
                                  },
                                );
                              },
                              child: const Text(
                                " Login",
                                style: TextStyle(color: Colors.purple),
                              ),
                            )
                          ],
                        ),
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
