import 'package:flutter/material.dart';
import 'package:my_app/Classes/authService.dart';
import 'package:my_app/screens/Register.dart';

class Login extends StatefulWidget {
  final VoidCallback login;
  Login({super.key, required this.login});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // initializing the variables
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isOpen = true;

  bool isLoading = false;
  // method to the login the user
  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Start loading
      });

      try {
        // Call AuthService with user inputs
        final response = await AuthService.login(
          emailController.text,
          passwordController.text,
        );

        // Check if token is present (success)
        if (response['token'] != null) {
          widget
              .login(); // Call the callback to proceed (e.g., navigate to home)
        } else {
          // Handle unexpected response
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login failed: Invalid response from server'),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        // Handle errors like network issues or invalid credentials
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${e.toString()}'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } finally {
        setState(() {
          isLoading = false; // Stop loading
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('asset/image/logo.png'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Welcome to LuxCars',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'poppins',
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.alternate_email_rounded),
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              } else if (value.length < 6) {
                                return 'Email is too short';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _formKey.currentState?.validate();
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: isOpen,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isOpen
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isOpen = !isOpen;
                                  });
                                },
                              ),
                              labelText: 'Password',
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              // Optional: Live validation
                              _formKey.currentState?.validate();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            // Handle forgot password
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'poppins',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : login, // Disable if loading
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(200, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      // Show spinner
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'poppins',
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account? ',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'poppins',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Register(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'poppins',
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
