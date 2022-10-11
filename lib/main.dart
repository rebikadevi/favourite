

import 'package:favorite_app/state/app_state.dart';
import 'package:favorite_app/view/api_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),

      child:const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ApiView(),
      ),
    );
  }
}




