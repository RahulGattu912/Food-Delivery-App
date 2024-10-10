import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/pages/address/address.dart';
import 'package:food_delivery_app/pages/cart_pages/cart_provider.dart';
import 'package:food_delivery_app/pages/cart_pages/count_provider.dart';
import 'package:food_delivery_app/pages/geolocation/geo_location.dart';
import 'package:food_delivery_app/pages/navigation_page/navigation_page.dart';
import 'package:food_delivery_app/pages/order_pages/order_history/order_provider.dart';
// import 'package:food_delivery_app/pages/order_pages/order_history/order_provider.dart';
import 'package:food_delivery_app/pages/order_pages/order_page.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/pages/widgets/widgets_cart_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String _address = '';
  bool _isLoading = true;
  String _selectedColor = 'Home';
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _fetchAddress();
  }

  void _fetchAddress() async {
    LocationService locationService = LocationService();
    String locationMessage =
        await locationService.getLocationMessage('Home', currentUser!.uid);
    if (mounted) {
      setState(() {
        _address = locationMessage;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    final ThemeData colorTheme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Consumer<CartProvider>(
              builder: (context, provider, child) => SafeArea(
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: provider.cart.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height -
                              kToolbarHeight, // Full height of the screen minus the AppBar height
                          child: Center(
                            child: Text(
                              'Cart Is Empty',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: colorTheme.primaryColor),
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NavigationPage()));
                                    },
                                    icon: const Icon(Icons.arrow_back_ios)),
                                Text(
                                  'Cart',
                                  style: theme.headlineSmall,
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: provider.reset,
                                  child: Text(
                                    'Clear Cart',
                                    style: theme.bodyMedium,
                                  ),
                                )
                              ],
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
                                      color: colorTheme.primaryColor,
                                      width: 1.0)),
                              child: Center(
                                child: Text(
                                  '30 Minutes',
                                  style: theme.titleMedium?.copyWith(
                                      color: colorTheme.primaryColor),
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
                                  style: theme.titleMedium?.copyWith(
                                      color: const Color(0xFFFFFFFF)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: provider.cart.length *
                                  90, // Provide an explicit height
                              child: ListView.builder(
                                itemCount: provider.cart.length,
                                itemBuilder: (context, index) {
                                  return ChangeNotifierProvider(
                                      create: (_) => CountProvider(),
                                      child: Stack(
                                        children: [
                                          ListTile(
                                              leading: Container(
                                                width:
                                                    60, // Provide a fixed width for image
                                                height:
                                                    60, // Provide a fixed height for image
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  image: DecorationImage(
                                                    image: NetworkImage(provider
                                                        .cart[index][3]),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              title: Row(
                                                children: [
                                                  Text(
                                                    provider.cart[index][2],
                                                    style: theme.titleMedium
                                                        ?.copyWith(
                                                            fontSize: 16),
                                                  ),
                                                  // provider.cart[index][6] ==
                                                  //         'Yes'
                                                  //     ? SvgPicture.asset(
                                                  //         'assets/svg/veg_non-veg/veg.svg')
                                                  //     : SvgPicture.asset(
                                                  //         'assets/svg/veg_non-veg/non_veg.svg')
                                                ],
                                              ),
                                              subtitle: Text(
                                                '₹${provider.cart[index][4]}',
                                                style: theme.titleLarge
                                                    ?.copyWith(
                                                        color: colorTheme
                                                            .primaryColor),
                                              ),
                                              trailing: Container(
                                                  height: 32,
                                                  width: 96,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: colorTheme
                                                              .shadowColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32)),
                                                  child:
                                                      Consumer<CountProvider>(
                                                    builder: (context,
                                                            provider2, child) =>
                                                        Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Spacer(),
                                                        GestureDetector(
                                                          onTap: () =>
                                                              provider2.add(
                                                                  context,
                                                                  index),
                                                          child: Text(
                                                            '+',
                                                            style: theme
                                                                .titleMedium
                                                                ?.copyWith(
                                                                    color: colorTheme
                                                                        .primaryColor),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          '${provider2.count}',
                                                          style: theme
                                                              .titleMedium
                                                              ?.copyWith(
                                                                  color: colorTheme
                                                                      .primaryColor),
                                                        ),
                                                        const Spacer(),
                                                        GestureDetector(
                                                          onTap: () =>
                                                              provider2.sub(
                                                                  context,
                                                                  index),
                                                          child: Text(
                                                            '-',
                                                            style: theme
                                                                .titleMedium
                                                                ?.copyWith(
                                                                    color: colorTheme
                                                                        .primaryColor),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                      ],
                                                    ),
                                                  ))),
                                          Positioned(
                                              top: 0,
                                              left: 0,
                                              child: Container(
                                                color: Colors.white,
                                                child: provider.cart[index][6]
                                                    ? SvgPicture.asset(
                                                        'assets/svg/veg_non-veg/veg.svg',
                                                        height: 17,
                                                        width: 17,
                                                      )
                                                    : SvgPicture.asset(
                                                        'assets/svg/veg_non-veg/non_veg.svg',
                                                        height: 17,
                                                        width: 17,
                                                      ),
                                              ))
                                        ],
                                      ));
                                },
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: const Color(0xFFFFF1ED)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14, left: 24),
                                    child: Text(
                                        'You’re saving ₹182.06 on this order',
                                        style: theme.titleMedium),
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
                            Consumer<CartProvider>(
                              builder: (context, provider, child) => Column(
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
                                                item[2],
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
                                            'Packaging Charge',
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
                                            'Delivery Charge',
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
                                            'Tax',
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
                                            'Coupon Discount',
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
                              ),
                            ),
                            Text(
                              'Note',
                              style: theme.titleLarge,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              textAlign: TextAlign.justify,
                              'Lorem ipsum dolor sit amet consectetur. Pretium vitae venenatis arcu ac mauris ridiculus tempor sed. Vitae amet elit ante a viverra ut pharetra a. Non diam eget neque dignissim vitae. Eget dolor at ornare nisi lectus tincidunt. Lorem ipsum dolor sit amet consectetur. Pretium vitae venenatis arcu ac mauris ridiculus tempor sed. ',
                              style: theme.bodyMedium,
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            Consumer<CartProvider>(
                              builder: (context, value, child) =>
                                  provider.cart.isNotEmpty
                                      ? const SizedBox(
                                          height: 200,
                                        )
                                      : const Text(''),
                            )
                          ],
                        ),
                ),
              ),
            ),
          ),
          Consumer<CartProvider>(
            builder: (context, provider, child) => provider.cart.isNotEmpty
                ? Positioned(
                    bottom: 56,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 200,
                      width: 400,
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 8,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 26,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Other',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    showAddresses(context, theme, colorTheme);
                                  },
                                  child: Text(
                                    'Change',
                                    style: theme.bodyLarge?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      color: colorTheme.primaryColor,
                                    )
                                  : Text(
                                      _address,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.labelLarge?.copyWith(
                                          color: const Color(0xFFA1A1A1)),
                                    ),
                            ),
                            const Spacer(),
                            Consumer<CartProvider>(
                              builder: (context, cartProvider, child) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 32),
                                  child: GestureDetector(
                                    onTap: () async {
                                      final uid = FirebaseAuth
                                          .instance.currentUser?.uid;
                                      final orderProvider =
                                          context.read<OrderProvider>();
                                      // Add cart items to orders collection
                                      for (var item in cartProvider.cart) {
                                        orderProvider.addCurrentOrder(
                                            name: item[2],
                                            restaurant: item[0],
                                            type: item[6],
                                            cost: item[4],
                                            address: _address,
                                            count: item[5]);
                                        await FirebaseFirestore.instance
                                            .collection('orders')
                                            .doc(uid)
                                            .update({
                                          'items': FieldValue.arrayUnion([
                                            {
                                              'name': item[2],
                                              'restaurant': item[0],
                                              'type': item[6],
                                              'cost': item[4],
                                              'address': _address,
                                              'count': item[5],
                                            }
                                          ])
                                        });
                                      }
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            backgroundColor:
                                                colorTheme.primaryColor,
                                            content: const Text(
                                              'Order placed successfully',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      );
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const OrderPage()));
                                      cartProvider.reset();
                                    },
                                    child: Container(
                                      height: 56,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Complete Order',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                  color:
                                                      const Color(0xFFFFFFFF)),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ))
                : const Text(''),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showAddresses(
      BuildContext context, TextTheme theme, ThemeData colorTheme) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Stack(clipBehavior: Clip.none, children: [
            DraggableScrollableSheet(
                initialChildSize: 0.6,
                maxChildSize: 0.9,
                expand: false,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20.0)),
                    child: Container(
                      width:
                          MediaQuery.of(context) //size of width of the screen
                              .size
                              .width,
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Select Address',
                            style: theme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyAddress()));
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
                                          color: colorTheme.primaryColor,
                                          fontSize: 24),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      'Add Address',
                                      style: theme.bodyLarge?.copyWith(
                                          color: colorTheme.primaryColor,
                                          fontSize: 15),
                                    )
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Saved Addresses',
                            style:
                                theme.bodyLarge?.copyWith(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          addressSpace(
                              title: 'Home',
                              subtitle: '301 8-2-684/4/5 Anand Banjara Colony'),
                          const SizedBox(height: 8),
                          addressSpace(
                              title: 'Sai',
                              subtitle: '301 8-2-684/4/5 Anand Banjara Colony'),
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
                }),
            Positioned(
                top: -50,
                left: 0,
                right: 0,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    )))
          ]);
        });
  }

  Future<dynamic> completeOrderAddress(
      BuildContext context, TextTheme theme, ThemeData colorTheme) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20.0)),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Stack(
                      children: [
                        SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  GestureDetector(
                                    child: SvgPicture.asset(
                                        'assets/svg/icons/location.svg'),
                                  ),
                                  const SizedBox(width: 20),
                                  Text('Apartment Name',
                                      style: theme.titleLarge),
                                ],
                              ),
                              const SizedBox(height: 10),
                              _isLoading
                                  ? CircularProgressIndicator(
                                      color: colorTheme.primaryColor)
                                  : Text(
                                      _address,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.labelLarge?.copyWith(
                                          color: const Color(0xFFA1A1A1)),
                                    ),
                              const SizedBox(height: 10),
                              Form(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Door No.', style: theme.titleMedium),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: _controller1,
                                      cursorColor: colorTheme.primaryColor,
                                      decoration: InputDecoration(
                                        hintText:
                                            'House Number / Flat / Block No.',
                                        hintStyle: theme.bodyLarge,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                            color: colorTheme.primaryColor,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFC0C0C0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text('Landmark', style: theme.titleMedium),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: _controller2,
                                      cursorColor: colorTheme.primaryColor,
                                      decoration: InputDecoration(
                                        hintText: 'e.g. Near ABC School',
                                        hintStyle: theme.bodyLarge,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                            color: colorTheme.primaryColor,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFC0C0C0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 'Home',
                                                activeColor: _controller1
                                                            .text.isEmpty &&
                                                        _controller2
                                                            .text.isEmpty
                                                    ? const Color(0xFFC0C0C0)
                                                    : colorTheme.primaryColor,
                                                groupValue: _selectedColor,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    _selectedColor = value!;
                                                  });
                                                },
                                              ),
                                              const Text('Home')
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 'Work',
                                                activeColor: _controller1
                                                            .text.isEmpty &&
                                                        _controller2
                                                            .text.isEmpty
                                                    ? const Color(0xFFC0C0C0)
                                                    : colorTheme.primaryColor,
                                                groupValue: _selectedColor,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    _selectedColor = value!;
                                                  });
                                                },
                                              ),
                                              const Text('Work')
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 'Other',
                                                activeColor: _controller1
                                                            .text.isEmpty &&
                                                        _controller2
                                                            .text.isEmpty
                                                    ? const Color(0xFFC0C0C0)
                                                    : colorTheme.primaryColor,
                                                groupValue: _selectedColor,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    _selectedColor = value!;
                                                  });
                                                },
                                              ),
                                              const Text('Other')
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 56,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(32),
                                            color: _controller1.text.isEmpty &&
                                                    _controller2.text.isEmpty
                                                ? const Color(0xFFC0C0C0)
                                                : colorTheme.primaryColor),
                                        child: Center(
                                          child: Text(
                                            'Save Address',
                                            style: theme.titleLarge
                                                ?.copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.black),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the sheet
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
