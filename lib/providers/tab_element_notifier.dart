import 'package:flutter/material.dart';
import 'package:help_your_city/db/models/basic_card_model.dart';

abstract class TabElementNotifier extends ChangeNotifier {
  final List<BasicCardModel> _cardModels = [];

  List<BasicCardModel> get cardModels => _cardModels;

  void initCardModel(List<BasicCardModel> cardModels) {
    if (_cardModels.isEmpty) {
      _cardModels.addAll(cardModels);
    }
  }

  void addCardModel(BasicCardModel cardModel) {
    _cardModels.add(cardModel);
    notifyListeners();
  }

  void addAllCardModel(List<BasicCardModel> cardModels) {
    _cardModels.addAll(cardModels);
    notifyListeners();
  }
}
