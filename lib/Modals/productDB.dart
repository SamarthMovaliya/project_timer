class productDB {
  final int id;
  final String image;
  final String name;
  final String category;
  final String description;
  final int quantity;
  final int price;

  productDB({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.image,
    required this.quantity,
    required this.price,
  });

  factory productDB.fromMap({required Map data}) {
    return productDB(
        id: data['Id'],
        name: data['Name'],
        category: data['Category'],
        description: data['Details'],
        image: data['Image'],
        quantity: data['Quantity'],
        price: data['Price']);
  }
}

