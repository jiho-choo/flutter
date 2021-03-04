import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/src/bloc.dart';

class SavedList extends StatefulWidget {
  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved"),
      ),
      body: _buildList()
    );
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
      stream: bloc.savedStream,
      builder: (context, snapshot) {
        var saved = Set<WordPair>();
        if (snapshot.hasData) {
          saved.addAll(snapshot.data);
        } else {
          bloc.addCurrentSaved;
        }

        return ListView.builder(itemBuilder: (context, index) {
          if (index.isOdd) {
            return Divider();
          }

          var realIndex = index ~/ 2;

          return (snapshot.hasData) ? _buildRow(snapshot.data.toList()[realIndex]) : null;

        },
        itemCount: (snapshot.hasData) ? snapshot.data.length*2 : 0,
        );
      }
    );
  }

  Widget _buildRow(WordPair wordPair) {
    return ListTile(
      title: Text(wordPair.asPascalCase, textScaleFactor: 1.5),
      onTap: () {
        bloc.addToOrRemoveFromSavedList(wordPair);
      },
    );
  }
}
