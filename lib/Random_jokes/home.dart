import 'dart:convert';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState()=> _HomePageState();
}

class _HomePageState extends State<HomePage>{

  Future<Map<String,dynamic>> fetchDataFromApi() async{
    final response = await http
        .get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));
        if(response.statusCode == 200) {
          final data = json.decode(response.body);
          return data;
        }else{
          throw Exception('Failed to fetch a random joke');
        }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Joke'),
        centerTitle: true,
      ),
      
      body: FutureBuilder(
          future: fetchDataFromApi(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasData){
              final joke = snapshot.data;
              final setup = joke!['setup'];
              final punchLine = joke['punchline'];

              return Center(
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    FlipCard(
                      front: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              const Text('Joke',
                                    style: TextStyle(fontSize: 20),),
                              const  SizedBox(height: 15),
                              Text('$setup',style: TextStyle(fontSize: 17),),
                            ],
                          ),
                        ),
                      ),
                      back: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              const Text('Punchline',
                                style: TextStyle(fontSize: 20),),
                              const  SizedBox(height: 15),
                              Text('$punchLine',style: TextStyle(fontSize: 17),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: (){
                          setState(() {
                            fetchDataFromApi();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                        ),
                      child: const Text('Generate a random Joke')),
                  ],
                ),
              );
            }else{
              return const CircularProgressIndicator();
            }
          },
      )
    );
  }
}

