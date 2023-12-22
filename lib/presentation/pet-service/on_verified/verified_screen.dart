import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OnVerifiedScreen extends StatelessWidget {
  const OnVerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 55.w,
              child: Image.asset("assets/pet-service/verification/verif.png"),
            ),
            const Row(
              children: [
                Icon(
                  Icons.info_rounded,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    "Your services account is under review by admin, please wait 1x24 working hours. Thank you",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
