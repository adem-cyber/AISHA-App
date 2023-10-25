import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/cart_controller.dart';
import 'package:flutter_application_1/data/repository/products_repo_vendor.dart';
import 'package:flutter_application_1/data/repository/store_repo_vendor.dart';
//import 'package:flutter_application_1/model/products_model.dart';
//import 'package:flutter_application_1/model/products_model.dart';
import 'package:flutter_application_1/pages/cart/cart_page.dart';
import 'package:flutter_application_1/pages/vendor/add/store_details.dart';
import 'package:flutter_application_1/pages/vendor/home/products_model_vendor.dart';



import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/widgets/app_icon.dart';
import 'package:get/get.dart';


//import '../../../data/repository/products_repo.dart';
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
  final sender =Get.put(StoreRepoVendor());
 late String name;
  late String description;
  late String location;
  late String storeid;
  late String email;
  late String phone;
  late String image;
  late String vendorid;
  late String type;
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
  vendorid = selectedStoreData.getvendorid();
  type=selectedStoreData.getType();
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
       vendorid=productData.vendorid??'';
        type=productData.type??'';
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
image = arguments['image']??'';
type=arguments['type']??'';
vendorid=arguments['vendorid']??'';
   setState(() {
    name = name;
    description = description;
    location = location;
    storeid = storeid;
    email = email;
    phone = phone;
    type=type;
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
            title:  Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                 GestureDetector(
                    onTap: () {
                   Get.to(() =>  GroceryShopPage(Store: selectedStoreData.getType()));
                   cart.clearCart();
                    },
                    child: const AppIcon(icon: Icons.arrow_back_ios_new_sharp)),
                 GestureDetector(
                    onTap: () {
                      Get.to(()=> CartPage(vendorid: selectedStoreData.getvendorid(),name:selectedStoreData.getName(),),);
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
                          child: Obx(() => Text(
                                "${cart.totalQuantity}", // Use totalQuantity from CartController
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12, // Customize the font size
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),),

              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Container(
                
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 5,bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),

                  )
                ),
                child: Center(
                  child: BigText(
                    size:Dimensions.font26
                  , text: selectedStoreData.getName()) ),
              ),
               ),
            pinned: true,
            backgroundColor:AppColors.yellowcolor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
             background: Image.network(
   selectedStoreData.getImage(), // Replace 'image' with the actual field name in storedata
    width: double.maxFinite,
    fit: BoxFit.cover,
  ),

             ),
          ),
           SliverToBoxAdapter(
            
            child: Column(
              children: [
                Container(
                   child:   FutureBuilder<List<ProductsModelVendor>>(
            future: controller.getallGroceryUser(selectedStoreData.getStoreid()),
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
                                   //Get.toNamed(RouteHelper.getfoodDetail(index),);
                           },
                           child: Container(
                             margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom:  Dimensions.height10),
                             child: Row(
                               children: [
                                 Container(
                                   width: Dimensions.ListViewImgSize,
                                   height: Dimensions.ListViewImgSize,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(Dimensions.width20),
                                     color: Colors.amber[300],),
                                     child: Image.network(
                                  docsnapshot.data![index].image,
                                  fit: BoxFit.cover,
                                ),
                                   
                                   
                      ),
                      //text container
                      Expanded(
                        child: Container(
                        height: Dimensions.ListViewTextsize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight :Radius.circular( Dimensions.radius30),
                            bottomRight: Radius.circular( Dimensions.radius30),
                          ),
                          color: const Color.fromARGB(26, 179, 173, 173),
                        ),
                        child: Padding(
                          padding:EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BigText(text: docsnapshot.data![index].name,size:16,),
                              SizedBox(height: Dimensions.height10,),
                              SamllText(text: docsnapshot.data![index].description),
                              SizedBox(height: Dimensions.height10,),
                         
                               Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      BigText(text: " Zmk ${docsnapshot.data![index].price} ", color: Colors.redAccent,size: 17, ),
                                      Container(
                      padding: EdgeInsets.only(top:Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width10,right: Dimensions.width10, ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white,
                                   
                       ),
                       child: Row(
                        children: [
                           GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                cart.getQuantity(productItem);
                                                              });
                                                                  cart.removeItem(
                                                                     productItem);     
                                                                },
                                                                
                                                                child: const Icon(
                                                                  Icons.remove,
                                                                  color: AppColors
                                                                      .signcolor,
                                                                ),
                                                              ),
                                                              SizedBox(width: Dimensions
                                                                        .width10 /
                                                                    2,
                                                              ),
                                                              Obx( 
                                                                () => BigText(
                                                                  text:
                                                                      "${cart.getQuantity(productItem)}",
                                                                    
                                                                ),
                                                                
                                                              ),
                                                              SizedBox(
                                                                width: Dimensions
                                                                        .width10 /
                                                                    2,
                                                              ),
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    setState(() {
                                                                cart.getQuantity(productItem);
                                                              });
                                                                    cart.addProduct(
                                                                        productItem);

                                                                  },
                                                                  child: const Icon(
                                                                    Icons.add,
                                                                    color: AppColors
                                                                        .signcolor,
                                                                  )),
                                                            ],
                                                          ),
                                                        )
                                                      ]),
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
                              } else if (docsnapshot.hasError) {
                  return Center(child: Text(docsnapshot.error.toString()));
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
                  
                ),



              ],

            ) ,
            ),
          
        ],
      ), 
    
  );

  }
}