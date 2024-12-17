import 'package:flutter/cupertino.dart';

import 'package:flutter_application_1/pages/cart/order_received_page.dart';

import 'package:flutter_application_1/pages/vendor/add_items_page.dart';

import 'package:flutter_application_1/pages/vendor/home/main_vendor_body.dart';

import 'package:flutter_application_1/pages/vendor/profile/account_page_vendor.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

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
        activeColorPrimary: AppColors.button1,
        inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.archivebox),
        title: ("Cart"),
        activeColorPrimary: AppColors.button1,
        inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_alt_circle),
        title: ("User"),
        activeColorPrimary: AppColors.button1,
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
      backgroundColor: AppColors.mainColor, // Nav bar background color
      stateManagement: true,
      resizeToAvoidBottomInset: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0.0),
        colorBehindNavBar: AppColors.mainColor,
      ),
      navBarStyle: NavBarStyle.style19, // Choose your preferred style
    );
  }
}
