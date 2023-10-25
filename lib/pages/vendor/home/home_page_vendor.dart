import 'package:flutter/cupertino.dart';

import 'package:flutter_application_1/pages/cart/order_received_page.dart';

import 'package:flutter_application_1/pages/vendor/add_items_page.dart';

import 'package:flutter_application_1/pages/vendor/home/main_vendor_body.dart';

import 'package:flutter_application_1/pages/vendor/profile/account_page_vendor.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePagevendor extends StatefulWidget {
  const HomePagevendor({super.key});

  @override
  State<HomePagevendor> createState() => _HomePageState();
}

class _HomePageState extends State<HomePagevendor> {
  int _selectedIndex = 1;
  late PersistentTabController _controller;

  List pages = [
   
    const MainVendorBody(),
     
    const OrderReceivedPage(),
    const AccountPagevendor(),
  ];
  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
      HomePagevendor();
    });
  }

  List<Widget> _buildScreens() {
    return [
     
      const MainVendorBody(),
      
      const OrderReceivedPage(),
      const AccountPagevendor(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.plus_circle),
        title: ("Home"),
        activeColorPrimary:  AppColors.button3,
        inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      ),
      
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.archivebox),
        title: ("Cart"),
        activeColorPrimary: AppColors.button3,
        inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_alt_circle),
        title: ("User"),
        activeColorPrimary: AppColors.button3,
        inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: AppColors.purple, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0.0),
        colorBehindNavBar: AppColors.mainColor,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style19, // Choose the nav bar style with this property.
    );
  }
}
