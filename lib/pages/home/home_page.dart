import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/pages/cart/order_history.dart';
import 'package:flutter_application_1/pages/home/main_food_page.dart';
import 'package:flutter_application_1/pages/home/add_product_page.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../account/profile/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PersistentTabController _controller;
  String userPhone = ''; 

  List pages = [
    const MainFoodPage(),
    
     OrderHistoryPage(userPhone: ''), // Pass the initial value
    const AccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);

    // Fetch the current user's phone number from Firebase Authentication
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      userPhone = currentUser.phoneNumber ?? '';
    }

    // Update the OrderHistoryPage with the user's phone number
    pages[2] = OrderHistoryPage(userPhone: userPhone);
  }

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _buildScreens() {
    return [
      const MainFoodPage(),
      
      OrderHistoryPage(userPhone: userPhone), // Use the updated userPhone
      const AccountPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.button3 ,
        inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
        
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.archivebox),
        title: ("History"),
        activeColorPrimary: AppColors.button3,
        inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      ),
      
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_alt_circle),
        title: ("User"),
        activeColorPrimary:  AppColors.button3,
        inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: AppColors.mainColor,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0.0),
        colorBehindNavBar: AppColors.mainColor,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style19,
      
    );
  }
}
    