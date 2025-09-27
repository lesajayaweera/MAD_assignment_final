import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WebTestScreen extends StatefulWidget {
  @override
  _WebTestScreenState createState() => _WebTestScreenState();
}

class _WebTestScreenState extends State<WebTestScreen> {
  String _status = 'Click to test API connection';
  bool _isLoading = false;
  List<dynamic> _vehicles = [];

  Future<void> testApiConnection() async {
    setState(() {
      _isLoading = true;
      _status = 'Testing connection to Laravel API...';
    });

    try {
      final response = await http.get(
        Uri.parse('https://ssp-final-assignment-production.up.railway.app//api/vehicles'),
        headers: {'Accept': 'application/json'},
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _status = '✅ API Connection Successful!';
          _vehicles = data['data'] ?? [];
        });
      } else {
        setState(() {
          _status = '❌ API Error: ${response.statusCode}\n${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _status = '❌ Connection Failed: $e\n\nMake sure Laravel is running on port 8000';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> testLogin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': 'lesanduluthmeen@gmail.com', // Use your test user
          'password': 'lesandu123',
        }),
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _status = '✅ Login Successful!\nUser: ${data['user']['name']}';
        });
      } else {
        setState(() {
          _status = '❌ Login Failed: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _status = '❌ Login Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Web + Laravel API Test')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flutter Web (Chrome) + Laravel API Test',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Laravel URL: http://192.168.8.183:8000/api'),
            Text('Flutter running in: Chrome'),
            SizedBox(height: 20),
            
            Row(
              children: [
                ElevatedButton(
                  onPressed: _isLoading ? null : testApiConnection,
                  child: Text('Test API Connection'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _isLoading ? null : testLogin,
                  child: Text('Test Login'),
                ),
              ],
            ),
            
            SizedBox(height: 20),
            if (_isLoading) CircularProgressIndicator(),
            
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status:', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    SelectableText(
                      _status,
                      style: TextStyle(
                        color: _status.contains('✅') ? Colors.green : 
                               _status.contains('❌') ? Colors.red : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            if (_vehicles.isNotEmpty) ...[
              SizedBox(height: 20),
              Text('Vehicles Found: ${_vehicles.length}', 
                   style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  itemCount: _vehicles.length,
                  itemBuilder: (context, index) {
                    final vehicle = _vehicles[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.directions_car),
                        title: Text('${vehicle['make']} ${vehicle['model']}'),
                        subtitle: Text('\$${vehicle['price']} • ${vehicle['year']}'),
                        trailing: Text(vehicle['status'] ?? 'Available'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}