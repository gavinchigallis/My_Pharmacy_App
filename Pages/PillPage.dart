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
import '../Models/Product.dart';
import '../Widgets/ProductCardWidget.dart';
import '../Widgets/DoctorCardWidget.dart';
import '../Services/ProductService.dart';



/*
* @Description:
*
*/
class PillPage extends StatefulWidget {
  /*[Attributes]*/
  int _product_id;

  PillPage(){

  }

  /*
  * @Description: Constructor
  *
  * @param:
  *
  * @return: void
  */
  PillPage.withData(int product_id){
      this._product_id=product_id;
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
      if(this._product_id==null){
          return _PillPage();
      }else{
          return _PillPage._withData(this._product_id);
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
class _PillPage extends State<PillPage> with WidgetsBindingObserver{
    /*[Attributes]*/
    int _state_id = 0;
    int mainDisplayState = 0;
    Widget _view = Container();
    ThemeAttribute theme_attribute = ThemeAttribute();
    Utility utility = new Utility();
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    bool _isPageLoading = false;
    ProductService _productService = new ProductService();
    List _pills = [];
    List _first_aids = [];
    List _doctors = [];
    List _emergencys = [];
    int _product_id;
    Product _product;

    /*[Constructors]*/


    /*
    * @Description: Constructor
    *
    * @param:
    *
    * @return: void
    */
    _PillPage()
    {

    }

    /*
    * @Description: Constructor
    *
    * @param:
    *
    * @return: void
    */
    _PillPage._withData(int product_id)
    {
        this._product_id = product_id;
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

        this._getPill(this._product_id);

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
                    child: Column(
                        children: [
                            Container(
                                width: deviceWidth,
                                height: deviceHeight * 0.45,
                                child: Stack(
                                    children: <Widget>[
                                        Container(
                                            height: (deviceHeight * 0.45) - 25,
                                            decoration: BoxDecoration(
                                                color: theme_attribute.primaryColor,
                                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                                            ),
                                            child: Center(
                                                /*child: Image.network(
                                                    this._product.image,
                                                    fit: BoxFit.fitHeight,
                                                    errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace){
                                                        return Image.asset(
                                                            "lib/Projects/My_Pharmacy_App/Assets/Images/noimage.png",
                                                            width: 120,
                                                            height: 120
                                                        );
                                                    },
                                                ),*/
                                            ),  
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            right: 30,
                                            child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(16),
                                                ),
                                                child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Icon(
                                                        Icons.favorite_border,
                                                        color: Colors.red,
                                                    ),
                                                ),
                                            )
                                        ),
                                        Positioned(
                                            top: 20,
                                            left: 0,
                                            child: Container(
                                                width: deviceWidth,
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                        ButtonTheme(
                                                            minWidth: 30,
                                                            height: 30,
                                                            child: RaisedButton(
                                                                color: Color.fromARGB(255, 195, 246, 248),
                                                                padding: EdgeInsets.all(5),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                ),
                                                                child: Icon(
                                                                    Icons.arrow_back
                                                                ),
                                                                onPressed: (){
                                                                    Navigator.pop(context);
                                                                },
                                                            ),
                                                        ),
                                                        Icon(
                                                            Icons.more_vert
                                                        )  
                                                    ],
                                                ),
                                            )
                                        ),
                                        this._pageLoader(),
                                    ],
                                ),
                            ),
                        ],
                    ),
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Container(
                                width: deviceWidth,
                                height: deviceHeight * 0.45,
                                child: Stack(
                                    children: <Widget>[
                                        Container(
                                            height: (deviceHeight * 0.45) - 25,
                                            decoration: BoxDecoration(
                                                color: theme_attribute.primaryColor,
                                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                                            ),
                                            child: Center(
                                                child: Image.network(
                                                    this._product.image,
                                                    fit: BoxFit.fitHeight,
                                                    errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace){
                                                        return Image.asset(
                                                            "lib/Projects/My_Pharmacy_App/Assets/Images/noimage.png",
                                                            width: 120,
                                                            height: 120
                                                        );
                                                    },
                                                ),
                                            ),  
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            right: 30,
                                            child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(16),
                                                ),
                                                child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: _likeIcon(),
                                                ),
                                            )
                                        ),
                                        Positioned(
                                            top: 20,
                                            left: 0,
                                            child: Container(
                                                width: deviceWidth,
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                        ButtonTheme(
                                                            minWidth: 30,
                                                            height: 30,
                                                            child: RaisedButton(
                                                                color: Color.fromARGB(255, 195, 246, 248),
                                                                padding: EdgeInsets.all(5),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                ),
                                                                child: Icon(
                                                                    Icons.arrow_back
                                                                ),
                                                                onPressed: (){
                                                                    Navigator.pop(context);
                                                                },
                                                            ),
                                                        ),
                                                        Icon(
                                                            Icons.more_vert
                                                        )  
                                                    ],
                                                ),
                                            )
                                        ),
                                        this._pageLoader(),
                                    ],
                                ),
                            ),
                            Container(
                                width: deviceWidth * 0.5,
                                padding: EdgeInsets.only(left: 15),
                                child: Text(this._product.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Colors.black)),
                            ),
                            SizedBox(
                                height: 10,
                            ),
                            Container(
                                width: deviceWidth,
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        Container(
                                            child: Row(
                                                children: [
                                                    Text("\$", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12.0, color: Colors.black)),
                                                    Text(this._product.price.toStringAsFixed(2), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black))
                                                ],
                                            ),
                                        ),
                                        Container(
                                            child: ButtonTheme(
                                                //minWidth: deviceWidth - 50,
                                                height: 30,
                                                child: RaisedButton(
                                                    color: this.theme_attribute.primaryColor,
                                                    padding: EdgeInsets.all(5),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                    child: Text("-  1  +", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0, color: Colors.black)),
                                                    onPressed: (){

                                                    },
                                                ),
                                            ),
                                        )
                                    ],
                                ),
                            ),
                            SizedBox(
                                height: 20,
                            ),
                            Container(
                                width: deviceWidth,
                                padding: EdgeInsets.only(left: 15),
                                child: Text("About Product", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black)),
                            ),
                            SizedBox(
                                height: 10,
                            ),
                            Container(
                                width: deviceWidth,
                                padding: EdgeInsets.only(left: 15),
                                child: Text(this._product.details, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.black)),
                            ),
                            SizedBox(
                                height: 20,
                            ),
                            Center(
                                child: ButtonTheme(
                                    minWidth: deviceWidth - 50,
                                    height: 50,
                                    child: RaisedButton(
                                        color: this.theme_attribute.primaryColor,
                                        padding: EdgeInsets.all(5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        child: Text("Add to Cart", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black)),
                                        onPressed: (){
                                            Toast.show("Added item to cart", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                        },
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
                    backgroundColor: this.theme_attribute.primaryColor,
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
    * @Description: show liked icon
    *
    * @param:
    *
    * @return: Icon (Widget)
    */
    Icon _likeIcon()
    {
        if(this._product.like){
            return Icon(
                Icons.favorite,
                color: Colors.red,
            );
        }else{
            return Icon(
                Icons.favorite_border,
                color: Colors.red,
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
    Future<void> _getPill(int product_id) async {
        this.utility.Custom_Print("START: _getPill");
        //Variables

        setState(() {
            this._isPageLoading = true;
        });
        
        
        this._productService.getPill(product_id)
        .then((value) {
            // Run extra code here
            utility.Custom_Print("Function Complete Successfully");
            utility.Custom_Print(value.toString());

            setState(() {
                this._isPageLoading = false;
                this._state_id = 2;
                this.mainDisplayState = 2;
                this._product = new Product.fromJson(value);
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

        this.utility.Custom_Print("STOP: _getPill");
    }
}