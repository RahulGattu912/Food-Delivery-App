import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    final ThemeData colorTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Notifications'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFC0C0C0)),
              borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            title: Text(
              'Promos and Offers',
              style: theme.titleSmall?.copyWith(fontSize: 14),
            ),
            subtitle: const Text(
                'Receive WhatsApp updates about coupons, promotions and  offers'),
            trailing: Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
              activeColor: colorTheme.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
