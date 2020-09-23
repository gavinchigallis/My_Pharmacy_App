import 'package:flutter/material.dart';
import 'dart:convert';

import './Models/ThemeAttribute.dart';
import './Models/Utility.dart';
import './Pages/homePage.dart';


class App extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _App();
  }
}

class _App extends State<App> {
    //Variables
    String _user_email;
    ThemeAttribute theme_attribute = ThemeAttribute();
    Utility utility = Utility();
    

    void checkLoginStatus() async {
        //Variables
        //Navigator.pushReplacementNamed(context, '/home');
        /*SharedPreferences prefs = await SharedPreferences.getInstance();
        this._user_email = prefs.getString('user_email').toString();
        
        print('user_email:');
        print(this._user_email);*/

        Future<int>.delayed(Duration(seconds: 1)).then((value){
            //if(this._user_email.toString() == 'null')
            if(true)
            {
                Navigator.pushReplacementNamed(context, '/home');
            }
            else
            {
                Navigator.pushReplacementNamed(context, '/home');
            }
        });
    }


    @override
    void initState(){
        
        Future.delayed(new Duration(seconds: 1)).then((value){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        });

        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        //final ThemeAttribute theme_attribute = ThemeAttribute();
        final double height = MediaQuery.of(context).size.height;
        final double width = MediaQuery.of(context).size.width;

        return SafeArea(
            child: Scaffold( 
                /*appBar: AppBar(
                  title: Row(
                      children: <Widget>[
                          Image.asset('assets/icon.png'),
                          SizedBox(width: 20),
                          Text('Profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.grey))
                      ]
                  ),
                  backgroundColor: Colors.white,
                ),*/
                body: Center(
                    child: Container(
                        //color: Colors.black,
                        width: width,
                        height: height,
                        //padding: EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 20.0),
                        child: Stack(
                            children: <Widget>[
                                Container(
                                    width: width,
                                    height: height,
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    //mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                        Center(
                                          child: SizedBox(height: 20.0),
                                        ),
                                        Center(),
                                    ],
                                ),
                            ],
                        )
                      ),
                  ),
              )
          );
    }


    /*[Method]*/

}