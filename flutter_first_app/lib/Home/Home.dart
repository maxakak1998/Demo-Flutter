import 'package:first_app/AppBloc/Bloc.dart';
import 'package:first_app/AppBloc/State.dart';
import 'package:first_app/Home/HomeBloc/Bloc.dart';
import 'package:first_app/Home/HomeBloc/Repo.dart';
import 'package:first_app/common/Country.dart';
import 'package:first_app/common/CustomListView.dart';
import 'package:first_app/common/DimensionHelper.dart';
import 'package:first_app/common/LeftDrawer.dart';
import 'package:first_app/common/FavoriteIcon.dart';
import 'package:first_app/common/Loading.dart';
import 'package:first_app/common/ProfileIcon.dart';
import 'package:first_app/common/SearchBar.dart';
import 'package:first_app/common/TitleTopBarText.dart';
import 'package:first_app/common/Tour.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'HomeBloc/State.dart';
import 'LeftDrawerBloc/Bloc.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  final String getProductByCategoryUrl =
      "https://jsonplaceholder.typicode.com/users";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  bool isLoading;

  int activeIndex;
  @override
  void initState() {
    // TODO: implement initState
    isLoading = true;

    WidgetsBinding.instance.addObserver(this);
    super.initState();

    // fetchData(widget.getProductByCategoryUrl);
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    log("Deactive ");

    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    log("Resumed");

    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      log("Resumed");
    } else if (state == AppLifecycleState.resumed) {
      log("Resumed");
      context.bloc<HomeBloc>().onStartFetching();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    log("Dispose ");
    super.dispose();
  }

  @override
  void didUpdateWidget(Home oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    log("didUpdateWidget ");
  }

  void onChangedActiveIndexState(int newActiveIndex) {
    if (activeIndex == newActiveIndex) return;
    setState(() {
      activeIndex = newActiveIndex;
    });
    log("newActiveIndex in Home is ${activeIndex}");
  }

  @override
  Widget build(BuildContext context) {
    log("Home context: " + context.toString());
    // TODO: implement build

    return Scaffold(
      drawer: Drawer(
        child: BlocProvider<DrawerBloc>(
          create: (context) => DrawerBloc(),
          child: LeftDrawer(),
        ),
      ),
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(child: SearchBar()),
            BlocBuilder<AppBloc, AppState>(
              condition: (prevState, currentState) {
                return true;
              },
              builder: (context, AppState state) {
                if (state is GlobalState) {
                  return FavoriteIcon(
                    iconValue: state.getFavoriteCount,
                  );
                }
              },
            ),
            SizedBox(
              width: 8,
            ),
            ProfileIcon(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TitleTopBarText(
                title: "Popular Tours",
                fontSize: 26.0,
                fontWeight: FontWeight.w400,
                colorText: Colors.black,
              ),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, HomeState state) {
                if (state is LoadingState) {
                  return LoadingSign();
                } else if (state is LoadedState) {
                  context.bloc<AppBloc>().onFavoriteChange(state.tours);
                  return CustomListView(
                    itemType: ItemType.PopularTourType,
                    height: dimensionHelper(context).height * 0.4,
                    axis: Axis.horizontal,
                    dataList: state.tours,
                  );
                } else if (state is ErrorState) {
                  return Text("Error : ${state.message}");
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TitleTopBarText(
                    title: "Countries",
                    fontSize: 26.0,
                    fontWeight: FontWeight.w400,
                    colorText: Colors.black,
                  ),
                  GestureDetector(
                      onTap: () {
                        //navigate to the countries screen
                        Navigator.pushNamed(context, "/countries");
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "See more",
                            style: TextStyle(color: Colors.orange),
                          ),
                          Text(
                            ">",
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                ],
              ),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, HomeState state) {
                if (state is LoadingState) {
                  return LoadingSign();
                } else if (state is LoadedState) {
                  return CustomListView(
                    itemType: ItemType.CountryType,
                    dataList: state.countries,
                    height: dimensionHelper(context).height * 0.35,
                    axis: Axis.horizontal,
                  );
                } else if (state is ErrorState) {
                  return Text("Error : ${state.message}");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
