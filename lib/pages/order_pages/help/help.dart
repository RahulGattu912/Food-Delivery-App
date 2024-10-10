import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/order_pages/help/delivery_related_issue.dart';
import 'package:food_delivery_app/pages/order_pages/help/order_related_issue.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
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
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text('Choose an Issue'),
      ),
      body: Column(
        children: [
          Divider(
            color: colorTheme.indicatorColor,
          ),
          ListTile(
            tileColor: Colors.white,
            title: Text(
              'Delivery Related',
              style: theme.bodyLarge?.copyWith(
                  color: const Color(0xFF333333),
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DeliveryRelatedIssue()));
                },
                icon: const Icon(Icons.arrow_forward_ios)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Divider(
              color: colorTheme.indicatorColor,
            ),
          ),
          ListTile(
            tileColor: Colors.white,
            title: Text(
              'Order Related',
              style: theme.bodyLarge?.copyWith(
                  color: const Color(0xFF333333),
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderRelatedIssue()));
                },
                icon: const Icon(Icons.arrow_forward_ios)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Divider(
              color: colorTheme.indicatorColor,
            ),
          ),
          ListTile(
            tileColor: Colors.white,
            title: Text(
              'Your Tickets',
              style: theme.bodyLarge?.copyWith(
                  color: const Color(0xFF333333),
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
          ),
          Divider(
            color: colorTheme.indicatorColor,
          ),
          ListTile(
            tileColor: Colors.white,
            title: Text(
              'Other Help Topics',
              style: theme.bodyLarge?.copyWith(
                  color: colorTheme.primaryColor, //const Color(0xFF007AFF),
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
