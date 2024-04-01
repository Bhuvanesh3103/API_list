import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled6/model.dart';
class work extends StatefulWidget {
  const work({super.key});

  @override
  State<work> createState() => _workState();
}

class _workState extends State<work> {


  Future<List<Want>> fetch()async{
    var res = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data=jsonDecode(res.body);
    return (data as List).map((obj) => Want.fromJson(obj)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: fetch(),
            builder: (BuildContext context, snapshot){
              if(snapshot.hasData){
                List<Want> _list=snapshot.data!;
                return Container(
                  height: 800,
                  child: ListView.builder(
                    itemCount: _list.length,
                      itemBuilder: (context,int index){
                    return Card(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(_list[index].id.toString()),
                              Text(_list[index].username.toString()),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(_list[index].email.toString()),
                              Text(_list[index].website.toString()),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
                );
              }else if(snapshot.hasError){
                return Text('${snapshot.error}');
              }return CircularProgressIndicator();
            }),
      ),
    );
  }
}
