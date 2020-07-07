//import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';
//
//
//class CustomTextFormField extends StatefulWidget{
//  final  _hint="a";
//
//  const CustomTextFormField({Key key,this._hint}):super(key:key);
//
//
//  @override
//  _CustomTextFormFieldState createState() {
//    // TODO: implement createState
//    return _CustomTextFormFieldState();
//  }
//
//}
//
//class _CustomTextFormFieldState extends State<CustomTextFormField> {
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return TextFormField(
//      decoration: const InputDecoration(
//        hintText:  widget._hint
//      ),
//      validator: (value){
//        if(value.isEmpty){
//          return "Enter your use name !";
//        }
//        return null;
//      },
//    )
//  }
//}
//
