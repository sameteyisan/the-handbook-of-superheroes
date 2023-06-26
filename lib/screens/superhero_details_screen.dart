import 'package:flutter/material.dart';
import 'package:the_handbook_of_superheroes/models/superhero.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_back_button.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_network_image.dart';
import 'package:the_handbook_of_superheroes/widgets/detail_panel.dart';
import 'package:the_handbook_of_superheroes/widgets/title_widget.dart';

class SuperheroesDetailsScreen extends StatelessWidget {
  const SuperheroesDetailsScreen({super.key, required this.superhero});
  final SuperheroModel superhero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(superhero.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: CustomNetworkImage(url: superhero.image.url),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: TitleWidget("Biography"),
          ),
          ...superhero.biography.toMap().entries.map((kv) => DetailPanel(kv: kv)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: TitleWidget("Powerstats"),
          ),
          ...superhero.powerstats.toMap().entries.map((kv) => DetailPanel(kv: kv)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: TitleWidget("Appearance"),
          ),
          ...superhero.appearance.toMap().entries.map((kv) => DetailPanel(kv: kv)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: TitleWidget("Connections"),
          ),
          ...superhero.connections.toMap().entries.map((kv) => DetailPanel(kv: kv)),
        ],
      ),
    );
  }
}
