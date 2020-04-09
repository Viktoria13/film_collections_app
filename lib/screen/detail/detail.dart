import 'package:film_collections_app/model/movie.dart';
import 'package:flutter/material.dart';


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
        //child: Text(widget.movie.toString()),
        child: Column(
          children: <Widget>[
            _buildTopPart(),
            _buildBottomPart()
          ],
        ),
      )
    );
  }

  Widget _buildTopPart() {
    return Row(
      children: <Widget>[
        _buildImage(),
        _buildMovieInfo()
      ],
    );
  }

  Widget _buildImage() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:10, vertical: 5),
        child: Image.asset('img/film.jpg'),
      )
      //
    );
  }

  Widget _buildMovieInfo() {
    return Expanded(
      child: Column(
          mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal:10, vertical: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(widget.movie.title, textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              )
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal:10, vertical: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(widget.movie.year, textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
              )
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal:10, vertical: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(widget.movie.getDetailRating(), textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
              )
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal:10, vertical: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: OutlineButton(
                  onPressed: () {

                  },
                  child: Text("Add to Watch List", textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal:10, vertical: 1),
              child: Align(
                alignment: Alignment.topLeft,
                child: OutlineButton(
                  onPressed: () {

                  },
                  child: Text("Seen", textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal:10, vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Overview:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            )
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Text(widget.movie.overview, textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
          )
        ],
      );
  }

}