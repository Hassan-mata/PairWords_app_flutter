import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // final wordPair = WordPair.random();
   // forEach()
  return  MaterialApp(
    theme: ThemeData(primaryColor: Colors.purple[300]),
    home: _RandomWords()
  );
}
}


class _RandomWords extends StatefulWidget {
  @override
  _RandomWordState  createState() => _RandomWordState();

}

class _RandomWordState extends State<_RandomWords> {

  final randomWordPairs = <WordPair>[];
  final savedword = Set<WordPair>();

  Widget _buildList() {
  return ListView.builder(
    padding : const EdgeInsets.all(16),
    itemBuilder:(context , item) {
      if(item.isOdd) return Divider();
      final index = item ~/2 ;
      if (index >= randomWordPairs.length) {
        randomWordPairs.addAll(generateWordPairs().take(10));
      }
      return buildrow(randomWordPairs[index]);
    },
  );   
}

  Widget buildrow(WordPair _items){

    final alreadysaved = savedword.contains(_items);

    return ListTile(title: Text(_items.asPascalCase, style: TextStyle(color: Colors.black , fontSize:18.0)),

    trailing: Icon(alreadysaved ? Icons.favorite: Icons.favorite_border,
    color: alreadysaved ? Colors.red: null),

     onTap: () {
     setState(() {
        if(alreadysaved){
           savedword.remove(_items);
        } else {
           savedword.add(_items);
        }
      }
      );
     }
    );
  }
  void _pushedItem() {
    Navigator.of(context).push(
      MaterialPageRoute (
        builder: (BuildContext context) {
         final Iterable<ListTile>  tiles =
              savedword.map((WordPair _items) {
                return ListTile(
                  title: Text(_items.asLowerCase, style: TextStyle(fontSize:18.8))
                );
               }
              );
            final List<Widget> _passItems = ListTile.divideTiles( 
                   context: context,
                   tiles: tiles).toList();
                   return Scaffold(
                     appBar: AppBar(title: Text("SavedWord")),
                     body: ListView(children:(_passItems)),
                   );
          }
        )
      );
  }



Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TrackRoad"),
      // navigator / pusged to anoher widget
      actions : <Widget> [
        IconButton(
          icon: Icon(Icons.list),
          onPressed: _pushedItem
        )
      ]
      ),
      body: _buildList(),
    );
  }
}

