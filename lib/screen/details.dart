// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:movieapp_test_sandi_romadon/controller/dashboardcontroller.dart';
import 'package:movieapp_test_sandi_romadon/model/detail_response.dart';
import 'package:movieapp_test_sandi_romadon/screen/widget/video_player.dart';
import 'package:movieapp_test_sandi_romadon/services/dashboardservices.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

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

  @override
  void initState() {
    dashboard.getDetailMovie(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: GetBuilder<DashboardController>(
        builder: (controller) {
          DetailMovieResponse detail = controller.detailMovie;
          return controller.loadingDetail
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
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
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5)),
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
                            margin: const EdgeInsets.all(20),
                            width: Get.width,
                            height: Get.height * 0.4,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Now Playing",
                                      style: TextStyle(
                                          color: Style.text2Color,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: FutureBuilder<VideoResponse>(
                                        future: DashboardServices()
                                            .getMovie(widget.id),
                                        builder: (context,
                                            AsyncSnapshot<VideoResponse>
                                                snapshot) {
                                          if (snapshot.hasData) {
                                            if (snapshot.data != null) {
                                              return _buildErrorWidget(
                                                  snapshot.data.toString());
                                            }
                                            return _buildVideoWidget(
                                                snapshot.data!);
                                          } else if (snapshot.hasError) {
                                            return _buildErrorWidget(
                                                snapshot.error.toString());
                                          } else {
                                            return _buildLoadingWidget();
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
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

  Widget _buildVideoWidget(VideoResponse data) {
    List<Result> videos = data.results!;
    return FloatingActionButton(
      backgroundColor: Style.secondsColor,
      onPressed: () {
        final controller = YoutubePlayerController(
          params: const YoutubePlayerParams(
              mute: false,
              showControls: true,
              showFullscreenButton: true,
              autoPlay: true),
        );
        controller.loadVideoById(videoId: videos.first.id!);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(
              controller: YoutubePlayerController(
                params: YoutubePlayerParams(
                  startAt: Duration(seconds: 30),
                  autoPlay: true,
                ),
              ),
            ),
          ),
        );
      },
      child: Icon(Icons.play_arrow),
    );
  }
}
