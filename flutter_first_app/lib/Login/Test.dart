import 'package:first_app/Login/LoginBloC.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

import 'LoginState.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final loginBloc = new LoginBloc();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: BlocBuilder(
          bloc: loginBloc,
          builder: (context, LoginState state) {
            return Row(
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                Checkbox(
                  value: state.passwordVisibility,
                  onChanged: (bool value) {},
                ),
                RaisedButton(
                  onPressed: () {
                    loginBloc.onTogglePassword();
                  },
                )
              ],
            );
          }),
    );
  }
}
