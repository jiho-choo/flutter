import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestings = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("naming app"),
        ),
        body: _buildList());
  }

  Widget _buildList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index.isOdd) {
          return Divider();
        }

        var realIndex = index ~/ 2;
        if (realIndex >= _suggestings.length) {
          _suggestings.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestings[realIndex]);
      },
    );
  }

  Widget _buildRow(WordPair wordPair) {
    return ListTile(title: Text(wordPair.asPascalCase, textScaleFactor: 1));

  }
}
