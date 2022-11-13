import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promo_app/components/rectangle_text_field/rectangle_text_field.dart';
import 'package:promo_app/httpService/httpService.dart';
import 'package:promo_app/theme/theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

const List<String> list = <String>['Male', 'Female'];
const List<String> typeList = <String>['ShopOwner', 'Customer'];

class _SignUpState extends State<SignUp> {
  String gender = 'Male';
  String type = 'Customer';
  String firstName = '';
  String lastName = '';
  String address = '';
  String contactNo = '';
  String imageUrl =
      'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
  String password = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    String dropdownValue = gender;
    String dropdownTypeValue = type;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "SignUp",
          textAlign: TextAlign.center,
          style: GoogleFonts.dmSans(
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.normal),
          ),
        ),
        backgroundColor: AppTheme.kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: 107,
                    height: 107,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(60.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10.0, // soften the shadow
                          spreadRadius: 1.0, //extend the shadow
                        )
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppTheme.kPrimaryLightColor,
                          radius: 50,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              height: 100,
                              width: 100,
                              imageUrl:
                                  'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset(
                                'assets/images/dp.jpg',
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/dp.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () async {
                              // await viewModel.showImagePicker(context);
                            },
                            child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.kPrimaryColor,
                                    border: Border.all(
                                        width: 2, color: Colors.white)),
                                child: Center(
                                    child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 15,
                                ))),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          width: size.width,
                          decoration: BoxDecoration(
                            // color: Color.fromARGB(255, 198, 40, 40),
                            // color: _color,
                            border: Border.all(
                              width: 1.5,
                              color: Color.fromARGB(
                                  255, 159, 119, 211), // red as border color
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                borderRadius: BorderRadius.circular(10),
                                value: dropdownTypeValue,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                hint: Text(
                                  "Type",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  // gender = value!;
                                  setState(() {
                                    type = value!;
                                  });
                                },
                                items: typeList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        RectangleTextField(
                            labelText: "First Name",
                            hintText: "Enter First Name",
                            value: firstName,
                            onChanged: ((value) {
                              firstName = value;
                            })),
                        RectangleTextField(
                            labelText: "Last Name",
                            hintText: "Enter Last Name",
                            value: lastName,
                            onChanged: ((value) {
                              lastName = value;
                            })),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          width: size.width,
                          decoration: BoxDecoration(
                            // color: Color.fromARGB(255, 198, 40, 40),
                            // color: _color,
                            border: Border.all(
                              width: 1.5,
                              color: Color.fromARGB(
                                  255, 159, 119, 211), // red as border color
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                borderRadius: BorderRadius.circular(10),
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                hint: Text(
                                  "Gender",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  // gender = value!;
                                  setState(() {
                                    gender = value!;
                                  });
                                },
                                items: list.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        RectangleTextField(
                            labelText: "Password",
                            hintText: "Enter Password",
                            value: address,
                            onChanged: ((value) {
                              address = value;
                            })),
                        RectangleTextField(
                            labelText: "Address",
                            hintText: "Enter Address",
                            value: address,
                            onChanged: ((value) {
                              address = value;
                            })),
                        RectangleTextField(
                            labelText: "Contact No",
                            hintText: "Enter Contact No",
                            value: contactNo,
                            onChanged: ((value) {
                              contactNo = value;
                              ;
                            })),
                        RectangleTextField(
                            labelText: "Email",
                            hintText: "Email",
                            value: email,
                            onChanged: ((value) {
                              email = value;
                            })),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppTheme.kPrimaryColor,
                            onSurface: Colors.red,
                            minimumSize: Size(200, 40),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            HttpService().getInstance().post('/users', data: {
                              "first_name": firstName,
                              "last_name": lastName,
                              "gender": gender,
                              "password": password,
                              "type": type,
                              "address": address,
                              "email": email,
                              "imageUrl": imageUrl,
                              "contactNo": contactNo
                            }).then((value) {
                              print(value);
                              Navigator.pop(context);
                            }).catchError((err) {
                              print(err);
                              Fluttertoast.showToast(
                                  msg: "Cannot Update User",
                                  backgroundColor:
                                      Color.fromARGB(255, 211, 47, 47),
                                  textColor: Colors.white,
                                  fontSize: 15.0);
                            });
                          },
                          child: Text(
                            'Save',
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
