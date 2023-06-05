part of 'cart_bloc.dart';

@immutable
class CartState{
  final List <Product> products ;
  final isloading ;

  CartState ({this.products = const [],this.isloading = true}) ;
}
