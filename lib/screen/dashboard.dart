import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp_test_sandi_romadon/controller/dashboardcontroller.dart';
import 'package:movieapp_test_sandi_romadon/screen/details.dart';
import 'package:movieapp_test_sandi_romadon/screen/widget/drawer.dart';
import 'package:movieapp_test_sandi_romadon/screen/widget/now_playing.dart';
import 'package:movieapp_test_sandi_romadon/screen/widget/top_rated.dart';
import 'package:movieapp_test_sandi_romadon/utils/styles.dart';

class DashoboardScreen extends StatefulWidget {
  const DashoboardScreen({Key? key}) : super(key: key);

  @override
  State<DashoboardScreen> createState() => _DashoboardScreenState();
}

class _DashoboardScreenState extends State<DashoboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var dashboardController = Get.find<DashboardController>();

  @override
  void initState() {
    dashboardController.getNowPlaying();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MainDrawer(),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Style.text1Color,
            )),
        title: Text(
          "Home",
          style: TextStyle(
            color: Style.text1Color,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Style.text1Color,
              )),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder<DashboardController>(builder: (controller) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Now Playing",
                      style: TextStyle(
                          color: Style.text2Color,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "MORE",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  color: Colors.transparent,
                  height: Get.height * 0.4,
                  width: Get.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.nowPlayingList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var result = controller.nowPlayingList[index];
                        return InkWell(
                            onTap: () {
                              Get.to(() =>
                                  MovieDetailScreen(id: result.id.toString()));
                            },
                            child: NowPlayingCard(result: result));
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top Rated",
                      style: TextStyle(
                          color: Style.text2Color,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "MORE",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  color: Colors.transparent,
                  height: Get.height * 0.3,
                  width: Get.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.topRatedList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var result = controller.topRatedList[index];
                        return TopRatedCard(result: result);
                      }),
                ),
              ],
            );
          }),
        ),
      )),
    );
  }
}
