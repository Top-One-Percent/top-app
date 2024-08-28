import '../../data/datasources/datasources.dart';
import '../models/models.dart';

abstract class TipRepository {
  Future<List<Tip>> getTips();
}

class TipRepositoryImpl implements TipRepository {
  final TipsDataSource tipDataSource;

  TipRepositoryImpl(this.tipDataSource);

  @override
  Future<List<Tip>> getTips() async {
    return await tipDataSource.getTips();
  }
}
