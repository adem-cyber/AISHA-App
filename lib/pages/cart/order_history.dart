import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/utils/colors.dart';

class OrderHistoryPage extends StatelessWidget {
  final String userPhone;

  OrderHistoryPage({Key? key, required this.userPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text('Order History'),
      ),
      body: OrderList(userPhone: userPhone),
    );
  }
}

class OrderList extends StatelessWidget {
  final String userPhone;

  OrderList({Key? key, required this.userPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where("userPhone", isEqualTo: userPhone)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No orders received yet.'));
        }

        final orders = snapshot.data!.docs;
        return ListView.separated(
          itemCount: orders.length,
          separatorBuilder: (context, index) => const Divider(
            color: Colors.white,
            height: 0,
            thickness: 1,
          ),
          itemBuilder: (context, index) {
            return OrderCard(order: orders[index]);
          },
        );
      },
    );
  }
}
class OrderCard extends StatelessWidget {
  final QueryDocumentSnapshot order;

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final orderData = order.data() as Map<String, dynamic>;
    final items = orderData['items'] as List<dynamic>;

    double totalAmount = double.tryParse(orderData['totalAmount'].toString()) ?? 0.0;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date: ${_formatTimestamp(orderData['timestamp'])}',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                
              ],
            ),
          ),
          ListTile(
            title: const Text(
              'Items:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) {
                final product = item as Map<String, dynamic>;
                final itemName = product['name'] as String? ?? 'Item Name Not Provided';
                final itemQuantity = product['quantity'];
                final itemDescription = product['description'];
                final itemPrice = product['price'];

                return ListTile(
                  title: Text(itemName),
                  subtitle: Text(
                    'Description: $itemDescription \n Quantity: $itemQuantity \n Price: $itemPrice',
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: 
              
              Center(
                  child: Text(
                    'Total Amount: ZMK- $totalAmount \n Delivery&Service: 12 ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
            
          ),
          const Divider(),
        ],
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
}
