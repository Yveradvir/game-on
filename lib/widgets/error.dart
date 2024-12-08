import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gameon/utils/styles.dart';

class AppErrorWidget extends StatelessWidget {
  final int? statusCode;
  final String message;

  const AppErrorWidget({super.key, this.statusCode, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/error.svg',
            height: 200,
          ),
          const SizedBox(height: 20),
          if (statusCode != null)
            Text(
              "Status Code: $statusCode",
              style: titleText,
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              message,
              style: smallText,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 30.0 * 2, vertical: 20.0),
            ),
            child: const Text(
              'Go back',
              style: largeText,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 30.0 * 2, vertical: 20.0),
            ),
            child: const Text(
              'Go Home',
              style: largeText,
            ),
          ),
        ],
      ),
    );
  }
}
