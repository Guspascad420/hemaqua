import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableBackButton extends StatelessWidget {
  const ReusableBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF60A5FA).withOpacity(0.3),
              blurRadius: 3,
              offset: const Offset(0, 3), // Shadow position
            ),
          ],
        ),
        margin: EdgeInsets.only(left: 20.w),
        child: IconButton(
          padding: const EdgeInsets.only(left: 7),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
        )
    );
  }
}