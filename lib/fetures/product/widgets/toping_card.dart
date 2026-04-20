import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/core/constant/app_colors.dart';

class TopingCard extends StatelessWidget {
  const TopingCard({
    super.key,
    required this.title,
    required this.image,
    this.onAdd,
  });

  final String title;
  final String image;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 145,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: AppColors.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    color: AppColors.bigtextColor,
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(image, height: 80),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: GestureDetector(
              onTap: onAdd,
              child: const CircleAvatar(
                radius: 15,
                backgroundColor: Colors.red,
                child: Icon(CupertinoIcons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
