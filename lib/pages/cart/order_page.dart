import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/cart_controller.dart';
import 'package:flutter_application_1/controller/order_controller.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:get/get.dart';

class OrderPage extends StatelessWidget {
  OrderPage({super.key, required this.vendorid, required this.name});
  final String vendorid;
  final String name;

  final CartController cartController = Get.find<CartController>();
  final OrderController orderController = Get.find<OrderController>();

  // Define service and delivery charges
  double serviceCharge = 2.0; // You can adjust this value as needed
  double deliveryCharge = 10.0; // You can adjust this value as needed

  @override
  Widget build(BuildContext context) {
    // Calculate the total order amount including service and delivery charges
    double totalAmount =
        cartController.totalAmount + serviceCharge + deliveryCharge;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Order'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(Dimensions.width20),
            child: BigText(
              text: 'Orders',
              size: 24,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartController.cartItems.length,
              itemBuilder: (context, index) {
                final product = cartController.cartItems[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Price: \$${product.price}'),
                  trailing: Text('Quantity: ${product.quantity}'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(product.image),
                    radius: Dimensions.radius30,
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(Dimensions.width10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Service Charge:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Zmk: ${serviceCharge.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Delivery Charge:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Zmk: ${deliveryCharge.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Zmk: ${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ElevatedButton(
              onPressed: () {
                // Place the order with service and delivery charges
                orderController.placeOrder(
                  vendorid,
                  name,
                );

                // Navigate back to the previous page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>const HomePage(), // Replace 'YourHomePage' with the actual homepage widget
                  ),
                );
              },
              child: const Text('Place Order'),
            ),
          ),
        ],
      ),
    );
  }
}
