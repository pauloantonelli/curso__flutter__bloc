import 'dart:io';
import 'package:dio/dio.dart';

import 'package:bloc_github_serach_project/models/result-search.dart';

class GitHubService {
  final Dio dio = new Dio();

  Future<SearchResult> searchGit(String search) async {
    try {
      Response response =
          await dio.get('https://api.github.com/search/repositories?q=$search');

      return SearchResult.fromJson(response.data);
    } catch (e) {
      print('Erro na requisicao: $e');
      throw SocketException(e);
    }
  }
}
