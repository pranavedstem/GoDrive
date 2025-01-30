import 'package:dummyprojecr/view/screens/home.dart';
import 'package:dummyprojecr/view/screens/signup.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
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
                            width: MediaQuery.of(context).size.width * 0.8, 
                            height: 200,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty || !value.contains('@')) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                          onSaved: (value) => _email = value ?? '',
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                          onSaved: (value) => _password = value ?? '',
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              if (_email == SignUpPage.user?.email && _password == SignUpPage.user?.password) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(user: SignUpPage.user!),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Invalid email or password')),
                                );
                              }
                            }
                          },
                          child: const Text('Sign In'),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      );
                    },
                    child: const Text('Create an Account'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


