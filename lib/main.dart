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

class RandomWords extends StatefulWidget { // Creador del estado interactivo
  @override
  State<StatefulWidget> createState() {
    return RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords>{  // Creador del diseño de la aplicación que hereda el estado del antes mencionado
  final _suggestions = <WordPair>[]; // el raya al piso significa que un atributo es privado, lista de palabras
  final _biggerFont = const TextStyle( fontSize: 16); // creación de variable para definir el tamaño

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Bienvenido a mí mundo')
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions (){ // creador del List View
    return ListView.builder(
        padding: const EdgeInsets.all(16.0), // atributo para acomodar mejor la lista según el dispositivo
        itemBuilder: (context, i) {

          if (i.isOdd){
            return Divider(); // si el item (listView) es par retorna un divisor, hacer la prueba poniendolo falso para entender
          }

          if (i >=_suggestions.length) { //para que la lista mostrada sea interminable (infinita)
            _suggestions.addAll(generateWordPairs().take(10));
                }


          return _buildRow(_suggestions[i]);
        },
    );
  }

  Widget _buildRow(WordPair pair){ // creador de cada fila
    return ListTile(
     title: Text(
         pair.asPascalCase,
         style: _biggerFont, // llamamos la variable creada anteriormente y acá le damos estilo
     ),
    );
  }

}
