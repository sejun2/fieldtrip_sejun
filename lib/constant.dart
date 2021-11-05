import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const defaultPadding = EdgeInsets.all(8.0);
const statementTextStyle = TextStyle(
    fontSize: 25,
    color: Colors.white,
    height: 1.5
);
const questionTextStyle = TextStyle(
    fontSize: 14,
    color: Colors.black,
    height: 1.2
);
const hintTextStyle = TextStyle(
  fontSize: 14,
  color: Colors.red,
  height: 1.2
);

typedef OnAnimatedTextFinished = Function();
