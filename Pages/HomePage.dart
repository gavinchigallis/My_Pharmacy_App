import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math';

import '../Models/ThemeAttribute.dart';
import '../Models/Utility.dart';
import '../Models/Hotel.dart';
import '../Pages/HotelPage.dart';
import '../Widgets/HotelCardWidget.dart';
import '../Services/HotelService.dart';



/*
* @Description:
*
*/
class HomePage extends StatefulWidget {
  /*[Attributes]*/

  HomePage()
  {

  }

  /*
  * @Description:
  *
  * @param:
  *
  * @return: void
  */
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

/*
* @Description:
*
* @param:
*
* @return: void
*/
class _HomePage extends State<HomePage> with WidgetsBindingObserver{
    /*[Attributes]*/
    int _state_id = 2;
    int mainDisplayState = 2;
    Widget _view = Container();
    ThemeAttribute theme_attribute = ThemeAttribute();
    Utility utility = new Utility();
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    bool _isPageLoading = false;
    HotelService _hotelService = new HotelService();
    List _hotels = [];
    List _selectedFilter = ["House", "Price"];

    /*[Constructors]*/


    /*
    * @Description: Constructor
    *
    * @param:
    *
    * @return: void
    */
    _HomePage()
    {

    }

    /*[Live Cycle methods]*/

    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    @override
    void initState(){
        WidgetsBinding.instance.addObserver(this);

        //this._getHotels();

        super.initState();
    }

    @override
    void dispose() {
        WidgetsBinding.instance.removeObserver(this);
        super.dispose();
    }
    

    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    @override
    Widget build(BuildContext context) {
        //Variables
        //final ThemeAttribute theme_attribute = ThemeAttribute();
        final double deviceHeight = MediaQuery.of(context).size.height;
        final double deviceWidth = MediaQuery.of(context).size.width;

        //Set view
        switch(this._state_id)
        {
            case 0:
            {
                this._view = SafeArea(
                    child: Scaffold(
                        key: _scaffoldKey,
                            /*appBar: AppBar(
                                title: Row(
                                    children: <Widget>[
                                        //Image.asset('assets/icon.png'),
                                        SizedBox(width: 20),
                                        Text('Home', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0, color: Colors.grey))
                                    ]
                                ),
                                backgroundColor: Colors.white,
                                elevation: 0.0,
                            ),*/
                            body: Container(
                                //color: Colors.red,
                            ),
                            /*floatingActionButton:Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                    FloatingActionButton(
                                            onPressed: () {
                                                this._search_isLoading = true;
                                                callShowModalBottomSheet(context);
                                                //_showModalBottomSheetCustom(context);
                                            },
                                            child: Icon(Icons.search),
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors.blue,
                                      ),
                                  ],
                            )*/
                    )
                );
                break;
            }

            case 1:
            {
                break;
            }

            case 2:
            {
                this._view = SafeArea(
                    child: Scaffold(
                        key: _scaffoldKey,
                        backgroundColor: Colors.white,
                            /*appBar: AppBar(
                                title: Row(
                                    children: <Widget>[
                                        //Image.asset('assets/icon.png'),
                                        SizedBox(width: 20),
                                        Text('Home', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0, color: Colors.grey))
                                    ]
                                ),
                                backgroundColor: Colors.white,
                                elevation: 0.0,
                            ),*/
                            body: _mainDisplay(),
                            /*floatingActionButton:Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                    FloatingActionButton(
                                            onPressed: () {
                                                this._search_isLoading = true;
                                                callShowModalBottomSheet(context);
                                                //_showModalBottomSheetCustom(context);
                                            },
                                            child: Icon(Icons.search),
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors.blue,
                                      ),
                                  ],
                            )*/
                    )
                );
                break;
            }


            default:
            {
                this._view = SafeArea(
                    child: Scaffold(
                        key: _scaffoldKey,
                        appBar: AppBar(
                          title: Row(
                              children: <Widget>[
                                  //Image.asset('assets/icon.png'),
                                  SizedBox(width: 20),
                                  Text('Home', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0, color: Colors.grey))
                              ]
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0.0,
                        ),
                        body: Container(),
                          /*floatingActionButton:Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FloatingActionButton(
                                        onPressed: () {
                                            this._search_isLoading = true;
                                            callShowModalBottomSheet(context);
                                            //_showModalBottomSheetCustom(context);
                                        },
                                        child: Icon(Icons.search),
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.blue,
                                  ),
                              ],
                          )*/
                    )
                );
                break;
            }
        }


        return this._view;
    }


