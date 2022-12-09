import 'package:http/http.dart' as http;
import 'package:movieapp_test_sandi_romadon/model/detail_response.dart';
import 'package:movieapp_test_sandi_romadon/model/now_playing_response.dart';
import 'package:movieapp_test_sandi_romadon/model/top_rated_response.dart';
import 'package:movieapp_test_sandi_romadon/model/video_response.dart';
import 'package:movieapp_test_sandi_romadon/utils/token.dart';

import '../utils/baseurl.dart';

class DashboardServices {
  Future<NowPlayingResponse> getNowPlaying() async {
    Uri url =
        Uri.parse("${BaseUrl().getip()}/movie/now_playing?api_key=$apiKey");
    final response = await http.get(
      url,
    );

    return nowPlayingResponseFromJson(response.body);
  }

  Future<DetailMovieResponse> getMovieDetail(String id) async {
    Uri url = Uri.parse("${BaseUrl().getip()}/movie/$id?api_key=$apiKey");
    final response = await http.get(
      url,
    );
    return detailMovieResponseFromJson(response.body);
  }

  Future<TopRatedResponse> getTopRated() async {
    Uri url = Uri.parse("${BaseUrl().getip()}/movie/top_rated?api_key=$apiKey");
    final response = await http.get(
      url,
    );

    return topRatedResponseFromJson(response.body);
  }

  Future<VideoResponse> getMovie(String id) async {
    Uri url =
        Uri.parse("${BaseUrl().getip()}/movie/$id/videos?api_key=$apiKey");
    final response = await http.get(
      url,
    );
    print(response.body);

    return videoResponseFromJson(response.body);
  }
}
