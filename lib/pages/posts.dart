import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class Posts extends StatefulWidget {
  String name;
  String auther;
  String title;
  String image;
  String des;
  String link;
  String time;

  Posts(
      {required this.name,
      required this.auther,
      required this.title,
      required this.image,
      required this.des,
       required this.link,
      required this.time});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {

  @override
  Widget build(BuildContext context) {
    final Uri _url2 = Uri.parse('${widget.link}');
    Future<void> _launchUrl2() async {
      if (!await launchUrl(_url2)) {
        throw 'Could not launch $_url2';
      }
    }
    return Container(
      margin: EdgeInsets.only(top: 9),
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 10),
            alignment: Alignment.topLeft,
            child: Text(widget.name,
            style: TextStyle(color: Colors.red[800]),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            alignment: Alignment.center,
            child: Text(
              widget.auther,
              style: TextStyle(color: Colors.blue[800]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 20, right: 20),
            alignment: Alignment.center,
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 12),
              maxLines: 2 ,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            child: widget.image!='null'?Image.network(widget.image):Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.3,
                child: Center(child: CircularProgressIndicator(),)),
          ),
          Container(
            height: MediaQuery.of(context).size.height*.05,
            margin: EdgeInsets.only(top: 0,bottom: 5,left: 20,right: 20),

            child: Text(widget.des,

              style: TextStyle(fontSize: 12),
              maxLines:4,
            overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
            height: MediaQuery.of(context).size.height*.05,
            width: MediaQuery.of(context).size.width,
            child:
            InkWell(
              onTap: (){
                _launchUrl2();
              },
              child: Text(
                style: TextStyle(fontSize: 12,color: Colors.blue[300]),
                widget.link.toString(),
                maxLines:3,
                overflow: TextOverflow.ellipsis,

              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*.05,
            child: Text(widget.time, style: TextStyle(fontSize: 8),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
