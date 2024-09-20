

import 'dart:ui';
import 'package:flutter/material.dart';

TextStyle newText (textColor,double size){
  return TextStyle(
    fontWeight: FontWeight.w400,
    color: textColor,
    fontSize: size
  );
}

BoxDecoration newDecoration(setBorder){
  return BoxDecoration(
    gradient: LinearGradient(
        colors: [Colors.blue.shade800,Colors.cyan],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(0, 2),
        spreadRadius: 0,
        blurRadius: 2
      )
    ],
    borderRadius: setBorder
  );
}

InputDecoration newInputDecoration (label,hintText){
  return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue)
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue)
    ),
    labelText: label,
    labelStyle: TextStyle(color: Colors.blue),
    hintText: hintText
  );
}