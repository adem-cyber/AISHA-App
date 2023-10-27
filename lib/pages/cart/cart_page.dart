import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/cart_controller.dart';
import 'package:flutter_application_1/pages/vendor/home/products_model_vendor.dart';
import 'package:get/get.dart';

import '../../base/no_data_page.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import 'order_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.vendorid, required this.name});
  final String vendorid;
  final String name;
  @override
  _CartPageState createState() => _CartPageState();
}
class _CartPageState extends State<CartPage> {
  final CartController cartController = Get.find();

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Obx(() {
        final RxList<ProductsModelVendor> cartItems = cartController.cartItems;

        if (cartItems.isEmpty) {
          return const Center(
            child: NoDataPage(text: "Your Cart Is Empty"),
          );
        }
       
        return ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            final product = cartItems[index];
            return Container(
              height: 100,
              width: double.maxFinite,
              margin: EdgeInsets.only(top: Dimensions.height15),
              child: Row(children: [
                 SizedBox(
                  width: Dimensions.height10,),
                Container(
                  width: Dimensions.height20 * 5,
                  height: Dimensions.height20 * 5,
                  margin: EdgeInsets.only(bottom: Dimensions.height10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.blue,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: Dimensions.width10,
                ),
                Expanded(
                    child: SizedBox(
                  height: Dimensions.height20 * 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BigText(
                        text: product.name,
                        color: Colors.black54,
                      ),
                      SamllText(text: product.description),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BigText(
                            text: product.price,
                            color: Colors.redAccent,
                          ),
                          Container(
                            
                            padding: EdgeInsets.only(
                              top: Dimensions.height10,
                              bottom: Dimensions.height10,
                              left: Dimensions.width10,
                              right: Dimensions.width10,
                            ),
                            
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white,
                            ),
                            child: Row(
                              
                              children: [
                                
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                                                cartController.getQuantity(product);
                                                              });
                                      cartController.removeItem(product);
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: AppColors.signcolor,
                                    )),
                                SizedBox(
                                  width: Dimensions.width10 / 2,
                                ),
                                BigText(text: product.quantity.toString()),
                                SizedBox(
                                  width: Dimensions.width10 / 2,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                                                cartController.getQuantity(product);
                                                              });
                                      cartController.addProduct(product);
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: AppColors.signcolor,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ))
              ]),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        final double total = cartController.totalAmount;
        return Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: Zmk: ${total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
              ),
              ElevatedButton(
                onPressed: () {
                   
              Get.to(()=> OrderPage(vendorid: widget.vendorid,name:widget.name));
                },
                child: const Text('Checkout'),
              ),
            ],
          ),
        );
      }),
    );
  }
  
 
}
