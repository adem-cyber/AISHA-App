import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/vendor/home/order_list_vendor.dart';
import 'package:flutter_application_1/utils/colors.dart';

class OrderReceivedVendor extends StatelessWidget {
  @override
  final String storeid;
const OrderReceivedVendor({super.key, required this.storeid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Received Orders'),
        backgroundColor: AppColors.purple, 
      actions: [
          IconButton(
            onPressed: () {
             OrderListVendor(storeid:storeid);
            },
            icon: Icon(Icons.refresh), // You can customize the icon as needed
          ),
        ],
      ),
      body: OrderListVendor(storeid:storeid),
    );
  }
}

