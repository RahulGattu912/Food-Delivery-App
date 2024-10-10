import 'package:flutter/material.dart';

class DeliveryRelatedIssue extends StatefulWidget {
  const DeliveryRelatedIssue({super.key});

  @override
  State<DeliveryRelatedIssue> createState() => _DeliveryRelatedIssueState();
}

class _DeliveryRelatedIssueState extends State<DeliveryRelatedIssue> {
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
        title: const Text('Delivery Related'),
      ),
      body: Column(
        children: [
          Divider(
            color: colorTheme.indicatorColor,
          ),
          ListTile(
            tileColor: Colors.white,
            title: Text(
              'Selected Wrong Address',
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
