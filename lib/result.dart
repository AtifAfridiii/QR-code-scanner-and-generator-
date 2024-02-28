// ignore_for_file: must_be_immutable, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Result extends StatelessWidget {

 
Future<void>Toastmessage()async{
   Fluttertoast.showToast(
        msg: "Copied",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 13.0
        
    );
  }
  String code ;
  final Function() closescreen;

  
   Result({super.key,required this.code , required this.closescreen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
           closescreen();
           Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back)),
        title: const Text('QR Scanner',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,letterSpacing: 1),),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImageView(
             data: code,
            version: QrVersions.auto,
            size: 151,
            gapless: false,
          ),
              const Text('Scanned Result',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black,letterSpacing: 1),),
              const SizedBox(height: 11,),
              Text(code,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black,letterSpacing: 1),),
             const SizedBox(height: 11,),
              SizedBox(
                width: MediaQuery.of(context).size.width-100,
              height: 45,
              child:ElevatedButton(
                style: ElevatedButton .styleFrom(
                  backgroundColor: Colors.deepPurple
                ),
                onPressed: (){
                   Clipboard.setData(ClipboardData(text: code),);
                     Toastmessage();
                  
               }, child: const Text('copy',style: TextStyle(color: Colors.white,letterSpacing: 1),) )
           ,),
                           
            ],
          ),
        ),
      ),
    );
  }
}