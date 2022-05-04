import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/blocs/bottom_navigation/screen/app_screen.dart';

import 'sign_in_bloc.dart';

// import 'package:flutter_application_1/services/shared_pref.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login Screen"),
          //  backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        //backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 35,
                top: 130,
              ),
              child: Text(
                'Welcome',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 43,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4,
                    right: 35,
                    left: 35),
                child: Form(
                  child: Column(
                    children: [
                      BlocBuilder<SignInBloc, SignInState>(
                        builder: (context, state) {
                          if (state is SignInErrorState) {
                            return Text(
                              state.errorMessage,
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _email,
                        onChanged: (value) {
                          BlocProvider.of<SignInBloc>(context).add(
                              SignInTextChangedEvent(
                                  _email.text, _password.text));
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        obscureText: true,
                        controller: _password,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {
                          BlocProvider.of<SignInBloc>(context).add(
                              SignInTextChangedEvent(
                                  _email.text, _password.text));
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          BlocBuilder<SignInBloc, SignInState>(
                            builder: (context, state) {
                              return CircleAvatar(
                                radius: 30,
                                backgroundColor: (state is SignInValidState)
                                    ? Colors.blue
                                    : Color(0xff4c505b),
                                child: IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    if (state is SignInValidState) {
                                      BlocProvider.of<SignInBloc>(context)
                                          .add(SignInSubmittedEvent(
                                        _email.text,
                                        _password.text,
                                      ));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AppScreen(),
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(Icons.arrow_forward),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
