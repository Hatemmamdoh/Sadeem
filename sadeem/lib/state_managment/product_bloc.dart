import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../product.dart';
import '../singleton.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  MySingleton instance = MySingleton();


  ProductBloc() : super(ProductState()) {
    on<FetchProductEvent>((event, emit) =>
        onFetchProducts(event,emit),);

  }
  onFetchProducts(FetchProductEvent event, Emitter<ProductState> emit) {
    // load
    List <Product> products = instance.getProducts() ;

    emit(ProductState(isLoading: false,products: products));
  }




}
