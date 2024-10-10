import 'package:flutter/material.dart';

class OrderRelatedIssue extends StatefulWidget {
  const OrderRelatedIssue({super.key});

  @override
  State<OrderRelatedIssue> createState() => _OrderRelatedIssueState();
}

class _OrderRelatedIssueState extends State<OrderRelatedIssue> {
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
        title: const Text('Order Related'),
      ),
      body: Column(
        children: [
          Divider(
            color: colorTheme.indicatorColor,
          ),
          ListTile(
            tileColor: Colors.white,
            title: Text(
              'Selected Wrong Order',
              style: theme.bodyLarge?.copyWith(
                  color: const Color(0xFF333333),
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
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
              'Where is my order',
              style: theme.bodyLarge?.copyWith(
                  color: const Color(0xFF333333),
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
