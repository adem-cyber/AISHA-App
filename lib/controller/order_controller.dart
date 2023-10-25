import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/data/repository/store_repo_vendor.dart';
import 'package:flutter_application_1/pages/vendor/home/products_model_vendor.dart';

import 'package:get/get.dart';
import 'package:flutter_application_1/controller/cart_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import '../model/products_model.dart';

class OrderController extends GetxController {
 
  final CartController _cartController = Get.find();
String _holdstoreid = ''; 
final sender =Get.put(StoreRepoVendor());
  @override


   void setStore(String storeid) {
    _holdstoreid = storeid;
    
  }

  
  String getStore() {
    return _holdstoreid;
  }

  @override
  void onInit() {
    super.onInit();
    
    // Listen to changes in the cart items
    ever(_cartController.cartItems, (_) {
      update(); // Update the OrderController when the cart items change
    });
  }

  void placeOrder(String vendorid, String name, {double? serviceCharge, double? deliveryCharge}) {
  // Get the list of cart items
  List<ProductsModelVendor> cartItems = _cartController.cartItems;

  // Calculate the total order amount
  double totalAmount = 0;

  // Calculate service and delivery charges (default to 0 if not provided)
  serviceCharge ??= 0.0;
  deliveryCharge ??= 0.0;

  // Create a list to store order item details
  List<Map<String, dynamic>> orderItems = [];

  for (var item in cartItems) {
    final price = double.tryParse(item.price) ?? 0.0;
    totalAmount += price * item.quantity;

    // Create a map for the item including its details
    Map<String, dynamic> orderItem = {
      'name': item.name,
      'price': price,
      'description': item.description,
      'quantity': item.quantity,
      // Add other item details if needed
    };

    orderItems.add(orderItem);

    setStore(item.storeid);
  }

  // Calculate the total order amount including service and delivery charges
  totalAmount += serviceCharge + deliveryCharge;

  final FirebaseAuth auth = FirebaseAuth.instance;

  // Subscribe to changes in the authentication state
  Stream<User?> authStateStream = auth.authStateChanges();

  authStateStream.listen((User? user) {
    if (user != null) {
      String userName = user.displayName ?? '';

      FirebaseFirestore.instance.collection('orders').add({
        'userId': user.uid,
        'userName': user.displayName ?? '', // Include user's name
        'userPhone': user.phoneNumber ?? '', // Include user's phone number
        'items': orderItems,
        'Storeid': getStore(),
        'Vendorid': vendorid,
        'StoreName': name,
        'serviceCharge': serviceCharge, // Add service charge
        'deliveryCharge': deliveryCharge, // Add delivery charge
        'totalAmount': totalAmount,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  });

  // Show a success message or perform other actions as needed
  Get.snackbar('Order Placed', 'Your order has been placed successfully!',
      snackPosition: SnackPosition.TOP);

  // Clear the cart after placing the order
  _cartController.clearCart();
}
 Stream<QuerySnapshot> getOrdersSortedByTime() {
    // Sort the orders by the "timestamp" field in ascending order (oldest first)
    return FirebaseFirestore.instance
        .collection('orders')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

}