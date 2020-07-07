import 'dart:developer';

import 'package:first_app/common/DimensionHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class LoginWithSocialNetwork extends StatelessWidget {
  final FACEBOOK_TYPE = 0;
  final TWITER_TYPE = 1;

  Widget createLogInRaisedButton(BuildContext context,
      {VoidCallback onPressed,
      label = "",
      @required int typeIcon,
      Color backgroundButton = Colors.white,
      Color labelColor = Colors.white}) {
    return SizedBox(
      height: dimensionHelper(context).height * 0.06,
      width: double.maxFinite,
      child: RaisedButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: backgroundButton,
          elevation: 5,
          onPressed: () {
            onPressed();
          },
          icon: getIcon(typeIcon),
          label: Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(fontSize: 18.0, color: labelColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: 30,
              )
            ],
          ))),
    );
  }

  Function getIcon = (int type) {
    switch (type) {
      case 0:
        return Image.asset('assets/facebook_icon.png',
            fit: BoxFit.contain, width: 30.0, height: 30.0);
        break;
      case 1:
        return Image.asset('assets/tw.png',
            fit: BoxFit.contain, width: 30.0, height: 30.0);
        break;
    }
    return null;
  };

  @override
  Widget build(BuildContext context) {
    log("LoginWithSocialNetwork context: " + context.toString());

    // TODO: implement build
    return Transform.translate(
      offset: Offset(0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          createLogInRaisedButton(context,
              onPressed: () => {},
              label: "Facebook",
              typeIcon: FACEBOOK_TYPE,
              backgroundButton: Colors.blueAccent,
              labelColor: Colors.black),
          SizedBox(height: 10.0),
          createLogInRaisedButton(context,
              onPressed: () => {},
              label: "Twitter",
              typeIcon: TWITER_TYPE,
              backgroundButton: Colors.lightBlueAccent,
              labelColor: Colors.black)
        ],
      ),
    );
  }
}
