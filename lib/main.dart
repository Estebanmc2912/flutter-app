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
  final _saved = Set<WordPair>();// los sets son una lista de objetos únicos, no se pueden repetir

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Generador de nombres de Startups'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.list),
              onPressed: _pushSaved, // función que se le pasa cuando selecciona un item
            )
          ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved(){
    Navigator.of(context).push(MaterialPageRoute( builder: (context) {
      final tiles = _saved.map((pair){ // Hacemos un mapa para guardar los seleccionados
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });

       final divided = ListTile.divideTiles( // Listado de ListStyles con separadores entre ellos
           context: context,
           tiles: tiles).toList();
      return Scaffold(
        appBar: AppBar(
          title: Text("Sugerencias guardadas"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: divided,
        )
      );
    })
    ); // función para crear una nueva pantalla, o navegador el cual recibe una ruta
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

          return _buildRow(_suggestions[i]); // retorno con llamamiento de función que hace el item
        },
    );
  }

  Widget _buildRow(WordPair pair){ // creador de cada elemento/item
    final alreadySaved = _saved.contains(pair);

    return ListTile(
     title: Text(
         pair.asPascalCase,
         style: _biggerFont, // llamamos la variable creada anteriormente y acá le damos estilo
     ),
      trailing: Icon(
         alreadySaved ? Icons.favorite : Icons.favorite_border,
         color: alreadySaved ? Colors.redAccent : Colors.blueGrey,
      ),
      onTap: (){
       setState(() {
         if (alreadySaved){
            _saved.remove(pair);
         } else {
            _saved.add(pair);
         }
       });
      },
    );
  }

}
