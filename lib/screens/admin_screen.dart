import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/screens/featured_screen.dart';
import 'package:the_handbook_of_superheroes/widgets/admin_card.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_back_button.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text("Admin Panel").animate().flip(delay: 100.ms),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 32),
            AdminCard(
              title: "Featured",
              icon: Ionicons.pencil_outline,
              onTap: () => Get.to(const FeaturedScreenn()),
            ),
            const SizedBox(height: 32),
            AdminCard(
              title: "Another Operation",
              icon: Ionicons.walk,
              invertColors: true,
              onTap: () {},
            ),
            const SizedBox(height: 32),
            AdminCard(
              title: "Another Operation",
              icon: Ionicons.warning,
              onTap: () {},
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
