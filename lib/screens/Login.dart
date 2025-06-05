import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: SafeArea(
    child: SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Changed to 'center'
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40), // Top padding
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('asset/image/logo.png'),
            ),
            SizedBox(height: 20),
            Text(
              'Login',
              style: TextStyle(fontSize: 32,fontFamily: 'poppins', fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Welcome to LuxCars',
              style: TextStyle(fontSize: 24,fontFamily: 'poppins', color: Colors.grey.shade600, ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.alternate_email_rounded),
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(

                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),

            ),

            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Handle forgot password action
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 16, fontFamily: 'poppins', color: Colors.black87),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  
                  
                  onPressed: () {
                    // Handle login action
                  },
                  style: TextButton.styleFrom(
                    
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white, // Button color
                    minimumSize: Size(200, 50), // Set button width and height
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                  child: Text('Login', style: TextStyle(fontSize: 20,fontFamily: 'poppins')),

                  
                ),
                
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account? ',
                  style: TextStyle(fontSize: 16, fontFamily: 'poppins'),
                ),
                TextButton(
                  onPressed: () {
                    // Handle sign up action
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16, fontFamily: 'poppins', color: Colors.blue),
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