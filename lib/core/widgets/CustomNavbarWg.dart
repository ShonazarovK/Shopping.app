import 'package:assigment_4/features/auth/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:assigment_4/core/common/colors/app_colors.dart';
import 'package:assigment_4/features/home/presentation/pages/wishlist_page.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.home, color: Colors.brown),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WishlistPage()),
              );
            },
            child: Icon(Icons.favorite, color: Colors.grey[400]),
          ),

      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfilePage()),
          );
        },
        // Profile icon
          child:Icon(Icons.person, color: Colors.grey[400]),
      ),
        ],
      ),
    );
  }
}
