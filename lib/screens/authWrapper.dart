import 'package:flutter/material.dart';
import 'package:my_app/Classes/apiService.dart';
import 'package:my_app/Dashboard.dart';
import 'package:my_app/screens/Login.dart';


class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  String? _token;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final token = await ApiService.getToken();
    setState(() {
      _token = token;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // If token exists → Dashboard, else Login
    return _token != null
        ? Dashboard(token: _token!)
        : Login(
            login: () {
              // When login successful → refresh auth state
              _checkAuth();
            },
          );
  }
}
