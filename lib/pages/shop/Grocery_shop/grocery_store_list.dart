import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/products_model.dart';


import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/widgets/app_icon.dart';
import 'package:get/get.dart';


import '../../../data/repository/products_repo.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/small_text.dart';
import 'grocery_shop_page.dart';

class GroceryStoreList extends StatelessWidget {
  const GroceryStoreList ({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductsRepo());
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
                      Get.to(()=>const GroceryShopPage());
                    },
                    child:
                      const AppIcon(icon: Icons.arrow_back_ios_new_sharp)),
                
                
                 GestureDetector(
                    onTap: () {
                     // Get.toNamed(RouteHelper.getcartpage());
                    },
                    child:
                      const AppIcon(icon: Icons.shopping_cart_outlined)),

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
                child: Center(child: BigText(size:Dimensions.font26, text:"Sliver App Bar") ),
              ),
               ),
            pinned: true,
            backgroundColor: AppColors.yellowcolor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background:Image.asset("assets/images/veg.1.jpg",
              width: double.maxFinite,
              fit: BoxFit.cover,),
              

             ),
          ),
           SliverToBoxAdapter(
            
            child: Column(
              children: [
                Container(
                   child:   FutureBuilder<List<ProductsModel>>(
            future: controller.getallProductG(),
            builder: (context, docsnapshot) {
              if (docsnapshot.connectionState == ConnectionState.done) {
                if (docsnapshot.hasData) {
                  return ListView.builder(
                         physics: const NeverScrollableScrollPhysics(),
                         shrinkWrap: true,
                       itemCount: docsnapshot.data!.length,
                       itemBuilder: (context, index) {
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
                              BigText(text: docsnapshot.data![index].name,size:15,),
                              SizedBox(height: Dimensions.height10,),
                              SamllText(text: docsnapshot.data![index].description),
                              SizedBox(height: Dimensions.height10,),
                         
                               Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      BigText(text: " \$ ${docsnapshot.data![index].price} ", color: Colors.redAccent, ),
                                      Container(
                      padding: EdgeInsets.only(top:Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width10,right: Dimensions.width10, ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white,
                                   
                       ),
                       child: Row(
                        children: [
                           GestureDetector(
                            onTap: (){
                              //cartController.addItem(_cartList[index].product!,-1)
                              
                            },
                            child: const Icon(Icons.remove,color: AppColors.signcolor,)),
                          SizedBox(width: Dimensions.width10/2,),
                          BigText(text:"0" ),//_cartList[index].quantity.toString()),
                          SizedBox(width: Dimensions.width10/2,),
                          GestureDetector(
                            onTap: (){
                              //cartController.addItem(_cartList[index].product!,1)
                              
                              
                            },
                            child: const Icon(Icons.add,color: AppColors.signcolor,)),
                        ],
                       ),
                                   
                                     ),
                                   
                                      ],
                                    )
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