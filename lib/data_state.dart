
import 'dart:math';

import 'package:flutter/material.dart';

class DataState with ChangeNotifier {
  bool isLoading = false;
  bool isFetching = false;
  int totalPages = 0;
  int currentPage = 0;
  List<int> items = [];

  DataState() {
    loadFirstPage();
  }

  void loadFirstPage() async {
    Random r = Random();
    for(var i=0; i<20; i++) {
      items.add(r.nextInt(100));
    }
    totalPages = 5;
    currentPage = 1;
    isLoading = currentPage < totalPages;
  }

  Future _delay() {
    return Future.delayed(Duration(seconds: 5));
  }

  void loadNextPage() async {
    if (isFetching) {
      return;
    }

    if (currentPage >= totalPages) {
      return;
    }

    isFetching = true;
    currentPage++;
    if (currentPage <= totalPages) {
      Random r = Random();
      for(var i=0; i<20; i++) {
        items.add(r.nextInt(100));
      }
    }
    isLoading = currentPage < totalPages;

    await _delay();

    print("new page loaded");

    isFetching = false;
    notifyListeners();
  }
}