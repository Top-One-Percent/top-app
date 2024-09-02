import 'package:animate_do/animate_do.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:top/config/theme/app_colors.dart';

import '../../../core/utils/get_img_url.dart';

class MsjBubbleWidget extends StatelessWidget {
  final String msj;
  final int total;
  final int current;

  const MsjBubbleWidget({
    super.key,
    required this.msj,
    required this.total,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    final int delay = ((current / total) * 500).round();

    return FadeInRight(
      delay: Duration(milliseconds: delay),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              color: AppColors.darkGrey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0)),
            ),
            child: msj.endsWith('.png')
                ? _futureImage(msj)
                : Text(
                    msj,
                    style: const TextStyle(fontSize: 18.0),
                  ),
          ),
          const SizedBox(height: 15.0),
        ],
      ),
    );
  }
}

Widget _futureImage(String imgPath) {
  return FutureBuilder<String?>(
    future: getImageUrl(imgPath),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
            child: CircularProgressIndicator(
                color: Colors
                    .white)); // Display a loading indicator while the image is being fetched
      } else if (snapshot.hasError || !snapshot.hasData) {
        return const Icon(Icons.error,
            color: Colors.red); // Display an error icon if something goes wrong
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.network(
            snapshot.data!,
            fit: BoxFit.cover,
          ),
        ); // Display the fetched image
      }
    },
  );
}
