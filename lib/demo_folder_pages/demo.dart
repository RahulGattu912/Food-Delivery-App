import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/pages/cart_pages/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage1 extends StatefulWidget {
  const CartPage1({super.key});

  @override
  State<CartPage1> createState() => _CartPage1State();
}

class _CartPage1State extends State<CartPage1> {
  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    final ThemeData colorTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<CartProvider>(
        builder: (context, provider, child) => SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: provider.cart.isEmpty
                ? Center(
                    child: Text(
                      'Cart Is Empty',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: colorTheme.primaryColor),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cart',
                        style: theme.headlineSmall,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (provider.cart.isNotEmpty) ...[
                        Text(
                          provider.cart[0][0],
                          style: theme.headlineMedium,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          provider.cart[0][1],
                          style: theme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                      Container(
                        height: 32,
                        width: 136,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                                color: colorTheme.primaryColor, width: 1.0)),
                        child: Center(
                          child: Text(
                            '30 Minutes',
                            style: theme.titleMedium
                                ?.copyWith(color: colorTheme.primaryColor),
                          ),
                        ),
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
                      Container(
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: colorTheme.primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            'You saved ₹243 on this order',
                            style: theme.titleMedium
                                ?.copyWith(color: const Color(0xFFFFFFFF)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 200, // Provide an explicit height
                        child: ListView.builder(
                          itemCount: provider.cart.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Container(
                                width: 50, // Provide a fixed width for image
                                height: 50, // Provide a fixed height for image
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: AssetImage(provider.cart[index][3]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(provider.cart[index][1]),
                              subtitle: Text(provider.cart[index][2]),
                              trailing: Text(provider.cart[index][4]),
                            );
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: provider.reset,
                        child: const Text('Clear Cart'),
                      ),
                      const SizedBox(
                        height: 200,
                      ),
                      /*ListTile(
                    leading: SvgPicture.asset('assets/svg/veg_non-veg/veg.svg'),
                    title: Text(
                      'Cookie Sandwich',
                      style: theme.titleMedium?.copyWith(fontSize: 20),
                    ),
                    subtitle: Text(
                      '₹250',
                      style: theme.titleLarge
                          ?.copyWith(color: colorTheme.primaryColor),
                    ),
                    trailing: Container(
                      height: 32,
                      width: 96,
                      decoration: BoxDecoration(
                          border: Border.all(color: colorTheme.shadowColor),
                          borderRadius: BorderRadius.circular(32)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Text(
                            '+',
                            style: theme.titleMedium
                                ?.copyWith(color: colorTheme.primaryColor),
                          ),
                          const Spacer(),
                          Text(
                            '1',
                            style: theme.titleMedium
                                ?.copyWith(color: colorTheme.primaryColor),
                          ),
                          const Spacer(),
                          Text(
                            '-',
                            style: theme.titleMedium
                                ?.copyWith(color: colorTheme.primaryColor),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading:
                        SvgPicture.asset('assets/svg/veg_non-veg/non_veg.svg'),
                    title: Text(
                      'Chicken Sandwich',
                      style: theme.titleMedium?.copyWith(fontSize: 20),
                    ),
                    subtitle: Text(
                      '₹300',
                      style: theme.titleLarge
                          ?.copyWith(color: colorTheme.primaryColor),
                    ),
                    trailing: Container(
                      height: 32,
                      width: 96,
                      decoration: BoxDecoration(
                          border: Border.all(color: colorTheme.shadowColor),
                          borderRadius: BorderRadius.circular(32)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Text(
                            '+',
                            style: theme.titleMedium
                                ?.copyWith(color: colorTheme.primaryColor),
                          ),
                          const Spacer(),
                          Text(
                            '2',
                            style: theme.titleMedium
                                ?.copyWith(color: colorTheme.primaryColor),
                          ),
                          const Spacer(),
                          Text(
                            '-',
                            style: theme.titleMedium
                                ?.copyWith(color: colorTheme.primaryColor),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),*/

                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color(0xFFFEA187)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 14, left: 24),
                              child: Text(
                                'You’re saving ₹182.06 on this order',
                                style: theme.titleMedium,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24.0, top: 8.0, bottom: 14),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/svg/icons/coupon.svg'),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'FOOD50 Applied',
                                    style: theme.bodyMedium
                                        ?.copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Summary',
                            style: theme.headlineSmall,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Cookie Sandwich:',
                                style: theme.bodyLarge,
                              ),
                              const Spacer(),
                              Text(
                                '₹ 250.00',
                                style: theme.titleMedium,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Chicken Sandwich:',
                                style: theme.bodyLarge,
                              ),
                              const Spacer(),
                              Text(
                                '₹ 300.00',
                                style: theme.titleMedium,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Packaging Charge:',
                                style: theme.bodyLarge,
                              ),
                              const Spacer(),
                              Text(
                                '₹ 40.00',
                                style: theme.titleMedium,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Delivery Charge:',
                                style: theme.bodyLarge,
                              ),
                              const Spacer(),
                              Text(
                                '₹ 0.00',
                                style: theme.titleMedium
                                    ?.copyWith(color: Colors.green),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Tax',
                                style: theme.bodyLarge,
                              ),
                              const Spacer(),
                              Text(
                                '₹ 18.20',
                                style: theme.titleMedium,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Coupon Discount',
                                style: theme.bodyLarge,
                              ),
                              const Spacer(),
                              Text(
                                '- ₹ 182.06',
                                style: theme.titleMedium
                                    ?.copyWith(color: Colors.green),
                              )
                            ],
                          ),
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
                            'Total Bill',
                            style:
                                theme.bodyLarge?.copyWith(color: Colors.black),
                          ),
                          const Spacer(),
                          Text(
                            '₹425.6',
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
                        height: 30,
                      ),
                      Text(
                        'Note',
                        style: theme.titleLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Lorem ipsum dolor sit amet consectetur. Pretium vitae venenatis arcu ac mauris ridiculus tempor sed. Vitae amet elit ante a viverra ut pharetra a. Non diam eget neque dignissim vitae. Eget dolor at ornare nisi lectus tincidunt. Lorem ipsum dolor sit amet consectetur. Pretium vitae venenatis arcu ac mauris ridiculus tempor sed. ',
                        style: theme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 100,
                      )
                      // Rest of your code remains the same
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
