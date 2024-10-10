import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/cart_pages/cart_provider.dart';
import 'package:provider/provider.dart';

class DemoCartPage extends StatefulWidget {
  const DemoCartPage({super.key});

  @override
  State<DemoCartPage> createState() => _DemoCartPageState();
}

class _DemoCartPageState extends State<DemoCartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Consumer<CartProvider>(
          builder: (context, provider, child) => Column(
            children: [
              Expanded(
                child: provider.cart.isEmpty
                    ? Center(
                        child: Text(
                          'Cart Is Empty',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Theme.of(context).primaryColor),
                        ),
                      )
                    : ListView.builder(
                        itemCount: provider.cart.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Container(
                              width: 50, // Add a fixed width
                              height: 50, // Add a fixed height
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image:
                                          AssetImage(provider.cart[index][3]),
                                      fit: BoxFit.fill)),
                            ),
                            title: Text(provider.cart[index][2]),
                            subtitle: Text(provider.cart[index][1]),
                            trailing: Text(provider.cart[index][4]),
                          );
                        }),
              ),
              if (provider.cart.isNotEmpty)
                TextButton(
                  onPressed: provider.reset,
                  child: const Text('Clear Cart'),
                ),
              const SizedBox(
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/* Center(
                          child: SizedBox(
                            width: 150,
                            child: TextButton(
                              onPressed: provider.reset,
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    colorTheme.primaryColor),
                              ),
                              child: Text(
                                'Clear Cart',
                                style: theme.titleMedium
                                    ?.copyWith(color: const Color(0xFFFFFFFF)),
                              ),
                            ),
                          ),
                        ),

                        ListTile(
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
                    */