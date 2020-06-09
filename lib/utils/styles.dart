
import 'package:flutter/material.dart';
import 'colors.dart';
import 'utils.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';


/////////////////////////////////
///   TEXT STYLES
////////////////////////////////
TextStyle logoStyle(BuildContext context){
  return TextStyle(
      fontFamily: 'Pacifico',
      fontSize: context.fontScale(30),
      color: Colors.black54,
      letterSpacing: 2);

}

TextStyle headingTxt(int size,BuildContext context,{FontWeight fontWeight,Color color}){
  return TextStyle(
      color: color,
      fontSize: context.fontScale(size),
      // fontWeight: FontWeight.w700,
//      fontFamily: 'Poppins',
      fontWeight: fontWeight

  );

}

TextStyle logoWhiteStyle(BuildContext context){
  return TextStyle(
    fontSize: context.scale(20),
      color: white
  );
}

//const logoStyle = TextStyle(
//    fontFamily: 'Pacifico',
//    fontSize: 30,
//    color: Colors.black54,
//    letterSpacing: 2
//);

//const logoWhiteStyle = TextStyle(
//    fontFamily: 'Pacifico',
//    fontSize: 21,
//    letterSpacing: 2,
//    color: Colors.white);

TextStyle disabledText(BuildContext context,double size){
  return TextStyle(color: Colors.grey,
//      fontFamily: 'Poppins',
      fontSize: context.scale(size));
}

const btnTxt = TextStyle(color: Colors.black87,);
//const disabledText = TextStyle(color: Colors.grey, fontFamily: 'Poppins',fontSize: 16);
const contrastText = TextStyle();
const contrastTextBold = TextStyle(color: primaryColor,  fontWeight: FontWeight.w600);

//const h3 = TextStyle(
//    color: Colors.black,
//    fontSize: 24,
//    fontWeight: FontWeight.w800,
//    fontFamily: 'Poppins');

//const h4 = TextStyle(
//    color: Colors.black,
//    fontSize: 18,
//   // fontWeight: FontWeight.w700,
//    fontFamily: 'Poppins');

    
//const h5 = TextStyle(
//    color: Colors.black,
//    fontSize: 18,
//    fontWeight: FontWeight.w500,
//    fontFamily: 'Poppins');

//    const h6 = TextStyle(
//    color: Colors.black,
//    fontSize: 16,
//    fontWeight: FontWeight.w500,
//    fontFamily: 'Poppins');

//
//const priceText = TextStyle(
//    color: Colors.black,
//    fontSize: 19,
//    //fontWeight: FontWeight.w800,
//    fontFamily: 'Poppins');

//const foodNameText = TextStyle(
//    color: Colors.black,
//    fontSize: 17,
//    fontWeight: FontWeight.w500,
//    fontFamily: 'Poppins');

const tabLinkStyle =
    TextStyle(fontWeight: FontWeight.w500);

const taglineText = TextStyle(color: Colors.black87, fontFamily: 'Poppins');
const categoryText = TextStyle(

    color: Color(0xff444444),
//    fontWeight: FontWeight.w700,
    fontWeight: FontWeight.w500,

    fontFamily: 'Poppins');

const inputFieldTextStyle =
    TextStyle( fontWeight: FontWeight.w500,fontSize: 14);

const inputFieldHintTextStyle =
    TextStyle( color: Colors.grey,fontSize: 14);

const inputFieldPasswordTextStyle = TextStyle(
    fontWeight: FontWeight.w500,fontSize: 14);

const inputFieldHintPaswordTextStyle = TextStyle(
 color: Colors.grey, fontSize: 14);

///////////////////////////////////
/// BOX DECORATION STYLES
//////////////////////////////////

const authPlateDecoration = BoxDecoration(
    color: white,
    boxShadow: [
      BoxShadow(
          color: Color.fromRGBO(0, 0, 0, .1),
          blurRadius: 10,
          spreadRadius: 5,
          offset: Offset(0, 1))
    ],
    borderRadius: BorderRadiusDirectional.only(
        bottomEnd: Radius.circular(20), bottomStart: Radius.circular(20)));

/////////////////////////////////////
/// INPUT FIELD DECORATION STYLES
////////////////////////////////////

const inputFieldFocusedBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6)),
    borderSide: BorderSide(
      color: primaryColor,
    ));

const inputFieldDefaultBorderStyle = OutlineInputBorder(
    gapPadding: 0, borderRadius: BorderRadius.all(Radius.circular(6)));
