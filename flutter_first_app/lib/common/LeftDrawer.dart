import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:first_app/AppBloc/Bloc.dart';
import 'package:first_app/AppBloc/State.dart';
import 'package:first_app/Home/LeftDrawerBloc/Bloc.dart';
import 'package:first_app/Home/LeftDrawerBloc/Events.dart';
import 'package:first_app/Home/LeftDrawerBloc/State.dart';
import 'package:first_app/common/DimensionHelper.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import "MyCamera.dart";
import "package:image_picker/image_picker.dart";

class LeftDrawer extends StatefulWidget {
  final _fontSize = 18.0;
  final int activeIndex;
  final Function onChangedActiveIndexState;

  LeftDrawer({Key key, this.activeIndex, this.onChangedActiveIndexState})
      : super(key: key);
  @override
  _LeftDrawerState createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  // Search is 1, Tour is 2 , .... It uses to determine what item is clicked
  // => Changed the background color
  int activeItemIndexState;
  bool hasImage;
  final accountFolderName = "AccountInfo";
  final imageName = "/Avatar.png";
  String path;
  File file;

  BoxDecoration activeStyle = BoxDecoration(
      color: Colors.grey.withOpacity(0.2),
      borderRadius: BorderRadius.circular(5));

  @override
  void initState() {
    hasImage = false;
    // TODO: implement initState
    //if activeIndex is null, then assign 0 to activeItemIndexState
    getImageFromStorage(ImageSource.camera);
    super.initState();
  }

  getImageFromStorage(ImageSource imageSource) async {
    String tempPath = (await getExternalStorageDirectory()).path;
    path = join(tempPath, accountFolderName);
    file = File(path + imageName);

    if (hasImage != true) {
      hasImage = await Directory(path).exists();
    }

    if (hasImage) {
      setState(() {
        this.hasImage = true;
      });
      return;
    }
    setState(() {
      this.hasImage = false;
    });
  }

