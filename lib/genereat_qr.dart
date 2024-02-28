
// ignore_for_file: camel_case_types, empty_statements, deprecated_member_use

import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_scanner/models/boxes/box.dart';
import 'package:qrcode_scanner/models/model.dart';
import 'package:share_plus/share_plus.dart';


class Bar_Code extends StatefulWidget {
  const Bar_Code({super.key});



  @override
  State<Bar_Code> createState() => _Bar_CodeState();
}

TextEditingController textController = TextEditingController();
String ? qrData;

class _Bar_CodeState extends State<Bar_Code> {
 final GlobalKey _qrKey = GlobalKey();
  
  @override
  Widget build(BuildContext context) {

    Future<void> toastMessage(String message) async {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 13.0,
      );
    }

  Future<void> shareQRCode() async {
    if (qrData != null) {
      try {
        RenderRepaintBoundary boundary = _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
       final ui.Image image = await boundary.toImage();
        ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();

        // Save image to a temporary file and share
        // You can also share directly without saving to file, depending on your use case
        // Here, I'm saving it to a temporary file and sharing the file
        // Note: You need to have permission to write to external storage if saving to file
        // For Android, add WRITE_EXTERNAL_STORAGE permission in AndroidManifest.xml
        // For iOS, add NSPhotoLibraryAddUsageDescription permission in Info.plist
        // Adjust permissions according to your needs and platform

        // Save image to a temporary file
        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/qr_code.png').create();
        await file.writeAsBytes(pngBytes);

        // Share the temporary file
        await Share.shareFiles([file.path], text: 'Check out my QR Code!');;
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        toastMessage('Failed to share QR code');
      }
    }
  }


    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Bar Code',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
        leading: InkWell(
          onTap: (){
          textController.clear();
           Navigator.pop(context);
           qrData=null;
          
          },
          child: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(qrData!=null) const Qr_View(),
               
            const SizedBox(height: 3,),
            if(qrData!=null) Align(
              alignment: Alignment.bottomRight,
              
               child: Padding(
                padding: const EdgeInsets.only(right: 61),
                 child: IconButton(
                  onPressed: ()async{
                    shareQRCode();

                 }, icon: const Icon(Icons.share,size: 31,)),
               ),
             ),
             const SizedBox(height: 11,),
              Padding(
               padding: const EdgeInsets.symmetric(horizontal: 11),
               child: TextField(
                controller: textController,
         
                 
                decoration:const InputDecoration(
                  
                    hintText: 'Enter anything to create a QR Code ',
                    focusColor: Colors.green,
                    prefixIcon:Icon(LineIcons.qrcode),
                    
                ),
               ),
             ),
             const SizedBox(height: 31,),
             InkWell(
              onTap: (){
              if (textController.text.isEmpty) {
                toastMessage('Please Enter something in order to create QR code');
              }else{
                  setState(() {
                  qrData=textController.text.toString();
                });
               toastMessage('QR code created ');
                final data = Generate_Model(title:qrData, qr_code :textController.text );
              final boxs = Retrive.getData2();
              boxs.add(data);
              }
               
             
              },
               child: Container(
                height: 51,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(),
                ),
                child: const Center(child: Text('Create',style: TextStyle(color: Colors.white),),),
               ),
             ),
            ],
          ),
        ),
      ),
    );
  }
}


class Qr_View extends StatelessWidget {
  const Qr_View({super.key});
 
  @override
  Widget build(BuildContext context) {
    return QrImageView(
                data:qrData!,
               gapless: false,
               size: 201,
               padding:const EdgeInsets.symmetric(vertical: 11),
               version: QrVersions.auto,
               
             );
  }
}