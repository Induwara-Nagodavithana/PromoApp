import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:promo_app/components/rounded_input_field/rounded_input_field_widget.dart';
import 'package:promo_app/components/rounded_password_field/rounded_password_field_widget.dart';
import 'package:promo_app/helpers/data_store.dart';
import 'package:promo_app/httpService/httpService.dart';
import 'package:promo_app/model/store.dart';
import 'package:promo_app/model/subscription.dart' as SubModel;
import 'package:promo_app/model/user.dart';
import 'package:promo_app/theme/theme.dart';
import 'package:promo_app/view/customer/landing.dart';
import 'package:promo_app/view/owner/landing_owner.dart';
import 'package:promo_app/view/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // String email = 'Nimal@gmail.com';
  String email = 'n@gmail.com';
  String password = '1234';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width * 0.4,
            ),
          ),
          Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      'Sign In',
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    // Image(image: AssetImage('assets/icons/LoginIcon1.png'), width: 200,),
                    Lottie.asset('assets/images/50124-user-profile.json',
                        height: 280),
                    // Lottie.asset('assets/images/smartwatch.json'),
                    // Image.asset(
                    //   'assets/images/fitness.gif',
                    //   height: 500,
                    //   // width: 900,
                    // ),
                    // SvgPicture.asset(
                    //   "assets/icons/login.svg",
                    //   height: size.height * 0.35,
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    RoundedTextField(
                      hintText: "Email",
                      icon: Icons.email_rounded,
                      onChanged: (value) {
                        // viewModel.setEmail = value;
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    RoundedPasswordField(
                      onChanged: (value) {
                        // viewModel.setPassword = value;
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppTheme.kPrimaryColor,
                        onSurface: Colors.red,
                        minimumSize: Size(200, 40),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                      ),
                      onPressed: () async {
                        // viewModel.login();
                        print('{email: $email,password: $password}');
                        // await FirebaseMessaging.instance
                        //     .subscribeToTopic('Customer');
                        HttpService().getInstance().post('/users/verifyUser',
                            data: {
                              'email': email,
                              'password': password
                            }).then((value) {
                          print(value);

                          UserModel userModel =
                              UserModel.fromJson(jsonDecode(value.data));
                          print(userModel);
                          DataStore.shared.setUserId = userModel.message!.sId!;
                          DataStore.shared.setUserName =
                              userModel.message!.firstName!;
                          if (userModel.message!.type == 'ShopOwner') {
                            

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LandingOwnerPage();
                                  // return LandingDrawerView();
                                },
                              ),
                            );
                          } else {
                            HttpService()
                                .getInstance()
                                .get(
                                    '/subscriptions/getSubscriptionsByUser/${userModel.message!.sId!}')
                                .then((value) async {
                              print(value);
                              SubModel.SubscriptionModel subscriptionModel =
                                  SubModel.SubscriptionModel.fromJson(
                                      jsonDecode(value.data));
                              print(subscriptionModel.message);
                              for (SubModel.Message element
                                  in subscriptionModel.message!) {
                                await FirebaseMessaging.instance
                                    .subscribeToTopic(element.store!.sId!);
                              }
                            }).catchError((err) {
                              print(err);
                              Fluttertoast.showToast(
                                  msg: "Cannot Get Subscription",
                                  backgroundColor:
                                      Color.fromARGB(255, 211, 47, 47),
                                  textColor: Colors.white,
                                  fontSize: 15.0);
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LandingPage();
                                  // return LandingDrawerView();
                                },
                              ),
                            );
                          }
                        }).catchError((err) {
                          print(err);
                          Fluttertoast.showToast(
                              msg: "Cannot Verify User",
                              backgroundColor: Color.fromARGB(255, 211, 47, 47),
                              textColor: Colors.white,
                              fontSize: 15.0);
                        });
                      },
                      child: Text(
                        'Login',
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return ResetPasswordView();
                        //     },
                        //   ),
                        // );
                      },
                      child: Text(
                        "Forget Password",
                        style: TextStyle(
                            color: AppTheme.kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    // RoundedButton(
                    //   text: "LOGIN",
                    //   press: () {
                    //   setState(() {
                    //     loading = true;
                    //   });
                    //   AuthService()
                    //       .login(nic, password)
                    //       .then((val) async {
                    //     setState(() {
                    //       loading = false;
                    //     });
                    //     if (val != null && val.data['id'] != true) {
                    //       Fluttertoast.showToast(
                    //           msg: 'Authenticated',
                    //           toastLength: Toast.LENGTH_SHORT,
                    //           gravity: ToastGravity.BOTTOM,
                    //           timeInSecForIosWeb: 1,
                    //           backgroundColor: Colors.green,
                    //           textColor: Colors.white,
                    //           fontSize: 16.0);
                    //       userId = val.data['id'];
                    //       token = val.data['token'];
                    //       print("token = " + token);
                    //       await updateSharedPreferences(userId,
                    //           val.data['token'], val.data['lastname']);

                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) {
                    //             return LandingBackground(
                    //               pageIndex1: 1,
                    //             );
                    //           },
                    //         ),
                    //       );
                    //     } else {
                    //       Fluttertoast.showToast(
                    //           msg: 'Not Authenticated',
                    //           toastLength: Toast.LENGTH_SHORT,
                    //           gravity: ToastGravity.BOTTOM,
                    //           timeInSecForIosWeb: 1,
                    //           backgroundColor: Colors.red,
                    //           textColor: Colors.white,
                    //           fontSize: 16.0);
                    //     }
                    //   });
                    //   print("button pushed");
                    //   print(nic);
                    //   print(password);
                    //   },
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Or',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an account ? ",
                          style: TextStyle(color: AppTheme.kPrimaryColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SignUp();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up ",
                            style: TextStyle(
                                color: AppTheme.kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
