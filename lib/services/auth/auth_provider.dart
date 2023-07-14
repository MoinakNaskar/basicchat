import 'package:basicchat/services/auth/auth_user.dart';
import 'package:flutter/material.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;
  Future<AuthUser?> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
}
