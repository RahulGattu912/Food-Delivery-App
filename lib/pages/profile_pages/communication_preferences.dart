import 'package:flutter/material.dart';

class CommunicationPreferences extends StatefulWidget {
  const CommunicationPreferences({super.key});

  @override
  State<CommunicationPreferences> createState() =>
      _CommunicationPreferencesState();
}

class _CommunicationPreferencesState extends State<CommunicationPreferences> {
  bool _isSelected = false;
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
          title: const Text('Communication Preferences'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.justify,
                'User Communication Preferences allows a user who has access to multiple channels to control how, when, and where they receive messages. Users define filters, or delivery preferences, that specify which channel a message should be delivered to, and under what circumstances',
                style:
                    theme.bodyLarge?.copyWith(color: const Color(0xFF767676)),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Checkbox(
                      value: _isSelected,
                      activeColor: colorTheme.primaryColor,
                      onChanged: (value) {
                        setState(() {
                          _isSelected = value!;
                        });
                      }),
                  Text(
                    'I want to receive delivery news & offers',
                    style: theme.titleSmall?.copyWith(fontSize: 14),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
