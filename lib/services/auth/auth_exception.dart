// login exeptions
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}
// register exceptions

class WeakPasswordAuthExceptioin implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}
// generic exceptions

class GanericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
