import 'package:film_collections_app/screen/detail/detail.dart';
import 'package:flutter/material.dart';
import 'screen/home/home.dart';
import 'screen/search/search.dart';

void main() => runApp(WhatToWatchApp());

class WhatToWatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatToWatch',
      theme: ThemeData.light(),
      home: HomePageWidget(),
    );
  }
}
