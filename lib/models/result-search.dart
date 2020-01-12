import 'package:bloc_github_serach_project/models/search-item.dart';

class SearchResult {
  final List<SearchItem> items;

  SearchResult(this.items);

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    final listItems =
        (json['items'] as List).cast<Map<String, dynamic>>()?.map((item) {
      return SearchItem.fromJson(item);
    })?.toList();
    return SearchResult(listItems);
  }
}
