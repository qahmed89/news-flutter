import 'package:dio/dio.dart';
import 'package:news/model/data_response.dart';
import 'package:news/model/news_response_entity.dart';
import 'package:news/model/sorces_resonse_entity.dart';

class NewRepository {
  static String baseURL = 'https://newsapi.org/v2';
  final String apiKey = '11a594b1e18a4e1b859144846fd7ba01';

  var getSourcesUrl = '$baseURL/sources';
  var getEverythingUrl = '$baseURL/everything';
  var getTopHeadLinesUrl = '$baseURL/top-headlines';
  var dio = Dio();

  Future<DataResponse<SorcesResonseEntity>> getSources() async {
    var params = {'apiKey': apiKey, 'language': 'en', 'country': 'us'};
    try {
      var response = await dio.get('$getSourcesUrl', queryParameters: params);
      if (response.statusCode == 200) {
        return DataResponse.success(SorcesResonseEntity().fromJson(response.data));
      }
    } catch (e) {
      print(e);
      return DataResponse.error(e.toString());

    }
  }
  Future<DataResponse<NewsResponseEntity>> getSourceNews(String sourceId) async {
    var params = {
      "apiKey": apiKey,
      "sources": sourceId};
    try {
      Response response = await dio.get(
          getTopHeadLinesUrl, queryParameters: params);

      return DataResponse.success(NewsResponseEntity().fromJson(response.data));

    } catch (e) {
     // print("Exception occured: $error stackTrace: $stacktrace");
      return DataResponse.error(e.toString());

    }
  }

  Future<DataResponse<NewsResponseEntity>> getTopHeadLine() async {
    var params = {'apiKey': apiKey, 'language': 'en', 'country': 'us'};
    try {
      var response = await dio.get('$getTopHeadLinesUrl', queryParameters: params);
      if (response.statusCode == 200) {
        return DataResponse.success(NewsResponseEntity().fromJson(response.data));
      }
    } catch (e) {
      print(e);
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<NewsResponseEntity>> getHotNews() async {
    var params = {'apiKey': apiKey, 'sortBy': 'popularity',  'q' : 'apple'};
    try {
      var response = await dio.get('$getEverythingUrl', queryParameters: params);
      if (response.statusCode == 200)
        return DataResponse.success(NewsResponseEntity().fromJson(response.data));

    } catch (e) {
      print(e);
      DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<NewsResponseEntity>> search(String searchValue) async {
    var params = {'apiKey': apiKey, 'q': searchValue};
    try {
      var response = await dio.get('$getEverythingUrl', queryParameters: params);
      if (response.statusCode == 200) {
        return DataResponse.success (NewsResponseEntity().fromJson(response.data));
      }
    } catch (e) {
      print(e);
      DataResponse.error(e.toString());

    }
  }
}
