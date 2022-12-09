import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:movieapp_test_sandi_romadon/utils/date_format.dart';

import '../../model/top_rated_response.dart';
import '../../utils/styles.dart';

class TopRatedCard extends StatelessWidget {
  final Result result;
  const TopRatedCard({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.35,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Column(
          children: <Widget>[
            Hero(
              tag: result,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: Get.height * 0.21,
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
            Container(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5),
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
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        result.voteAverage.toString(),
                        style: TextStyle(
                            height: 1.5,
                            color: Style.text3Color,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      RatingBar(
                        ratingWidget: RatingWidget(
                          empty: Icon(
                            Icons.star_outline,
                            color: Style.secondsColor,
                          ),
                          full: Icon(
                            Icons.star,
                            color: Style.secondsColor,
                          ),
                          half: Icon(
                            Icons.star_outline,
                            color: Style.secondsColor,
                          ),
                        ),
                        itemSize: 10.0,
                        initialRating: result.voteAverage! / 2,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
