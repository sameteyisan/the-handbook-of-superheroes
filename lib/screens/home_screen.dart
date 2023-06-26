import 'package:flutter/material.dart';
import 'package:the_handbook_of_superheroes/widgets/text_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("The Handbook of Superheroes"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          CustomTextField(
            hintText: "Search Superhero",
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