  Widget createAvatar(BuildContext context) {
    log("Create avatar");

    if (hasImage) {
      var bytes = file.readAsBytesSync();

      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 70,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: MemoryImage(bytes), fit: BoxFit.cover)),
          ),
          GestureDetector(
            onTap: () {
              _cameraTapped(context);
            },
            child: Icon(
              Icons.photo_camera,
              color: Colors.white,
            ),
          )
        ],
      );
    }
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 70,
          width: 60,
          color: Colors.grey,
        ),
        GestureDetector(
          onTap: () {
            _cameraTapped(context);
          },
          child: Icon(Icons.photo_camera),
        )
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    log("Dispose");
    super.dispose();
  }

  Future<String> createDialog(BuildContext context) async {
    String choice;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(
              "Open with",
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FlatButton(
                  textTheme: ButtonTextTheme.primary,
                  child: Text("Camera"),
                  onPressed: () {
                    choice = "Camera";
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textTheme: ButtonTextTheme.primary,
                  child: Text("Gallery"),
                  onPressed: () {
                    choice = "Gallery";
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        });
    return choice;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final _drawerBloc = BlocProvider.of<DrawerBloc>(context);
    final _appBloc = BlocProvider.of<AppBloc>(context);
    log("App bloc is ${_appBloc}");
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: BlocBuilder<DrawerBloc, DrawerState>(
          condition: (prevState, currentState) {
        if (currentState.getCurrentIndex != currentState.getPreviousIndex) {
          log("current index is ${currentState.getCurrentIndex}");
          log("previous index is ${currentState.getPreviousIndex}");
          return true;
        }
        return false;
      }, builder: (context, DrawerState state) {
        if (state is DrawerState) {
          return ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                height: dimensionHelper(context).height * 0.02,
              ),
              ListTile(
                leading: createAvatar(context),
                title: Text("Herbert Singeleton"),
                subtitle: Container(
                  transform: Matrix4.translationValues(-4, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 18,
                        color: Colors.grey,
                      ),
                      Text("Palo-Alto, CA")
                    ],
                  ),
                ),
              ),
              Divider(
                height: dimensionHelper(context).height * 0.05,
                thickness: 1,
              ),
              InkWell(
                  onTap: () {
                    _drawerBloc.onCategoryChange(1);
                    log("Search tapped");
                  },
                  child: Container(
                    decoration: state.getCurrentIndex == 1 ? activeStyle : null,
                    child: ListTile(
                      leading: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      title: Text(
                        "Search",
                        style: TextStyle(fontSize: widget._fontSize),
                      ),
                    ),
                  )),
              InkWell(
                onTap: () {
                  _drawerBloc.onCategoryChange(2);

                  log("Tours tapped");
                },
                child: Container(
                  decoration: state.getCurrentIndex == 2 ? activeStyle : null,
                  child: ListTile(
                    leading: Icon(
                      Icons.golf_course,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Tours",
                      style: TextStyle(fontSize: widget._fontSize),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _drawerBloc.onCategoryChange(3);

                  log("Hotels tapped");
                },
                child: Container(
                  decoration: state.getCurrentIndex == 3 ? activeStyle : null,
                  child: ListTile(
                    leading: Icon(
                      Icons.local_hotel,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Hotels",
                      style: TextStyle(fontSize: widget._fontSize),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _drawerBloc.onCategoryChange(4);
                },
                child: Container(
                  decoration: state.getCurrentIndex == 4 ? activeStyle : null,
                  child: ListTile(
                    leading: Icon(
                      Icons.favorite,
                      color: Colors.black,
                    ),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.ideographic,
                      children: <Widget>[
                        Text(
                          "Favourites",
                          style: TextStyle(fontSize: widget._fontSize),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        BlocBuilder<AppBloc, AppState>(
                          builder: (context, AppState appState) {
                            if (appState is GlobalState) {
                              return Text(
                                appState.getFavoriteCount.toString(),
                                style: TextStyle(
                                  fontSize: widget._fontSize - 4,
                                  color: Colors.grey,
                                ),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                height: dimensionHelper(context).height * 0.05,
              ),
              InkWell(
                  onTap: () {
                    _drawerBloc.onCategoryChange(5);
                  },
                  child: Container(
                    decoration: state.getCurrentIndex == 5 ? activeStyle : null,
                    child: ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Settings",
                          style: TextStyle(fontSize: widget._fontSize),
                        )),
                  )),
              InkWell(
                  onTap: () {
                    _drawerBloc.onCategoryChange(6);
                  },
                  child: Container(
                    decoration: state.getCurrentIndex == 6 ? activeStyle : null,
                    child: ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Help",
                          style: TextStyle(fontSize: widget._fontSize),
                        )),
                  )),
              Divider(
                height: dimensionHelper(context).height * 0.05,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: dimensionHelper(context).height * 0.07,
                  ),
                  Text("Contact me via kiet.pa@gmail.com"),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Version 1.0"),
                ],
              )
            ],
          );
        }
        return SizedBox();
      }),
    );
  }

  void _cameraTapped(BuildContext context) async {
    log("Camera tapped");
    String result = await createDialog(context);
    log("Result is ${result}");
    if (result == "Camera") {
      await Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyCamera(path: path)))
          .then((response) {
        log("Result from Camera is ${response}");
        if (response) {
          log("camera backed");
          getImageFromStorage(ImageSource.camera);
        }
      });
    } else if (result == "Gallery") {
      File file = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        if (hasImage) {
          //There is an image in a storage
          //delete it and re-create;
          await Directory(path).delete(recursive: true);
          await Directory(path).create();
        } else {
          //create a new folder
          await Directory(path).create();
        }
        await file.copy(path + imageName);
        getImageFromStorage(ImageSource.gallery);
        //open gallery
      }
    }
  }
}
