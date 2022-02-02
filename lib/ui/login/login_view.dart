import 'package:cast_actors/ui/login/login_viewmodel.dart';
import 'package:cast_actors/ui/shared/spinner.dart';
import 'package:cast_actors/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ViewModelBuilder<LoginViewModel>.nonReactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => FlutterLogin(
        title: 'MCast',
        logo: const AssetImage('assets/logo.png'),
        onLogin: model.authUser,
        onSignup: model.signUpUser,
        // children: [model.isBusy ? loadingSpinnerWidget : Container()],
        onSubmitAnimationCompleted: model.onComplete,
        onRecoverPassword: model.recoverPassword,
      ),
    );
  }
}
