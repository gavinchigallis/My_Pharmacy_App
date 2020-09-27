import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Product
{
    /*[Attributes]*/
    int id = 0;
    String name = "";
    int category_id = 0;
    double price = 0;
    bool like = false;
    String details = "";
    String image = "";
    List<dynamic> images = [];

    /*[Constructors]*/
    Product();

    //JSON serialization
    Product.fromJson(Map<String, dynamic> json):
        id = json['id'],
        name = json['name'],
        category_id = json['category_id'],
        price = json['price'],
        like = json['like'],
        details = json['details'],
        image = json['image'],
        images = json['images'];

    Map<String, dynamic> toJson() =>
    {
        'id': id,
        'name': name,
        'category_id': category_id,
        'price': price,
        'like': like,
        'details': details,
        'image': image,
        'images': images
    };

    /*[Methods]*/
    int get getID{
        return this.id;
    }

}