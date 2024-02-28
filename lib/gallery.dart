
// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode_scanner/result.dart';
import 'package:scan/scan.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {

  File? _selectedimage;

  Future Image_Picker()async{

  final image_returned = await ImagePicker().pickImage(source: ImageSource.gallery);
   if(image_returned==null)return;
  if (kDebugMode) {
    print( "Image Path Cached : ${image_returned.path}");
  }
      String? scannedCode = await Scan.parse(image_returned.path);
    
  if(scannedCode!=null){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Result(code: scannedCode, closescreen: closeScreen),));
  }
setState(() {
  _selectedimage=File(image_returned.path);
});

   }
   bool isScanning = false;
  void closeScreen(){
    isScanning=false;
  }



  
  MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    detectionTimeoutMs: 2000,
    returnImage: true,

    // autoStart: true,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Gallery',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                _selectedimage!=null ? Image.file(_selectedimage!) : Container(
                  height: 191,
                  width: 191,
                  decoration: BoxDecoration(
                    border: Border.all()
                    
                  ),
                  child:  const Center(child:Icon(Icons.photo,size: 51,)),
                ),
                const SizedBox(height: 31,),

                InkWell(
                  onTap: (){
                  Image_Picker();
                  },
                  child: Container(
                    height: 51,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(11),
                  
                    ),
                    child: const Center(child: Text('Scan Gallery',style: TextStyle(color: Colors.white),),),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
