import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class CinemaApiClient {
  final String _endpoint = 'http://www.omdbapi.com';
  final String _key = '8aa3fb72';
  final http.Client _httpClient;

  CinemaApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List<CinemaItem>> retrieveCinemaItems(int pageNumber) async {
    final uri = Uri.parse('$_endpoint?apikey=$_key&s=movie&type=movie&page=$pageNumber');
    try {
      final responseData = await _performRequest(uri);
      final List<dynamic> rawItems = responseData['Search'];
      return await Future.wait(rawItems.map((item) => _enrichCinemaItemData(item['imdbID'])));
    } catch (error) {
      print('Error in retrieveCinemaItems: $error');
      rethrow;
    }
  }

  Future<CinemaItem> _enrichCinemaItemData(String imdbId) async {
    final uri = Uri.parse('$_endpoint?apikey=$_key&i=$imdbId');
    try {
      final responseData = await _performRequest(uri);
      return CinemaItem.fromMap(responseData);
    } catch (error) {
      print('Error in _enrichCinemaItemData for $imdbId: $error');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> _performRequest(Uri uri) async {
    final response = await _httpClient.get(uri);
    if (response.statusCode != 200) {
      throw Exception('HTTP request failed with status: ${response.statusCode}');
    }
    final decodedData = json.decode(response.body);
    if (decodedData['Response'] != 'True') {
      throw Exception(decodedData['Error'] ?? 'Unknown API error occurred');
    }
    return decodedData;
  }

  void dispose() {
    _httpClient.close();
  }
}