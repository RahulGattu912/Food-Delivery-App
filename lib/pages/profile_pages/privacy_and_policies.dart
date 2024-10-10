import 'package:flutter/material.dart';

class PrivacyAndPolicies extends StatefulWidget {
  const PrivacyAndPolicies({super.key});

  @override
  State<PrivacyAndPolicies> createState() => _PrivacyAndPoliciesState();
}

class _PrivacyAndPoliciesState extends State<PrivacyAndPolicies> {
  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;

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
          title: const Text('Privacy and Policies'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. Types data we collect',
                  style: theme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  textAlign: TextAlign.justify,
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. \n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident.',
                  style:
                      theme.bodyLarge?.copyWith(color: const Color(0xFF767676)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '2. Use of your personal data',
                  style: theme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  textAlign: TextAlign.justify,
                  'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae.\n\nNemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.',
                  style:
                      theme.bodyLarge?.copyWith(color: const Color(0xFF767676)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '3. Disclosure of your personal data',
                  style: theme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  textAlign: TextAlign.justify,
                  'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. \n\nEt harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. \n\nTemporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus',
                  style:
                      theme.bodyLarge?.copyWith(color: const Color(0xFF767676)),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
