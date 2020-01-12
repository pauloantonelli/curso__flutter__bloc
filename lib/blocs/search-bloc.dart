import 'package:rxdart/rxdart.dart';

import 'package:bloc_github_serach_project/models/result-search.dart';
import 'package:bloc_github_serach_project/services/data/github-service.dart';

class SearchBloc {
  GitHubService _serviceGitHubApi = new GitHubService();
  final _searchController = new BehaviorSubject<String>();

  Stream<String> get searchFlux => this._searchController.stream;
  Sink<String> get searchEvent => this._searchController.sink;

  Stream<SearchResult> apiResultFlux;

  SearchBloc() {
    apiResultFlux = searchFlux
        .distinct()
        .where((valor) => valor.length > 3)
        .debounce((valor) => TimerStream(valor, Duration(milliseconds: 500)))
        .asyncMap(_serviceGitHubApi.searchGit)
        .switchMap((valor) => Stream.value(valor));
  }

  void dispose() {
    this._searchController?.close();
  }
}
