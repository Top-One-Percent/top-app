import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/models.dart';

abstract class TipsDataSource {
  Future<List<Tip>> getTips();
}

class TipsDataSourceImpl implements TipsDataSource {
  final FirebaseFirestore firestore;

  TipsDataSourceImpl(this.firestore);

  @override
  Future<List<Tip>> getTips() async {
    CollectionReference tipsCollection = firestore.collection('tips');
    QuerySnapshot querySnapshot = await tipsCollection.get();

    return querySnapshot.docs.map((doc) {
      return Tip.fromFirestore(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
