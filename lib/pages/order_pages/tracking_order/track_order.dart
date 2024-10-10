import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery_app/pages/cart_pages/cart_provider.dart';
import 'package:food_delivery_app/pages/order_pages/help/help.dart';
import 'package:provider/provider.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
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
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Help()));
                },
                child: const Text(
                  'Help    ',
                  style: TextStyle(fontSize: 15),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '22 Jul 2024 at 12:30 pm',
                  style: theme.headlineMedium?.copyWith(fontSize: 20),
                ),
                Row(
                  children: [
                    Text(
                      'Delivery partner assigned',
                      style: theme.bodyLarge?.copyWith(
                          fontSize: 14, color: const Color(0xFF111111)),
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return DraggableScrollableSheet(
                                  initialChildSize: 1,
                                  maxChildSize: 1,
                                  builder: (BuildContext context,
                                      ScrollController scrollController) {
                                    return Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Positioned.fill(
                                          child: SvgPicture.asset(
                                              'assets/svg/track_order/estimated.svg',
                                              fit: BoxFit.fill),
                                        ),
                                      ],
                                    );
                                  });
                            });
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 13,
                      ),
                    )
                  ],
                ),
                Text(
                  'Estimated pickup in 10 mins',
                  style: theme.bodyMedium?.copyWith(fontSize: 12),
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/track_order/timer1.svg',
                    ),
                    Positioned(
                      child: SvgPicture.asset(
                        'assets/svg/track_order/timer.svg',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Container(
                      height: 224,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/track_order/map.png'))),
                    ),
                    Positioned(
                        left: 20,
                        bottom: 10,
                        child: SvgPicture.asset(
                          'assets/svg/track_order/otp.svg',
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(
                    left: 0,
                  ),
                  leading: Image.asset(
                    'assets/images/track_order/pizza_hut.jpeg',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  tileColor: Colors.white,
                  title: Text(
                    'Pizza Hut',
                    style: theme.titleMedium,
                  ),
                  subtitle: Text(
                    'Banjara hills, Banjara Hills, Hyderabad,Telangana, 500034',
                    style: theme.labelMedium,
                  ),
                  trailing: SvgPicture.asset('assets/svg/track_order/call.svg'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: colorTheme.indicatorColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(
                    left: 0,
                  ),
                  leading: const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/images/track_order/profile_image.png'),
                  ),
                  tileColor: Colors.white,
                  title: Text(
                    'John Doe',
                    style: theme.titleMedium,
                  ),
                  trailing: SvgPicture.asset('assets/svg/track_order/call.svg'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: colorTheme.indicatorColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<CartProvider>(
                  builder: (context, provider, child) =>
                      provider.cart.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order Summary',
                                  style: theme.headlineSmall,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(3),
                                    1: FlexColumnWidth(1)
                                  },
                                  border: const TableBorder(
                                    horizontalInside: BorderSide.none,
                                    verticalInside: BorderSide.none,
                                  ),
                                  children: [
                                    ...provider.cart.map(
                                      (item) {
                                        return TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 6,
                                            ),
                                            child: Text(
                                              '${item[2]}:',
                                              textAlign: TextAlign.left,
                                              style: theme.bodyLarge,
                                            ),
                                          ),
                                          Text(
                                            '₹ ${double.parse(item[4]).toStringAsFixed(2)}',
                                            textAlign: TextAlign.right,
                                            style: theme.titleMedium,
                                          )
                                        ]);
                                      },
                                    ),
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 6,
                                        ),
                                        child: Text(
                                          'Packaging Charge:',
                                          textAlign: TextAlign.left,
                                          style: theme.bodyLarge,
                                        ),
                                      ),
                                      Text(
                                        '₹ 40.00',
                                        textAlign: TextAlign.right,
                                        style: theme.titleMedium,
                                      )
                                    ]),
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 6,
                                        ),
                                        child: Text(
                                          'Delivery Charge:',
                                          textAlign: TextAlign.left,
                                          style: theme.bodyLarge
                                              ?.copyWith(color: Colors.green),
                                        ),
                                      ),
                                      Text(
                                        '₹ 0.00',
                                        textAlign: TextAlign.right,
                                        style: theme.titleMedium
                                            ?.copyWith(color: Colors.green),
                                      )
                                    ]),
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 6,
                                        ),
                                        child: Text(
                                          'Tax:',
                                          textAlign: TextAlign.left,
                                          style: theme.bodyLarge,
                                        ),
                                      ),
                                      Text(
                                        '₹ 18.20',
                                        textAlign: TextAlign.right,
                                        style: theme.titleMedium,
                                      )
                                    ]),
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 6,
                                        ),
                                        child: Text(
                                          'Coupon Discount:',
                                          textAlign: TextAlign.left,
                                          style: theme.bodyLarge
                                              ?.copyWith(color: Colors.green),
                                        ),
                                      ),
                                      Text(
                                        '- ₹ 182.06',
                                        textAlign: TextAlign.right,
                                        style: theme.titleMedium
                                            ?.copyWith(color: Colors.green),
                                      )
                                    ]),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: colorTheme.shadowColor,
                                  thickness: 1.0,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Total bill',
                                      style: theme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '₹ ${provider.totalCost().toStringAsFixed(2)}',
                                      style: theme.titleLarge,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: colorTheme.shadowColor,
                                  thickness: 1.0,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                          : const Text(''),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Delivery Details',
                  style: theme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    'assets/svg/icons/location.svg',
                    height: 30,
                    width: 30,
                  ),
                  title: Text(
                    'Address',
                    style: theme.titleMedium,
                  ),
                  subtitle: Text(
                    'Banjara hills, Banjara Hills, Hyderabad,Telangana, 500034',
                    style: theme.labelMedium,
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    'assets/svg/track_order/phone.svg',
                    height: 30,
                    width: 30,
                  ),
                  title: Text(
                    'Phone Number',
                    style: theme.titleMedium,
                  ),
                  subtitle: Text(
                    '9876543210',
                    style: theme.labelMedium,
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    'assets/svg/track_order/order_number.svg',
                    height: 30,
                    width: 30,
                  ),
                  title: Text(
                    'Order Number',
                    style: theme.titleMedium,
                  ),
                  subtitle: Text(
                    'ONDC_151421TwEXCj',
                    style: theme.labelMedium,
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    'assets/svg/track_order/wallet.svg',
                    height: 30,
                    width: 30,
                  ),
                  title: Text(
                    'Payment Mode',
                    style: theme.titleMedium,
                  ),
                  subtitle: Text(
                    'UPI',
                    style: theme.labelMedium,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
