import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadeem/cubit/states.dart';

import '../product.dart';
class LoginCubit extends Cubit <LoginState> {
  LoginCubit () : super (LoginState()) ;

  static LoginCubit get(context) => BlocProvider.of(context);

  List<Product> products =
  [
    Product(
        'Product 1',
        'Description for Product 1',
        9.99,
        'images/2.png'
    ),
    Product(
        'Product 2',
        'Description for Product 2',
        19.99,
        'images/3.png'
    ),
    Product(
        'Product 3',
        'Description for Product 3',
        14.99,
        'images/2.png'
    ),
  ];

  bool isLoading = false;
  void falseLoadingState (){
    isLoading = false ;
    emit(state.copyWith(isLoading: false)) ;
  }
  void trueLoadingState (){
    isLoading = true ;
    emit(state.copyWith(isLoading:true)) ;
  }

  void onPasswordChanged(String value) {
    emit(state.copyWith(password: value)) ;
  }
  void onUserNameChanged(String value) {
    emit(state.copyWith(username: value)) ;
  }



}