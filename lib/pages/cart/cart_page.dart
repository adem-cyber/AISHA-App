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
        title: const Text(
          'Your Cart',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.mainColor,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
              margin: EdgeInsets.symmetric(
                vertical: Dimensions.height10,
                horizontal: Dimensions.width20 / 3,
              ),
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 4, 4, 4).withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.width10),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    ),
                  ),
                  SizedBox(width: Dimensions.width10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: Dimensions.height10),
                        BigText(
                            text: product.name, color: Colors.black, size: 18),
                        SizedBox(height: 5),
                        SamllText(
                            text: product.description,
                            size: 12,
                            color: Colors.black54),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BigText(
                                text: '${product.price} ZMK',
                                color: Colors.black,
                                size: 14),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove,
                                      color: AppColors.signcolor),
                                  onPressed: () {
                                    cartController.removeItem(product);
                                  },
                                ),
                                BigText(
                                    text: product.quantity.toString(),
                                    color: Colors.black,
                                    size: 14),
                                IconButton(
                                  icon:
                                      const Icon(Icons.add, color: Colors.blue),
                                  onPressed: () {
                                    cartController.addProduct(product);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        final RxList<ProductsModelVendor> cartItems = cartController.cartItems;
        final double total = cartController.totalAmount;
        return Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: cartItems.isEmpty
              ? const SizedBox.shrink()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: ${total.toStringAsFixed(2)} ZMK',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width20,
                            vertical: Dimensions.height10),
                      ),
                      onPressed: () {
                        Get.to(() => OrderPage(
                            vendorid: widget.vendorid, name: widget.name));
                      },
                      child: const Text('Checkout',
                          style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
        );
      }),
    );
  }
}
