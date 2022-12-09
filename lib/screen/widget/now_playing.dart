import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/now_playing_response.dart';
import '../../utils/date_format.dart';
import '../../utils/styles.dart';

class NowPlayingCard extends StatelessWidget {
  final Result result;
  const NowPlayingCard({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.5,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Stack(
          children: <Widget>[
            Hero(
              tag: result,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: Get.height * 0.33,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          // ignore: prefer_interpolation_to_compose_strings
                          "https://image.tmdb.org/t/p/original/" +
                              result.backdropPath!)),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Positioned(
                bottom: 15.0,
                child: Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  width: 250.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        result.title ?? "",
                        style: TextStyle(
                            height: 1.5,
                            color: Style.text2Color,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                      ),
                      Text(
                        DateFormatCustom.tgl(
                            result.releaseDate ?? DateTime.now()),
                        style: TextStyle(
                            height: 1.0,
                            color: Style.text3Color,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
