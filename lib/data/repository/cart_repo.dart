import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/cart_controller.dart';
import 'package:flutter_application_1/model/products_model.dart';

class CartRepo extends StatelessWidget {
  final CartController controller;
  final ProductsModel product;
  final int quantity;
  final int index;
  const CartRepo({super.key, 
  required this.controller, 
  required this.product, 
  required this.quantity, 
  required this.index});

  @override
  Widget build(BuildContext context) {
    
    return  Container();
  }
}