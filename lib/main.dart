import 'package:film_collections_app/screen/detail/detail.dart';
import 'package:flutter/material.dart';
import 'screen/home/home.dart';
import 'screen/search/search.dart';

void main() => runApp(WhatToWatchApp());

class WhatToWatchApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatToWatch',
      theme: ThemeData.light(),
      home: HomePageWidget(),
    );
    /*return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/search': (context) => SearchScreen(),
        '/detail': (context) => DetailPage(),
      },
      title: 'What to watch',

      //home: HomePage(),
    );*/
  }
}







/*child: Container(
                    //margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          child: Image.asset(
                              'img/film.jpg',
                              // width: 300,
                              height: 150,
                              fit:BoxFit.fill

                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(film.title, textAlign: TextAlign.left),
                            Text(film.rating.toString(), textAlign: TextAlign.right)
                          ],
                        )
                      ],
                    )
                    *//*child: Center(
                        child: Text(data,
                            style: TextStyle(fontSize: 22, color: Colors.white),
                            textAlign: TextAlign.center)
                    )*//*)*/


/*class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: *//*1*//* (context, i) {
          if (i.isOdd) return Divider(); *//*2*//*

          final index = i ~/ 2; *//*3*//*
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); *//*4*//*
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}*/
