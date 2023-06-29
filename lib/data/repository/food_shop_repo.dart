import 'package:flutter_application_1/data/api/api_client.dart';
import 'package:flutter_application_1/utils/app_constants.dart';
import 'package:get/get.dart';

class FoodShopRepo extends GetxService{
final ApiClient apiClient;
FoodShopRepo({required this.apiClient});

Future<Response> getFoodShopList()async{
   return await apiClient.getData(AppConstants.Food_Shop_URI);

}

}