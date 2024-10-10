import 'package:flutter/material.dart';

Widget adSpace({required String img}) {
  return Container(
    height: 168,
    width: 336,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
    ),
  );
}

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

Widget stackSpace1(
    {required String img,
    required String name,
    required color,
    required BuildContext context}) {
  // Get screen size
  var screenWidth = MediaQuery.of(context).size.width;

  // Adjust size based on screen width
  var containerHeight = screenWidth * 0.28; // Adjust the ratio as needed
  var containerWidth = screenWidth * 0.21; // Adjust the ratio as needed

  return SizedBox(
    height: containerHeight,
    width: containerWidth,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: containerWidth,
          height: containerHeight * 0.8, // Adjust height relative to container
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(16)),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                name,
                style: const TextStyle(
                    color: Color(0xFF000000),
                    fontFamily: 'DMSans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
        Positioned(
          top: -containerHeight *
              0.25, // Adjust position based on container size
          left: 0,
          right: 0,
          child: SizedBox(
            width: containerWidth * 0.7, // Adjust image size
            height: containerHeight * 0.5, // Adjust image size
            child: Image.asset(img),
          ),
        ),
      ],
    ),
  );
}

Widget stackSpace({required String img, required String name, required color}) {
  return SizedBox(
    height: 112,
    width: 91,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 91,
          height: 89,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(16)),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                name,
                style: const TextStyle(
                    color: Color(0xFF000000),
                    fontFamily: 'DMSans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
        Positioned(
          top: -25,
          left: 0,
          right: 0,
          child: SizedBox(width: 64, height: 64, child: Image.asset(img)),
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
        child: Container(
            width: 49,
            height: 49,
            decoration: BoxDecoration(
              border: Border.all(color: color1, width: 1),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Image.asset(img)),
      ),
    ],
  );
}
