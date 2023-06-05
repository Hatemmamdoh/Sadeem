import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadeem/screens/productDetailsScreen.dart';
import 'package:sadeem/state_managment/product_bloc.dart';
import 'package:provider/provider.dart';


import '../provider/theme_provider.dart';
import 'cartScreen.dart';

// price
// title
// description
// image

class ProductsScreen extends StatelessWidget {

  const ProductsScreen._({Key? key,}) : super(key: key);

  static Widget create(context,) {
    return BlocProvider<ProductBloc>(
      create: (context) =>
      ProductBloc()
        ..add(FetchProductEvent()),
      child: ProductsScreen._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
          actions: [
            Switch(
              value: themeProvider.isLightTheme,
              onChanged: (val) {
                themeProvider.setThemeData (val) ;
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen.create(context),
                  ),
                );
              },
            ),
          ]
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          print(state.isLoading);

          if (state.isLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            if (state.products.length == 0){
              return (Text ("There is no products")) ;
            }
           return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen.create(context, state.products[index].title),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  state.products[index].imageUrl,
                                  width: 100,
                                  height: 100,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),
                                    Text(
                                      state.products[index].title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(state.products[index].description),
                                    SizedBox(height: 5),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(height: 5),
                                Text(
                                  '\$${state.products[index].price.toStringAsFixed(2)}',
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
                  ),
                );
              },
            );
          }

        },
      ),
    );
  }

}