import 'package:flutter_application_1/data/repository/cart_repo.dart';
import 'package:flutter_application_1/model/product_model.dart';
import 'package:get/get.dart';

import '../model/cart_model.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items={};
  
  void addItem(ProductModel product ,int quantity){
    _items.putIfAbsent(product.id, () { 
     
      print("adding item to cart");
      return CartModel(id:product.id,
       name: product.name, 
       price: product.price, 
       img: product.img, 
       quantity: quantity, 
       isExit: true, 
       time: DateTime.now().toString());});
  }

}