import 'dart:async';
import 'dart:convert';

import 'package:http/browser_client.dart';

final customSearchEngineId = "015237388199217754610:yx9xdnmqab8";
final apiKey = "AIzaSyDRqG50Bhw2s-5qCxTLibIo-KwL-jUtvac";

Future<List<String>> getFirstImageUrlFromGoogleApi(String searchText) async {
  var url = _getGoogleApiUrl();
  url += _getImageQueryParameters(searchText, imageSize: "large");

  dynamic jsonResponse = await _executeGetRequest(url);

  if (jsonResponse != null && jsonResponse["items"] != null) {
    final items = jsonResponse["items"] as List<Map<String, dynamic>>;
    return items
        .map((Map<String, dynamic> searchResult) =>
            searchResult['link'] as String)
        .toList();
  }

  return null;
}

String _getGoogleApiUrl() =>
    "https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=$customSearchEngineId";

String _getImageQueryParameters(String searchText, {String imageSize}) {
  var result = "&q=$searchText&searchType=image";

  if (imageSize != null) {
    result += "&imgSize=$imageSize";
  }

  return result;
}

Future<Map<String, dynamic>> _executeGetRequest(String url) async {
  var client = new BrowserClient();

  final uri = Uri.parse(url);
  final response = await client.get(uri);

  var data = JSON.decode(response.body);

  client.close();

  return data;
}
