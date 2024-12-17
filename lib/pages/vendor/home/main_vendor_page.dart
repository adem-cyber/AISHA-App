import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repository/store_repo_vendor.dart';
import 'package:flutter_application_1/pages/vendor/add/edit_items_page.dart';
import 'package:flutter_application_1/pages/vendor/add/store_details.dart';
import 'package:flutter_application_1/pages/vendor/add_items_page.dart';
import 'package:flutter_application_1/pages/vendor/home/store_list.dart';
import 'package:flutter_application_1/pages/vendor/home/store_model_vendor.dart';

import 'package:flutter_application_1/pages/vendor/profile_controller_vendor.dart';
import 'package:flutter_application_1/pages/vendor/user_model_vendor.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:flutter_application_1/widgets/icon_and_text.dart';
import 'package:flutter_application_1/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodShopBodyVendor extends StatefulWidget {
  const FoodShopBodyVendor({super.key});

  @override
  State<FoodShopBodyVendor> createState() => _FoodShopBodyState();
}

class _FoodShopBodyState extends State<FoodShopBodyVendor> {
  final controller = Get.put(StoreRepoVendor());

  SelectedStoreData selectedStoreData = SelectedStoreData(data: {});
  late UserModelVendor userData = UserModelVendor(
    // Initialize with specific data fields
    name: "",

    phone: "",
    vendorid: "",
  );
  Future<void> _refreshData() async {
    setState(() {
      FoodShopBodyVendor();
    });
  }

  Future<void> _fetchUserData() async {
    final controller = Get.find<ProfileControllervendor>();
    final user = await controller.getUserData();
    if (user != null) {
      if (mounted) {
        // Check if the widget is still mounted before calling setState
        setState(() {
          userData = user;
        });
      }
    }
  }

  @override
  void initState() {
    _fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: const BoxDecoration(
          color: AppColors.purple, // Header background color
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
        padding: const EdgeInsets.only(
            top: 70), // Add top padding inside the container
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Stores",
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Header text color
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the "Create Store" page
                      Get.to(
                        () => const AddItemPage(),
                      ); // Adjust this to your route
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.button1,
                      // Button text color
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text(
                      'Create Store',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      //list of food and images
      FutureBuilder<List<StoreModelVendor>>(
        future: controller.getAllStore(userData.vendorid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        bottom: Dimensions.height10,
                        top: Dimensions.height10 / 2,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to StoreList and pass store data
                          Get.to(
                            () => const StoreList(),
                            arguments: {
                              'name': snapshot.data![index].name,
                              'description': snapshot.data![index].description,
                              'location': snapshot.data![index].location,
                              'storeid': snapshot.data![index].storeid,
                              'email': snapshot.data![index].email,
                              'phone': snapshot.data![index].phone,
                              'image': snapshot.data![index].image,
                            },
                          );
                          // SelectedStoreData selectedStoreData = SelectedStoreData(data: Get.arguments);
                        },
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Navigate to StoreList and pass store data
                                Get.to(
                                  () => const StoreList(),
                                  arguments: {
                                    'name': snapshot.data![index].name,
                                    'description':
                                        snapshot.data![index].description,
                                    'location': snapshot.data![index].location,
                                    'storeid': snapshot.data![index].storeid,
                                    'email': snapshot.data![index].email,
                                    'phone': snapshot.data![index].phone,
                                    'image': snapshot.data![index].image,
                                  },
                                );
                                // SelectedStoreData selectedStoreData = SelectedStoreData(data: Get.arguments);
                              },
                              child: Container(
                                width: Dimensions.ListViewImgSize / 1.2,
                                height: Dimensions.ListViewImgSize / 1.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius30),
                                  color: Colors.amber[300],
                                ),
                                child: Image.network(
                                  snapshot.data![index].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            //text container
                            Expanded(
                              child: Container(
                                height: Dimensions.ListViewTextsize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Dimensions.radius30),
                                    bottomRight:
                                        Radius.circular(Dimensions.radius30),
                                  ),
                                  color:
                                      const Color.fromARGB(255, 240, 242, 242),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: Dimensions.width10,
                                    right: Dimensions.width10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                // Navigate to StoreList and pass store data
                                                Get.to(
                                                  () => const StoreList(),
                                                  arguments: {
                                                    'name': snapshot
                                                        .data![index].name,
                                                    'description': snapshot
                                                        .data![index]
                                                        .description,
                                                    'location': snapshot
                                                        .data![index].location,
                                                    'storeid': snapshot
                                                        .data![index].storeid,
                                                    'email': snapshot
                                                        .data![index].email,
                                                    'phone': snapshot
                                                        .data![index].phone,
                                                    'image': snapshot
                                                        .data![index].image,
                                                  },
                                                );
                                                // SelectedStoreData selectedStoreData = SelectedStoreData(data: Get.arguments);
                                              },
                                              child: BigText(
                                                text:
                                                    snapshot.data![index].name,
                                                size: 15,
                                              ),
                                            ),
                                            SizedBox(
                                                width: Dimensions.width10 / 2),
                                            GestureDetector(
                                              onTap: () {
                                                // Show a confirmation SnackBar
                                                final snackBar = SnackBar(
                                                  content: const Text(
                                                      'Do you want to delete this Store?'),
                                                  action: SnackBarAction(
                                                    label: 'Yes',
                                                    onPressed: () {
                                                      controller.deleteStore(
                                                          snapshot
                                                              .data![index].id);

                                                      _refreshData();
                                                      Get.snackbar(
                                                          'Store Deleted',
                                                          'Your Store has been Deleted successfully!');
                                                    },
                                                  ),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0), // Adjust the border radius as needed
                                                  ),
                                                );

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              },
                                              child: const Icon(
                                                Icons.delete_sweep_outlined,
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                          ]),
                                      SamllText(
                                        text: snapshot.data![index].location,
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
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width: Dimensions.width10 / 2),
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(() => EditItemPage(
                                                    name: snapshot
                                                        .data![index].name,
                                                    description: snapshot
                                                        .data![index]
                                                        .description,
                                                    location: snapshot
                                                        .data![index].location,
                                                    id: snapshot
                                                        .data![index].id,
                                                    image: snapshot
                                                        .data![index].image,
                                                    email: snapshot
                                                        .data![index].email,
                                                    phone: snapshot
                                                        .data![index].phone,
                                                    type: snapshot
                                                        .data![index].type,
                                                  ));
                                            },
                                            child: const Icon(
                                              Icons.edit_sharp,
                                              color: Colors.black26,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
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
    ]);
  }
}
