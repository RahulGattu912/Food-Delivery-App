import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/navigation_page/navigation_page.dart';
import 'package:food_delivery_app/pages/order_pages/tracking_order/track_order.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
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
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NavigationPage(
                            initialIndex: 0,
                          )),
                  (Route<dynamic> route) => false);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text('My Orders'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 270,
                padding: const EdgeInsets.all(16),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 72,
                              width: 72,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/offers/img1.jpeg'))),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '3 Items',
                                  style: theme.labelLarge,
                                ),
                                Text(
                                  'Pizza Hut',
                                  style: theme.titleMedium,
                                )
                              ],
                            ),
                            const Spacer(),
                            Text(
                              '#264100',
                              style: theme.titleMedium?.copyWith(
                                  color: colorTheme.primaryColor, fontSize: 20),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Estimated Arrival',
                              style: theme.labelMedium,
                            ),
                            const Spacer(),
                            Text(
                              'Now',
                              style: theme.labelMedium,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Baseline(
                              baseline: 30,
                              baselineType: TextBaseline.alphabetic,
                              child: Text(
                                '25',
                                style: theme.headlineMedium,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Baseline(
                              baseline: 30,
                              baselineType: TextBaseline.alphabetic,
                              child: Text(
                                'min',
                                style: theme.headlineMedium
                                    ?.copyWith(fontSize: 20),
                              ),
                            ),
                            const Spacer(),
                            Baseline(
                              baseline: 30,
                              baselineType: TextBaseline.alphabetic,
                              child: Text(
                                'Food on the way',
                                style: theme.headlineMedium
                                    ?.copyWith(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 8, bottom: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: colorTheme.indicatorColor),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                'Cancel',
                                style: theme.titleSmall
                                    ?.copyWith(color: colorTheme.primaryColor),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TrackOrder()));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: colorTheme.primaryColor,
                                    border: Border.all(
                                        color: colorTheme.indicatorColor),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                  child: Text(
                                    'Track Order',
                                    style: theme.titleSmall
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer()
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            Container(
                height: 200,
                padding: const EdgeInsets.all(16),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 72,
                              width: 72,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/offers/img1.jpeg'))),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '3 Items',
                                  style: theme.labelLarge,
                                ),
                                Text(
                                  'Pizza Hut',
                                  style: theme.titleMedium,
                                )
                              ],
                            ),
                            const Spacer(),
                            Text(
                              '₹850',
                              style: theme.titleMedium?.copyWith(
                                  color: colorTheme.primaryColor, fontSize: 20),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 92,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Container(
                              height: 3,
                              width: 3,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(32)),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Order Delivered',
                              style: theme.labelMedium
                                  ?.copyWith(color: Colors.green),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 8, bottom: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: colorTheme.indicatorColor),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                'Rate',
                                style: theme.titleSmall
                                    ?.copyWith(color: colorTheme.primaryColor),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: colorTheme.primaryColor,
                                  border: Border.all(
                                      color: colorTheme.indicatorColor),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Text(
                                  'Re-Order',
                                  style: theme.titleSmall
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            const Spacer()
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            Container(
                height: 200,
                padding: const EdgeInsets.all(16),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 72,
                              width: 72,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/offers/img1.jpeg'))),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '3 Items',
                                  style: theme.labelLarge,
                                ),
                                Text(
                                  'Pizza Hut',
                                  style: theme.titleMedium,
                                )
                              ],
                            ),
                            const Spacer(),
                            Text(
                              '₹850',
                              style: theme.titleMedium?.copyWith(
                                  color: colorTheme.primaryColor, fontSize: 20),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 92,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Container(
                              height: 3,
                              width: 3,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(32)),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Order Cancelled',
                              style: theme.labelMedium
                                  ?.copyWith(color: Colors.red),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 8, bottom: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: colorTheme.indicatorColor),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                'Rate',
                                style: theme.titleSmall
                                    ?.copyWith(color: colorTheme.primaryColor),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: colorTheme.primaryColor,
                                  border: Border.all(
                                      color: colorTheme.indicatorColor),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Text(
                                  'Re-Order',
                                  style: theme.titleSmall
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            const Spacer()
                          ],
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
