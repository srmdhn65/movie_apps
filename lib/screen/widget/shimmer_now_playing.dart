import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp_test_sandi_romadon/screen/widget/shimmer.dart';

import '../../model/now_playing_response.dart';
import '../../utils/date_format.dart';
import '../../utils/styles.dart';

class ShimmerNowPlaying extends StatelessWidget {
  const ShimmerNowPlaying({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.5,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: Get.height * 0.32,
              child: ShimmerHelper().buildBasicShimmer(),
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
                      ShimmerHelper().buildBasicShimmer(height: 10),
                      const SizedBox(
                        height: 5,
                      ),
                      ShimmerHelper().buildBasicShimmer(height: 10),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
