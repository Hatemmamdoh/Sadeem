import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadeem/product.dart';
import 'package:sadeem/screens/products.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../singleton.dart';

class LoginScreen extends StatelessWidget {
  bool _isPasswordVisible = false;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
  }

  void onChanged(String value,context) {
    _passwordFieldController.text = value;
    LoginCubit.get(context).onPasswordChanged(value);
  }

  TextEditingController _nameFieldController = TextEditingController(text: "");
  TextEditingController _passwordFieldController = TextEditingController();

  void _handleButtonClick(BuildContext context) {

    if (_nameFieldController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your name'),
        ),
      );
      return;
    }

    if (_passwordFieldController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your password'),
        ),
      );
      return;
    }
    LoginCubit.get(context).trueLoadingState();

    _loadData(context).then((result) {
      LoginCubit.get(context).trueLoadingState();

      // Navigate to the next screen and pass the result as a parameter
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ProductsScreen.create(context),
        ),
            (route) => false,
      );
    });
  }

  Future<List<Product>> _loadData(BuildContext context) async {
    // Simulate loading data

    await Future.delayed(Duration(seconds: 2));

    // Return the loaded list
    // return instance.getProducts();
    return LoginCubit.get(context).products;
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 40,
                    width: 250,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(237, 237, 237, 1)),
                    child: Column(
                      children: [
                        TextField(
                            onChanged: (value) {
                              LoginCubit.get(context).onUserNameChanged(value);
                            },
                            controller: _nameFieldController,
                            enabled: true,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal:
                                        10.0), //Change this value to custom as you like
                                isDense: true,
                                border: OutlineInputBorder(),
                                hintText: 'Enter your name',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(104, 104, 104, 0.5),
                                    fontFamily: 'Cairo',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(237, 237, 237, 1)),
                    child: Column(
                      children: [
                        TextField(
                          obscureText: !_isPasswordVisible,
                          onChanged: (value) {
                            LoginCubit.get(context).onPasswordChanged(value);
                          },
                          controller: _passwordFieldController,
                          enabled: true,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: (){
                                _isPasswordVisible = !_isPasswordVisible;
                              },
                              child: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            isDense: true,
                            border: OutlineInputBorder(),
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(104, 104, 104, 0.5),
                              fontFamily: 'Cairo',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Set the background color here
                    ),
                    child: Text("Run App"),
                    onPressed: () {
                                _handleButtonClick(context);
                              }),
                if (LoginCubit.get(context).isLoading)
                  Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// class _LoginScreenState extends State<LoginScreen> {
//   final _nameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   String _textFieldValue = '';
//   String _passwordFieldValue = '';
//   bool _isPasswordVisible = false;
//
//   bool _isLoading = false;
//




