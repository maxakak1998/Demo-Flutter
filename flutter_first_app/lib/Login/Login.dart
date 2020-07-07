import 'dart:developer';

import 'package:first_app/Login/LoginBloC.dart';
import 'package:first_app/common/DimensionHelper.dart';
import 'package:first_app/common/TitleTopBarText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'LoginDefault.dart';
import 'LoginWithSocialNetwork.dart';

void main() => (Login);

class Login extends StatelessWidget {
  Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: Center(
                    child: TitleTopBarText(
                  hasShadow: true,
                )),
              ),
              Icon(
                Icons.help,
                color: Colors.white,
              )
            ],
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
          margin: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Log In",
                style: TextStyle(fontSize: 30.0),
              ),
              LoginDefault(),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "or login with",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: dimensionHelper(context).height * 0.2,
                child: LoginWithSocialNetwork(),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text("Create an account",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.deepOrange,
                          fontStyle: FontStyle.italic)),
                  Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: Colors.deepOrange,
                  )
                ],
              )
            ],
          ),
        ));
  }
}
