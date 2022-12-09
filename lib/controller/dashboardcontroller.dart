import 'package:get/get.dart';
import 'package:movieapp_test_sandi_romadon/model/detail_response.dart';
import 'package:movieapp_test_sandi_romadon/model/now_playing_response.dart';
import 'package:movieapp_test_sandi_romadon/model/video_response.dart' as video;
import 'package:movieapp_test_sandi_romadon/services/dashboardservices.dart';
import 'package:movieapp_test_sandi_romadon/model/top_rated_response.dart'
    as top;

class DashboardController extends GetxController {
  var dashboardServices = DashboardServices();
  var isLoading = true;
  var loadingDetail = true;
  List<Result> nowPlayingList = [];
  List<top.Result> topRatedList = [];
  var detailMovie = DetailMovieResponse();
  var videosdata = video.VideoResponse();

  getNowPlaying() async {
    try {
      isLoading = true;
      var res = await dashboardServices.getNowPlaying();
      if (res.results != null) {
        nowPlayingList = res.results!;
      }
      var top = await dashboardServices.getTopRated();
      if (top.results != null) {
        topRatedList = top.results!;
      }
      isLoading = false;
      update();
    } catch (e) {}
  }

  getDetailMovie({id = 0}) async {
    try {
      loadingDetail = true;
      var detail = await dashboardServices.getMovieDetail(id);
      detailMovie = detail;
      // var video = await dashboardServices.getMovie(id);
      // videosdata = video;
      print(detailMovie.toJson());
      loadingDetail = false;
      update();
    } catch (e) {
      print(e);
    }
  }
}
