import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Hotel
{
    /*[Attributes]*/
    int id = 0;
    String name = "";
    int category_id = 0;
    double price = 0;
    Map location;
    int space = 0;
    double review = 0;
    String image = "";
    dynamic user;
    List<dynamic> images = [];

    /*[Constructors]*/
    Hotel();

    //JSON serialization
    Hotel.fromJson(Map<String, dynamic> json):
        id = json['id'],
        name = json['name'],
        category_id = json['category_id'],
        price = json['price'],
        location = json['location'],
        space = json['space'],
        review = json['review'],
        image = json['image'],
        user = json['user'],
        images = json['images'];

    Map<String, dynamic> toJson() =>
    {
        'id': id,
        'name': name,
        'category_id': category_id,
        'price': price,
        'location': location,
        'space': space,
        'review': review,
        'image': image,
        'user': user,
        'images': images
    };

    /*[Methods]*/
    int get getID{
        return this.id;
    }

}