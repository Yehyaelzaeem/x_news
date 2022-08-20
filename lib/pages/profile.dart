import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:giff_dialog/giff_dialog.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  Future<void> _namecountry( String _country ) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('country', _country);
    });
  }
  Future<void> _language( String _lan ) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('language', _lan);
    });
  }

  Retriever1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('country') ?? '';
    final lang = prefs.getString('language') ?? '';
   setState(() {
     x=name;
     y=lang;
   });
    print(name);
    print(lang);
  }
 static String x='';
 String y='';
  @override
  void initState() {
    //_namecountry('eg');
    Retriever1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Profile',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Expanded(
              flex: 1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/aa.jpg'), fit: BoxFit.fill),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.black54,
                          size: 35,
                        ),
                      ),
                    ),
                  )
                ],
              )),
          Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 30, right: 30),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: const ListTile(
                          leading: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                          title: Center(child: Text('My Account')),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => AssetGiffDialog(
                                      image: Image.asset('assets/aa.jpg'),
                                      title: const Text(
                                        'Choose Your Country',
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      description: const Text(
                                        'This is a men wearing jackets dialog box.This library helps you easily create fancy giff dialog.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(),
                                      ),
                                      entryAnimation: EntryAnimation.topLeft,
                                      onOkButtonPressed: () {

                                        setState(() {
                                          _namecountry('eg');
                                          Navigator.pop(context);
                                          Retriever1();
                                        });

                                      },
                                      buttonRadius: 20,
                                  onCancelButtonPressed: (){
                                    setState(() {
                                      _namecountry('us');
                                      Navigator.pop(context);
                                      Retriever1();

                                    });
                                  },
                                      buttonOkText: Text(
                                        'Egypt',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      buttonCancelText: Text(
                                        'United States',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ));
                          },
                          leading: const Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          ),
                          title: Center(child: Text('Country  ($x)')),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 30, right: 30),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child:  ListTile(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (_) => AssetGiffDialog(
                                  image: Image.asset('assets/aa.jpg'),
                                  title: const Text(
                                    'Choose Your language',
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  description: const Text(
                                    'This is a men wearing jackets dialog box.This library helps you easily create fancy giff dialog.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
                                  ),
                                  entryAnimation: EntryAnimation.topLeft,
                                  onOkButtonPressed: () {

                                    setState(() {
                                      _language('ar');
                                      Navigator.pop(context);
                                      Retriever1();
                                    });

                                  },
                                  buttonRadius: 20,
                                  onCancelButtonPressed: (){
                                    setState(() {
                                      _language('en');
                                      Navigator.pop(context);
                                      Retriever1();

                                    });
                                  },
                                  buttonOkText: Text(
                                    'Arabic',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  buttonCancelText: Text(
                                    'English',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ));
                          },
                          leading: Icon(
                            Icons.language,
                            color: Colors.blue,
                          ),
                          title: Center(child: Text('Language  ($y)')),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
