
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/pages/cart/cart_page.dart';
import 'package:flutter_application_1/pages/home/main_food_page.dart';
import 'package:flutter_application_1/pages/home/add_items_page.dart';

import 'package:flutter_application_1/utils/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../account/profile/profile_page.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex=0;
late PersistentTabController _controller;




  List pages=[
   const MainFoodPage(),
   //Container(child: const Center(child: Text("Next page"))),
    Container(child: const Center(child: Text("Next page"))),
   CartPage(),
   // Container(child: const Center(child: Text("Next page"))),
   //NoDataPage(),
   const AccountPage(),
  


  ];
  void onTapNav(int index){
    setState(() {
       _selectedIndex=index;
    });
   
  }
 
List<Widget> _buildScreens() {
    return [
   const MainFoodPage(),
  //Container(child: const Center(child: Text("Next page"))),
  Container(child: const Center(child: Text("Next page"))),
  const AddItemPage(),
  //Container(child: const Center(child: Text("Next page"),)),
   // CartHistory(),
     const AccountPage(),
  
        ];
    }
    List<PersistentBottomNavBarItem> _navBarsItems() {
        return [
            PersistentBottomNavBarItem(
                icon: const Icon(CupertinoIcons.home),
                title: ("Home"),
                activeColorPrimary: const Color.fromARGB(255, 213, 134, 134),
                inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
            ),
            PersistentBottomNavBarItem(
                icon: const Icon(CupertinoIcons.archivebox),
                title: ("Hstory"),
                activeColorPrimary: const Color.fromARGB(159, 121, 32, 255),
                inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
            ),
             PersistentBottomNavBarItem(
                icon: const Icon(CupertinoIcons.cart_fill),
                title: ("Cart"),
                activeColorPrimary: CupertinoColors.activeGreen,
                inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
            ),
            PersistentBottomNavBarItem(
                icon: const Icon(CupertinoIcons.person_alt_circle),
                title: ("User"),
                activeColorPrimary: const Color.fromARGB(255, 255, 245, 56),
                inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
            ),
        ];
    }


@override
void initState(){
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
        backgroundColor: AppColors.mainColor, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0.0),
        colorBehindNavBar:AppColors.mainColor,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style19, // Choose the nav bar style with this property.
    );
  }

}

