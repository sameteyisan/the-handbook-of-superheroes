import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/models/powerstat.dart';
import 'package:the_handbook_of_superheroes/models/superhero.dart';
import 'package:the_handbook_of_superheroes/utils/extentions.dart';

class Api {
  static final firestore = FirebaseFirestore.instance;

  static Future<SuperheroModel?> getSuperheroDetails(String id) async {
    try {
      final res = await firestore.collection("superheroes").doc(id).get();
      return SuperheroModel.fromMap(res.data()!);
    } catch (e) {
      debugPrint('Get Superhero Details Error : $e');
      return null;
    }
  }

  static Future<PowerstatModel?> getPowerstats(String id) async {
    try {
      final res = await firestore.collection("powerstats").doc(id).get();
      return PowerstatModel.fromMap(res.data()!);
    } catch (e) {
      debugPrint('Get Powerstats Heroes Error : $e');
      return null;
    }
  }

  static Future<List<BasicHeroModel>> getSuperheros(String name, {bool descending = false}) async {
    try {
      final superheroes = await firestore
          .collection("heroes")
          .where('name', isGreaterThanOrEqualTo: name.titleCase)
          .where('name', isLessThanOrEqualTo: '${name.titleCase}\uf8ff')
          .orderBy("name", descending: descending)
          .limit(20)
          .get();

      return superheroes.docs.map((e) => BasicHeroModel.fromMap(e.data())).toList();
    } catch (e) {
      debugPrint('Get Superheros Error : $e');
      return [];
    }
  }

  static Future<List<BasicHeroModel>> getAllSuperheros() async {
    try {
      final superheroes = await firestore.collection("heroes").get();

      return superheroes.docs.map((e) => BasicHeroModel.fromMap(e.data())).toList();
    } catch (e) {
      debugPrint('Get All Superheros Error : $e');
      return [];
    }
  }

  static Future<List<BasicHeroModel>> getFeaturedHeroes() async {
    try {
      final res = await firestore.collection("featured").get();
      return res.docs.map((e) => BasicHeroModel.fromMap(e.data())).toList();
    } catch (e) {
      debugPrint('Get Featured Heroes Error : $e');
      return [];
    }
  }

  static Future<void> deleteFeaturedHero(BasicHeroModel hero) async {
    try {
      await firestore.collection("featured").doc(hero.id).delete();
    } catch (e) {
      debugPrint('Delete Featured Hero Error : $e');
    }
  }

  static Future<void> deleteFeaturedHeroes() async {
    try {
      final batch = firestore.batch();
      final collection = firestore.collection('featured');
      final snapshots = await collection.get();
      for (final doc in snapshots.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      debugPrint('Delete Featured Heroes Error : $e');
    }
  }

  static Future<void> setFeaturedHeroes(BasicHeroModel hero) async {
    try {
      await firestore.collection("featured").doc(hero.id).set(hero.toMap());
    } catch (e) {
      debugPrint('Set Featured Heroes Error : $e');
    }
  }

  static Future<bool> getAdminData(String id) async {
    try {
      final res = await firestore.collection("admin").doc(id).get();
      final data = res.data()?.values.firstOrNull;

      return data ?? false;
    } catch (e) {
      debugPrint('Get Admin Data Error : $e');
      return false;
    }
  }
}
