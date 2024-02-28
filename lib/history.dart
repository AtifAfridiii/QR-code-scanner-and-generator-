
// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_scanner/models/model.dart';

import 'models/boxes/box.dart';

class History_Screen extends StatefulWidget {
  const History_Screen({super.key});

  @override
  State<History_Screen> createState() => _History_ScreenState();
}

class _History_ScreenState extends State<History_Screen> with SingleTickerProviderStateMixin {

  TabController? _tabController;

@override
  void initState() {
    _tabController =TabController(length: 2, vsync: this);
    super.initState();
  }

@override
  void dispose() {
    _tabController!.dispose();
    
    super.dispose();
  }

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


  void Delete(History_Model history_model){
    history_model.delete();
  }
  
  void Delete2(Generate_Model generate_model){
    generate_model.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History Screen",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black),),

      ),
      body: Column(
        children: [
      Padding(
        padding:const EdgeInsets.symmetric(horizontal: 11,vertical: 11),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
          height: 45,
          decoration: BoxDecoration(
                   color: const Color(0xff393939),
                   borderRadius: BorderRadius.circular(21),
                 //  border: Border.all(),
          ),
          child:TabBar(
            controller: _tabController,
            unselectedLabelColor: Colors.white,
            dividerColor:const Color(0xff393939),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(21),
              color: Colors.deepOrange,

            ),
           
            tabs: const [
               Text('Scanned History',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: Colors.white),),
               Text('Generate History',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: Colors.white)),
            ]),

        ),
         ),
         Expanded(
          child:TabBarView(
            controller: _tabController,
            children: [
           ValueListenableBuilder<Box<History_Model>>(
            valueListenable: Retrive.getData().listenable(), 
            builder: (context, box, _) {
              final data = box.values.toList().cast<History_Model>();
            return SafeArea(
            
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title:  Text(data[index].title!.toString(),style: const TextStyle(fontWeight: FontWeight.bold,),),
                      subtitle: QrImageView(
                  data:data[index].title!.toString(),
                 gapless: false,
                 size: 111,
                 padding:const EdgeInsets.symmetric(vertical: 11),
                 version: QrVersions.auto,
               ),
               trailing: PopupMenuButton<dynamic>(
                position:PopupMenuPosition.over ,
                icon: const Icon(Icons.more_vert),
                itemBuilder:(context) {
                  
                  return [
                    
                    PopupMenuItem(
                    child:ListTile(
                     
                      onTap: () {
                       Clipboard.setData(ClipboardData(text:data[index].title.toString() ),);
                     Toastmessage();
                        Navigator.pop(context);
                      },
                      leading: const Icon(Icons.copy,),
                      title: const Text('Copy',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                    ) ),

                    PopupMenuItem(
                    child:ListTile(
                     
                      onTap: () {
                        Delete(data[index]);
                        Navigator.pop(context);
                      },
                      leading: const Icon(Icons.delete,),
                      title: const Text('Delete',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                    ) ),

                    
                  ];
                }, ),
                    
                    ),
                  );
                },),
            );
 
            },)  ,            
            
            // seperate list 

            ValueListenableBuilder<Box<Generate_Model>>(
              valueListenable:  Retrive.getData2().listenable(),
              builder: (context, box, _) {
                 final data = box.values.toList().cast<Generate_Model>();
                return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title:  Text(data[index].title!.toString(),style: const TextStyle(fontWeight: FontWeight.bold,)),
                    subtitle:QrImageView(
                  data:data[index].title!.toString(),
                 gapless: false,
                 size: 111,
                 padding:const EdgeInsets.symmetric(vertical: 11),
                 version: QrVersions.auto,
               ),
               trailing: PopupMenuButton<dynamic>(
                position:PopupMenuPosition.over ,
                icon: const Icon(Icons.more_vert),
                itemBuilder:(context) {
                  
                  return [
 
                   PopupMenuItem(
                    child:ListTile(
                     
                      onTap: () {
                       Clipboard.setData(ClipboardData(text:data[index].title.toString() ),);
                     Toastmessage();
                        Navigator.pop(context);
                      },
                      leading: const Icon(Icons.copy,),
                      title: const Text('Copy',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                    ) ),

                    PopupMenuItem(
                    child:ListTile(
                     
                      onTap: () {
                        Delete2(data[index]);
                        Navigator.pop(context);
                      },
                      leading: const Icon(Icons.delete,),
                      title: const Text('Delete',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                    ) ),
                  ];
                }, ),
                  ),
                );
              },);
 
              },
             )
          ])
         ),
        ],
      ),
    );
  }
}