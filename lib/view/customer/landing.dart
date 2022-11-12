import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:promo_app/helpers/data_store.dart';
import 'package:promo_app/main.dart';
import 'package:promo_app/theme/theme.dart';
import 'package:promo_app/view/customer/account.dart';
import 'package:promo_app/view/customer/deal.dart';
import 'package:promo_app/view/customer/notification.dart';
import 'package:promo_app/view/customer/stores.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      print(notification);
      print(message);
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        DataStore.shared.setOneNotification = {
          'title': message.notification!.title,
          'time': message.sentTime.toString(),
          'body': message.notification!.body
        };
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: '@mipmap/launcher_icon',
                // other properties...
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new onMessageOpenedApp event was published');
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      print(notification.title);
      print(message);
      print('message');
      print('body');
      print(notification.body);
      print(message.notification!.body);
      print('message');
      print('mesage');
      print('message');
      print('message');
      print('message');
      if (notification != null && android != null) {
        print(notification);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return NotificationPage();
              // return LandingDrawerView();
            },
          ),
        );
        // _navigationService.navigateToView(NotificationView(message:message));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}

List<Widget> _buildScreens() {
  return [
    DealPage(),
    StoresPage(),
    AccountPage(),
    NotificationPage(),
    // SettingsScreen()
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: FaIcon(FontAwesomeIcons.ticket),
      iconSize: 20,
      title: ("Deals"),
      textStyle: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Colors.black, fontSize: 10.0, fontWeight: FontWeight.bold),
      ),
      activeColorPrimary: AppTheme.kPrimaryColor,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: FaIcon(FontAwesomeIcons.store),
      iconSize: 20,
      title: ("Stores"),
      textStyle: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Colors.black, fontSize: 10.0, fontWeight: FontWeight.bold),
      ),
      activeColorPrimary: AppTheme.kPrimaryColor,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: FaIcon(FontAwesomeIcons.circleUser),
      iconSize: 20,
      title: ("Account"),
      textStyle: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Colors.black, fontSize: 10.0, fontWeight: FontWeight.bold),
      ),
      activeColorPrimary: AppTheme.kPrimaryColor,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: FaIcon(FontAwesomeIcons.bell),
      iconSize: 20,
      title: ("Notification"),
      textStyle: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Colors.black, fontSize: 10.0, fontWeight: FontWeight.bold),
      ),
      activeColorPrimary: AppTheme.kPrimaryColor,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    // PersistentBottomNavBarItem(
    //   icon: Icon(CupertinoIcons.settings),
    //   title: ("Settings"),
    //   activeColorPrimary: CupertinoColors.activeBlue,
    //   inactiveColorPrimary: CupertinoColors.systemGrey,
    // ),
  ];
}
