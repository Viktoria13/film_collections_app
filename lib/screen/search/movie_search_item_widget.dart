import 'package:film_collections_app/model/movie.dart';
import 'package:film_collections_app/screen/detail/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@deprecated
class MovieSearchItemWidget extends StatefulWidget {

  MovieSearchItemWidget({Key key, this.movie});

  Movie movie;

  MovieSearchItemWidgetState createState() => MovieSearchItemWidgetState();
}

class MovieSearchItemWidgetState extends State<MovieSearchItemWidget> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
            widget.movie.getTitleWithYear()
        ),
        IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => DetailsPageWidget()));
            }
        )
        /*Align(
          alignment: Alignment.centerLeft,
          child: Text(
              widget.movie.getTitleWithYear()
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => DetailsPageWidget()));
              }
          ),
        )*/
      ],
    );
  }

}