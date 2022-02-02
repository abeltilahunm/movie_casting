import 'package:cast_actors/app/app.locator.dart';
import 'package:cast_actors/util/logger.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class LoginViewModel extends BaseViewModel {
  final authService = locator<FirebaseAuthenticationService>;

  Duration get loginTime => const Duration(milliseconds: 2250);

  //This used to authenticate user.
  //The login data is a model from the package login
  Future<String?> authUser(LoginData data) async {
    logger.d('Name: ${data.name}, Password: ${data.password}');
    setBusy(true);
    final result = await authService()
        .loginWithEmail(email: data.name, password: data.password);
    setBusy(false);

    return result.hasError ? result.errorMessage : null;
  }

  //This is used to signUp users.
  //The signUp data is the data sent from the signUp form.
  Future<String?> signUpUser(SignupData data) async {
    logger.d('Signup Name: ${data.name}, Password: ${data.password}');
    setBusy(true);
    final result = await authService()
        .createAccountWithEmail(email: data.name!, password: data.password!);
    setBusy(false);

    return result.hasError ? result.errorMessage : null;
  }

  Future<String> recoverPassword(String name) async {
    return "";
  }
}
