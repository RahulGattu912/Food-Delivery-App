import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/profile_pages/language/lang.dart';

class Languages extends StatefulWidget {
  const Languages({super.key});

  @override
  State<Languages> createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  String _isSelected = 'English';
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
          title: const Text('Languages'),
        ),
        body: ListView.builder(
            itemCount: languages.length,
            padding: const EdgeInsets.only(left: 8),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  RadioListTile(
                      title: Text(
                        languages[index],
                        style: theme.bodyLarge
                            ?.copyWith(color: const Color(0xFF333333)),
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: languages[index],
                      groupValue: _isSelected,
                      activeColor: colorTheme.primaryColor,
                      onChanged: (String? value) {
                        setState(() {
                          _isSelected = value!;
                        });
                      }),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Divider(
                      color: colorTheme.indicatorColor,
                    ),
                  ),
                ],
              );
            }));
  }
}
