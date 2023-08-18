

import 'package:flutter_application_1/model/products_model.dart';
import 'package:get/get.dart';


class CartController extends GetxController{
  final _products = {}.obs;

  var product;

  
  void addProduct(ProductsModel product){
    
    if(_products.containsKey(product)){
      _products[product]+=1;
    }else{
      _products[product]=1;
    }
    Get.snackbar("product Added",
     "You have added the ${product.name} to the cart",
     snackPosition: SnackPosition.BOTTOM,
     duration: const Duration(seconds: 2),
     );
  }
  get products => product;
}

