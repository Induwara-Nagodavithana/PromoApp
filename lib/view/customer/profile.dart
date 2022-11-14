import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promo_app/components/rectangle_text_field/rectangle_text_field.dart';
import 'package:promo_app/helpers/data_store.dart';
import 'package:promo_app/httpService/httpService.dart';
import 'package:promo_app/model/user.dart';
import 'package:promo_app/theme/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:path/path.dart' as p;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

const List<String> list = <String>['Male', 'Female'];

class _ProfileState extends State<Profile> {
  String firstName = '';
  String lastName = '';
  String gender = 'Male';
  String address = '';
  String contactNo = '';
  String email = '';
  String imageUrl =
      'https://promo-deal-bucket.s3.us-east-2.amazonaws.com/upload-to-s3/dp.jpg';
  String baseUrl = 'https://promo-deal-bucket.s3.us-east-2.amazonaws.com/';

  late String userId;

  late PickedFile _image;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void getUserDetails() async {
    userId = await DataStore.shared.getUserId();

    ///whatever you want to run on page build
    HttpService().getInstance().get('/users/$userId').then((value) {
      print(value);

      UserModel userModel = UserModel.fromJson(jsonDecode(value.data));
      print(userModel);
      setState(() {
        firstName = userModel.message!.firstName!;
        lastName = userModel.message!.lastName!;
        gender =
            "${userModel.message!.gender![0].toUpperCase()}${userModel.message!.gender!.substring(1).toLowerCase()}";
        address = userModel.message!.address!;
        contactNo = userModel.message!.contactNo!;
        email = userModel.message!.email!;
        bool _validURL = Uri.parse(userModel.message!.imageUrl!).isAbsolute;
        if (_validURL) {
          imageUrl = userModel.message!.imageUrl!;
        }
      });
    }).catchError((err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Cannot Get User",
          backgroundColor: Color.fromARGB(255, 211, 47, 47),
          textColor: Colors.white,
          fontSize: 15.0);
    });
    // ....
  }

  Future uploadImages() async {
    print(_image);
    print(_image.path);
    File myImage = File(_image.path);
    String fileExtension = p.extension(myImage.path);
    print("fileExtension");
    print(fileExtension);
    List<int> imageBytes = await _image.readAsBytes();
    print(imageBytes);
    String base64Image = base64Encode(imageBytes);
    print("base64Image");
    print(base64Image);

    HttpService().getInstance().post('/users/uploadUserImage', data: {
      "file": base64Image,
      "type": fileExtension.substring(1)
    }).then((value) {
      Map<String, dynamic> data = jsonDecode(value.data);
      print("data.keys.contains('message')");
      print(data['message']);
      print('$baseUrl${data['message']}');

      HttpService().getInstance().put('/users/$userId', data: {
        'imageUrl': '$baseUrl${data['message']}',
      }).then((value) {
        print(value);
        Fluttertoast.showToast(
            msg: "Image Uploaded",
            backgroundColor: Color.fromARGB(255, 46, 125, 50),
            textColor: Colors.white,
            fontSize: 15.0);
        getUserDetails();
      }).catchError((err) {
        print(err);
        Fluttertoast.showToast(
            msg: "Cannot Update User",
            backgroundColor: Color.fromARGB(255, 211, 47, 47),
            textColor: Colors.white,
            fontSize: 15.0);
      });
    }).catchError((err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Cannot Get User",
          backgroundColor: Color.fromARGB(255, 211, 47, 47),
          textColor: Colors.white,
          fontSize: 15.0);
    });
  }

  Future showImagePicker(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () async {
                        await imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () async {
                      await imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future imgFromCamera() async {
    PickedFile? image3 = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = image3!;
    });
    uploadImages();
  }

  Future imgFromGallery() async {
    PickedFile? image3 = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = image3!;
    });
    uploadImages();
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = gender;
    Size size = MediaQuery.of(context).size;

    return SmartRefresher(
      onRefresh: () async {
        getUserDetails();

        await Future.delayed(Duration(milliseconds: 1000));
        _refreshController.refreshCompleted();
      },
      controller: _refreshController,
      enablePullDown: true,
      header: WaterDropMaterialHeader(
        backgroundColor: Colors.white,
        color: AppTheme.kPrimaryColor,
      ),
      child: Scaffold(
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
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Image.asset(
                                  'assets/images/dp.jpg',
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
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
                                await showImagePicker(context);
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                              HttpService()
                                  .getInstance()
                                  .put('/users/$userId', data: {
                                'firstName': firstName,
                                'lastName': lastName,
                                'gender': gender,
                                'address': address,
                                'contactNo': contactNo,
                                'email': email,
                              }).then((value) {
                                print(value);

                                UserModel userModel =
                                    UserModel.fromJson(jsonDecode(value.data));
                                print(userModel);
                                getUserDetails();
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
      ),
    );
  }
}
