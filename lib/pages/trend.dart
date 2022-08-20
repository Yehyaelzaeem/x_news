import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:x_news/pages/home.dart';
import 'package:http/http.dart' as http;
import 'package:x_news/pages/posts.dart';

import '../Models/news.dart';

class Trends extends StatefulWidget{
  @override
  State<Trends> createState() => _TrendsState();
}

class _TrendsState extends State<Trends> {
  String n ='https://newsapi.org/v2/top-headlines?country=eg&category=general&apiKey=a2d197f199fa4e82aa52e38252d32cef';

  Future<News> getdata()async{
    var result = await http.get(Uri.parse(n));
    print('=======================');
    print('${result.body}');
    print('=======================');
    return News.fromJson(jsonDecode(result.body));
  }

  late Future<News> _future;

  @override
  void initState(){
    _future= getdata() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body:FutureBuilder<News>(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
         if(snapshot.hasData){
           return ListView.builder(
               itemCount: snapshot.data!.articles?.length,
               itemBuilder:(context,i){
                 return     Posts(
                   name: '${snapshot.data!.articles![i].source?.name}',
                   auther: '${snapshot.data!.articles![i].author}',
                   title: '${snapshot.data!.articles![i].title}',
                   image: "${snapshot.data!.articles![i].urlToImage}",
                   des: '${snapshot.data!.articles![i].description}',
                   link:"${snapshot.data!.articles![i].url}" ,
                   time: "${snapshot.data!.articles![i].publishedAt}",

                 );
               }

           );
         }
         else{
           return Center(child: CircularProgressIndicator(),);
         }
        },

      )
    );
  }
}