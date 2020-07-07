import 'package:first_app/Login/LoginEvent.dart';

class LoginState {
  bool passwordVisibility;
  String userName, password;
  String userNameError;
  String passwordError;
  bool isUserNameValid;
  bool isPasswordValid;

  LoginState._();

  factory LoginState.initial(
      {passwordVisibility = false,
      userName = "default",
      password = "default"}) {
    return LoginState._()
      ..passwordVisibility = passwordVisibility
      ..password = password
      ..userName = userName
      ..passwordError = "Enter your password"
      ..userNameError = "Enter your user name"
      ..isPasswordValid = false
      ..isUserNameValid = false;
  }

  LoginState copyWith(
      {String userName,
      String password,
      String passwordVisibility,
      String userNameError,
      String passwordError,
      bool isUserNameValid,
      bool isPasswordValid}) {
    return new LoginState.initial()
      ..password = userName ?? this.password
      ..userName = password ?? this.userName
      ..passwordVisibility = passwordVisibility ?? this.passwordVisibility
      ..passwordError = passwordError ?? this.passwordError
      ..userNameError = userNameError ?? this.userNameError
      ..isPasswordValid = isPasswordValid ?? this.isPasswordValid
      ..isUserNameValid = isUserNameValid ?? this.isUserNameValid;
  }
}
