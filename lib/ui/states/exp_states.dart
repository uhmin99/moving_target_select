import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class UserNameState with ChangeNotifier {
  String _name = "Unknown";

  String get name => _name;

  void setName(String newName) {
    _name = newName;
    notifyListeners();
  }
}

class ExpReserveState with ChangeNotifier {
  // TODO : Implement the ExpReserve class. 실험 예약에 뭐가 들어가야되는지 나타내는 클라스 만들기고 적용
  var _reserve = [];

  get reserve => _reserve;

  void append(data) {
    _reserve.add(data);
    notifyListeners();
  }

  void reset() {
    _reserve = [];
    notifyListeners();
  }

  void removeLast() {
    _reserve.removeLast();
    notifyListeners();
  }

  int getLength() {
    return _reserve.length;
  }

  void removeAt(int index) {
    _reserve.removeAt(index);
    notifyListeners();
  }

  void updateAt(int index, data) {
    _reserve[index] = data;
    notifyListeners();
  }

  void setReserveList(List data) {
    _reserve = data;
    notifyListeners();
  }

  bool isEmpty() {
    return _reserve.isEmpty;
  }
}

class ExpResultState with ChangeNotifier {
  // TODO : Implement the ExpResult class. 실험 결과에 뭐가 들어가야되는지 나타내는 클라스 만들기고 적용
  List<List<dynamic>?> _result = [];

  get result => _result;

  void append(data) {
    _result.add(data);
    notifyListeners();
  }

  void reset() {
    _result = [];
    notifyListeners();
  }

  void removeLast() {
    _result.removeLast();
    notifyListeners();
  }

  void removeAt(int index) {
    _result.removeAt(index);
    notifyListeners();
  }

  void updateAt(int index, data) {
    _result[index] = data;
    notifyListeners();
  }
}