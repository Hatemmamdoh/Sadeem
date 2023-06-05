import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadeem/state_managment/cart_bloc.dart';

class CartScreen extends StatelessWidget {

  const CartScreen._({Key? key,}) : super(key: key);

  static Widget create(context,) {
    return BlocProvider<CartBloc>(
      create: (context) =>
      CartBloc()
        ..add(FetchCartEvent()),
      child: CartScreen._(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: BlocBuilder <CartBloc,CartState>(
        builder: (context,state) {
          if (state.isloading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            if (state.products.isEmpty){
              return Center(child: Text("The cart is empty")) ;
            }
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context,index){
                return Card(
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
                ) ;
              },

            );
          }
        }
      ),
    ) ;
  }

}