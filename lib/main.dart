import 'package:chatify/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() {
  runApp(
    SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () {},
    ),
  );
}
