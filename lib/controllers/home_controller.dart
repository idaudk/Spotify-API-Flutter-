import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_complex_api_app/models/spotify_model.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  var isloading = true.obs;
  SpotifyModel? spotifyModel;

  Future<String> _loadFile() async {
    return await rootBundle.loadString('assets/response.json');
  }

  Future SongsData() async {
    String jsonString = await _loadFile();
    final jsonResponse = json.decode(jsonString);
    spotifyModel = new SpotifyModel.fromJson(jsonResponse);
    isloading.value = false;
    print(spotifyModel!.response);
  }

  @override
  void onReady() {
    SongsData();
    super.onReady();
  }

  launchURL(index) async {
    String url = spotifyModel!.content[index].track_url.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
