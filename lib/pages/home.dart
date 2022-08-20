import 'dart:convert';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:x_news/pages/posts.dart';
import 'package:x_news/pages/profile.dart';
import '../Models/news.dart';
import 'trend.dart';
import 'package:http/http.dart' as http;
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget categories (String n,){
    return Container(
      height: 30,
      width: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color:Colors.black54,blurRadius:5)],
        borderRadius: BorderRadius.all(Radius.circular(30)),
        border: Border.all(color:Colors.blue,width:1),
      ),
      margin: EdgeInsets.only(right:5,top: 10,bottom: 5,left: 10),
      child: Center(child: Text(n,style: TextStyle(fontSize: 18,color: Colors.blue,
          shadows: [BoxShadow(color: Colors.white    ,blurRadius:5)]),)),
    );
  }
  Future<News> getdata(String x)async{
  var result = await http.get(Uri.parse(x));
  print('=======================');
  print('${result.body}');
  print('=======================');
  return News.fromJson(jsonDecode(result.body));
}

   String _Categoryapi(String c,String n){
    return 'https://newsapi.org/v2/top-headlines?country=$n&category=$c&apiKey=a2d197f199fa4e82aa52e38252d32cef';
   }
   String tesla='https://newsapi.org/v2/everything?q=tesla&from=2022-07-17&sortBy=publishedAt&apiKey=a2d197f199fa4e82aa52e38252d32cef';
   String everything='https://newsapi.org/v2/everything?q=bitcoin&apiKey=a2d197f199fa4e82aa52e38252d32cef';
   String apple='https://newsapi.org/v2/everything?q=apple&from=2022-08-15&to=2022-08-15&sortBy=popularity&apiKey=a2d197f199fa4e82aa52e38252d32cef';
   String  bbc ='https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=a2d197f199fa4e82aa52e38252d32cef';
  int i =1;
  late Future<News> _future;

  @override
  void initState(){
    Retriever1();
    _future= getdata(_Categoryapi('Sports',xx)) ;
    super.initState();
  }
  String xx='';
  String y='';
  Retriever1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('country') ?? '';
    final lang = prefs.getString('language') ?? '';
    setState(() {
      xx=name;
      y=lang;
    });
    print(name);
    print(name);
    print(lang);
    print(lang);
  }

   bool x =false;
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.grey[200],
      body:
      i==1?
      FutureBuilder<News>(
          future: _future,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return CustomScrollView(
                slivers: <Widget>[
                   SliverAppBar(
                    pinned: true,
                    expandedHeight: 160.0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text('X - News',style: TextStyle(color: Colors.white,shadows: [BoxShadow(color: Colors.red,blurRadius:15)]),),
                      background:Image.asset('assets/aa.jpg',fit: BoxFit.cover,),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      alignment: Alignment.topCenter,
                      height: 50,
                      // color: Colors.black54,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          InkWell(
                              onTap: (){
                                setState(() {
                                  _future=getdata(everything);

                                });
                              },
                              child: categories('General')),
                          InkWell(
                              onTap: (){
                                setState(() {
                                _future=getdata(_Categoryapi('sports',xx));
                                });
                              },
                              child: categories('Sports')),
                          InkWell(
                              onTap: (){
                                setState(() {
                                  _future=getdata(bbc);
                                });
                              },
                              child: categories('BBC')),
                          InkWell(
                              onTap: (){
                                setState(() {
                                  _future=getdata(apple);
                                });
                              },
                              child: categories('Apple')),
                          InkWell(
                              onTap: (){
                                setState(() {
                                  _future=getdata(tesla);
                                });
                              },
                              child: categories('Tesla')),
                          InkWell(
                              onTap: (){
                                setState(() {
                                  _future=getdata(_Categoryapi('general',xx));
                                });
                              },
                              child: categories('Everything')),
                          InkWell(
                              onTap: (){
                                setState(() {
                                  _future=getdata(_Categoryapi('science',xx));
                                });
                              },
                              child: categories('Science')),
                          InkWell(
                              onTap: (){
                                setState(() {
                                  _future=getdata(_Categoryapi('health',xx));
                                });
                              },
                              child: categories('Health')),
                          InkWell(
                              onTap: (){
                                setState(() {
                                  _future=getdata(_Categoryapi('entertainment',xx));
                                });
                              },
                              child: categories('Entertainment')),
                          InkWell(
                              onTap: (){
                                setState(() {
                                  _future=getdata(_Categoryapi('business',xx));
                                });
                              },
                              child: categories('Business')),
                          InkWell(
                              onTap: (){
                                setState(() {
                                  _future=getdata(_Categoryapi('technology',xx));
                                });
                              },
                              child: categories('Technology')),

                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate:
                    SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return
                           Posts(
                             name: '${snapshot.data!.articles![index].source?.name}',
                             auther: '${snapshot.data!.articles![index].author}',
                             title: '${snapshot.data!.articles![index].title}',
                             image: "${snapshot.data!.articles![index].urlToImage}",
                             des: '${snapshot.data!.articles![index].description}',
                             link:"${snapshot.data!.articles![index].url}" ,
                             time: "${snapshot.data!.articles![index].publishedAt}",

                           );
                      },
                      childCount: snapshot.data!.articles?.length,
                    ),
                  ),
                ],
              );
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          })
          
          :i==0?Trends():Profile(),
      bottomNavigationBar:
        ConvexAppBar(
          items: [
            TabItem(icon: Icons.trending_up_sharp, title: 'Trends'),
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.person, title: 'profile'),
          ],
           initialActiveIndex: 1,
          onTap: (x)=> {
            setState((){
            i=x;
            if(i==1){
              setState(() {
                Retriever1();
                _future=getdata(_Categoryapi('general',xx));
              });
            }
          })
          },
        )
    );
  }
}
// Container(
//   decoration: const BoxDecoration(
//       color: Colors.white30,
//       borderRadius: BorderRadius.all(Radius.circular(15))
//   ),
//   margin: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
//   child:   TextField(
//     style:  const TextStyle(
//       color: Colors.white,
//     ),
//
//     textInputAction: TextInputAction.search,
//     onSubmitted: (value) => {},
//     decoration: InputDecoration(
//       contentPadding: EdgeInsets.all(8),
//       suffix: const Icon(
//         Icons.search,
//         color: Colors.white,
//       ),
//       hintStyle: const TextStyle(color: Colors.white),
//       hintText: '     Search'.toUpperCase(),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15),
//         borderSide: const BorderSide(color: Colors.white,width: 2),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15),
//         borderSide: BorderSide(color: Colors.white,width: 2),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15),
//         borderSide: BorderSide(color: Colors.grey),
//       ),
//     ),
//   ),
// ),