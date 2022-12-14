import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:promo_app/theme/theme.dart';
import 'package:promo_app/view/customer/account.dart';
import 'package:promo_app/view/customer/deal.dart';
import 'package:promo_app/view/customer/notification.dart';
import 'package:promo_app/view/customer/stores.dart';
import 'package:promo_app/view/owner/deals_owner.dart';
import 'package:promo_app/view/owner/home.dart';
import 'package:promo_app/view/owner/profile_owner.dart';
import 'package:promo_app/view/owner/store_owner.dart';

class LandingOwnerPage extends StatelessWidget {
  const LandingOwnerPage({super.key});

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
    HomePage(),
    DealOwnerPage(),
    // StoresPage(),
    ProfileOwnerPage(),
    StoreOwnerPage(),
    // SettingsScreen()
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: FaIcon(FontAwesomeIcons.house),
      iconSize: 20,
      title: ("Home"),
      textStyle: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Colors.black, fontSize: 10.0, fontWeight: FontWeight.bold),
      ),
      activeColorPrimary: AppTheme.kPrimaryColor,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: FaIcon(FontAwesomeIcons.ticket),
      iconSize: 20,
      title: ("Deal"),
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
      title: ("Profile"),
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
      title: ("Store"),
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
