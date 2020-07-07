import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:first_app/common/LeftDrawer.dart';
import "package:flutter/material.dart";
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'EnumTypes.dart';

class MyCamera extends StatefulWidget {
  final String path;

  const MyCamera({Key key, this.path}) : super(key: key);
  @override
  _MyCameraState createState() => _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {
  CameraController cameraController;
  Future<void> initCameraController;
  CameraDescription camera;
  List<CameraDescription> cameraList;
  bool isCamReady;

  void onChangedCamera(CameraType cameraType) {
    log("Camera type " + cameraType.toString());
    isCamReady = false;

    int _type;
    if (cameraType == CameraType.FrontFacing) {
      _type = 1;
    } else {
      _type = 0;
    }
    initCam(_type);
  }

  @override
  void initState() {
    // TODO: implement initState
    isCamReady = false;

    super.initState();

    WidgetsFlutterBinding.ensureInitialized();
    availableCameras().then((cameras) {
      this.cameraList = cameras;
      initCam(0);
    });
  }

  Future<void> initCam(int cameraType) async {
    WidgetsFlutterBinding.ensureInitialized();

    log("init cam");
    camera = cameraList[cameraType]; // default is back camera
    cameraController = CameraController(camera, ResolutionPreset.medium);

    if (!mounted) return;

    setState(() {
      isCamReady = true;
      log("Set state to true! isCamReady = ${isCamReady}");
    });

    initCameraController = cameraController.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: FutureBuilder<void>(
        future: initCameraController?.catchError((e) {
          log(" Error: ${e.code} \n Error message : ${e.description}");
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            log("Camera done ! ${snapshot.connectionState}");
            return CameraPreview(cameraController);
          } else {
            // Otherwise, display a loading indicator.
            log("Camera is loading! ${snapshot.connectionState}");
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            heroTag: null,
            child: Icon(
              Icons.camera_alt,
            ),
            onPressed: () async {
              if (isCamReady) {
                try {
                  await initCameraController;
                  // final tempPath = (await getExternalStorageDirectory()).path;
                  // final accountFolderName = "AccountInfo";
                  final imageName = "/Avatar.png";
                  // final path = join(tempPath, accountFolderName);
                  final hasImage = await Directory(widget.path).exists();
                  if (hasImage) {
                    //There is an image in a storage
                    //delete it and re-create;
                    await Directory(widget.path).delete(recursive: true);
                    await Directory(widget.path).create();
                  } else {
                    //create a new folder
                    await Directory(widget.path).create();
                  }
                  StringBuffer buffer = StringBuffer();
                  buffer.write(widget.path);
                  buffer.write(imageName);
                  await cameraController.takePicture(buffer.toString());
                  Navigator.pop(context, true);
                } catch (e) {
                  log(e.toString());
                  Navigator.pop(context, false);
                }
              }
            },
          ),
          SizedBox(width: 8),
          FloatingActionButton(
            heroTag: null,
            child: Icon(Icons.swap_horiz),
            onPressed: () {
              if (isCamReady) {
                CameraLensDirection cameraType =
                    cameraController.description.lensDirection;
                if (cameraType == CameraLensDirection.front) {
                  onChangedCamera(CameraType.RearFacing);
                } else if (cameraType == CameraLensDirection.back) {
                  onChangedCamera(CameraType.FrontFacing);
                }
              }
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
