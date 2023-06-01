import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sadeem/screens/products.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _textFieldValue = '';
  String _passwordFieldValue = '';
  bool _isPasswordVisible = false;




  Widget _getText(
      String text, double fontSize, Color color, FontWeight fontWeight) {
    return Text(
      text,
      textDirection: TextDirection.rtl,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: 'Cairo',
          fontWeight: fontWeight),
    );
  }
  @override
  Widget build(BuildContext context) {
    bool isTextFieldEmpty = _textFieldValue.isEmpty;
    bool isPasswordFieldEmpty = _passwordFieldValue.isEmpty;
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
              decoration: BoxDecoration(
                  color: Color.fromRGBO(237, 237, 237, 1)),
              child: Column(
                children: [
                  TextField(
                      onChanged: (value) {
                        setState(() {
                          _textFieldValue = value;
                        });
                      },
                      controller: _nameController,
                      enabled: true ,
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
                              fontWeight: FontWeight.w400))
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          if (isTextFieldEmpty)
            Text(
              'Please enter your name',
              style: TextStyle(color: Colors.red),
            ),
          SizedBox(height: 20,),
          Center(
            child: Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(237, 237, 237, 1)),
              child: Column(
                children: [
                  TextField(
                      obscureText: !_isPasswordVisible,
                      onChanged: (value) {
                        setState(() {
                          _passwordFieldValue = value;
                        });
                      },
                      controller: _passwordController,
                      enabled: true ,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            child: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal:
                              10.0), //Change this value to custom as you like
                          isDense: true,
                          border: OutlineInputBorder(),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(104, 104, 104, 0.5),
                              fontFamily: 'Cairo',
                              fontSize: 15,
                              fontWeight: FontWeight.w400))
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          if (isPasswordFieldEmpty)
            Text(
              'Please enter your password',
              style: TextStyle(color: Colors.red),
            ),
          SizedBox(height: 20,),
          RaisedButton(
              child: Text(
                  "Run App"
              ),
              onPressed: _textFieldValue.isEmpty || _passwordFieldValue.isEmpty ? null : (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProductsScreen()),
                );
              }

          )
        ],


      ),
    );
  }
}
