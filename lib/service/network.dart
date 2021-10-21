import 'dart:convert';
import 'package:flickr_app/service/model.dart';
import 'package:http/http.dart' as http;

class NetWorkFavorite {
  static var queryParametersFavorite = {
    'method': 'flickr.favorites.getList',
    'api_key': '978a14bff9f56eeb7c52e27ed4266523',
    'extras': 'views, media, path_alias, url_sq, url_t, url_s, url_q, url_m, url_n, url_z, url_c, url_l, url_o',
    'per_page': "10",
    'page': "1",
    'format': 'json',
    'nojsoncallback': '1',
    'user_id' : '184740542@N04'
  };


  static var urlFavorite =
  Uri.http("www.flickr.com", "services/rest/", queryParametersFavorite);

  static void setFavorite() => urlFavorite =
      Uri.http("www.flickr.com", '/services/rest/', queryParametersFavorite);

  static Future<List<Photo>> getPhotoFavorite() async {
    NetWorkFavorite.queryParametersFavorite['page'] = "1";
    setFavorite();
    var data = await http.get(urlFavorite);
    if (data.statusCode == 200) {
      var _tmp = jsonDecode(data.body);
      return Flickr.fromJson(_tmp).photos!.photo!;
    } else {
      throw Exception("trang web loi");
    }
  }
  static Future<List<Photo>> getPhotoMore(int page) async {
    NetWorkFavorite.queryParametersFavorite['page'] = page.toString();
    setFavorite();
    var data = await http.get(urlFavorite);
    if (data.statusCode == 200) {
      var _tmp = jsonDecode(data.body);
      return Flickr.fromJson(_tmp).photos!.photo!;
    } else {
      throw Exception("trang web loi");
    }
  }

}

class NetWorkHome {
  static var queryParameters = {
    'method': 'flickr.photos.getRecent',
    'api_key': '978a14bff9f56eeb7c52e27ed4266523',
    'extras':
    'views, media, path_alias, url_sq, url_t, url_s, url_q, url_m, url_n, url_z, url_c, url_l, url_o',
    'per_page': "15",
    'page': "1",
    'format': 'json',
    'nojsoncallback': '1',
  };

  static var url =
  Uri.http("www.flickr.com", '/services/rest/', queryParameters);

  static void setUrl() =>
      url = Uri.http("www.flickr.com", '/services/rest/', queryParameters);

  static Future<List<Photo>> getPhoto() async {
    NetWorkHome.queryParameters['page'] = '1';
    setUrl();
    var data = await http.get(url);
    if (data.statusCode == 200) {
      var _tmp = jsonDecode(data.body);
      return Flickr.fromJson(_tmp).photos!.photo!;
    } else {
      throw Exception("trang web loi");
    }
  }

  static Future<List<Photo>> getPhotoMore(int page) async {
    NetWorkHome.queryParameters['page'] = page.toString();
    setUrl();
    var data = await http.get(url);
    if (data.statusCode == 200) {
      var _tmp = jsonDecode(data.body);
      return Flickr.fromJson(_tmp).photos!.photo!;
    } else {
      throw Exception("trang web loi");
    }
  }

}

class NetWorkSearch {
  static var queryParametersSearch = {
    'method': 'flickr.photos.search',
    'api_key': '978a14bff9f56eeb7c52e27ed4266523',
    'text': '',
    'accuracy': '1',
    'extras':
    'views, media, path_alias, url_sq, url_t, url_s, url_q, url_m, url_n, url_z, url_c, url_l, url_o',
    'per_page': "10",
    'page': "1",
    'format': 'json',
    'nojsoncallback': '1',
  };

  static var urlSearch =
  Uri.http("www.flickr.com", "services/rest/", queryParametersSearch);

  static void setUrlSearch() => urlSearch =
      Uri.http("www.flickr.com", '/services/rest/', queryParametersSearch);

  static Future<List<Photo>> search(String txt) async {
    NetWorkSearch.queryParametersSearch['text'] = txt;
    NetWorkSearch.queryParametersSearch['page'] = '1';
    setUrlSearch();
    var data = await http.get(urlSearch);
    if (data.statusCode == 200) {
      var _tmp = jsonDecode(data.body);
      return Flickr.fromJson(_tmp).photos!.photo!;
    } else {
      throw Exception("Err Search");
    }
  }

  static Future<List<Photo>> loadMoreSearch(int page) async {
    NetWorkSearch.queryParametersSearch['page'] = page.toString();
    setUrlSearch();
    var data = await http.get(urlSearch);
    if (data.statusCode == 200) {
      var _tmp = jsonDecode(data.body);
      return Flickr.fromJson(_tmp).photos!.photo!;
    } else {
      throw Exception("Err loadMore");
    }
  }

}

