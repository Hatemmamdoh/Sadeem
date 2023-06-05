import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../productDetails.dart';
import '../singleton.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  MySingleton instance = MySingleton();

  ProductDetailsBloc() : super(ProductDetailsState()) {
    on<FetchProductDetailsEvent>((event, emit) =>
        onFetchProductDetails(event,emit),);
  }

  onFetchProductDetails(FetchProductDetailsEvent event, Emitter<ProductDetailsState> emit,) {

    emit (ProductDetailsState(isLoading: true)) ;
     ProductsDetails myProduct = instance.getSpecificProduct(event.productName) ;
     emit (ProductDetailsState(myProduct: myProduct,isLoading: false)) ;
  }
}
