class Product {
  int ?_totalSize;
  int ? _typeId;
  int ?_offset;
  late List<ProductModel> _products;
  List<ProductModel> get products=>_products;

  Product({required totalSize, required typeId, required offset, required products}){
           this._totalSize=totalSize;
           this._typeId=typeId;
           this._offset=offset;
           this._products=products;


  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products.add(ProductModel.fromJson(v));
      });
    }
  }

 
}

class ProductModel {
  int id;
  String name;
  String description;
  int price;
  int stars;
  String img;
  String location;
  String createdAt;
  String updatedAt;
  int typeId;

  ProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.stars,
      required this.img,
      required this.location,
      required this.createdAt,
      required this.updatedAt,
      required this.typeId});

  ProductModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int,
      name = json['name'] as String,
      description = json['description'] as String,
      price = json['price'] as int,
      stars = json['stars'] as int,
      img = json['img'] as String,
      location = json['location'] as String,
      createdAt = json['created_at'] as String,
      updatedAt = json['updated_at'] as String,
      typeId = json['type_id'] as int;

 

  

}