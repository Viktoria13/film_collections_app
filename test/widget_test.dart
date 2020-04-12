// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:film_collections_app/database/database_helper.dart';
import 'package:film_collections_app/model/movie.dart';
import 'package:film_collections_app/screen/detail/detail.dart';
import 'package:film_collections_app/service/movie_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:film_collections_app/main.dart';
import 'package:mockito/mockito.dart';

class DatabaseHelperMock extends Mock implements DatabaseHelper{}

void main() {

  final dbHelperMock = DatabaseHelperMock();
  final movieService = MovieService(dbHelperMock);

  //movie, that has been got from api
  Movie originalMovie = new Movie(
      id: 123,
      title: "Terminator",
      year: "2003",
      rating: 6.7,
      overview: "overview",
      posterPath: "/path",
      watchList: false,
      seen: false
  );

  //the same movie in our db
  Movie movieInDb = new Movie(
      id: 123,
      title: "Terminator",
      year: "2003",
      rating: 6.7,
      overview: "overview",
      posterPath: "/path",
      watchList: true,
      seen: false
  );

  Movie movie = new Movie(
      id: 142,
      title: "Jack",
      year: "2007",
      rating: 8.0,
      overview: "overview",
      posterPath: "/path",
      watchList: false,
      seen: false
  );

  group('Get Actual movie', () {
    test('Get movie existing in db', () async {
      when(dbHelperMock.get(123)).thenAnswer((_) => Future.value(movieInDb.toMap()));
      expect(await movieService.getActualMovie(originalMovie), movieInDb);
      verify(dbHelperMock.get(123));
    });

    test('Get original movie, not existing in db', () async {
      when(dbHelperMock.get(142)).thenAnswer((_) => Future.value(null));
      expect(await movieService.getActualMovie(movie), movie);
      verify(dbHelperMock.get(142));
    });
  });

  group('Save movie to category', () {
    test('Save movie to watchlist', () async {
      Movie updatedMovie = new Movie(
          id: 142,
          title: "Jack",
          year: "2007",
          rating: 8.0,
          overview: "overview",
          posterPath: "/path",
          watchList: true,
          seen: false
      );
      when(dbHelperMock.insert(updatedMovie.toMap())).thenAnswer((_) => Future.value(142));
      expect(await movieService.saveToWatchList(movie), updatedMovie);
      verify(dbHelperMock.insert(movie.toMap()));
    });

    test('Save movie to seen list', () async {
      Movie updatedMovie = new Movie(
          id: 142,
          title: "Jack",
          year: "2007",
          rating: 8.0,
          overview: "overview",
          posterPath: "/path",
          watchList: false,
          seen: true
      );
      when(dbHelperMock.insert(updatedMovie.toMap())).thenAnswer((_) => Future.value(142));
      expect(await movieService.saveToSeenList(movie), updatedMovie);
      verify(dbHelperMock.insert(movie.toMap()));
    });
  });

  testWidgets('Movie info', (WidgetTester tester) async {

    Movie movie = new Movie(
        id: 142,
        title: "Jack",
        year: "2007",
        rating: 8.0,
        overview: "overview",
        posterPath: "/path",
        watchList: true,
        seen: false
    );

    //when(movieServiceMock.getPosterUrl(movie)).thenAnswer((_) => "https://image.tmdb.org/t/p/w154/5mubFanEHVFJff4jLQH0uIOThMz.jpg");

    await tester.pumpWidget(
        new MaterialApp(
          home: DetailsPageWidget(movie: movie/*, movieService: movieServiceMock*/),
        ));

    expect(find.text('Jack'), findsOneWidget);
    expect(find.text('2007'), findsOneWidget);
    expect(find.text('8.0/10'), findsOneWidget);
    expect(find.text('overview'), findsOneWidget);
  });

  testWidgets('Movie not in categories', (WidgetTester tester) async {

    Movie movie = new Movie(
        id: 142,
        title: "Jack",
        year: "2007",
        rating: 8.0,
        overview: "overview",
        posterPath: "/path",
        watchList: false,
        seen: false
    );

    //when(movieServiceMock.getPosterUrl(movie)).thenAnswer((_) => "https://image.tmdb.org/t/p/w154/5mubFanEHVFJff4jLQH0uIOThMz.jpg");

    await tester.pumpWidget(
        new MaterialApp(
          home: DetailsPageWidget(movie: movie/*, movieService: movieServiceMock*/),
        ));

    expect(find.widgetWithText(RaisedButton, "Add to Watch List"), findsOneWidget);
    expect(find.widgetWithText(RaisedButton, "Already Watched"), findsOneWidget);
    expect(find.widgetWithText(RaisedButton, "Delete"), findsNothing);
  });

  testWidgets('Movie in watchlist', (WidgetTester tester) async {

    Movie movie = new Movie(
        id: 142,
        title: "Jack",
        year: "2007",
        rating: 8.0,
        overview: "overview",
        posterPath: "/path",
        watchList: true,
        seen: false
    );

    //when(movieServiceMock.getPosterUrl(movie)).thenAnswer((_) => "https://image.tmdb.org/t/p/w154/5mubFanEHVFJff4jLQH0uIOThMz.jpg");

    await tester.pumpWidget(
        new MaterialApp(
          home: DetailsPageWidget(movie: movie/*, movieService: movieServiceMock*/),
        ));

    expect(find.widgetWithText(RaisedButton, "Already Watched"), findsOneWidget);
    expect(find.widgetWithText(RaisedButton, "Delete"), findsOneWidget);
    expect(find.widgetWithText(RaisedButton, "Add to Watch List"), findsNothing);
  });

  testWidgets('Movie in seen category', (WidgetTester tester) async {

    Movie movie = new Movie(
        id: 142,
        title: "Jack",
        year: "2007",
        rating: 8.0,
        overview: "overview",
        posterPath: "/path",
        watchList: false,
        seen: true
    );

    //when(movieServiceMock.getPosterUrl(movie)).thenAnswer((_) => "https://image.tmdb.org/t/p/w154/5mubFanEHVFJff4jLQH0uIOThMz.jpg");

    await tester.pumpWidget(
        new MaterialApp(
          home: DetailsPageWidget(movie: movie/*, movieService: movieServiceMock*/),
        ));

    expect(find.widgetWithText(RaisedButton, "Add to Watch List"), findsOneWidget);
    expect(find.widgetWithText(RaisedButton, "Delete"), findsOneWidget);
    expect(find.widgetWithText(RaisedButton, "Already Watched"), findsNothing);
  });




  /*testWidgets('Add movie to watch list', (WidgetTester tester) async {

    Movie updatedMovie = new Movie(
        id: 142,
        title: "Jack",
        year: "2007",
        rating: 8.0,
        overview: "overview",
        posterPath: "/path",
        watchList: true,
        seen: false
    );

    when(movieServiceMock.saveToWatchList(movie)).thenAnswer((_) => Future.value(updatedMovie));
    when(movieServiceMock.getPosterUrl(movie)).thenAnswer((_) => "https://image.tmdb.org/t/p/w154/5mubFanEHVFJff4jLQH0uIOThMz.jpg");

    await tester.pumpWidget(
        new MaterialApp(
          home: DetailsPageWidget(movie: movie, movieService: movieServiceMock),
        ));

    expect(find.widgetWithText(RaisedButton, "Add to Watch List"), findsOneWidget);
    expect(find.widgetWithText(RaisedButton, "Already Watched"), findsOneWidget);
    expect(find.widgetWithText(RaisedButton, "Delete"), findsNothing);

    await tester.tap(find.widgetWithText(RaisedButton, "Add to Watch List"));
    await tester.pump();

    expect(find.widgetWithText(RaisedButton, "Already Watched"), findsOneWidget);
    expect(find.widgetWithText(RaisedButton, "Delete"), findsOneWidget);
    expect(find.widgetWithText(RaisedButton, "Add to Watch List"), findsNothing);

  });*/


  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(WhatToWatchApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
