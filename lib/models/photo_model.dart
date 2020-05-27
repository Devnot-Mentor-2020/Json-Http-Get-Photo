import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:http_get_photos/photo.dart';

class PhotoModel extends StatefulWidget {
  @override
  _PhotoModelState createState() => _PhotoModelState();
}

class _PhotoModelState extends State<PhotoModel>{
  Future<List<Photo>> _getPhoto() async {
  var response = await http.get("https://jsonplaceholder.typicode.com/photos");  
  if (response.statusCode==200){
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
        builder: 
        (BuildContext context, AsyncSnapshot<List<Photo>> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(snapshot.data[index].title),
                  leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data[index].url)),
                  
                  );
                
              });
           }

           else {
             return Center(child: CircularProgressIndicator(),);
           }
        }),
      
    );
  }
}