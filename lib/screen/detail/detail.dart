import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_collections_app/context.dart';
import 'package:film_collections_app/model/movie.dart';
import 'package:film_collections_app/model/movie_category.dart';
import 'package:film_collections_app/screen/home/home.dart';
import 'package:film_collections_app/service/movie_service.dart';
import 'package:flutter/material.dart';


class DetailsPageWidget extends StatefulWidget {

  //DetailsPageWidget({this.movie, this.movieService});
  DetailsPageWidget({Key key, this.movie});

  //MovieService movieService;

  Movie movie;

  //static const firstButtonKey = Key('firstButtonKey');

  @override
  DetailsPageWidgetState createState() => DetailsPageWidgetState();
}

class DetailsPageWidgetState extends State<DetailsPageWidget> {

  @override
  void dispose() {
    _firstBtnText = "";
    _secondBtnText = "";
    _firstBtnAction = null;
    _secondBtnAction = null;
    super.dispose();
  }

  final String _addToWatchListBtnText = "Add to Watch List";
  final String _alreadyWatchedBtnText = "Already Watched";
  final String _deleteBtnText = "Delete";

  MovieCategory _currentMovieCategory;
  
  MovieService _movieService = Context.movieService;

  String _firstBtnText;
  String _secondBtnText;

  var _firstBtnAction;
  var _secondBtnAction;

  void _defineMovieCategory() {
    print("_defineMovieCategory");
    print(widget.movie.toString());

    widget.movie.watchList ? _currentMovieCategory = MovieCategory.watch
        : widget.movie.seen ? _currentMovieCategory = MovieCategory.seen
        : _currentMovieCategory = MovieCategory.none;
  }

  void _defineBtnProperties() {
    switch (_currentMovieCategory) {
      case MovieCategory.watch: {
        _addToWatchCategory();
      }
      break;

      case MovieCategory.seen: {
        _addToSeenCategory();
      }
      break;

      case MovieCategory.none:
      default: {
      _deleteFromCategory();
      }
      break;
    }
  }

  void _addToWatchCategoryAction() {
    print("action");
    /*widget.*/_movieService.saveToWatchList(widget.movie).then((movie) {
      print("then action");
      _currentMovieCategory = MovieCategory.watch;
      widget.movie = movie;
      _addToWatchCategory();
    });
  }

  void _addToSeenCategoryAction() {
    /*widget.*/_movieService.saveToSeenList(widget.movie).then((movie) {
      _currentMovieCategory = MovieCategory.seen;
      widget.movie = movie;
      _addToSeenCategory();
    });
  }

  void _deleteFromCategoryAction() {
    /*widget.*/_movieService.deleteMovieFromCategory(widget.movie).then((movie) {
      _currentMovieCategory = MovieCategory.none;
      widget.movie = movie;
      _deleteFromCategory();
    });
  }

  void _addToWatchCategory() {
    print("_addToWatchCategory");
    setState(() {
      _firstBtnText = _alreadyWatchedBtnText;
      _secondBtnText = _deleteBtnText;
    });
    _firstBtnAction = _addToSeenCategoryAction;
    _secondBtnAction = _deleteFromCategoryAction;
  }

  void _addToSeenCategory() {
    print("_addToSeenCategory");
    setState(() {
      _firstBtnText = _addToWatchListBtnText;
      _secondBtnText = _deleteBtnText;
    });
    _firstBtnAction = _addToWatchCategoryAction;
    _secondBtnAction = _deleteFromCategoryAction;
  }

  void _deleteFromCategory() {
    print("_deleteFromCategory");
    setState(() {
      _firstBtnText = _addToWatchListBtnText;
      _secondBtnText = _alreadyWatchedBtnText;
    });
    _firstBtnAction = _addToWatchCategoryAction;
    _secondBtnAction = _addToSeenCategoryAction;
  }

  @override
  Widget build(BuildContext context) {
    _defineMovieCategory();
    _defineBtnProperties();
    return WillPopScope(
      onWillPop: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePageWidget())),
      child: new Scaffold(
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
      ),
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
        padding: EdgeInsets.only(top: 5, left: 10),
        //padding: EdgeInsets.symmetric(horizontal:10, vertical: 5),
        child: CachedNetworkImage(
          imageUrl: /*widget.*/_movieService.getPosterUrl(widget.movie),
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      )
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
                  //key: DetailsPageWidget.firstButtonKey,
                  onPressed: () {
                    _firstBtnAction();
                  },
                  child: Text(_firstBtnText, textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal:10, vertical: 1),
              child: Align(
                alignment: Alignment.topLeft,
                child: OutlineButton(
                  //key: Key('second_btn_key'),
                  onPressed: () {
                    _secondBtnAction();
                  },
                  child: Text(_secondBtnText, textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
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
