import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final String date;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.date,
    this.isRead = false,
  });
}

// Global notification list
List<NotificationItem> notifications = [];