import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';

class ShakeDetector {
  static const double shakeThreshold = 15.0; // Adjust sensitivity
  static const int shakeDuration = 200; // milliseconds
  
  DateTime? _lastShakeTime;
  StreamSubscription<AccelerometerEvent>? _subscription;
  
  void startListening(Function onShake) {
    _subscription = accelerometerEventStream().listen((AccelerometerEvent event) {
      final double acceleration = sqrt(
        event.x * event.x + event.y * event.y + event.z * event.z
      );
      
      // Detect shake (strong acceleration)
      if (acceleration > shakeThreshold) {
        final now = DateTime.now();
        
        // Prevent multiple triggers
        if (_lastShakeTime == null || 
            now.difference(_lastShakeTime!).inMilliseconds > shakeDuration) {
          _lastShakeTime = now;
          onShake();
        }
      }
    });
  }
  
  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }
}