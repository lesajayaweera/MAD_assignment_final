// import 'package:flutter/material.dart';
// import 'package:my_app/Classes/authService.dart';
// import 'package:my_app/main.dart';
// import 'package:my_app/screens/home.dart';

// class Register extends StatefulWidget {
//   const Register({super.key});

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final phoneController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   var isOpen = false;

//   //  fake method to register the user
//   void Register() async {
//     if (_formKey.currentState!.validate()) {

//       try{

//         final name = nameController.text;
//         final email = emailController.text;
//         final password = passwordController.text;
//         final confirmPassword = passwordController.text;

//         final response = await AuthService.register(name, email, password, confirmPassword);

//         if(response['token'] != null){
//           print('Registration successful, token: ${response['token']}');
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
//         } else {
//           print('Registration failed: $response');
//         }
//       } catch (e) {
//         print('Error occurred during registration: $e');
//       }
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Registration was Successful!'),
//           backgroundColor: Colors.greenAccent,
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Invalid email or password'),
//           backgroundColor: Colors.redAccent,
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               // Changed to 'center'
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: 40), // Top padding
//                 CircleAvatar(
//                   radius: 70,
//                   backgroundImage: AssetImage('asset/image/logo.png'),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Sign Up',
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontFamily: 'poppins',
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Find Your Dream Car',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontFamily: 'poppins',
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//                 SizedBox(height: 40),

//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                         child: TextFormField(
//                           onChanged: (value) {
//                             _formKey.currentState?.validate();
//                           },
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.person),
//                             labelText: 'Name',
//                             border: OutlineInputBorder(),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your name';
//                             } else if (value.length < 6) {
//                               return 'Name is too short';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.alternate_email_rounded),
//                             labelText: 'Email',
//                             border: OutlineInputBorder(),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your email';
//                             } else if (!value.contains('@')) {
//                               return 'Please enter a valid email';
//                             } else if (value.length < 6) {
//                               return 'Email is too short';
//                             }
//                             return null;
//                           },
//                           onChanged: (value) {
//                             _formKey.currentState?.validate();
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                         child: TextFormField(
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.phone),
//                             labelText: 'Phone Number',
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                         child: TextFormField(
//                           obscureText: isOpen,
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.lock),
//                             suffixIcon: IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   isOpen = !isOpen;
//                                 });
//                               },
//                               icon: Icon(
//                                 isOpen
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                               ),
//                             ),
//                             labelText: 'Password',
//                             border: OutlineInputBorder(),
//                           ),
//                           onChanged: (value) {
//                             // Optional: Live validation
//                             _formKey.currentState?.validate();
//                           },
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your password';
//                             } else if (value.length < 6) {
//                               return 'Password must be at least 6 characters';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),

//                       SizedBox(height: 20),
//                     ],
//                   ),
//                 ),

//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Handle login action
//                       },
//                       style: ElevatedButton.styleFrom(

//                         // Button color
//                         minimumSize: Size(200, 50),
//                         // Set button width and height
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(
//                             10,
//                           ), // Rounded corners
//                         ),
//                       ),
//                       child: Text(
//                         'Sign Up',
//                         style: TextStyle(fontSize: 20, fontFamily: 'poppins'),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Have an account? ',
//                       style: TextStyle(fontSize: 16, fontFamily: 'poppins'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
//                       },
//                       child: Text(
//                         'Login',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontFamily: 'poppins',
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:my_app/Classes/authService.dart';
import 'package:my_app/main.dart';
import 'package:my_app/screens/home.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController =
      TextEditingController(); // Added for confirm password
  final phoneController =
      TextEditingController(); // Optional, if needed by backend
  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = true; // Renamed for clarity
  bool isConfirmPasswordVisible = true; // For confirm password field

  bool isLoading = false; // To manage loading state

  // Register method
  void register() async {
    
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Start loading
      });
      try {
        final name = nameController.text;
        final email = emailController.text;
        final password = passwordController.text;
        final confirmPassword = confirmPasswordController.text;

        final response = await AuthService.register(
          name,
          email,
          password,
          confirmPassword,
        );

        if (response['token'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration successful!'),
              backgroundColor: Colors.greenAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Registration failed: ${response['message'] ?? 'Unknown error'}',
              ),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      finally {
        setState(() {
          isLoading = false; // Stop loading
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors in the form'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('asset/image/logo.png'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Find Your Dream Car',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'poppins',
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 40),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Name Field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            } else if (value.length < 6) {
                              return 'Name must be at least 6 characters';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _formKey.currentState?.validate();
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Email Field
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

                      // Phone Number Field (Optional)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            labelText: 'Phone Number (Optional)',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                return 'Enter a valid 10-digit phone number';
                              }
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _formKey.currentState?.validate();
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password Field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: isPasswordVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            labelText: 'Password',
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _formKey.currentState?.validate();
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Confirm Password Field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: confirmPasswordController,
                          obscureText: isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordVisible =
                                      !isConfirmPasswordVisible;
                                });
                              },
                              icon: Icon(
                                isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            labelText: 'Confirm Password',
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            } else if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _formKey.currentState?.validate();
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                // Sign Up Button
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: register, // Connect to register method
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
                                Colors.black,
                              ),
                            )
                          : const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'poppins',
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Have an account? ',
                      style: TextStyle(fontSize: 16, fontFamily: 'poppins'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyApp(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
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
        ),
      ),
    );
  }
}
