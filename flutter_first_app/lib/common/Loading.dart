import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DimensionHelper.dart';

class LoadingSign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.5))),
      height: dimensionHelper(context).height,
      width: double.infinity,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
