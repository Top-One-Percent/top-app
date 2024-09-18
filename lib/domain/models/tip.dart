
class Tip {
  final String id;
  final String name;
  final List<String> messages;
  final bool isFavorite;
  final bool isGeneral;

  Tip({
    required this.id,
    required this.name,
    required this.messages,
    required this.isFavorite,
    required this.isGeneral,
  });

  factory Tip.fromFirestore(String id, Map<String, dynamic> data) {
    return Tip(
      id: id,
      name: data['name'] ?? '',
      messages: List<String>.from(data['messages'] ?? []),
      isFavorite: data['isFavorite'] ?? false,
      isGeneral: data['isGeneral'] ?? false,
    );
  }
}
