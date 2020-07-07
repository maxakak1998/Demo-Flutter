import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

enum UserNameError {
  LengthError, //User name must be great than 6 chars
  SyntaxError, // User name must have @ char and white space
}
enum PasswordError {
  LengthError, //User name must be great than 6 chars
}

abstract class LoginEvent {}

class LoginClickedEvent extends LoginEvent {}

class FacebookClickedEvent extends LoginEvent {}

class TwitterClickedEvent extends LoginEvent {}

class TogglePasswordEvent extends LoginEvent {}

class RegisterEvent extends LoginEvent {}

class UserNameCheckingEvent extends LoginEvent {
  String _userName;
  String error;
  UserNameCheckingEvent(String userName) {
    this._userName = userName;
    if (_userName.length < 7) {
      error = _checkUserNameError(UserNameError.LengthError);
    } else if (!_userName.contains("@") || _userName.contains(" ")) {
      error = _checkUserNameError(UserNameError.SyntaxError);
    } else {
      error = _checkUserNameError();
    }
  }

  String _checkUserNameError([UserNameError userNameError]) {
    if (userNameError == UserNameError.LengthError) {
      return "User name must be greater than 6 characters";
    } else if (userNameError == UserNameError.SyntaxError) {
      return "User name must include @ character and \n can't include white space";
    }
    return ""; //no error
  }
}

class PasswordCheckingEvent extends LoginEvent {
  String _password;
  String error;
  PasswordCheckingEvent(String password) {
    this._password = password;
    if (this._password.length < 7) {
      error = _checkPasswordError(PasswordError.LengthError);
    } else if (_password.contains(" ")) {
      error = "Cant include white space";
    } else {
      error = _checkPasswordError();
    }
  }

  String _checkPasswordError([PasswordError passwordError]) {
    if (passwordError == PasswordError.LengthError) {
      return "Password must be greater than 6 characters";
    }
    return "";
  }
}
