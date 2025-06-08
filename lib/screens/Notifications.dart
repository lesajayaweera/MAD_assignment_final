import 'package:flutter/material.dart';
import 'package:my_app/components/common/myappBar.dart';


class NotificationItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final bool isRead; // Default value for read status
  final String date;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.date,
    this.isRead = false,
  });
}


class Notifications extends StatelessWidget {
   Notifications({super.key});

//  Notification samples
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Order Successful!',
      subtitle: 'Your order #234 was placed successfully.',
      icon: Icons.check_circle,
      iconColor: Colors.green,
      date: '2023-10-01',
      isRead: false, // Default value for read status
    ),
    NotificationItem(
      title: 'New Message',
      subtitle: 'You have a new message from John.',
      icon: Icons.message,
      iconColor: Colors.blue,
      date: '2023-10-02',
      isRead: false, // Default value for read status
    ),
    NotificationItem(
      title: 'Delivery Update',
      subtitle: 'Your package will arrive tomorrow.',
      icon: Icons.local_shipping,
      iconColor: Colors.orange,
      date: '2023-10-03',
      isRead: false, // Default value for read status
    ),
    NotificationItem(
      title: 'Payment Received',
      subtitle: 'We have received your payment.',
      icon: Icons.payment,
      iconColor: Colors.purple,
      date: '2023-10-04',
      isRead: true, // Default value for read status
    ),
    NotificationItem(
      title: 'Payment Unsuccessful',
      subtitle: 'Your payment was not successful.',
      icon: Icons.error,
      iconColor: Colors.red.shade400,
      date: '2023-10-05',
      isRead: true, // Default value for read status
    ),
    NotificationItem(
      title: 'New Feature Available',
      subtitle: 'Check out the new features in the app.',
      icon: Icons.new_releases,
      iconColor: Colors.teal,
      date: '2023-10-06',
      isRead: true, // Default value for read status
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Container(
              color: item.isRead ? Colors.transparent : Colors.black12,
              margin: EdgeInsets.only(top: 5,left: 5,right: 5),
              padding: EdgeInsets.all(10),
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.iconColor.withOpacity(0.2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(item.icon, color: item.iconColor),
                ),
              ),
              title: Text(
                item.title,
                style: const TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(item.subtitle),
              trailing: Text(
                item.date,
                style: const TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        },
      );
  }
}
