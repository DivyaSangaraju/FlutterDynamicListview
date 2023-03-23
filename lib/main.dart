import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:listdynamic/User.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 late Future<List<User>> usersFuture;
 // Future<List<User>> usersFuture;

 @override
 void initState(){
   super.initState();

   usersFuture = getUsers(context);
 }

  static Future<List<User>> getUsers(BuildContext context) async{

   final assetBundle = DefaultAssetBundle.of(context);
   final data = await assetBundle.loadString('assets/users.json');

   // const url = 'https://jsonplaceholder.typicode.com/users';
    //final response = await http.get(Uri.parse(url));
   // final response = await http.get(Uri.parse(url));
    //final body = json.decode(response.body);
    final body = json.decode(data);
    return body.map<User>(User.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        title: const  Text('ListView with JSON'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
            future: usersFuture,
          builder:(context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
               return const CircularProgressIndicator();
              }else if(snapshot.hasError){
                return Text('${snapshot.error}');
              }
              else if(snapshot.hasData){
                final users = snapshot.data!;
                return buildUsers(users);
              }else{
                return const Text('No User data');
              }
          },
        ),
      ),
    );
  }
  Widget buildUsers(List<User> users)=>ListView.builder(
    itemCount: users.length,
    itemBuilder: (context,index){
      final user=users[index];

      return Card(
        child: ListTile(
          title: Text(user.username),
          subtitle: Text(user.email),
        ),
      );
    },
  );

}
