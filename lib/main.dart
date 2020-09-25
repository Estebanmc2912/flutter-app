import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soy yo tú maestro', // Nombre de la aplicación en segundo plano
      theme: ThemeData(  // Tema de la aplicación
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordsState();
    throw UnimplementedError();
  }
}

class RandomWordsState extends State<RandomWords>{
  final _suggestions = <WordPair>[]; // el raya al piso significa que un atributo es privado
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Bienvenido a mí mundo')
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions (){
    return ListView.builder(
        itemBuilder: (context, i) {
          if (i >=_suggestions.length) { //para que la lista mostrada sea interminable (infinita)
            _suggestions.addAll(generateWordPairs().take(10));
                }
          return _buildRow(_suggestions[i]);
        },
    );
  }

  Widget _buildRow(WordPair pair){
    return ListTile(
     title: Text(pair.asPascalCase),
    );
  }

}
