import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Tip {
  final String id;
  final String name;
  final IconData icon;

  Tip(this.name, this.icon) : id = const Uuid().v4();
}
