class CartModel {
  int id;
  String name;  
  int price;
  String img;
  int quantity;
  bool isExit;
  String time;
 
  CartModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.img,
      required this.quantity,
      required this.isExit,
      required this.time,
      


      });

  CartModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int,
      name = json['name'] as String,
      price = json['price'] as int,
      img = json['img'] as String,
      quantity = json['quantity'] as int,
      isExit = json['isExit'] as bool,
      time = json['time'] as String;




  
  

}