import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:toast/toast.dart';
import 'package:provider/provider.dart';

import '../Models/ThemeAttribute.dart';
import '../Models/Utility.dart';
import '../Models/Product.dart';
import '../Services/ProductService.dart';

class ProductCardWidget extends StatefulWidget {
  int _state_id=0;
  Product widgetDataObject;

  /*
  * @Description: Constructor
  *
  * @param:
  *
  * @return: void
  */
  ProductCardWidget();

  /*
  * @Description: Constructor
  *
  * @param:
  *
  * @return: void
  */
  ProductCardWidget.withData(Product productObject){
      this._state_id = 2;
      this.widgetDataObject = productObject;
  }

  @override
  State<StatefulWidget> createState() {
      switch(this._state_id)
      {
            case 2:
            {
                return _ProductCardWidget._withData(this._state_id, this.widgetDataObject);
                break;
            }

            default:
            {
                return _ProductCardWidget();
                break;
            }
      }
    }
}

class _ProductCardWidget extends State<ProductCardWidget> {
    /*[Attributes]*/
    int _state_id=0;
    Product widgetDataObject;
    Widget _view = Container();
    ThemeAttribute theme_attribute = ThemeAttribute();
    Utility utility = Utility();
    List<Widget> _productWidgets = [];
    bool _showProducts = false;
    int _contentIndex = 0;
    bool _liked = false;
    bool _isPageLoading = false;


    _ProductCardWidget();

    /*
    * @Description: Constructor
    *
    * @param:
    *
    * @return: void
    */
    _ProductCardWidget._withData(int state_id, Product productObject)
    {
        this._state_id = state_id;
        this.widgetDataObject = productObject;
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
        final double cardWidth = (deviceWidth - 40);
        final double cardHeight = 160;

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
                    height: cardHeight,
                    //padding: EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 0),
                    width: deviceWidth,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      //borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Card(
                        color: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    Container(
                                        width: cardWidth / 2,
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                                Container(
                                                    padding: EdgeInsets.only(left: 10),
                                                    child: Text(this.widgetDataObject.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black)),
                                                ),
                                                SizedBox(
                                                    height: 20,
                                                ),
                                                Row(
                                                    children: [
                                                        SizedBox(
                                                            width: 10,
                                                        ),
                                                        Container(
                                                            child: Row(
                                                                children: [
                                                                    Text("\$", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12.0, color: Colors.black)),
                                                                    Text(this.widgetDataObject.price.toStringAsFixed(2), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black))
                                                                ],
                                                            ),
                                                        ),
                                                        SizedBox(
                                                            width: 40,
                                                        ),
                                                        ButtonTheme(
                                                            minWidth: 30,
                                                            height: 30,
                                                            child: RaisedButton(
                                                                color: this.theme_attribute.primaryColor,
                                                                padding: EdgeInsets.all(5),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                ),
                                                                child: Icon(
                                                                    Icons.add
                                                                ),
                                                                onPressed: (){

                                                                },
                                                            ),
                                                        )
                                                    ],
                                                )
                                            ],
                                        ),
                                    ),
                                    Container(
                                        width: (cardWidth / 2) - 50,
                                        height: 140,
                                        decoration: BoxDecoration(
                                            color: this.theme_attribute.primaryColor,
                                            borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: Stack(
                                            children: [
                                                Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: _likeIcon()
                                                ),
                                                Center(
                                                    child: Image.network(
                                                        this.widgetDataObject.image,
                                                        width: 120,
                                                        height: 120,
                                                    ),
                                                )
                                            ],
                                        )
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

    /*
    * @Description: show liked icon
    *
    * @param:
    *
    * @return: Icon (Widget)
    */
    Icon _likeIcon()
    {
        if(this.widgetDataObject.like){
            return Icon(
                Icons.favorite,
                color: Colors.red,
            );
        }else{
            return Icon(
                Icons.favorite_border,
                color: Colors.white,
            );
        }
    }

}