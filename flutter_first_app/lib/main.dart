import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:first_app/AppBloc/Bloc.dart';
import 'package:first_app/Countries/CountriesBloc/Bloc.dart';
import 'package:first_app/Home/HomeBloc/Repo.dart' as HomeRepo;
import 'package:first_app/Login/LoginBloC.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "Countries/CountriesBloc/Repo.dart" as CountryRepo;
import 'Countries/Countries.dart';
import 'Home/Home.dart';
import 'Home/HomeBloc/Bloc.dart';
import 'Login/Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("Main context: " + context.toString());
    FocusScope.of(context).unfocus();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocProvider(
        create: (context) => AppBloc(),
        child: MaterialApp(
          title: "Travel Apps",
          initialRoute: "/home",
          routes: {
            "/": (context) {
              return BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(),
                child: Login(),
              );
            },
            "/home": (context) {
              return BlocProvider<HomeBloc>(
                create: (context) =>
                    HomeBloc(new HomeRepo.Repo())..onStartFetching(),
                child: Home(),
              );
            },
            "/countries": (context) {
              return BlocProvider<CountryBLoc>(
                create: (context) => CountryBLoc(CountryRepo.Repo())
                  ..onStartFetchingCountries("Asian"),
                child: Countries(),
              );
            }
          },
        ),
      ),
    );
  }
}

class PushMessagingExample extends StatefulWidget {
  @override
  _PushMessagingExampleState createState() => _PushMessagingExampleState();
}

class _PushMessagingExampleState extends State<PushMessagingExample> {
  String _homeScreenText = "Waiting for token...";
  String _messageText = "Waiting for message...";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        log("onMessage: ${message}");
      },
      onLaunch: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        log("onLaunch: ${message}");
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: ${message['data']}";
        });
        log("onResume: ${message['data']['id']}");
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      print(_homeScreenText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Messaging Demo'),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Text(_homeScreenText),
          ),
          Row(children: <Widget>[
            Expanded(
              child: Text(_messageText),
            ),
          ])
        ],
      ),
    );
  }
}
