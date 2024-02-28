// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrcode_scanner/code.dart';
import 'package:hive/hive.dart';
import 'package:qrcode_scanner/models/model.dart';
void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(HistoryModelAdapter());
  Hive.registerAdapter(GenerateModelAdapter());
  await Hive.openBox<History_Model>('History');
  await Hive.openBox<Generate_Model>('History2');
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {

 
   const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
          
        ),

       ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Qr_Code(),
    );
  }
}

