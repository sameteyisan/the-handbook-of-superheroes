import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:the_handbook_of_superheroes/const.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/models/superhero.dart';
import 'package:the_handbook_of_superheroes/utils/extentions.dart';

class Api {
  static final firestore = FirebaseFirestore.instance;

  static Future<Dio> dioAuth() async {
    return Dio(
      BaseOptions(
        baseUrl: Const.apiUrl,
        connectTimeout: 20.seconds,
        receiveTimeout: 20.seconds,
        headers: {
          "Accept": "application/json",
        },
        responseType: ResponseType.json,
      ),
    );
  }

  static Future<SuperheroModel?> getSuperheroDetails(String id) async {
    try {
      final res = await firestore.collection("superheroes").doc(id).get();
      return SuperheroModel.fromMap(res.data()!);
    } catch (e) {
      debugPrint('Get Superhero Details Error : $e');
      return null;
    }
  }

  static Future<List<BasicHeroModel>> getSuperheros(String name) async {
    try {
      final superheroes = await firestore
          .collection("heroes")
          .where('name', isGreaterThanOrEqualTo: name.titleCase)
          .where('name', isLessThanOrEqualTo: '${name.titleCase}\uf8ff')
          .limit(20)
          .get();

      return superheroes.docs.map((e) => BasicHeroModel.fromMap(e.data())).toList();
    } catch (e) {
      debugPrint('Get Superheros Error : $e');
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

  static Future<bool> getAdminData(String id) async {
    try {
      final res = await firestore.collection("admin").doc(id).get();
      final data = res.data()?.values.firstOrNull;

      return data ?? false;
    } catch (e) {
      debugPrint('Get Featured Heroes Error : $e');
      return false;
    }
  }
}
