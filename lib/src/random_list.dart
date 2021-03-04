import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:testing_app/src/bloc.dart';
import 'package:testing_app/src/saved.dart';

class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestings = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("한글테스트 app울라라"), actions: <Widget>[
          IconButton(
              icon: Icon(Icons.list),
              onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SavedList()))
                  .then((value) => setState(() {}))
              // onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SavedList(saved: _saved)))
              )
        ]),
        body: _buildList());
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
        stream: bloc.savedStream,
        builder: (context, snapshot) {
          return ListView.builder(
            itemBuilder: (context, index) {
              if (index.isOdd) {
                return Divider();
              }

              var realIndex = index ~/ 2;
              if (realIndex >= _suggestings.length) {
                _suggestings.addAll(generateWordPairs().take(10));
              }

              return _buildRow(snapshot.data, _suggestings[realIndex]);
            },
          );
        });

    // return ListView.builder(
    //   itemBuilder: (context, index) {
    //     if (index.isOdd) {
    //       return Divider();
    //     }
    //
    //     var realIndex = index ~/ 2;
    //     if (realIndex >= _suggestings.length) {
    //       _suggestings.addAll(generateWordPairs().take(10));
    //     }
    //
    //     return _buildRow(_suggestings[realIndex]);
    //   },
    // );
  }

  Widget _buildRow(Set<WordPair> saved, WordPair wordPair) {

    if (saved == null) saved = Set<WordPair>();
    final bool alreadySaved = saved.toList().contains(wordPair);
    return ListTile(
      title: Text(wordPair.asPascalCase, textScaleFactor: 1.5),
      trailing: Icon((!alreadySaved) ? Icons.favorite_border : Icons.favorite,
          color: Colors.pinkAccent),
      onTap: () {
        bloc.addToOrRemoveFromSavedList(wordPair);
        print(saved.toString());
      },
    );
  }
}
