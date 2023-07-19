import 'package:basicchat/constants/routes.dart';
import 'package:basicchat/services/auth/auth_exception.dart';
import 'package:basicchat/services/auth/auth_service.dart';
import 'package:basicchat/utilities/show_error_dialog.dart';

import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            controller: _email,
            decoration: const InputDecoration(
              hintText: 'Enter Your Email Here',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter Your Password Here',
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase()
                    .createUser(email: email, password: password);
                final user = AuthService.firebase().currentUser;
                await AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(VerifyEmailRoute);
              } on WeakPasswordAuthExceptioin {
                await showErrorDialog(context, 'Weak password');
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(context, 'Email is already in use');
              } on InvalidEmailAuthException {
                await showErrorDialog(context, 'invalid');
              } on GanericAuthException {
                await showErrorDialog(context, 'some thing went wrong');
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (route) => false,
                );
              },
              child: const Text('Already Registered? Login here!'))
        ],
      ),
    );
  }
}
