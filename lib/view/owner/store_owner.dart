import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promo_app/components/rectangle_text_field/rectangle_text_field.dart';
import 'package:promo_app/helpers/data_store.dart';
import 'package:promo_app/httpService/httpService.dart';
import 'package:promo_app/model/store.dart';
import 'package:promo_app/theme/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:path/path.dart' as p;

class StoreOwnerPage extends StatefulWidget {
  const StoreOwnerPage({super.key});

  @override
  State<StoreOwnerPage> createState() => _StoreOwnerPageState();
}

class _StoreOwnerPageState extends State<StoreOwnerPage> {
  String name = '';
  String openHours = '';
  String address = '';
  String contactNo = '';
  String catergory = '';
  String imageUrl =
      'https://promo-deal-bucket.s3.us-east-2.amazonaws.com/upload-to-s3/dp.jpg';
  String baseUrl = 'https://promo-deal-bucket.s3.us-east-2.amazonaws.com/';

  late PickedFile _image;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  String userId = '';
  String storeId = '';

  void getDeals() async {
    ///whatever you want to run on page build
    ///
    userId = await DataStore.shared.getUserId();

    print('userId');
    print(userId);

    HttpService()
        .getInstance()
        .get('/stores/getStoreByOwnerId/$userId')
        .then((value) async {
      print(value);
      Map<String, dynamic> data = jsonDecode(value.data);
      print(data['message']);
      print(data['message']['_id']);
      StoreModel storeModel = StoreModel.fromJson(jsonDecode(value.data));
      print("storeModel.oneMessage");
      print(storeModel.oneMessage);
      // DataStore.shared.setStoreId = storeModel.message.;
      // DataStore.shared.setStoreId = data['message']['_id'];
      // storeId = data['message']['_id'];
      print(storeId);
      setState(() {
        userId = userId;
        storeId = storeModel.oneMessage!.sId!;
        name = storeModel.oneMessage!.name!;
        openHours = storeModel.oneMessage!.openHours!;
        address = storeModel.oneMessage!.address!;
        contactNo = storeModel.oneMessage!.contactNo!;
        catergory = storeModel.oneMessage!.catergory!;
        bool _validURL = Uri.parse(storeModel.oneMessage!.imageUrl!).isAbsolute;
        if (_validURL) {
          imageUrl = storeModel.oneMessage!.imageUrl!;
        }
      });
    }).catchError((err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Cannot Get Store",
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

      HttpService().getInstance().put('/stores/$storeId', data: {
        'imageUrl': '$baseUrl${data['message']}',
      }).then((value) {
        print(value);
        Fluttertoast.showToast(
            msg: "Image Uploaded",
            backgroundColor: Color.fromARGB(255, 46, 125, 50),
            textColor: Colors.white,
            fontSize: 15.0);
        getDeals();
      }).catchError((err) {
        print(err);
        Fluttertoast.showToast(
            msg: "Cannot Update Store",
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
    getDeals();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Store",
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
        body: Scaffold(
          body: SmartRefresher(
            onRefresh: () async {
              // getUserDetails();
              getDeals();
              await Future.delayed(Duration(milliseconds: 1000));
              _refreshController.refreshCompleted();
            },
            controller: _refreshController,
            enablePullDown: true,
            header: WaterDropMaterialHeader(
              backgroundColor: Colors.white,
              color: AppTheme.kPrimaryColor,
            ),
            child: SingleChildScrollView(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(60.0)),
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
                                  labelText: "Store Name",
                                  hintText: "Enter Store Name",
                                  value: name,
                                  onChanged: ((value) {
                                    name = value;
                                  })),
                              RectangleTextField(
                                  labelText: "Open Hours",
                                  hintText: "eg :- 10.00 AM to 8.00 PM",
                                  value: openHours,
                                  onChanged: ((value) {
                                    openHours = value;
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
                                  labelText: "Category",
                                  hintText: "Category",
                                  value: catergory,
                                  onChanged: ((value) {
                                    catergory = value;
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
                                      .put('/stores/${storeId}', data: {
                                    "name": name,
                                    "address": address,
                                    "openHours": openHours,
                                    "contactNo": contactNo,
                                    "imageUrl":
                                        "http://bizenglish.adaderana.lk/wp-content/uploads/f449622a-3dec-4810-8eb9-b00cb2850013_logo-1.jpg",
                                    "catergory": catergory,
                                    "owner": userId
                                  }).then((value) {
                                    print(value);
                                    Fluttertoast.showToast(
                                        msg: "Store Details Updated",
                                        backgroundColor:
                                            Color.fromARGB(255, 46, 125, 50),
                                        textColor: Colors.white,
                                        fontSize: 15.0);
                                    getDeals();
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
        ));
  }
}
