class Product {
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  Product(this.title, this.description, this.price,this.imageUrl);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'imageUrl' : imageUrl,
      'description' : description
      // add other properties as needed...
    };
  }
}