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
//import '../Pages/PhotoPage.dart';
import '../Widgets/HotelCardWidget.dart';
import '../Services/HotelService.dart';



/*
* @Description:
*
*/
class HotelPage extends StatefulWidget {
  /*[Attributes]*/
  int id;

  HotelPage(int id)
  {
      this.id = id;
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
    return _HotelPage(this.id);
  }
}

/*
* @Description:
*
* @param:
*
* @return: void
*/
class _HotelPage extends State<HotelPage> with WidgetsBindingObserver{
    /*[Attributes]*/
    int _state_id = 2;
    int mainDisplayState = 0;
    Widget _view = Container();
    ThemeAttribute theme_attribute = ThemeAttribute();
    Utility utility = new Utility();
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    int id;
    bool _isPageLoading = false;
    HotelService _hotelService = new HotelService();
    Hotel _hotel;
    List _selectedFilter = ["House", "Price"];

    /*[Constructors]*/


    /*
    * @Description: Constructor
    *
    * @param:
    *
    * @return: void
    */
    _HotelPage(int id)
    {
        this.id = id;
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

        this._getHotelsByID(this.id);

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
                                color: Colors.red,
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
                        backgroundColor: Colors.grey[200],
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
                            body: Hero(
                                tag: "hotel_"+id.toString(),
                                child: _mainDisplay()
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
            case 0:
            {
                return Container(
                    width: deviceWidth,
                    height: deviceHeight,
                    //color: Colors.blue,
                    child: Stack(
                        children: <Widget>[
                            Container(
                                width: deviceWidth,
                                height: deviceHeight,
                                color: Colors.grey[400],
                            ),
                            Positioned(
                                bottom: 0,
                                child: Container(
                                    width: deviceWidth,
                                    height: deviceHeight/2,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                                    ),
                                ),
                            )
                        ],
                    ),
                );
                break;
            }

            case 1:
            {
                return Container();
                break;
            }

            case 2:
            {
                return Container(
                    width: deviceWidth,
                    height: deviceHeight,
                    //color: Colors.blue,
                    child: Stack(
                        children: <Widget>[
                            Container(
                                width: deviceWidth,
                                height: deviceHeight/2,
                                color: Colors.grey[400],
                                child: Container(
                                    width: deviceWidth,
                                    height: deviceHeight/2,
                                    child: Stack(
                                        children: <Widget>[
                                            Container(
                                                width: deviceWidth,
                                                height: deviceHeight/2,
                                                child:  Image.network(
                                                    this._hotel.image,
                                                    fit: BoxFit.cover,
                                                ),
                                            ),
                                            Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                            Container(
                                                                margin: EdgeInsets.only(left: 10, top: 20),
                                                                child: GestureDetector(
                                                                    child: Icon(
                                                                        Icons.arrow_back_ios,
                                                                        color: Colors.white,
                                                                    ),
                                                                    onTap: (){
                                                                        Navigator.pop(context);
                                                                    },
                                                                )
                                                            ),
                                                            Container(
                                                                margin: EdgeInsets.only(right: 20, top: 20),
                                                                child: Icon(
                                                                    Icons.notifications,
                                                                    color: Colors.white,
                                                                ),
                                                            )
                                                        ],
                                                    ),
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                            Container(
                                                                margin: EdgeInsets.only(bottom: 40),
                                                                child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                        Container(
                                                                            height: 30,
                                                                            padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                                                                            margin: EdgeInsets.only(top: 20, bottom: 0, left: 20, right: 10),
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.yellow[600],
                                                                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                                                            ),
                                                                            child: Text("for rent".toUpperCase(), style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.white)),
                                                                        ),
                                                                        SizedBox(
                                                                            height: 10,
                                                                        ),
                                                                        Container(
                                                                            padding: EdgeInsets.only(left: 20),
                                                                            child: Text(this._hotel.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Colors.white)),
                                                                        ),
                                                                        Row(
                                                                            children: <Widget>[
                                                                                Container(
                                                                                    padding: EdgeInsets.only(left: 20),
                                                                                    child: Row(
                                                                                        children: <Widget>[
                                                                                            Icon(
                                                                                                Icons.place,
                                                                                                color: Colors.white,
                                                                                                size: 14,
                                                                                            ),
                                                                                            SizedBox(
                                                                                                width: 5,
                                                                                            ),
                                                                                            Text(this._hotel.location["city"], style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.white)),
                                                                                        ],
                                                                                    )
                                                                                ),
                                                                                SizedBox(
                                                                                    width: 20,
                                                                                ),
                                                                                Container(
                                                                                    padding: EdgeInsets.only(left: 10),
                                                                                    child: Row(
                                                                                        children: <Widget>[
                                                                                            Icon(
                                                                                                Icons.business,
                                                                                                color: Colors.white,
                                                                                                size: 14,
                                                                                            ),
                                                                                            SizedBox(
                                                                                                width: 5,
                                                                                            ),
                                                                                            Text(this.utility.numberFormatter(this._hotel.space)+" sq/m", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.white)),
                                                                                        ],
                                                                                    )
                                                                                )
                                                                            ],
                                                                        ),
                                                                    ],
                                                                )
                                                            ),
                                                            Container(
                                                                child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                    children: <Widget>[
                                                                        Container(
                                                                            margin: EdgeInsets.only(top: 0, bottom: 5, left: 0, right: 20),
                                                                            child: Container(
                                                                                height: 60,
                                                                                width: 60,
                                                                                decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                                                                ),
                                                                                child: Icon(
                                                                                    Icons.favorite,
                                                                                    color: Colors.yellow[600],
                                                                                    size: 30,
                                                                                ),
                                                                            )
                                                                        ),
                                                                        Container(
                                                                            padding: EdgeInsets.only(right: 20),
                                                                            child: Row(
                                                                                children: <Widget>[
                                                                                    Icon(
                                                                                        Icons.star,
                                                                                        color: Colors.yellow[600],
                                                                                        size: 14,
                                                                                    ),
                                                                                    SizedBox(
                                                                                        width: 5,
                                                                                    ),
                                                                                    Text(this._hotel.review.toString()+" reviews", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.white)),
                                                                                ],
                                                                            )
                                                                        )
                                                                    ],
                                                                ),
                                                            )
                                                        ],
                                                    )
                                                ],
                                            )
                                        ],
                                    ),
                                ),
                            ),
                            Positioned(
                                bottom: 0,
                                child: Container(
                                    width: deviceWidth,
                                    height: deviceHeight/2,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                                    ),
                                    child: SingleChildScrollView(
                                        child: Column(
                                            children: <Widget>[
                                                SizedBox(
                                                    height: 20,
                                                ),
                                                Container(
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                            Container(
                                                                margin: EdgeInsets.only(left: 20, right: 10),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: <Widget>[
                                                                        Container(
                                                                            child: CircleAvatar(
                                                                                backgroundImage: NetworkImage(
                                                                                    this._hotel.user['image']
                                                                                ),
                                                                                backgroundColor: Colors.grey[300],
                                                                                radius: 35,
                                                                            ),
                                                                        ),
                                                                        SizedBox(
                                                                            width: 10,
                                                                        ),
                                                                        Container(
                                                                            child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: <Widget>[
                                                                                    Text(this._hotel.user['first_name']+" "+this._hotel.user['last_name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black)),
                                                                                    SizedBox(
                                                                                        height: 5,
                                                                                    ),
                                                                                    Text("Property Owner", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.grey)),
                                                                                ],
                                                                            ),
                                                                        ),
                                                                    ],
                                                                )
                                                            ),
                                                            Container(

                                                            )
                                                        ],
                                                    )
                                                ),
                                                SizedBox(
                                                    height: 20,
                                                ),
                                                Container(
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: <Widget>[
                                                            Container(
                                                                padding: EdgeInsets.only(right: 0),
                                                                child: Column(
                                                                    children: <Widget>[
                                                                        Icon(
                                                                            Icons.weekend,
                                                                            color: Colors.yellowAccent[700],
                                                                            size: 30,
                                                                        ),
                                                                        SizedBox(
                                                                            width: 5,
                                                                        ),
                                                                        Text("4 Bedroom", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.grey)),
                                                                    ],
                                                                )
                                                            ),
                                                            Container(
                                                                padding: EdgeInsets.only(right: 0),
                                                                child: Column(
                                                                    children: <Widget>[
                                                                        Icon(
                                                                            Icons.hot_tub,
                                                                            color: Colors.yellowAccent[700],
                                                                            size: 30,
                                                                        ),
                                                                        SizedBox(
                                                                            width: 5,
                                                                        ),
                                                                        Text("4 Bathroom", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.grey)),
                                                                    ],
                                                                )
                                                            ),
                                                            Container(
                                                                padding: EdgeInsets.only(right: 0),
                                                                child: Column(
                                                                    children: <Widget>[
                                                                        Icon(
                                                                            Icons.kitchen,
                                                                            color: Colors.yellowAccent[700],
                                                                            size: 30,
                                                                        ),
                                                                        SizedBox(
                                                                            width: 5,
                                                                        ),
                                                                        Text("4 Kitchen", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.grey)),
                                                                    ],
                                                                )
                                                            ),
                                                            Container(
                                                                padding: EdgeInsets.only(right: 0),
                                                                child: Column(
                                                                    children: <Widget>[
                                                                        Icon(
                                                                            Icons.local_taxi,
                                                                            color: Colors.yellowAccent[700],
                                                                            size: 30,
                                                                        ),
                                                                        SizedBox(
                                                                            width: 5,
                                                                        ),
                                                                        Text("4 Parkings", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.grey)),
                                                                    ],
                                                                )
                                                            )
                                                        ],
                                                    ),
                                                ),
                                                SizedBox(
                                                    height: 20
                                                ),
                                                Container(
                                                    width: deviceWidth,
                                                    padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                                                    child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                            Text("Description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black)),
                                                            SizedBox(
                                                                height: 5,
                                                            ),
                                                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.grey)),
                                                        ],
                                                    ),
                                                ),
                                                SizedBox(
                                                    width: 10,
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                                                    child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                            Text("Photos", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black)),
                                                            SizedBox(
                                                                height: 5,
                                                            ),
                                                            Row(
                                                                children: this._hotel.images.map((item) {
                                                                    return new Builder(
                                                                        builder: (BuildContext context) {
                                                                            
                                                                            return GestureDetector(
                                                                                child: Container(
                                                                                    width: 100,
                                                                                    height: 100,
                                                                                    margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                                                                                    //padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
                                                                                    decoration: BoxDecoration(
                                                                                        border: Border.all(
                                                                                            color: Colors.grey[300],
                                                                                            width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.all(
                                                                                            Radius.circular(5.0)
                                                                                        ),
                                                                                    ),
                                                                                    child: Image.network(
                                                                                        item['image'],
                                                                                        fit: BoxFit.cover,
                                                                                    ),
                                                                                ),
                                                                                onTap: (){

                                                                                }
                                                                            );
                                                                        },
                                                                    );
                                                                }).toList(),
                                                            )
                                                        ],
                                                    )
                                                )
                                            ],
                                        ),
                                    ),
                                ),
                            )
                        ],
                    ),
                );
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
    Future<void> _getHotelsByID(int id) async {
        this.utility.Custom_Print("START: _getHotelsByID");
        //Variables

        setState(() {
            this._isPageLoading = true;
        });
        
        
        this._hotelService.getHotelByID(id)
        .then((value) {
            // Run extra code here
            utility.Custom_Print("Function Complete Successfully");
            utility.Custom_Print(value.toString());

            setState(() {
                this._isPageLoading = false;
                this._state_id = 2;
                this.mainDisplayState = 2;
                this._hotel = new Hotel.fromJson(value);
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

        this.utility.Custom_Print("STOP: _getHotelsByID");
    }


    
}