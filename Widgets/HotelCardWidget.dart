import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:toast/toast.dart';
import 'package:provider/provider.dart';

import '../Models/ThemeAttribute.dart';
import '../Models/Utility.dart';
import '../Models/Hotel.dart';
import '../Services/HotelService.dart';

class HotelCardWidget extends StatefulWidget {
  int _state_id=0;
  Hotel widgetDataObject;

  /*
  * @Description: Constructor
  *
  * @param:
  *
  * @return: void
  */
  HotelCardWidget();

  /*
  * @Description: Constructor
  *
  * @param:
  *
  * @return: void
  */
  HotelCardWidget.withData(Hotel hotelObject){
      this._state_id = 2;
      this.widgetDataObject = hotelObject;
  }

  @override
  State<StatefulWidget> createState() {
      switch(this._state_id)
      {
            case 2:
            {
                return _HotelCardWidget._withData(this._state_id, this.widgetDataObject);
                break;
            }

            default:
            {
                return _HotelCardWidget();
                break;
            }
      }
    }
}

class _HotelCardWidget extends State<HotelCardWidget> {
    /*[Attributes]*/
    int _state_id=0;
    Hotel widgetDataObject;
    Widget _view = Container();
    ThemeAttribute theme_attribute = ThemeAttribute();
    Utility utility = Utility();
    List<Widget> _productWidgets = [];
    bool _showProducts = false;
    int _contentIndex = 0;
    bool _liked = false;
    bool _isPageLoading = false;


    _HotelCardWidget();

    /*
    * @Description: Constructor
    *
    * @param:
    *
    * @return: void
    */
    _HotelCardWidget._withData(int state_id, Hotel hotelObject)
    {
        this._state_id = state_id;
        this.widgetDataObject = hotelObject;
    }


    /*[Live Cycle]*/

    @override
    void initState(){
        super.initState();

        //this._buildProductWidgetList(this.widgetDataObject.products);
    }
    

    @override
    Widget build(BuildContext context) {
        final double deviceHeight = MediaQuery.of(context).size.height;
        final double deviceWidth = MediaQuery.of(context).size.width;

        //Set view
        switch(this._state_id)
        {
            case 0:
            {
                this._view = Container();
                break;
            }

            case 1:
            {
                break;
            }

            case 2:
            {
                this._view = Container(
                    //color: Colors.blue,
                    height: 250,
                    //padding: EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 0),
                    width: deviceWidth,
                    decoration: BoxDecoration(
                      //color: Colors.redAccent,
                      //borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                            child: Stack(
                                children: <Widget>[
                                    Image.network(
                                        this.widgetDataObject.image,
                                        width: deviceWidth,
                                        fit: BoxFit.fill
                                    ),
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            Container(
                                                padding: EdgeInsets.only(top: 0, bottom: 5, left: 10, right: 10),
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                        Container(
                                                            child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: <Widget>[
                                                                    Text(this.widgetDataObject.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white)),
                                                                    Row(
                                                                        children: <Widget>[
                                                                            Container(
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
                                                                                        Text(this.widgetDataObject.location["city"], style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.white)),
                                                                                    ],
                                                                                )
                                                                            ),
                                                                            SizedBox(
                                                                                width: 20,
                                                                            ),
                                                                            Container(
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
                                                                                        Text(this.utility.numberFormatter(this.widgetDataObject.space)+" sq/m", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.white)),
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
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: <Widget>[
                                                                    Text(this.utility.currencyFormatter(this.widgetDataObject.price), style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0, color: Colors.white)),
                                                                    Row(
                                                                        children: <Widget>[
                                                                            Container(
                                                                                child: Row(
                                                                                    children: <Widget>[
                                                                                        Icon(
                                                                                            Icons.grade,
                                                                                            color: Colors.yellowAccent[700],
                                                                                            size: 14,
                                                                                        ),
                                                                                        SizedBox(
                                                                                            width: 5,
                                                                                        ),
                                                                                        Text(this.widgetDataObject.review.toString()+" Reviews", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.white)),
                                                                                    ],
                                                                                )
                                                                            ),
                                                                        ],
                                                                    )
                                                                ],
                                                            )
                                                        )
                                                    ],
                                                ),
                                            )
                                        ],
                                    )
                                ],
                            ),
                        )
                    ),
                );
                break;
            }

            default:
            {
                break;
            }
        }

        return this._view;
    }


    /*[Methods]*/

}