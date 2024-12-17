import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/base/search_page.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:flutter_application_1/widgets/small_text.dart';
import '../../utils/colors.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> searchResults = [];

  void _handleSearch(String searchText) async {
    print('Search Text: $searchText'); // Debugging

    try {
      Navigator.push(
        context,
        MaterialPageRoute(
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height20, bottom: Dimensions.height10),
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(
                        text: "Zambia",
                        color: AppColors.mainColor,
                      ),
                      Row(
                        children: [
                          BigText(
                            text: "Iiyishha",
                            color: AppColors.button3,
                            size: 13,
                          ),
                        ],
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
          const Expanded(
            child: SingleChildScrollView(
              child: FoodPageBody(),
            ),
          )
        ],
      ),
    );
  }
}
