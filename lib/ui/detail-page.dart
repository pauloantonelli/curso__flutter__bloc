import 'package:flutter/material.dart';

import 'package:bloc_github_serach_project/models/search-item.dart';

class DetailsPage extends StatelessWidget {
  final SearchItem item;

  DetailsPage({this.item, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Details Page'),
    );
  }
}
