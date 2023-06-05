import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadeem/productDetails.dart';
import 'package:sadeem/state_managment/product_bloc.dart';
import 'package:sadeem/state_managment/product_details_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../state_managment/cart_bloc.dart';


class ProductDetailScreen extends StatelessWidget {

  const ProductDetailScreen._({Key? key,}) : super(key: key);


  static Widget create(BuildContext context, String productName) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductDetailsBloc>(
          create: (context) =>
          ProductDetailsBloc()..add(FetchProductDetailsEvent(productName)),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
      ],
      child: ProductDetailScreen._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CartBloc _cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
        appBar: AppBar(
        title: Text('Products Details Screen'),
        ),
      body: BlocBuilder <ProductDetailsBloc,ProductDetailsState>(
        builder: (context, state) {
          ProductsDetails? myProduct = state.myProduct ;
          if (state.isLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            print ('here') ;
            print (myProduct?.name) ;
            return Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  SizedBox(height: 30,) ,
                  CarouselSlider(
                      items: myProduct?.images?.map((e) {
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(e),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList() ?? [],
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 2,
                        viewportFraction: 1,
                      ),
                    ),
                  SizedBox(height: 16),
                  Text(
                    myProduct?.name ?? '',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${myProduct?.price?.toStringAsFixed(2) ?? ''}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      print (myProduct?.price) ;
                      final addToCartEvent = AddToCartEvent(myProduct?.name ?? '');
                      _cartBloc.add(addToCartEvent);
                      print (_cartBloc.state.products.length) ;
                    },
                    child: Text('Add to Cart'),
                  ),
                ],
              ),
            );
            ;
          }
        }

      ),
    );
  }


}