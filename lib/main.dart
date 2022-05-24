import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futurebuilder/Github_user.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'futer Builder',

      home: const HomePage(),
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<Github> _CallAPi()async{
    var url=Uri.parse("https://api.github.com/users/fayazashraf98");
    var response=await http.get(url);
    return Github.fromJson(jsonDecode(response.body));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text("Futer Builder"),),
      body: FutureBuilder<Github>(
        future: _CallAPi(),
        builder: (childContext,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasError){
            return Center(child: Text("Connection Error"),);
          }
          else{
            return Column(

              children: [
                Text(snapshot.data?.id.toString() ?? "id"),
                ListTile(
                  title: Text(snapshot.data?.name ??"error"),
                  subtitle: Text(snapshot.data?.location??"error"),
                  leading: Image.network(snapshot.data?.avatarUrl??"error"),
                ),
              ],
            );
          }

        },
      ),

    );
  }
}


