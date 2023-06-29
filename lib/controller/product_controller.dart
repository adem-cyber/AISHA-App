import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/cart_controller.dart';
import 'package:flutter_application_1/data/repository/product_repo.dart';
import 'package:flutter_application_1/model/product_model.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  final ProductRepo productRepo;
  ProductController({required this.productRepo});
  List<ProductModel> _ProductList=[];
  List<ProductModel> get productList => _ProductList ;
  late CartController _cart;

   bool _isLoaded=false;
   bool get isLoaded=>_isLoaded;

   int _quantity=0;
   int get quantity=>_quantity;
   int _inCartItems=0;
   int get inCartItems=>_inCartItems+_quantity;

  Future <void> getProductList()async{
   Response response= await   productRepo.getProductList();
   if(response.statusCode==200){
    print("got products");
    _ProductList=[];
   _ProductList.addAll(Product.fromJson(response.body).products);
   _isLoaded=true;
    update();

   }else{

   }

  }
  void setQuantity(bool isIncrement){
    if (isIncrement){
      print("increment"+_quantity.toString());

      _quantity=checkQuantity(_quantity+1);
    }else{

      _quantity=checkQuantity(_quantity-1);
      print("decrement"+_quantity.toString());
    

    }
    update();

  }
int checkQuantity(int quantity){
  if (quantity<0){
    Get.snackbar("Item count", "you can't Reduce more !", backgroundColor: AppColors.mainColor,colorText: Colors.white);
    return 0;
  }else if (quantity>30){
    Get.snackbar("Item count", "you can't ADD more !", backgroundColor: AppColors.mainColor,colorText: Colors.white);

    return 30;

  }else{
    return quantity;
  

  }
 }
 
 void initProduct(CartController cart ){
   _quantity=0;
   _inCartItems=0;
   _cart=cart;

   
 }

  void addItem(ProductModel product) {
      _cart.addItem(product, _quantity);
  }

}