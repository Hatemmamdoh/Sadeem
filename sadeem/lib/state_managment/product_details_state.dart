part of 'product_details_bloc.dart';

@immutable
class ProductDetailsState{
  final ProductsDetails ? myProduct ;
  final bool isLoading;

  ProductDetailsState({this.myProduct,this.isLoading=true});

}
