import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:survey/login.dart';
import 'package:survey/questionnaire/survey_dass.dart';


void main() async {
  // Inicializar o banco de dados - firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();



  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: dass()));
}
