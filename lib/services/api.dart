import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:the_handbook_of_superheroes/const.dart';
import 'package:the_handbook_of_superheroes/models/superhero.dart';

class Api {
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

  static Future<SuperheroModel?> getSuperhero(String id) async {
    try {
      final dio = await Api.dioAuth();
      Response response = await dio.get("/$id");
      if (response.statusCode == 200) {
        return SuperheroModel.fromMap(response.data);
      }
      return null;
    } catch (e) {
      debugPrint('Get Superhero Error : $e');
      return null;
    }
  }

  static Future<List<SuperheroModel>?> getSuperheros(String name, CancelToken canceler) async {
    try {
      final dio = await Api.dioAuth();
      Response response = await dio.get("/search/$name", cancelToken: canceler);
      if (response.statusCode == 200) {
        List<dynamic> superheroes = response.data["results"] ?? [];
        return superheroes.map((e) => SuperheroModel.fromMap(e)).toList();
      }
      return [];
    } catch (e) {
      if (canceler.isCancelled) {
        return null;
      }
      debugPrint('Get Superheros Error : $e');
      return [];
    }
  }
}
