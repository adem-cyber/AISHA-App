import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repository/products_repo_vendor.dart';
import 'package:flutter_application_1/data/repository/store_repo_vendor.dart';
import 'package:flutter_application_1/pages/vendor/add/add_product_page.dart';
import 'package:flutter_application_1/pages/vendor/add/edit_product.dart';
import 'package:flutter_application_1/pages/vendor/add/store_details.dart';
import 'package:flutter_application_1/pages/vendor/home/home_page_vendor.dart';
import 'package:flutter_application_1/pages/vendor/home/order_received_vendor.dart';
import 'package:flutter_application_1/pages/vendor/home/products_model_vendor.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/app_icon.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:flutter_application_1/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoreList extends StatefulWidget {
  const StoreList({Key? key}) : super(key: key);

  @override
  _StoreListState createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  SelectedStoreData selectedStoreData = SelectedStoreData(data: {});
  final controller = Get.put(ProductsRepoVendor());
  final sender = Get.put(StoreRepoVendor());
  late String name;
  late String description;
  late String location;
  late String storeid;
  late String email;
  late String phone;
  late String image;
  final _db = FirebaseFirestore.instance;
//  final cart = Get.put(CartController());
  @override
  void initState() {
    super.initState();
    selectedStoreData = SelectedStoreData(data: Get.arguments);
    name = selectedStoreData.getName();
    description = selectedStoreData.getDescription();
    location = selectedStoreData.getLocation();
    storeid = selectedStoreData.getStoreid();
    email = selectedStoreData.getEmail();
    phone = selectedStoreData.getPhone();
    image = selectedStoreData.getImage();
  }

  Future<void> _refreshData() async {
    final storeDataList = await sender.getStore(storeid);
    if (storeDataList.isNotEmpty) {
      final productData = storeDataList.first;

      setState(() {
        name = productData.name ?? '';
        description = productData.description ?? '';
        location = productData.location ?? '';
        storeid = productData.storeid ?? '';
        email = productData.email ?? '';
        phone = productData.phone ?? '';
        image = productData.image ?? '';
      });
    } else {
      print('snapshot is empty');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Extract route arguments
    final arguments = Get.arguments as Map<String, dynamic>;
    name = arguments['name'] ?? ''; // Provide a default value if 'Name' is null
    description = arguments['description'] ?? '';
    location = arguments['location'] ?? '';
    storeid = arguments['storeid'] ?? '';
    email = arguments['email'] ?? '';
    phone = arguments['phone'] ?? '';
    image = arguments['image'] ?? '';
    setState(() {
      name = name;
      description = description;
      location = location;
      storeid = storeid;
      email = email;
      phone = phone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 50,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const HomePagevendor());

                    selectedStoreData.clearStoreData();
                  },
                  child: const AppIcon(icon: Icons.arrow_back_ios_new_sharp),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => OrderReceivedVendor(
                          storeid: selectedStoreData.getStoreid(),
                        ));
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const AppIcon(icon: Icons.shopping_cart_outlined),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.mainColor, // Customize the color
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                ),
                child: Center(
                  child: BigText(
                    size: Dimensions.font26,
                    text: selectedStoreData.getName(),
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.mainColor,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                selectedStoreData
                    .getImage(), // Replace 'image' with the actual field name in storedata
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: FutureBuilder<List<ProductsModelVendor>>(
                    future: controller
                        .getallGrocery(selectedStoreData.getStoreid()),
                    builder: (context, product) {
                      if (product.connectionState == ConnectionState.done) {
                        if (product.hasData) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: product.data!.length,
                            itemBuilder: (context, index) {
                              final productItem = product.data![index];
                              return Container(
                                margin: EdgeInsets.only(
                                  left: Dimensions.width20,
                                  right: Dimensions.width20,
                                  bottom: Dimensions.height10,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: Dimensions.ListViewImgSize / 1.2,
                                      height: Dimensions.ListViewImgSize / 1.2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          Dimensions.width20,
                                        ),
                                        color: Colors.amber[300],
                                      ),
                                      child: Image.network(
                                        product.data![index].image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    //text container
                                    Expanded(
                                      child: Container(
                                        height: Dimensions.ListViewTextsize,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(
                                                Dimensions.radius30),
                                            bottomRight: Radius.circular(
                                                Dimensions.radius30),
                                          ),
                                          color: const Color.fromARGB(
                                              255, 240, 242, 242),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Dimensions.width10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BigText(
                                                      text: product
                                                          .data![index].name,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            Dimensions.width10 /
                                                                2),
                                                    GestureDetector(
                                                      onTap: () {
                                                        // Show a confirmation SnackBar

                                                        final snackBar =
                                                            SnackBar(
                                                          content: const Text(
                                                              'Do you want to delete this item?'),
                                                          action:
                                                              SnackBarAction(
                                                            label: 'Yes',
                                                            onPressed: () {
                                                              // Pass the id (document ID) to the deleteProduct function

                                                              controller
                                                                  .deleteProduct(
                                                                      product
                                                                          .data![
                                                                              index]
                                                                          .id);
                                                              _refreshData();
                                                              Get.snackbar(
                                                                  'Product Deleted',
                                                                  'Your Product has been Deleted successfully!');
                                                            },
                                                          ),
                                                        );

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);
                                                      },
                                                      child: const Icon(
                                                        Icons
                                                            .delete_sweep_outlined,
                                                        color: Colors.redAccent,
                                                      ),
                                                    )
                                                  ]),
                                              SizedBox(
                                                  height: Dimensions.height10),
                                              Row(
                                                children: [
                                                  if (product.data![index]
                                                          .available ==
                                                      "Available")
                                                    BigText(
                                                      text:
                                                          "${product.data![index].available}",
                                                      color: AppColors
                                                          .button1, // Change the color to green for available
                                                      size: 15,
                                                    )
                                                  else
                                                    BigText(
                                                      text:
                                                          "${product.data![index].available}",
                                                      color: AppColors
                                                          .paracolor, // Change the color to red for unavailable
                                                      size: 15,
                                                    ),
                                                  SizedBox(
                                                      width:
                                                          Dimensions.width10 /
                                                              8),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      String availability;
                                                      if (product.data![index]
                                                              .available ==
                                                          "Available") {
                                                        availability =
                                                            "Unavailable";
                                                      } else {
                                                        availability =
                                                            "Available";
                                                      }
                                                      final Map<String, dynamic>
                                                          itemData = {
                                                        'Availability':
                                                            availability
                                                      };

                                                      await _db
                                                          .collection(
                                                              "Products")
                                                          .doc(product
                                                              .data![index].id)
                                                          .update(itemData);
                                                      _refreshData();
                                                    },
                                                    child: Icon(
                                                      product.data![index]
                                                                  .available ==
                                                              "Available"
                                                          ? Icons.check_circle
                                                          : Icons.cancel,
                                                      color: product
                                                                  .data![index]
                                                                  .available ==
                                                              "Available"
                                                          ? Colors.green
                                                          : Colors.purple,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  height: Dimensions.height10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text:
                                                        "\Zmk- ${product.data![index].price} ",
                                                    color: Colors.black,
                                                    size: 15,
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          Dimensions.width10 /
                                                              2),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditProduct(
                                                            storeid:
                                                                selectedStoreData
                                                                    .getStoreid(),
                                                            name: product
                                                                .data![index]
                                                                .name,
                                                            description: product
                                                                .data![index]
                                                                .description,
                                                            price: product
                                                                .data![index]
                                                                .price,
                                                            id: product
                                                                .data![index]
                                                                .id,
                                                            image: product
                                                                .data![index]
                                                                .image,
                                                          ), // Pass storeid as an argument

                                                          // Replace with the actual name of your additems page
                                                        ),
                                                      );
                                                    },
                                                    child: const Icon(
                                                      Icons.edit_sharp,
                                                      color: Colors.black26,
                                                    ),
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
                              );
                            },
                          );
                        } else if (product.hasError) {
                          return Center(child: Text(product.error.toString()));
                        } else {
                          return const Center(
                              child: Text("Something went wrong"));
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the additems page when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductPage(
                  storeid: selectedStoreData
                      .getStoreid()), // Pass storeid as an argument

              // Replace with the actual name of your additems page
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add), // Customize the button color
      ),
    );
  }

  Future<void> _navigateToStoreList() async {
    final storeDataList = await sender.getStore(storeid);
    if (storeDataList.isNotEmpty) {
      final productData = storeDataList.first; // Get the first item

      // Create a map with the desired field names
      final data = {
        'name': productData.name,
        'description': productData.description,
        'location': productData.location,
        'storeid': productData.storeid,
        'email': productData.email,
        'phone': productData.phone,
        'image': productData.image,
      };

      print('Navigating to StoreList with data: $data'); // Debugging

      // Navigate back to the StoreList page and pass data as arguments
      Get.to(() => const StoreList(), arguments: data);
    } else {
      print('snapshot is empty'); // Debugging
    }
  }
}
