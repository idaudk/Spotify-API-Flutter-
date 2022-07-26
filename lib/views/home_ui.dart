import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complex_api_app/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeUI extends StatelessWidget {
  HomeUI({Key? key}) : super(key: key);
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top 50 Songs"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        height: MediaQuery.of(context).size.height - 100,
        child: Obx(() => _homeController.isloading.value == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _homeController.spotifyModel!.content.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ExpansionTile(
                        backgroundColor: Color.fromARGB(255, 243, 249, 252),
                        title: Text(
                          _homeController
                              .spotifyModel!.content[index].track_title,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Container(
                          child: Row(
                            children: _homeController
                                .spotifyModel!.content[index].artists
                                .map((item) => Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.black),
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 9),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        trailing: _homeController
                                    .spotifyModel!.content[index].trend
                                    .toString() ==
                                "sideway"
                            ? const Icon(
                                Icons.line_axis_rounded,
                                color: Colors.grey,
                              )
                            : _homeController.spotifyModel!.content[index].trend
                                        .toString() ==
                                    "up"
                                ? const Icon(
                                    Icons.trending_up_rounded,
                                    color: Colors.green,
                                  )
                                : _homeController
                                            .spotifyModel!.content[index].trend
                                            .toString() ==
                                        "down"
                                    ? const Icon(
                                        Icons.trending_down_rounded,
                                        color: Colors.red,
                                      )
                                    : Text(_homeController
                                        .spotifyModel!.content[index].trend),
                        childrenPadding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: 70,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.play_arrow_rounded,
                                        size: 15,
                                      ),
                                      Text(
                                        _homeController.spotifyModel!
                                            .content[index].streams
                                            .toString(),
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  )),
                              Text(
                                  "#" +
                                      _homeController
                                          .spotifyModel!.content[index].position
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () => _homeController.launchURL(index),
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/logo.png',
                                      fit: BoxFit.contain,
                                      width: 40,
                                      height: 40,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Listen on",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "Spotify",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          )
                        ],
                        leading: AlbumArt(index)),
                  );
                })),
      ),
    );
  }

  Container AlbumArt(int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      height: 60,
      width: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          _homeController.spotifyModel!.content[index].thumbnail,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
