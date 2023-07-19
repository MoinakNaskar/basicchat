import 'dart:math';

import 'package:basicchat/services/auth/auth_exception.dart';
import 'package:basicchat/services/auth/auth_provider.dart';
import 'package:basicchat/services/auth/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('Should not be initialized to begin with', () {
      expect(provider.isInitialised, false);
    });
    test('Cannot logout if not initialised', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitialisedException>()),
      );
    });
    test('Should be able to initializer', () async {
      await Future.delayed(const Duration(seconds: 1));
      expect(provider.isInitialised, true);
    });
    test('User should be null after initialized', () {
      expect(provider.currentUser, null);
    });
    test(
      'Should be able to initialized in less two second ',
      () async {
        await provider.initialized();
        expect(provider.isInitialised, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );
    test('Create user should delegate to login funvtion', () {
      final badEmailUser =
          provider.createUser(email: "main@k", password: "anypassword");
      expect(badEmailUser,
          throwsA(const TypeMatcher<UserNotFoundAuthException>()));
      final badPasswordEmail =
          provider.createUser(email: "someone@kar", password: "naskar");
      expect(
          badPasswordEmail, throwsA(TypeMatcher<WrongPasswordAuthException>()));
      final userr = provider.createUser(email: 'mai', password: 'kar');
      expect(provider.currentUser, userr);
      final user = provider.currentUser;
      expect(user!.isEmailVerified, false);
    });
    test('Logged in user should be able to verify', () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });
    test('Should be able to logged out and log in', () {
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotInitialisedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialised = false;
  bool get isInitialised => _isInitialised;

  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) async {
    if (!isInitialised) throw NotInitialisedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(email: email, password: password);
  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialized() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialised = true;
  }

  @override
  Future<AuthUser> logIn(
      {required String email, required String password}) async {
    if (!isInitialised) throw NotInitialisedException();
    if (email == 'main@k') throw UserNotFoundAuthException();
    if (password == 'naskar') throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialised) throw NotInitialisedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialised) throw NotInitialisedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
  }
}