    /*[Methods]*/


    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    Widget _mainDisplay() {
        //Variables
        //final ThemeAttribute theme_attribute = ThemeAttribute();
        Utility utility = new Utility();
        final double deviceHeight = MediaQuery.of(context).size.height;
        final double deviceWidth = MediaQuery.of(context).size.width;

        

        switch(this.mainDisplayState)
        {
            //is loading
            case 0:
            {
                return Container(
                    width: deviceWidth,
                    height: deviceHeight,
                    //color: Colors.blue,
                    //child: SingleChildScrollView(
                        child: Container(
                            child: Column(
                                children: <Widget>[
                                    this._pageLoader(),
                                    Container(
                                        padding: EdgeInsets.only(left: 20, right: 20),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              
                                            ],
                                        ),
                                    ),
                                    Container(
                                        height: deviceHeight-220,
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                Icon(Icons.shopping_cart, color: Colors.grey[600], size: 100),
                                                SizedBox(height: 10),
                                            ],
                                        ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 20, right: 20),
                                        margin: EdgeInsets.only(top: 10, bottom: 10),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                                
                                            ],
                                        ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 20, right: 20),
                                        child: FlatButton(
                                            color: Colors.black,
                                            child: Container(
                                                constraints: BoxConstraints(
                                                    minWidth: deviceWidth-100
                                                ),
                                                margin: EdgeInsets.all(10),
                                                child: Center(
                                                    //child:,
                                                )
                                            ),
                                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                            onPressed: (){
                                                
                                            },
                                        )
                                    ),
                                ],
                            ),
                        ),
                    //),
                );
                break;
            }

            //Empty State
            case 1:
            {
                return Container();
                break;
            }

            //has data
            case 2:
            {
                return Container(
                    width: deviceWidth,
                    height: deviceHeight,
                    child: DefaultTabController(
                        length: 4,
                        child: Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Container(
                                        width: deviceWidth,
                                        height: 175,
                                        decoration: BoxDecoration(
                                            color: theme_attribute.primaryColor,
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                                        ),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                                Container(
                                                    color: Colors.transparent,
                                                    child: Row(
                                                        children: [
                                                            Container(
                                                                color: Colors.transparent,
                                                                padding: EdgeInsets.only(left: 25.00, top: 20.00, right: 25.00, bottom: 5.00),
                                                                constraints: BoxConstraints(
                                                                    maxHeight: 70,
                                                                    minHeight: 70,
                                                                    maxWidth: deviceWidth * 0.8
                                                                ),
                                                                child: TextField(
                                                                    keyboardType: TextInputType.text,
                                                                    style: new TextStyle(
                                                                        fontSize: 18.0,
                                                                        //height: 0.35,
                                                                        color: Colors.grey,
                                                                        fontWeight: FontWeight.normal                  
                                                                    ),
                                                                    decoration: InputDecoration(
                                                                        labelText: "Search",
                                                                        border: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.circular(10.0),
                                                                        ),
                                                                        //icon: Icon(Icons.search, color: Colors.grey),
                                                                        suffixIcon:  Icon(Icons.search, color: Colors.black),
                                                                        hasFloatingPlaceholder: true,
                                                                        filled: true,
                                                                        fillColor: Colors.white
                                                                    ),
                                                                    onSubmitted: (String value){
                                                                        if(value!="")
                                                                        {
                                                                            //Navigator.pushNamed(context, "/search/"+value);
                                                                        }
                                                                    },
                                                                    onChanged: (String value) {
                                                                        setState(() {
                                                                            //_passwordValue = value;
                                                                        });
                                                                    }
                                                                ),
                                                            ),
                                                            Container(
                                                                width: 40,
                                                                height: 40,
                                                                margin: EdgeInsets.only(top: 10),
                                                                padding: EdgeInsets.all(5),
                                                                decoration: BoxDecoration(
                                                                    color: Color.fromARGB(255, 195, 246, 248), //#C3F6F8,
                                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                ),
                                                                child: RotatedBox(
                                                                    quarterTurns: 2,
                                                                    child: Icon(
                                                                        Icons.sort,
                                                                        size: 30,
                                                                    ),
                                                                ),
                                                            )
                                                        ],
                                                    ),
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                                                    child: TabBar(
                                                        indicatorColor: Colors.transparent,
                                                        unselectedLabelColor: Colors.grey,
                                                        tabs:
                                                        [
                                                            Tab(
                                                                text: "Medicines",
                                                                icon: Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    padding: EdgeInsets.all(5),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                    ),
                                                                    child: Image.asset(
                                                                        "lib/Projects/My_Pharmacy_App/Assets/Images/bandage_150x150.png",
                                                                        width: 30,
                                                                        height: 30,
                                                                    ),
                                                                ),
                                                            ),
                                                            Tab(
                                                                text: "First Aid kit",
                                                                icon: Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    padding: EdgeInsets.all(5),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                    ),
                                                                    child: Image.asset(
                                                                        "lib/Projects/My_Pharmacy_App/Assets/Images/kit_150x150.png",
                                                                        width: 30,
                                                                        height: 30,
                                                                    ),
                                                                ),
                                                            ),
                                                            Tab(
                                                                text: "Find Doctor",
                                                                icon: Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    padding: EdgeInsets.all(5),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                    ),
                                                                    child: Image.asset(
                                                                        "lib/Projects/My_Pharmacy_App/Assets/Images/doctor_150x150.png",
                                                                        width: 30,
                                                                        height: 30,
                                                                    ),
                                                                ),
                                                            ),
                                                            Tab(
                                                                text: "Emergency",
                                                                icon: Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    padding: EdgeInsets.all(5),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                    ),
                                                                    child: Image.asset(
                                                                        "lib/Projects/My_Pharmacy_App/Assets/Images/emergency_150x150.png",
                                                                        width: 30,
                                                                        height: 30,
                                                                    ),
                                                                ),
                                                            ),
                                                        ]

                                                    ),
                                                )
                                            ],
                                        ),
                                    ),
                                    Container(
                                        color: Colors.transparent,
                                        width: deviceWidth,
                                        height: 100,
                                        child: TabBarView(
                                            children: [
                                                new Container(
                                                    color: Colors.transparent,
                                                    child: Center(child: Text('Hi from School', style: TextStyle(color: Colors.white),),),
                                                    ),
                                                new Container(
                                                  color: Colors.transparent,
                                                  child: Center(child: Text('Hi from home', style: TextStyle(color: Colors.white),),),
                                                ),   new Container(
                                                  color: Colors.transparent,
                                                  child: Center(child: Text('Hi from Church', style: TextStyle(color: Colors.white),),),
                                                ),  new Container(
                                                  color: Colors.transparent,
                                                  child: Center(child: Text('Hi from Hospital', style: TextStyle(color: Colors.white),),),
                                                ),
                                            ]
                                        )
                                    )
                                ]
                            )
                        )
                    )
                );
                    /*child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                Container(
                                    width: deviceWidth,
                                    height: deviceHeight * 0.20,
                                    decoration: BoxDecoration(
                                        color: theme_attribute.primaryColor,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                                    ),
                                    child: Column(
                                        children: [
                                            Container(
                                                color: Colors.transparent,
                                                child: Row(
                                                    children: [
                                                        Container(
                                                            color: Colors.transparent,
                                                            padding: EdgeInsets.only(left: 25.00, top: 20.00, right: 25.00, bottom: 5.00),
                                                            constraints: BoxConstraints(
                                                                maxHeight: 70,
                                                                minHeight: 70,
                                                                maxWidth: deviceWidth * 0.8
                                                            ),
                                                            child: TextField(
                                                                keyboardType: TextInputType.text,
                                                                style: new TextStyle(
                                                                    fontSize: 18.0,
                                                                    //height: 0.35,
                                                                    color: Colors.grey,
                                                                    fontWeight: FontWeight.normal                  
                                                                ),
                                                                decoration: InputDecoration(
                                                                    labelText: "Search",
                                                                    border: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                    ),
                                                                    //icon: Icon(Icons.search, color: Colors.grey),
                                                                    suffixIcon:  Icon(Icons.search, color: Colors.black),
                                                                    hasFloatingPlaceholder: true,
                                                                    filled: true,
                                                                    fillColor: Colors.white
                                                                ),
                                                                onSubmitted: (String value){
                                                                    if(value!="")
                                                                    {
                                                                        //Navigator.pushNamed(context, "/search/"+value);
                                                                    }
                                                                },
                                                                onChanged: (String value) {
                                                                    setState(() {
                                                                        //_passwordValue = value;
                                                                    });
                                                                }
                                                            ),
                                                        ),
                                                        Container(
                                                            color: Colors.red,
                                                        )
                                                    ],
                                                ),
                                            ),
                                            Container(
                                              
                                            )
                                        ],
                                    ),
                                ),
                                Container(
                                    color: Colors.transparent,
                                    width: deviceWidth,
                                    height: 100,
                                )
                            ],
                        ),
                    ),*/
                //);
                break;
            }

            default:
            {
                return Container();
                break;
            }

        }
    }

    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    Widget _pageLoader()
    {
        //final ThemeAttribute theme_attribute = ThemeAttribute();
        Utility utility = new Utility();
        final double deviceHeight = MediaQuery.of(context).size.height;
        final double deviceWidth = MediaQuery.of(context).size.width;

        if(this._isPageLoading)
        {
            return Container(
                height: 3,
                margin: EdgeInsets.only(bottom: 5),
                child: LinearProgressIndicator(
                    backgroundColor: Colors.black,
                ),
            );
        }
        else
        {
            return Container(
                height: 3,
                margin: EdgeInsets.only(bottom: 5)
            );
        }
    }
    
   
    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    Future<void> _getHotels() async {
        this.utility.Custom_Print("START: _getHotels");
        //Variables

        setState(() {
            this._isPageLoading = true;
        });
        
        
        this._hotelService.getHotels()
        .then((value) {
            // Run extra code here
            utility.Custom_Print("Function Complete Successfully");
            utility.Custom_Print(value.toString());

            setState(() {
                this._isPageLoading = false;
                this._state_id = 2;
                this.mainDisplayState = 2;
                this._hotels = value;
            });
        },
        onError: (error) {
            utility.Custom_Print("Future returned Error");
            utility.Custom_Print(error.toString());
            //Toast.show(error['message'], context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

            setState(() {
                this._isPageLoading = false;
            });

            switch(error.runtimeType) { 

                case SocketException: {

                    SnackBar snackBar = SnackBar(
                        content: Text("Could not login at this time"),
                        action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {
                                // Some code to undo the change.
                            },
                        ),
                    );
                    
                    //_scaffoldKey.currentState.showSnackBar(snackBar);

                    Toast.show("Could not login at this time", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    break;
                }


                default: {

                    SnackBar snackBar =  SnackBar(
                        content: Text(error['error']),
                        action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {
                                // Some code to undo the change.
                            },
                        ),
                    );
                    
                    //_scaffoldKey.currentState.showSnackBar(snackBar);

                    Toast.show(error['error'].toString(), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                }
            }
        })
        .catchError((error){
            utility.Custom_Print("Please try again later");
            utility.Custom_Print(error.toString());
            //Toast.show("Please try again later", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

            setState(() {
                this._isPageLoading = false;
            });
        });

        this.utility.Custom_Print("STOP: _getHotels");
    }


    
}