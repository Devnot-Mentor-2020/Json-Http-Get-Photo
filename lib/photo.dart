import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:http_get_photos/models/photo_model.dart';

class PhotoModel extends StatefulWidget {
  @override
  _PhotoModelState createState() => _PhotoModelState();
}

class _PhotoModelState extends State<PhotoModel>{

  String url="https://jsonplaceholder.typicode.com/photos";
  
  Future<List<Photo>> _getPhoto() async {
  var response = await http.get(url);  
  if (HttpStatus.ok==200){
    return (json.decode(response.body)as List)
    .map((e) => Photo.fromJsonMap(e))
    .toList();
  }
  else {
    throw Exception("Bağlantı Başarısız Hata Kodu: ${response.statusCode}");
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Json Api "),),
      body: FutureBuilder(
        future: _getPhoto(),
        builder: builder),
      
    );
  }

  Widget builder(BuildContext context, AsyncSnapshot<List<Photo>> snapshot) {
        
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data[index].title),
                    leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data[index].url)),               
                    ),
                );
              }
            );
        }
        }
        


        /*if(snapshot.hasData){
          return  ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data[index].title),
                    leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data[index].url)),               
                    ),
                );
              },
          );
         }  
         else {
           return Center(child: CircularProgressIndicator(),);
         }*/
   }
 
 
 