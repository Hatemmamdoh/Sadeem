import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sadeem/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../singleton.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  MySingleton instance = MySingleton();

  CartBloc() : super(CartState()) {
    on<AddToCartEvent>((event, emit) => onAddToCartEvent(event, emit));
    on<FetchCartEvent>((event, emit) => onFetchCartEvent(event, emit)) ;

  }
  onAddToCartEvent (AddToCartEvent event , Emitter <CartState> emit){
    instance.addToCart(event.productToAdd) ;
    List <Product> cartProducts  = instance.getCartProducts() ;
    emit(CartState(products: cartProducts)) ;
    saveCartToSharedPreferences(cartProducts) ;
  }
  onFetchCartEvent (FetchCartEvent event , Emitter <CartState> emit) async {
    emit(CartState(isloading: true)) ;

    List <Product> cartProducts  = await getCartFromSharedPreferences()  ;
    emit(CartState(products: cartProducts,isloading: false)) ;
  }
  Future<void> saveCartToSharedPreferences(List<Product> cartProducts) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(cartProducts);
    await prefs.setString('cart', jsonString);
  }
  Future<List<Product>> getCartFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('cart');
    List<dynamic>? jsonList = jsonString != null ? jsonDecode(jsonString) : null;

    List<Product> cartProducts = jsonList?.map((json) => Product(
      json['title'],
      json['description'],
      json['price'],
      json['imageUrl'],
    )).toList() ?? [];
    return cartProducts ;
  }
}
