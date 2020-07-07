import 'dart:developer';

import 'package:first_app/Login/LoginEvent.dart';
import 'package:first_app/Login/LoginState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'LoginEvent.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  // TODO: implement initialState
  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // TODO: implement mapEventToState
    if (event is TogglePasswordEvent) {
      var newState = state.copyWith();
      newState.passwordVisibility = !state.passwordVisibility;
      yield newState;
    } else if (event is UserNameCheckingEvent) {
      var newState;
      if (event.error.isEmpty) {
        //no error
        newState = state.copyWith(isUserNameValid: true, userNameError: "");
      } else {
        newState =
            state.copyWith(isUserNameValid: false, userNameError: event.error);
      }
      yield newState;
    } else if (event is PasswordCheckingEvent) {
      var newState;
      if (event.error.isEmpty) {
        //no error
        newState = state.copyWith(isPasswordValid: true, passwordError: "");
      } else {
        log("event password error is ${event.error}");
        newState =
            state.copyWith(isPasswordValid: false, passwordError: event.error);
      }
      yield newState;
    }
    yield state;
  }

  void onUserNameChecking(String userName) {
    add(UserNameCheckingEvent(userName));
  }

  void onPasswordChecking(String password) {
    log("Changed !");

    add(PasswordCheckingEvent(password));
  }

  void onTogglePassword() {
    add(TogglePasswordEvent());
  }
}
