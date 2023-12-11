// ignore_for_file: unused_import

import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamestellar/home_page.dart';
import 'package:gamestellar/firebase_options.dart';
import 'package:gamestellar/login.dart';
import 'package:gamestellar/register.dart';
import 'noticias.dart';
import 'package:dio/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Directionality(
      textDirection: TextDirection.ltr,
      child: LoginPage(),
    ),
  ));
}