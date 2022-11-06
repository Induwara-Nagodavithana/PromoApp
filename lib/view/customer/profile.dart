import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promo_app/components/rectangle_text_field/rectangle_text_field.dart';
import 'package:promo_app/theme/theme.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String firstName = '';
  @override
  Widget build(BuildContext context) {
    return Container(
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
                              'https://static.wikia.nocookie.net/tacobell/images/1/18/Pizza_Hut_logo.svg.png/revision/latest?cb=20161212011454',
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
                                border:
                                    Border.all(width: 2, color: Colors.white)),
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
                          setState(() {
                            firstName = value;
                          });
                        })),
                    RectangleTextField(
                        labelText: "Last Name",
                        hintText: "Enter Last Name",
                        value: firstName,
                        onChanged: ((value) {
                          setState(() {
                            firstName = value;
                          });
                        })),
                    RectangleTextField(
                        labelText: "Gender",
                        hintText: "Enter Gender",
                        value: firstName,
                        onChanged: ((value) {
                          setState(() {
                            firstName = value;
                          });
                        })),
                    RectangleTextField(
                        labelText: "Address",
                        hintText: "Enter Address",
                        value: firstName,
                        onChanged: ((value) {
                          setState(() {
                            firstName = value;
                          });
                        })),
                    RectangleTextField(
                        labelText: "Contact No",
                        hintText: "Enter Contact No",
                        value: firstName,
                        onChanged: ((value) {
                          setState(() {
                            firstName = value;
                          });
                        })),
                    RectangleTextField(
                        labelText: "Email",
                        hintText: "Email",
                        value: firstName,
                        onChanged: ((value) {
                          setState(() {
                            firstName = value;
                          });
                        })),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
