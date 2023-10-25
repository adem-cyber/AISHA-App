class SelectedStoreData {
  String name = '';
  String location = '';
  String phone = '';
  String description = '';
  String email = '';
  String storeid = '';
  String image = '';
  String vendorid='';
  String type='';
  // Constructor to initialize the data
  SelectedStoreData({
    required Map<String, dynamic> data,
  }) {
    name = data['name'] ?? '';
    description = data['description'] ?? '';
    location = data['location'] ?? '';
    storeid = data['storeid'] ?? '';
    email = data['email'] ?? '';
    phone = data['phone'] ?? '';
    image =data['image']??'';
    vendorid=data['vendorid']??'';
    type=data['type']??'';
  }

  String getName() {
    return name;
  }
String getvendorid() {
    return vendorid;
  }

  String getLocation() {
    return location;
  }

  String getPhone() {
    return phone;
  }

  String getDescription() {
    return description;
  }

  String getEmail() {
    return email;
  }

  String getStoreid() {
    return storeid;
  }

  String getImage() {
    return image;
  }
String getType() {
    return type;
  }

  void clearStoreData() {
    name = '';
    location = '';
    phone = '';
    description = '';
    email = '';
    storeid = '';
    image = '';
    vendorid='';
  }
}
