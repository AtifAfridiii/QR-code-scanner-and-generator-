
// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:qrcode_scanner/contact.dart';
import 'package:qrcode_scanner/gallery.dart';
import 'package:qrcode_scanner/genereat_qr.dart';
import 'package:qrcode_scanner/history.dart';
import 'package:qrcode_scanner/models/boxes/box.dart';
import 'package:qrcode_scanner/models/model.dart';

import 'package:qrcode_scanner/result.dart';
import 'package:share_plus/share_plus.dart';



class Qr_Code extends StatefulWidget {
  const Qr_Code({super.key});

  @override
  State<Qr_Code> createState() => _Qr_CodeState();
}

class _Qr_CodeState extends State<Qr_Code> {

String bar_code = '';

//Future<void> scanCode()async {
//  String bar_code_result;
 
//     try{
//  bar_code_result =  await FlutterBarcodeScanner.scanBarcode(
//                                                     '#ff6666', 
//                                                     'cancle', 
//                                                    true, 
//                                                    ScanMode.QR,
                                                   
//                                                    );
//     }on PlatformException{
//       bar_code_result = 'Failed to scan';
//     }                                             

//    bar_code = bar_code_result;

// }
 MobileScannerController cameraController = MobileScannerController(
     detectionSpeed: DetectionSpeed.normal,
    detectionTimeoutMs: 2000,
    returnImage: true,
    autoStart: true,
  );
bool isFlash = false;
bool isCamerac= false;


   bool isScanning = false;
  void closeScreen(){
    isScanning=false;
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(

        width: 201,
       backgroundColor: Colors.white,
        child: Column(
       
          children: [
           const SizedBox(height: 31,),
            const Center(child: Text('About Details ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,letterSpacing: 1.9),textAlign: TextAlign.center,)),
            const SizedBox(height: 71,),
           InkWell(onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) => const History_Screen(),));
           }, child:  const ListTile(
              leading: Icon(LineIcons.history) ,
              trailing: Text("History",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 1.9,),), 
            )),
            const SizedBox(height: 11,),
            InkWell(
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>const Bar_Code(),));
           }, child:  const ListTile(
              leading: Icon(LineIcons.qrcode) ,
              trailing: Text("Create QR Code",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold,),), 
            )),
             const SizedBox(height: 11,),
            InkWell(
              onTap: () async {
              final result = await Share.share('com.example.qrcode_scanner');
              
           }, child: const  ListTile(
              leading:  Icon(LineIcons.share) ,
              trailing:  Text("Share",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 1.9),), 
            )),
             const SizedBox(height: 11,),
            InkWell(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Contact(),));
           }, child:  const ListTile(
              leading: Icon(LineIcons.alternateMobile) ,
              trailing: Text("Contact us",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 1.9),), 
            )),
         

          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        actionsIconTheme: const IconThemeData(
          color: Colors.black,
        ),

        actions: [
        IconButton(
          onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context) => const Gallery(),)); 
             
          }, icon: const Icon(
              LineIcons.photoVideo,

            ),),

          IconButton(onPressed: (){
              setState(() {
                isCamerac=!isCamerac;
              });
              cameraController.switchCamera();
          }, icon: Icon(
              LineIcons.camera,
             
              color:isCamerac ? Colors.lightBlue.shade700: Colors.grey.shade700,
            ),),

          IconButton(onPressed: (){
              setState(() {
                isFlash=!isFlash;
              });
              cameraController.toggleTorch();
          }, icon: Icon(
              LineIcons.lightningBolt,
             
              color:isFlash ? Colors.yellow.shade700 : Colors.grey.shade700,
            ),),
        ],
        title: const Text('QR Code scanner',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21,),),),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Container(
                child: const Column(
                  children: [
                    SizedBox(height: 11,),
                    Text('Scan the QR Code in the area',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black),),
                    SizedBox(height: 3,),
                    Text('Scanning will be started automatically',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: Colors.black54),)
                  ],
                ),
                )),
                Expanded(
                  flex: 4,
                  child: Container(
                  child: Stack(
                    children: [
                      MobileScanner(
                        fit: BoxFit.cover,
                    controller: cameraController,
                    startDelay: true,
        // fit: BoxFit.contain,
        onDetect: (capture) async{
          
          final List<Barcode> barcodes = capture.barcodes;
        //  final Uint8List? image = capture.image;
          for (final barcode in barcodes) {
            if(!isScanning){
            
              String code = barcode.rawValue ?? '---';
              isScanning=true;
              Navigator.push(context, MaterialPageRoute(builder: (context) => Result(code: code, closescreen: closeScreen),)).then((value) {
                // debugPrint('Camera started');
              final data = History_Model(title:code, qr_code :barcodes.toString() );
              final boxs = Retrive.getData();
              boxs.add(data);
              });
          }
            debugPrint('Barcode found! ${barcode.rawValue}');
          }
          
        },
      ),
     QRScannerOverlay(
      
      overlayColor: Colors.white,
      borderColor: Colors.red,
      borderRadius: 19,
      borderStrokeWidth: 1.9,
     ),
            ],
                  )
                )),
                Expanded(child: Container(
                  alignment: Alignment.center,
                 child: const Text('Developed by @Atif Afridi',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.black),)
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}