import 'dart:developer';

import 'package:first_app/Countries/CountriesBloc/Bloc.dart';
import 'package:first_app/Countries/CountriesBloc/Repo.dart';
import 'package:first_app/common/Country.dart';
import 'package:first_app/common/DimensionHelper.dart';
import 'package:first_app/common/FavoriteIcon.dart';
import 'package:first_app/common/ItemCountry.dart';
import 'package:first_app/common/Loading.dart';
import 'package:first_app/common/ProfileIcon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'CountriesBloc/State.dart';

class Countries extends StatefulWidget {
  Countries({Key key}) : super(key: key);
  final String title = "Places";
  final List<String> regions = [
    "Asian",
    "Europ",
    "Africa",
    "South America",
    "North America",
    "Central Africa",
    "South Asia",
    " Middle East",
  ];
  @override
  _CountriesState createState() => _CountriesState();
}

class _CountriesState extends State<Countries>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  CountryBLoc _countryBloc;
  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  void initState() {
    // TODO: implement initState
    _tabController =
        new TabController(vsync: this, length: widget.regions.length);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        log("change ${widget.regions[_tabController.previousIndex]} and ${widget.regions[_tabController.index]} ");
        _countryBloc
            .onStartFetchingCountries(widget.regions[_tabController.index]);
      }
    });
    _countryBloc = context.bloc<CountryBLoc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: widget.regions.length,
      child: Scaffold(
        appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.title,
                )
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FavoriteIcon(),
                  SizedBox(
                    width: 8,
                  ),
                  ProfileIcon(),
                  SizedBox(
                    width: 12,
                  )
                ],
              )
            ],
            bottom: TabBar(
                controller: _tabController,
                unselectedLabelColor: Colors.white,
                isScrollable: true,
                indicatorColor: Colors.limeAccent,
                labelColor: Colors.black,
                tabs: widget.regions
                    .map<Widget>((title) => Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            title,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ))
                    .toList())),
        body: BlocBuilder<CountryBLoc, CountriesState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return LoadingSign();
            } else if (state is LoadedState) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: state.getCountries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemCountry(
                        containerHeight: dimensionHelper(context).height,
                        country: state.getCountries[index]);
                  });
            }
          },
        ),
      ),
    );
  }
}
