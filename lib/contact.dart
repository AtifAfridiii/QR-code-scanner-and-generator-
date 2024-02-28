import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Contact Me ! ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),),
      ),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Expanded(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
           return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: ListTile(
                  leading: Icon(LineIcons.whatSApp),
                  title: Text('+92 3370399050',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.email_outlined),
                  title: Text('atifafridi378@gmail.com',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(LineIcons.instagram),
                  title: Text('atif.x.afridi',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                ),
              ),
                     
                     
            ],
           );
         },))
        ],
      ),
    );
  }
}