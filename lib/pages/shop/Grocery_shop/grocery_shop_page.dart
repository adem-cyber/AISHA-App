import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/base/search_page.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';

import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_icon.dart';
import 'grocery_shop_body.dart';

class  GroceryShopPage extends StatefulWidget {
  const GroceryShopPage({Key? key, required this.Store}) : super(key: key);
final String Store;
  @override
  State< GroceryShopPage> createState() => _GroceryShopPageState();
}

 
class _GroceryShopPageState extends State< GroceryShopPage> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> searchResults = [];

  

 void _handleSearch(String searchText) async {
  print('Search Text: $searchText'); // Debugging

  try {
   
    Navigator.push(
      context,
      MaterialPageRoute(
     /*    Get.to(
      () => SearchResultsPage(searchResults:_searchController.text)
      );*/
        builder: (context) => SearchResultsPage(searchResults: searchText),
      ),
    );
  } catch (e) {
    print('Error performing search: $e');
  }
}
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(
        children:[
           Container(
          
        child: Container(
          margin:  EdgeInsets.only(top:Dimensions.height30,bottom: Dimensions.height10),
          padding:  EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                 GestureDetector(
                 onTap: () {
                  Get.to(()=>const HomePage());
                    },
                   child: const AppIcon(
                                icon: Icons.arrow_back_ios_new_sharp,
                           backgroundColor: AppColors.mainColor,
                           iconColor: Colors.white,
                                            ),
                                    ),
                  
      
                ],
              ),
              
              Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                    ),
                    child: AnimSearchBar(
                      width: Dimensions.height45 * 5,
                      textController: _searchController,
                      rtl: true,
                      animationDurationInMilli: 374,
                      color: AppColors.mainColor,
                      searchIconColor: Colors.white,
                      boxShadow: true,
                     onSuffixTap: () {
                       
                              
                                  _handleSearch(_searchController.text);
                        
                      },
                      helpText: "Search...",
                      onSubmitted: (String query) {
                         
                        _handleSearch(query);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
  
           Expanded( 
            child: SingleChildScrollView(
           
            child:GroceryShopBody(Store: widget.Store),
            )
           ,)
          
        ],
      ),
    

     );
  }
}



