import 'package:flutter/material.dart';
import 'package:moving_target_select/entity/exp_entity.dart';

class UserInfoState with ChangeNotifier {
  String _name = "Unset";
  String _gender = "Unset";
  String _age = "Unset";

  String get name => _name;
  String get gender => _gender;
  String get age => _age;

  void setName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void setGender(String newGender) {
    _gender = newGender;
    notifyListeners();
  }

  void setAge(String newAge) {
    _age = newAge;
    notifyListeners();
  }
}

class ExpReserveState with ChangeNotifier {
  List<ExpEntity> _reserve = [];

  List<ExpEntity> get reserve => _reserve;

  void append(data) {
    _reserve.add(data);
    notifyListeners();
  }

  ExpEntity getFirst() {
    return _reserve[0];
  }

  void reset() {
    _reserve = [];
    notifyListeners();
  }

  void removeFirst() {
    _reserve.removeAt(0);
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

  void setReserveList(List<ExpEntity> data) {
    _reserve = data;
    notifyListeners();
  }

  bool isEmpty() {
    return _reserve.isEmpty;
  }
}

class ExpResultState with ChangeNotifier {
  List<ExpResultEntity> _result = [];

  List<ExpResultEntity> get result => _result;

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