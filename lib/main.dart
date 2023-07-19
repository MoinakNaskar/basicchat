import 'package:basicchat/constants/loader.dart';
import 'package:basicchat/constants/routes.dart';
import 'package:basicchat/services/auth/auth_service.dart';

import 'package:basicchat/views/login_view.dart';
import 'package:basicchat/views/notes_view.dart';
import 'package:basicchat/views/register_view.dart';
import 'package:basicchat/views/verify_email_view.dart';

import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    darkTheme: ThemeData(brightness: Brightness.dark),
    themeMode: ThemeMode.dark,
    home: const HomePage(),
    routes: {
      loginRoute: ((context) => const LoginView()),
      registerRoute: ((context) => const RegisterView()),
      noteRoute: (context) => const NotesView(),
      VerifyEmailRoute: (context) => const VerifyEmailView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialized(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified) {
                  return const NotesView();
                } else {
                  return const RegisterView();
                }
              } else {
                return const LoginView();
              }

            default:
              return const LodingScreen();
          }
        });
  }
}
