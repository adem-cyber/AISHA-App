import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/pages/vendor/profile_controller_vendor.dart';
import 'package:flutter_application_1/pages/vendor/user_model_vendor.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:get/get.dart';

class OrderReceivedPage extends StatefulWidget {
  const OrderReceivedPage({super.key});

  @override
  State<OrderReceivedPage> createState() => OrderList();
}

class OrderList extends State<OrderReceivedPage> {
  late UserModelVendor userData = UserModelVendor(
    name: "",
    phone: "",
    vendorid: "",
  );

  Future<void> _fetchUserData() async {
    final controller = Get.find<ProfileControllervendor>();
    final user = await controller.getUserData();
    if (user != null) {
      if (mounted) {
        setState(() {
          userData = user;
        });
      }
    }
  }

  @override
  void initState() {
    _fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Received Orders'),
        backgroundColor: AppColors.purple,
        actions: [
          IconButton(
            onPressed: () {
              OrderList();
            },
            icon: Icon(Icons.refresh), // You can customize the icon as needed
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where("Vendorid", isEqualTo: userData.vendorid)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No orders received yet.'),
            );
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              final orderData = order.data() as Map<String, dynamic>;
              final storeName = orderData['StoreName'] as String?;
              final userPhone = orderData['userPhone'] as String?;
              final items = orderData['items'] as List<dynamic>;

              return Card(
                elevation: 3,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                          'Date: ${_formatTimestamp(orderData['timestamp'])}'),
                      subtitle: Text('Order ID: ${order.id}'),
                      trailing: Text(
                          'Total Amount: ZMK--${orderData['totalAmount']}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: storeName != null
                          ? Text('Store Name: $storeName')
                          : const Text('Store Name: Not provided'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: userPhone != null
                          ? Text('User Phone: $userPhone')
                          : const Text('User Phone: Not provided'),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Items:'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: items.map((item) {
                          final product = item as Map<String, dynamic>;
                          final itemName = product['name'] as String?;
                          final itemQuantity = product['quantity'];
                          final itemDescription = product['description'];
                          final itemPrice = product['price'];

                          return ListTile(
                            title: Text(itemName ?? 'Item Name Not Provided'),
                            subtitle: Text(
                                'Description:$itemDescription | Quantity: $itemQuantity \n Price: $itemPrice '),
                          );
                        }).toList(),
                      ),
                    ),
                    ListTile(
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Call the function to delete the order here
                          _deleteOrder(order.id);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) {
      return 'Unknown Date';
    }
    final dateTime = timestamp.toDate();
    final formattedDate =
        "${_twoDigits(dateTime.year)}-${_twoDigits(dateTime.month)}-${_twoDigits(dateTime.day)} ${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)}";
    return formattedDate;
  }

  String _twoDigits(int n) => n.toString().padLeft(2, "0");

  Future<void> _deleteOrder(String orderId) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .delete();
    } catch (e) {
      // Handle the error
      print('Error deleting order: $e');
    }
  }
}
