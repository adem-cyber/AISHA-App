import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repository/store_repo_vendor.dart';
import 'package:flutter_application_1/pages/shop/Grocery_shop/grocery_shop_page.dart';
import 'package:flutter_application_1/pages/shop/Grocery_shop/grocery_store_list.dart';
import 'package:flutter_application_1/pages/vendor/home/store_model_vendor.dart';

import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:flutter_application_1/widgets/icon_and_text.dart';
import 'package:flutter_application_1/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../widgets/category_icon.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);
final String Grocery="Grocery";
final String Restaurant="Restaurant";
final String Tech="Tech";
final String Pharmaceutical="Pharmaceutical";
  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var currPageValue = 0.0;
  double scaleFactor = 0.8;
  double height = Dimensions.PageViewContainer;

  final controller = Get.put(StoreRepoVendor());

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose(); // Call the superclass dispose method
    pageController.dispose();
  }
  final List<String> imageUrls = [
    'assets/images/veg.1.jpg',
    'assets/images/food.png',
    'assets/images/phone.jpeg',
    'assets/images/food3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [  CarouselSlider.builder(
            itemCount: imageUrls.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Container(
                margin: const EdgeInsets.only(
                  left: 5,
                  right: 15,
                  bottom: 10,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageUrls[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200, // Adjust the height as needed
                  ),
                ),
              );
            },
            options: CarouselOptions(
              // Adjust carousel options as needed
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.85,
              aspectRatio: 16 / 9,
            ),
          ),
     // Category Icons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() =>  GroceryShopPage(Store: widget.Restaurant));
                  },
                  child: const CategoryIcon(
                      icon: Icons.restaurant, text: 'Restaurant'),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() =>  GroceryShopPage(Store: widget.Grocery));
                  },
                  child: const CategoryIcon(
                      icon: Icons.local_grocery_store, text: 'Grocery'),
                ),
                
                GestureDetector(
                  onTap: () {
                    Get.to(() =>  GroceryShopPage(Store: widget.Tech));
                  },
                  child: const CategoryIcon(
                      icon: Icons.local_grocery_store, text: 'Tech'),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() =>  GroceryShopPage(Store: widget.Pharmaceutical));
                  },
                  child: const CategoryIcon(
                      icon: Icons.medical_services, text: 'Pharmaceutical'),
             ) ,]
                ),
          ),
                
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                BigText(text: "Popular"),
                const SizedBox(width: 10),
                const Text(".", style: TextStyle(color: Colors.black26)),
                const SizedBox(width: 10),
                SamllText(text: "Popular Item"),
              ],
            ),
          ),

          // List of Food and Images
           FutureBuilder<List<StoreModelVendor>>(
          future: controller.getAllStoreuser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to StoreList and pass store data
                        Get.to(
                          () => const GroceryStoreList(),
                          arguments: {
                            'name': snapshot.data![index].name,
                            'description': snapshot.data![index].description,
                            'location': snapshot.data![index].location,
                            'storeid': snapshot.data![index].storeid,
                            'email': snapshot.data![index].email,
                            'phone': snapshot.data![index].phone,
                            'image':snapshot.data![index].image,
                            'type':snapshot.data![index].type,
                          },
                    
                        );
                       // SelectedStoreData selectedStoreData = SelectedStoreData(data: Get.arguments);
                    
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                          bottom: Dimensions.height10,
                        ),
                        child: Row(
                          children: [
                            
                              Container(
                                width: Dimensions.ListViewImgSize/1.3,
                                height: Dimensions.ListViewImgSize/1.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.width10),
                                  color: Colors.amber[300],
                                ),
                                child: Image.network(
                                  snapshot.data![index].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            
                            //text container
                            Expanded(
                              child: Container(
                                height: Dimensions.ListViewTextsize/1.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(Dimensions.radius30/1.5),
                                    bottomRight: Radius.circular(Dimensions.radius30/1.5),
                                  ),
                                  color: const Color.fromARGB(255, 240, 242, 242),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: Dimensions.width10,
                                    right: Dimensions.width10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                        text: snapshot.data![index].name,
                                        size: 17,
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      
                                      Row(
                                        children: [
                                          Wrap(
                                            children: List.generate(
                                              5,
                                              (index) => const Icon(
                                                Icons.star,
                                                color: AppColors.yellowcolor,
                                                size: 10,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Dimensions.height10,
                                          ),
                                          SamllText(text: "4.5"),
                                          SizedBox(
                                            width: Dimensions.height10,
                                          ),
                                          SamllText(text: '1287'),
                                          SizedBox(
                                            width: Dimensions.height10,
                                          ),
                                          SamllText(text: "comments"),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                        
                                          IconAndTextWidget(
                                            icon: Icons.location_on,
                                            text: snapshot.data![index].location,
                                            iconColor: AppColors.mainColor,
                                            
                                          ),
                                          
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return const Center(child: Text("Something went wrong"));
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ]
      
    
        
        )
        );}} 