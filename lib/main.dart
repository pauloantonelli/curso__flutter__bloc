import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:bloc_github_serach_project/blocs/search-bloc.dart';
import 'package:bloc_github_serach_project/models/search-item.dart';

import 'ui/detail-page.dart';
import 'models/result-search.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bloc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title, Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SearchBloc _searchBloc;

  @override
  void initState() {
    // blocs sempre devem ser inicializados pelo initState para ser montado antes do widget ser rendenizado
    this._searchBloc =
        new SearchBloc(); // com isso o bloc será inicializado somente uma vez, é exatamente o que sempre vamos querer
    super.initState();
  }

  @override
  void dispose() {
    this._searchBloc?.dispose();
    super.dispose();
  }

  Widget _textField() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (String value) {
          this._searchBloc.searchEvent.add(value);
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Digite o nome do repositorio',
            labelText: 'Pesquisa'),
      ),
    );
  }

  Widget _items(SearchItem item) {
    return ListTile(
      leading: Hero(
        tag: item.url,
        child: CircleAvatar(
          backgroundImage: NetworkImage(item?.avatarUrl ??
              'https://cdn.dribbble.com/users/902865/screenshots/4814970/loading-opaque.gif'),
        ),
      ),
      title: Text(item?.fullName ?? 'title'),
      subtitle: Text(item?.url ?? 'url'),
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => DetailsPage(
            item: item,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Bloc'),
      ),
      body: ListView(
        children: <Widget>[
          this._textField(),
          StreamBuilder<SearchResult>(
              stream: this._searchBloc.apiResultFlux,
              builder:
                  (BuildContext context, AsyncSnapshot<SearchResult> snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          SearchItem item = snapshot.data.items[index];
                          return _items(item);
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              })
        ],
      ),
    );
  }
}
