import 'package:flutter/material.dart';

import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';

class TipProvider with ChangeNotifier {
  final TipRepository tipRepository;

  TipProvider(this.tipRepository);

  List<Tip> _tips = [];

  List<Tip> get tips => _tips;

  Future<void> loadTips() async {
    _tips = await tipRepository.getTips();
    notifyListeners();
  }

  List<Tip> get generalTips => _tips.where((tip) => tip.isGeneral).toList();
  List<Tip> get favoriteTips => _tips.where((tip) => tip.isFavorite).toList();
}
