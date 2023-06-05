part of 'product_bloc.dart';

@immutable
class ProductState {
  final List<Product> products;
  final bool isLoading;

  ProductState({this.products = const [],this.isLoading=true});
}