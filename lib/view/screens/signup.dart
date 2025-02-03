import 'package:dummyprojecr/view/screens/home.dart';
import 'package:dummyprojecr/models/signupmodel.dart';
import 'package:dummyprojecr/view/screens/signin.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  static User? user;

  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final User _user =
      User(name: '', phoneNumber: '', email: '', username: '', password: '');

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset(
                          Theme.of(context).brightness == Brightness.light
                              ? 'assets/images/lightlogo.png'
                              : 'assets/images/darklogo.png',
                          width: 200,
                          height: 180,
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onSaved: (value) => _user.name = value ?? '',
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Phone Number'),
                            keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                        onSaved: (value) => _user.phoneNumber = value ?? '',
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        onSaved: (value) => _user.email = value ?? '',
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                        onSaved: (value) => _user.username = value ?? '',
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onSaved: (value) => _user.password = value ?? '',
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            SignUpPage.user = _user;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                  user: _user,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInPage()),
                    );
                  },
                  child: const Text('I already have an account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
