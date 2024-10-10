import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery_app/pages/order_pages/help/help.dart';
import 'package:food_delivery_app/pages/order_pages/order_history/order_provider.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
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
                  'General Info',
                  style: theme.headlineMedium?.copyWith(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Order ID :',
                      style: theme.bodyLarge?.copyWith(
                          fontSize: 14, color: const Color(0xFF767676)),
                    ),
                    const Spacer(),
                    Text(
                      '247-96024',
                      textAlign: TextAlign.right,
                      style: theme.titleMedium?.copyWith(fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Order Date :',
                      style: theme.bodyLarge?.copyWith(
                          fontSize: 14, color: const Color(0xFF767676)),
                    ),
                    const Spacer(),
                    Text(
                      '20/04/2024, 04:30',
                      textAlign: TextAlign.right,
                      style: theme.titleMedium?.copyWith(fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
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
                Text(
                  'Product Info',
                  style: theme.titleLarge,
                ),
                Consumer<OrderProvider>(
                  builder: (context, orderProvider, child) {
                    List<List<dynamic>> orders = orderProvider.currentOrder;
                    return SizedBox(
                      height: 60.0 * orders.length,
                      child: ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(orders[index][0],
                                  style: theme.bodyLarge?.copyWith(
                                      color: const Color(0xFF333333))),
                              trailing: Text(
                                '₹${orders[index][3]} x ${orders[index][5].toString()}',
                                style: theme.titleMedium,
                              ),
                            );
                          }),
                    );
                  },
                ),
                Divider(
                  color: colorTheme.indicatorColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<OrderProvider>(
                  builder: (context, orderProvider, child) =>
                      orderProvider.currentOrder.isNotEmpty
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
                                    ...orderProvider.currentOrder.map(
                                      (item) {
                                        return TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 6,
                                            ),
                                            child: Text(
                                              '${item[0]}:',
                                              textAlign: TextAlign.left,
                                              style: theme.bodyLarge,
                                            ),
                                          ),
                                          Text(
                                            '₹ ${double.parse(item[3]).toStringAsFixed(2)}',
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
                                      '₹ ${orderProvider.totalCost().toStringAsFixed(2)}',
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

                // Consumer<CartProvider>(
                //   builder: (context, provider, child) =>
                //       provider.cart.isNotEmpty
                //           ? Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   'Order Summary',
                //                   style: theme.headlineSmall,
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 Table(
                //                   columnWidths: const {
                //                     0: FlexColumnWidth(3),
                //                     1: FlexColumnWidth(1)
                //                   },
                //                   border: const TableBorder(
                //                     horizontalInside: BorderSide.none,
                //                     verticalInside: BorderSide.none,
                //                   ),
                //                   children: [
                //                     ...provider.cart.map(
                //                       (item) {
                //                         return TableRow(children: [
                //                           Padding(
                //                             padding: const EdgeInsets.only(
                //                               top: 6,
                //                             ),
                //                             child: Text(
                //                               '${item[2]}:',
                //                               textAlign: TextAlign.left,
                //                               style: theme.bodyLarge,
                //                             ),
                //                           ),
                //                           Text(
                //                             '₹ ${double.parse(item[4]).toStringAsFixed(2)}',
                //                             textAlign: TextAlign.right,
                //                             style: theme.titleMedium,
                //                           )
                //                         ]);
                //                       },
                //                     ),
                //                     TableRow(children: [
                //                       Padding(
                //                         padding: const EdgeInsets.only(
                //                           top: 6,
                //                         ),
                //                         child: Text(
                //                           'Packaging Charge:',
                //                           textAlign: TextAlign.left,
                //                           style: theme.bodyLarge,
                //                         ),
                //                       ),
                //                       Text(
                //                         '₹ 40.00',
                //                         textAlign: TextAlign.right,
                //                         style: theme.titleMedium,
                //                       )
                //                     ]),
                //                     TableRow(children: [
                //                       Padding(
                //                         padding: const EdgeInsets.only(
                //                           top: 6,
                //                         ),
                //                         child: Text(
                //                           'Delivery Charge:',
                //                           textAlign: TextAlign.left,
                //                           style: theme.bodyLarge
                //                               ?.copyWith(color: Colors.green),
                //                         ),
                //                       ),
                //                       Text(
                //                         '₹ 0.00',
                //                         textAlign: TextAlign.right,
                //                         style: theme.titleMedium
                //                             ?.copyWith(color: Colors.green),
                //                       )
                //                     ]),
                //                     TableRow(children: [
                //                       Padding(
                //                         padding: const EdgeInsets.only(
                //                           top: 6,
                //                         ),
                //                         child: Text(
                //                           'Tax:',
                //                           textAlign: TextAlign.left,
                //                           style: theme.bodyLarge,
                //                         ),
                //                       ),
                //                       Text(
                //                         '₹ 18.20',
                //                         textAlign: TextAlign.right,
                //                         style: theme.titleMedium,
                //                       )
                //                     ]),
                //                     TableRow(children: [
                //                       Padding(
                //                         padding: const EdgeInsets.only(
                //                           top: 6,
                //                         ),
                //                         child: Text(
                //                           'Coupon Discount:',
                //                           textAlign: TextAlign.left,
                //                           style: theme.bodyLarge
                //                               ?.copyWith(color: Colors.green),
                //                         ),
                //                       ),
                //                       Text(
                //                         '- ₹ 182.06',
                //                         textAlign: TextAlign.right,
                //                         style: theme.titleMedium
                //                             ?.copyWith(color: Colors.green),
                //                       )
                //                     ]),
                //                   ],
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 Divider(
                //                   color: colorTheme.shadowColor,
                //                   thickness: 1.0,
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 Row(
                //                   children: [
                //                     Text(
                //                       'Total bill',
                //                       style: theme.bodyLarge
                //                           ?.copyWith(color: Colors.black),
                //                     ),
                //                     const Spacer(),
                //                     Text(
                //                       '₹ ${provider.totalCost().toStringAsFixed(2)}',
                //                       style: theme.titleLarge,
                //                     )
                //                   ],
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 Divider(
                //                   color: colorTheme.shadowColor,
                //                   thickness: 1.0,
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //               ],
                //             )
                //           : const Text(''),
                // ),
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
                Consumer<OrderProvider>(
                  builder: (context, orderProvider, child) {
                    String address = orderProvider.currentOrder[0][4];
                    return ListTile(
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
                        address,
                        style: theme.labelMedium,
                      ),
                    );
                  },
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
