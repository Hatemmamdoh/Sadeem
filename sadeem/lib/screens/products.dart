import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// price
// title
// description
// image
class Product {
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  Product(this.title, this.description, this.price,this.imageUrl);
}

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  List<Product> products = [
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
    Product(
      'Product 3',
      'Description for Product 3',
      14.99,
        'images/2.png'
    ),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row (
                      children: [
                        Image.asset(
                          products[index].imageUrl,
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text(
                              products[index].title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(products[index].description),
                            SizedBox(height: 5),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(height: 5),
                        Text(
                          '\$${products[index].price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}