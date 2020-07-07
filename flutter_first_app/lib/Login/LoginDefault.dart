import 'dart:developer';
import 'package:first_app/Login/LoginBloC.dart';
import 'package:first_app/Login/LoginEvent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_app/Home/Home.dart';
import 'package:first_app/common/CustomCheckBox.dart';
import 'package:first_app/common/DimensionHelper.dart';
import 'package:flutter/material.dart';

import 'Login.dart';
import 'LoginState.dart';

class LoginDefault extends StatefulWidget {
  LoginDefault({Key key}) : super(key: key);

  @override
  _LoginDefaultState createState() {
    // TODO: implement createState
    return _LoginDefaultState();
  }
}

class _LoginDefaultState extends State<LoginDefault> {
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("Deactive ");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final _loginBloc = BlocProvider.of<LoginBloc>(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, LoginState state) {
              return TextFormField(
                //start --- move to the next textForm when the current form is completed
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  _onUserNameChanged(value, _loginBloc);
                },
                onFieldSubmitted: (value) {
                  FocusScope.of(context).nextFocus();
                },
                //----end
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "User name",
                ),
                validator: (value) {
                  if (!state.isUserNameValid) {
                    return state.userNameError;
                  }
                  return null;
                },
              );
            },
          ),
          BlocBuilder<LoginBloc, LoginState>(
            condition: (prevState, state) {
              if (prevState.passwordVisibility != state.passwordVisibility) {
                return true;
              }
              if (prevState.passwordError != state.passwordError) {
                return true;
              }
              return false;
            },
            builder: (context, LoginState state) {
              log("State in BlocBuilder is ${state.passwordVisibility}");
              return TextFormField(
                keyboardType: TextInputType.text,
                enableInteractiveSelection: false,
                obscureText: state.passwordVisibility,
                onChanged: (value) {
                  _onPasswordChanged(value, _loginBloc);
                },
                decoration: InputDecoration(
                    hintText: "Password",
                    //toggle the password visibility
                    suffixIcon: IconButton(
                      icon: Icon(state.passwordVisibility
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        _loginBloc.onTogglePassword();
                      },
                    )),
                validator: (value) {
                  if (!state.isPasswordValid) {
                    return state.passwordError;
                  }
                  return null;
                },
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(-15, 0, 0),
                child: CustomCheckBox.withTitle("Remember me"),
              ),
              Text(
                "Forgot password",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              )
            ],
          ),
          SizedBox(
            width: double.maxFinite,
            height: dimensionHelper(context).height * 0.06,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              splashColor: Colors.green,
              elevation: 5,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Navigator.pushReplacementNamed(context, "/home");
                }
              },
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 20),
              ),
              color: Colors.blueAccent,
            ),
          )
        ],
      ),
    );
  }

  void _onUserNameChanged(String value, final LoginBloc loginBloc) {
    loginBloc.onUserNameChecking(value);
  }

  void _onPasswordChanged(String value, LoginBloc loginBloc) {
    loginBloc.onPasswordChecking(value);
  }
}
