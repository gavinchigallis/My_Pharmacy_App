import 'package:flutter/material.dart';

class ThemeAttribute{

    Color _primaryColor = Color.fromARGB(255, 172, 241, 255); //hex: #ACF1FF
    Color _secondaryColor = Colors.grey;
    TextStyle _textStyle_1 = TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.normal
    );
    TextStyle _textStyle_2 = TextStyle(
        color: Colors.black,
        fontSize: 36,
        fontWeight: FontWeight.bold
    );

    ThemeAttribute();

    Color get primaryColor{
        return _primaryColor;
    }

    Color get secondaryColor{
        return _secondaryColor;
    }

    //Standard small black text
    TextStyle get textStyle_1{
        return _textStyle_1;
    }

    //Standard Page header Large text
    TextStyle get textStyle_2{
        return _textStyle_2;
    }
}