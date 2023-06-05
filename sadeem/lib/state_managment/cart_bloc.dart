import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sadeem/product.dart';

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
  }
  onFetchCartEvent (FetchCartEvent event , Emitter <CartState> emit){
    emit(CartState(isloading: true)) ;
    List <Product> cartProducts  = instance.getCartProducts() ;
    emit(CartState(products: cartProducts,isloading: false)) ;
  }
}
