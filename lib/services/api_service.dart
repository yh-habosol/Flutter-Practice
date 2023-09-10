import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon/models/webtoon.dart';
import 'package:webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static List<WebtoonModel> webtoonInstance = [];

  Future<List<WebtoonModel>> getTodaysToons() async {
    var url = Uri.parse("$baseUrl/$today");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final webtoons = jsonDecode(response.body);

      for (var webtoon in webtoons) {
        webtoonInstance.add(WebtoonModel.fromJson(webtoon));
      }

      return webtoonInstance;
    }
    throw Error();
  }

  Future<WebToonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebToonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  Future<List<WebToonEpisodeModel>> getLatestEpisodesById(String id) async {
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    List<WebToonEpisodeModel> episodesInstance = [];

    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstance.add(WebToonEpisodeModel.fromJson(episode));
      }
      return episodesInstance;
    }
    throw Error();
  }
}
