import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (BuildContext context) => DataState(),
        child: ListDemo(),
      ),
    );
  }
}

class ListDemo extends StatefulWidget {
  @override
  _ListDemoState createState() => _ListDemoState();
}

class _ListDemoState extends State<ListDemo> {
  ScrollController _controller;


  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
    _controller.addListener(_onScrollUpdated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DataState>(
        builder: (BuildContext context, DataState value, Widget child) {
          return ListView.builder(
            controller: _controller,
            itemCount:
                value.isLoading ? value.items.length + 1 : value.items.length,
            itemBuilder: (BuildContext context, int index) {
              if (index >= value.items.length) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListTile(
                title: Text("$index - ${value.items[index]}"),
              );
            },
          );
        },
      ),
    );
  }

  void _onScrollUpdated() {
    var maxScroll = _controller.position.maxScrollExtent;
    var currentPosition = _controller.position.pixels;

    if (currentPosition > maxScroll - 100) {
      var state = Provider.of<DataState>(context, listen: false);

      state.loadNextPage();
    }
  }
}
