import 'package:sadeem/product.dart';
import 'package:sadeem/productDetails.dart';

class MySingleton {
  static final MySingleton _singleton = MySingleton._internal();
  List<Product> products =
  [
    Product(
        'Product 1',
        'Description for Product 1',
        9.99,
        'images/2.png'
    ),
    Product(
        'Product 2',
        'Description for Product 2',
        19.99,
        'images/3.png'
    ),
    // Product(
    //     'Product 3',
    //     'Description for Product 3',
    //     14.99,
    //     'images/2.png'
    // ),
  ];
  Map<String, ProductsDetails> myMap = {
    'Product 1': ProductsDetails
      (
      ['images/2.png',],'Product 1',  9.99,
    ),
    'Product 2': ProductsDetails
      (
      ['images/2.png','images/3.png'],'Product 2',  19.99,),

  };
  Map<String, Product> productMap = {
    'Product 1': Product(
        'Product 1',
        'Description for Product 1',
        9.99,
        'images/2.png'
    ),
    'Product 2': Product(
        'Product 2',
        'Description for Product 2',
        19.99,
        'images/3.png'
    ),

  };
  List<Product> cart = [] ;

  factory MySingleton() {
    return _singleton;
  }

  MySingleton._internal();

  List<Product> getProducts() {
    return products ;
  }
  ProductsDetails getSpecificProduct(String productName){
    ProductsDetails? product = myMap[productName];
    if (product != null) {
      return product;
    } else {
      throw Exception('Product not found');
    }
  }
  void addToCart (String productToAdd){
    Product? product = productMap[productToAdd] ;
    print (productToAdd) ;

    if (product != null){
      print (product.price) ;
      cart.add(product) ;
    }
  }
  List<Product> getCartProducts() {
    return cart ;
  }

}