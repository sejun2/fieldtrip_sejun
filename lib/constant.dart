import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const defaultPadding = EdgeInsets.all(8.0);
const statementTextStyleBold = TextStyle(fontSize: 21, color: Colors.white, height: 1.5, fontWeight: FontWeight.bold);
const statementTextStyleRedBold = TextStyle(fontSize: 21, color: Colors.red, height: 1.5, fontWeight: FontWeight.bold);
const statementTextStyle =
    TextStyle(fontSize: 21, color: Colors.white, height: 1.5);
const nameTextStyle =
TextStyle(fontSize: 25, color: Colors.white, height: 1.5);
const questionTextStyle =
    TextStyle(fontSize: 14, color: Colors.black, height: 1.2);
const hintTextStyle = TextStyle(fontSize: 14, color: Colors.red, height: 1.2);
const chapterTextStyle = TextStyle(color: Colors.white, fontSize: 35);

typedef OnAnimatedTextFinished = Function();
