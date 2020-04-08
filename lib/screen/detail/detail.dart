import 'package:film_collections_app/model/movie.dart';
import 'package:flutter/material.dart';

/*class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DetailPage();
  }
}*/

class DetailsPageWidget extends StatefulWidget {

  DetailsPageWidget({Key key, this.movie});

  Movie movie;

  @override
  DetailsPageWidgetState createState() => DetailsPageWidgetState();
}

class DetailsPageWidgetState extends State<DetailsPageWidget> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Search Movies"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Text(widget.movie.toString()),
      )
    );
  }
}