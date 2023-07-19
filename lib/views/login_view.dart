// ignore_for_file: use_build_context_synchronously


import 'package:basicchat/constants/routes.dart';
import 'package:basicchat/services/auth/auth_exception.dart';
import 'package:basicchat/services/auth/auth_service.dart';


import 'package:flutter/material.dart';

import '../utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          const Text(
            'MEMOW',
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 1,
                fontSize: 50,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: const InputDecoration(
                  hintText: 'Enter Your Email Here',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(color: Colors.black)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                  hintText: 'Enter Your Password Here',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                  fillColor: Colors.black,
                  hintStyle: TextStyle(color: Colors.black)),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase()
                    .logIn(email: email, password: password);

                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    noteRoute,
                    (route) => false,
                  );
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      VerifyEmailRoute, ((route) => false));
                }
              } on UserNotFoundAuthException {
                await showErrorDialog(context, 'User-not-found');
              } on WrongPasswordAuthException {
                await showErrorDialog(context, 'Wrong credentials');
              } on GanericAuthException {
                await showErrorDialog(context, 'AuthenticationError');
              }
            },
            style: TextButton.styleFrom(
                elevation: 5,
                shadowColor: Colors.grey,
                backgroundColor: Colors.black,
                textStyle: const TextStyle(color: Colors.white)),
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.black,
              disabledForegroundColor: Colors.black.withOpacity(0.38),
            ),
            child: const Text("Not register yet?Register here!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ],
      ),
    );
  }
}
