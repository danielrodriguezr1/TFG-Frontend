import 'package:flutter/material.dart';

// Singleton class that contains a bunch of useful constants for rapid and responsive developement
class Constants {
  //Constructor
  static final Constants _singleton = Constants._internal();

  factory Constants() {
    return _singleton;
  }
  //Neded for the singleton
  Constants._internal();
}
