import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery_app/demo_folder_pages/demo_restaurant_page.dart';

Widget itemSpace({required String img, required String name}) {
  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: Column(
      children: [
        Image.asset(
          img,
          height: 75,
          width: 75,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          name,
          style: const TextStyle(
              fontFamily: 'DMSans',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
      ],
    ),
  );
}

Widget cardItem({
  required BuildContext context,
  required String img,
  required String heading,
  required String subHeading,
}) {
  return Card(
    elevation: 5,
    color: Colors.white,
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.95, // 395,
      height: 306,
      child: Column(
        children: [
          // Image container with rounded top corners
          Container(
            height: 166,
            width: MediaQuery.of(context).size.width * 0.95, // 395,
            decoration: const BoxDecoration(
              color: Color(0xFFFE724C),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14), // Circular top-left corner
                topRight: Radius.circular(14), // Circular top-right corner
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14), // Match with the container
                topRight: Radius.circular(14),
              ),
              child: Image.network(
                img,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, color: Colors.red);
                },
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Text and content below the image
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(width: 20),
                  Text(
                    heading,
                    style: const TextStyle(
                        fontFamily: 'Merienda',
                        fontSize: 16,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Container(
                    height: 24,
                    width: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '4.5',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 12,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Text(
                    subHeading,
                    style: const TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 14,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Row(
                children: [
                  SizedBox(width: 20),
                  Text(
                    'from',
                    style: TextStyle(
                        fontFamily: 'Merienda',
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    ' ₹250',
                    style: TextStyle(
                        fontFamily: 'Merienda',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFE724C)),
                  ),
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: Divider(
              thickness: 1,
              color: Color(0xFFC0C0C0),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Left over food and supplies are gathered and sold for 50% off!',
            style: TextStyle(
                color: Color(0xFFA1A1A1),
                fontFamily: 'DMSans',
                fontSize: 11,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}

Widget buildRestaurantCard(
    BuildContext context, String heading, String subHeading, String img,
    [String? badge, String? discount]) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RestaurantPage(
            pageImage: img,
            pageHeading: heading,
            pageSubHeading: subHeading,
          ),
        ),
      );
    },
    child: Stack(
      children: [
        cardItem(
            context: context,
            img: img,
            heading: heading,
            subHeading: subHeading),
        if (badge != null)
          Positioned(
            top: 25,
            left: -2,
            child: SvgPicture.asset(badge),
          ),
        if (discount != null)
          Positioned(
            top: 60,
            left: -2,
            child: SvgPicture.asset(discount),
          ),
      ],
    ),
  );
}

Widget offerSpace(
    {required String img,
    required String heading,
    required String subHeading,
    required color1,
    required color2}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        height: 96,
        width: 190,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [color1, color2]),
            borderRadius: BorderRadius.circular(14)),
        child: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            Text(
              heading,
              style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'Merienda',
                  fontSize: 19,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              subHeading,
              style: const TextStyle(
                  color: Color(0xFFF5E8C8),
                  fontFamily: 'DMSans',
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
            ),
            const Spacer()
          ],
        ),
      ),
      Positioned(
        top: -25,
        left: 68,
        child: SizedBox(width: 49, height: 49, child: Image.asset(img)),
      ),
    ],
  );
}
