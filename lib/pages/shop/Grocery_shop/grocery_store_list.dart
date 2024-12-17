import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/cart_controller.dart';
import 'package:flutter_application_1/data/repository/products_repo_vendor.dart';
import 'package:flutter_application_1/data/repository/store_repo_vendor.dart';
import 'package:flutter_application_1/pages/cart/cart_page.dart';
import 'package:flutter_application_1/pages/vendor/add/store_details.dart';
import 'package:flutter_application_1/pages/vendor/home/products_model_vendor.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/widgets/app_icon.dart';
import 'package:get/get.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/small_text.dart';
import 'grocery_shop_page.dart';

class GroceryStoreList extends StatefulWidget {
  const GroceryStoreList({Key? key}) : super(key: key);
  @override
  _GroceryStoreList createState() => _GroceryStoreList();
}

class _GroceryStoreList extends State<GroceryStoreList> {
  SelectedStoreData selectedStoreData = SelectedStoreData(data: {});
  final controller = Get.put(ProductsRepoVendor());
  final clear = Get.put(CartController());
  final sender = Get.put(StoreRepoVendor());
  late String name;
  late String description;
  late String location;
  late String storeid;
  late String email;
  late String phone;
  late String image;
  late String vendorid;
  late String type;
  Set<int> product = <int>{};

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
    vendorid = selectedStoreData.getvendorid();
    type = selectedStoreData.getType();
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
        vendorid = productData.vendorid ?? '';
        type = productData.type ?? '';
      });
    } else {
      print('snapshot is empty');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = Get.arguments as Map<String, dynamic>;
    name = arguments['name'] ?? '';
    description = arguments['description'] ?? '';
    location = arguments['location'] ?? '';
    storeid = arguments['storeid'] ?? '';
    email = arguments['email'] ?? '';
    phone = arguments['phone'] ?? '';
    image = arguments['image'] ?? '';
    type = arguments['type'] ?? '';
    vendorid = arguments['vendorid'] ?? '';
    setState(() {
      name = name;
      description = description;
      location = location;
      storeid = storeid;
      email = email;
      phone = phone;
      vendorid = vendorid;
      type = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductsRepoVendor());
    Get.put(CartController());
    final cart = Get.put(CartController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      // GroceryShopPage(Store: selectedStoreData.getType()));
                      Navigator.of(context).pop();
                      cart.clearCart();
                    },
                    child: const AppIcon(icon: Icons.arrow_back_ios_new_sharp)),
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => CartPage(
                        vendorid: selectedStoreData.getvendorid(),
                        name: selectedStoreData.getName(),
                      ),
                    );
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
                            color: AppColors.mainColor,
                          ),
                          child: Obx(
                            () => Text(
                              "${cart.totalQuantity}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                    )),
                child: Center(
                    child: BigText(
                        size: Dimensions.font26,
                        text: selectedStoreData.getName())),
              ),
            ),
            pinned: false,
            backgroundColor: Colors.white,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                selectedStoreData.getImage(),
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                FutureBuilder<List<ProductsModelVendor>>(
                  future: controller
                      .getallGroceryUser(selectedStoreData.getStoreid()),
                  builder: (context, docsnapshot) {
                    if (docsnapshot.connectionState == ConnectionState.done) {
                      if (docsnapshot.hasData) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: docsnapshot.data!.length,
                          itemBuilder: (context, index) {
                            final productItem = docsnapshot.data![index];
                            return GestureDetector(
                              onTap: () {
                                // Get.toNamed(RouteHelper.getfoodDetail(index));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width20,
                                      vertical: Dimensions.height10 / 2,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.width20),
                                            color: Colors.white,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.width10),
                                            child: Image.network(
                                              productItem.image,
                                              fit: BoxFit.cover,
                                              width: 80,
                                              height: 80,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.width10),
                                            //height: Dimensions.ListViewTextsize,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                BigText(
                                                  text: productItem.name,
                                                  size: 16,
                                                ),
                                                SizedBox(height: 5),
                                                SamllText(
                                                  text: productItem.description,
                                                  size: 12,
                                                ),
                                                SizedBox(
                                                    height:
                                                        Dimensions.height10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BigText(
                                                      text:
                                                          " ${productItem.price} Zmk ",
                                                      color: Colors.black,
                                                      size: 17,
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            Dimensions.width20,
                                                        vertical: Dimensions
                                                                .height10 /
                                                            5,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius20),
                                                        color: Colors.white,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              cart.removeItem(
                                                                  productItem);
                                                            },
                                                            child: const Icon(
                                                              Icons.remove,
                                                              color: AppColors
                                                                  .signcolor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: Dimensions
                                                                      .width10 /
                                                                  2),
                                                          Obx(
                                                            () => BigText(
                                                              text:
                                                                  "${cart.getQuantity(productItem)}",
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: Dimensions
                                                                      .width10 /
                                                                  2),
                                                          GestureDetector(
                                                            onTap: () {
                                                              cart.addProduct(
                                                                  productItem);
                                                            },
                                                            child: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.grey[400],
                                    indent: 100,
                                    endIndent: 20,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (docsnapshot.hasError) {
                        return Center(
                            child: Text(docsnapshot.error.toString()));
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
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Obx(() {
        final cart = Get.find<CartController>();

        return Visibility(
          visible: cart.totalQuantity > 0,
          child: FloatingActionButton.extended(
            onPressed: () {
              Get.to(
                () => CartPage(
                  vendorid: selectedStoreData.getvendorid(),
                  name: selectedStoreData.getName(),
                ),
                transition: Transition.fadeIn,
              );
            },
            backgroundColor: Colors.blue,
            icon: Padding(
              padding: const EdgeInsets.only(right: 8.0), // Adjust as needed
              child: Row(
                children: [
                  const Icon(Icons.shopping_cart),
                  Transform.translate(
                    offset: const Offset(-2, -20), // Adjust as needed
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.green,
                      child: Text(
                        "${cart.totalQuantity}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            label: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: const Text(
                "Go to Cart",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 8,
            hoverElevation: 12,
          ),
        );
      }),
    );
  }
}
