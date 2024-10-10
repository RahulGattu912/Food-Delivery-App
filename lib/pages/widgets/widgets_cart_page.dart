import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
