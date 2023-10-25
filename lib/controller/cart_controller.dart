import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/vendor/home/products_model_vendor.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<ProductsModelVendor> cartItems = <ProductsModelVendor>[].obs;

  double get totalAmount {
    double total = 0;
    for (var item in cartItems) {
      final price = double.tryParse(item.price) ?? 0.0;
      total += price * item.quantity;
    }
    return total;
  }
void addProduct(ProductsModelVendor product) {
  final index = cartItems.indexWhere((item) => item.id == product.id);
  if (index != -1) {
    updateQuantity(index, cartItems[index].quantity + 1);
    print("Product added: ${product.name}, New quantity: ${cartItems[index].quantity}");
  } else {
    product.quantity = 1;
    cartItems.add(product);
    print("Product added: ${product.name}, New quantity: 1");
  }

  Get.snackbar(
    "Product Added",
    "You have added ${product.name} to the cart",
    snackPosition: SnackPosition.TOP,
    backgroundColor: const Color.fromARGB(206, 246, 246, 13),
    duration: const Duration(seconds: 1),
  );
  update();
}

void removeItem(ProductsModelVendor product) {
  final index = cartItems.indexWhere((item) => item.id == product.id);
  if (index != -1) {
    if (cartItems[index].quantity > 1) {
      updateQuantity(index, cartItems[index].quantity - 1);
      
      print("Product removed: ${product.name}, New quantity: ${cartItems[index].quantity}");
    } else {
      cartItems.removeAt(index);
      print("Product removed: ${product.name}, Quantity: 0");
    }

    Get.snackbar(
      "Remove product",
      "You have removed ${product.name} from the cart",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      duration: const Duration(seconds: 1),
    );
    update();
  }
}

  

  void updateQuantity(int index, int newQuantity) {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index].quantity = newQuantity;
    }
    update();
  }

  int getQuantity(ProductsModelVendor product) {
    final index = cartItems.indexWhere((item) => item.id == product.id);
     update();
    return index != -1 ? cartItems[index].quantity : 0;
  }

  int get totalQuantity {
    int quantity = 0;
    for (var item in cartItems) {
      quantity += item.quantity;
    }
     update();
    return quantity;
  }

  void clearCart() {
    cartItems.clear();
    update();
  }
}
