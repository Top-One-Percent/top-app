import 'package:flutter/material.dart';

import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';

class TipProvider with ChangeNotifier {
  final TipRepository tipRepository;

  TipProvider(this.tipRepository);

  List<Tip> _tips = [];

  List<Tip> get tips => _tips;

  Future<void> loadTips() async {
    print(_tips);
    _tips = await tipRepository.getTips();
    print(_tips);

    notifyListeners();
  }

  List<Tip> get normalTips => _tips.where((tip) => !tip.isFavorite).toList();
  List<Tip> get favoriteTips => _tips.where((tip) => tip.isFavorite).toList();
}
