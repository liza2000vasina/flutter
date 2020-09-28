import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liza Vasina TI-72 FirstApp', 
      theme: ThemeData(          
    // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.pink[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Georgia',
      ),                               
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
    final _suggestions = <WordPair>[];
    final _biggerFont = TextStyle(fontSize: 18.0);
    final _saved = Set<WordPair>(); 
    Widget _buildRow(WordPair pair) {
      final alreadySaved = _saved.contains(pair);
      return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: Icon(   
          alreadySaved ? Icons.remove_circle_outline : Icons.add_circle_outline,
          color: alreadySaved ? Colors.black : null,
        ),
        onTap: () {      
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else { 
              _saved.add(pair); 
            } 
          });
        },            
      );
    }
    Widget _buildSuggestions() {
      return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemBuilder: /*1*/ (context, i) {
            if (i.isOdd) return Divider(); /*2*/
            final index = i ~/ 2; /*3*/
            if (index >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10)); /*4*/
            }
            return _buildRow(_suggestions[index]);
          }
      );
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Liza Vasina FirstApp'),
           actions: [
            IconButton(icon: Icon(Icons.add_to_photos), onPressed: _pushSaved),
          ],
        ),
        body: _buildSuggestions(),
      );
    }
    void _pushSaved() {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
            final tiles = _saved.map(
              (WordPair pair) {
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                );
              },
            );
            final divided = ListTile.divideTiles(
              context: context,
              tiles: tiles,
            ).toList();
            return Scaffold(
              appBar: AppBar(
                title: Text('Saved'),
              ),
              body: ListView(children: divided),
            );
          }, 
        ),
      );
    }
  }