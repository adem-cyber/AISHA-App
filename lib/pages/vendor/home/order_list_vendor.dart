import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class OrderListVendor extends StatelessWidget {
  @override
  final String storeid;
const OrderListVendor({super.key, required this.storeid});
    
  @override
  Widget build(BuildContext context) {
   // Scaffold(
     // appBar: AppBar(
     //   title: Text('Received Orders'),
    //  ),);
    return StreamBuilder<QuerySnapshot>(
      
      stream: FirebaseFirestore.instance
      .collection('orders')
      .where("Storeid", isEqualTo: storeid)
    
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

            final userPhone = orderData['userPhone'] as String?;
            final items = orderData['items'] as List<dynamic>;

            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Text('Date: ${_formatTimestamp(orderData['timestamp'])}'),
                    subtitle:
                        Text('Order ID: ${order.id}'),
                    trailing: Text('Total Amount: ZMK-${orderData['totalAmount']}'
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
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
                              '  Description:$itemDescription \n Quantity: $itemQuantity \n Price: $itemPrice '),
                        );
                      },
                      ).toList(),
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
    );
  }
String _formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final formattedDate =
        "${_twoDigits(dateTime.year)}-${_twoDigits(dateTime.month)}-${_twoDigits(dateTime.day)} ${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)}";
    return formattedDate;
  }

  String _twoDigits(int n) => n.toString().padLeft(2, "0");
}

   Future<void> _deleteOrder(String orderId) async {
    try {
      await FirebaseFirestore.instance.collection('orders').doc(orderId).delete();
    } catch (e) {
      // Handle the error
      print('Error deleting order: $e');
    }
  }

