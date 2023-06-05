part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final String productToAdd ;

  AddToCartEvent (this.productToAdd) ;
}
class FetchCartEvent extends CartEvent {}
