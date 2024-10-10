import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery_app/pages/address/address.dart';

class Myaddresses extends StatefulWidget {
  const Myaddresses({super.key});

  @override
  State<Myaddresses> createState() => _MyaddressesState();
}

class _MyaddressesState extends State<Myaddresses> {
  Widget addressSpace({required String title, required String subtitle}) {
    return Container(
      height: 76,
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFC0C0C0)),
          borderRadius: BorderRadius.circular(16)),
      child: Center(
        child: ListTile(
          leading: SvgPicture.asset('assets/svg/bookmark/home.svg'),
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: 'DMSans',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFFFE724C),
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              fontFamily: 'DMSans',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF767676),
            ),
          ),
          trailing: const Icon(
            Icons.more_vert,
            size: 16,
          ),
        ),
      ),
    );
  }

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
        title: const Text('My Addresses'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyAddress()));
              },
              child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: colorTheme.indicatorColor,
                      )),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '+',
                        style: theme.bodyLarge?.copyWith(
                            color: colorTheme.primaryColor, fontSize: 24),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        'Add Address',
                        style: theme.bodyLarge?.copyWith(
                            color: colorTheme.primaryColor, fontSize: 15),
                      )
                    ],
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Saved Addresses',
              style: theme.bodyLarge?.copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            addressSpace(
                title: 'Home',
                subtitle: '301 8-2-684/4/5 Anand Banjara Colony'),
            const SizedBox(height: 8),
            addressSpace(
                title: 'Sai', subtitle: '301 8-2-684/4/5 Anand Banjara Colony'),
            const SizedBox(height: 8),
            addressSpace(
                title: 'Other',
                subtitle: '301 8-2-684/4/5 Anand Banjara Colony'),
            const SizedBox(height: 8),
            addressSpace(
                title: 'Work',
                subtitle: '301 8-2-684/4/5 Anand Banjara Colony'),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
