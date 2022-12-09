// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp_test_sandi_romadon/controller/dashboardcontroller.dart';
import 'package:movieapp_test_sandi_romadon/model/detail_response.dart';
import 'package:movieapp_test_sandi_romadon/screen/widget/video_player.dart';
import 'package:movieapp_test_sandi_romadon/services/dashboardservices.dart';
import 'package:youtube/youtube_thumbnail.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../model/video_response.dart';
import '../utils/styles.dart';

class MovieDetailScreen extends StatefulWidget {
  final String id;
  const MovieDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  var dashboard = Get.find<DashboardController>();
  late YoutubePlayerController controller;

  @override
  void initState() {
    controller = YoutubePlayerController(
        initialVideoId: "",
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: true,
        ));
    dashboard.getDetailMovie(id: widget.id);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      DetailMovieResponse detail = controller.detailMovie;
      return controller.loadingDetail
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              backgroundColor: Colors.grey,
              body: Stack(
                children: <Widget>[
                  Hero(
                    tag: detail,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: Get.height * 0.3,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                // ignore: prefer_interpolation_to_compose_strings
                                "https://image.tmdb.org/t/p/original/" +
                                    detail.backdropPath!)),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.5)),
                        child: Text(
                          detail.title ?? "",
                          style: TextStyle(
                              color: Style.text1Color,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.23,
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          width: Get.width,
                          height: Get.height * 0.35,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Trailers",
                                    style: TextStyle(
                                        color: Style.text2Color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    width: Get.width,
                                    height: Get.height * 0.25,
                                    child: _buildVideoWidget(
                                        controller.videosdata),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          width: Get.width,
                          height: Get.height * 0.35,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Description",
                                    style: TextStyle(
                                        color: Style.text2Color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      width: Get.width,
                                      height: Get.height * 0.25,
                                      child: Text(
                                        detail.overview ?? "",
                                        style: TextStyle(
                                            color: Style.text2Color,
                                            fontSize: 12),
                                        textAlign: TextAlign.justify,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
    });
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildVideoWidget(VideoResponse videoResponse) {
    var id = videoResponse.results!.first.key;
    controller = YoutubePlayerController(
        initialVideoId: id!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: true,
        ));
    return InkWell(
      onTap: () {},
      child: Center(
        child: YoutubePlayer(
          controller: controller,
          showVideoProgressIndicator: true,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}
