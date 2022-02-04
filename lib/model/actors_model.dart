class Actor {
  final String name;
  final String description;
  final int cost;
  final String? id;
  final String castedBy;

  const Actor({
    required this.name,
    required this.description,
    required this.cost,
    required this.castedBy,
    this.id,
  });

  factory Actor.fromMap(Map<dynamic, dynamic> map, String id) {
    return Actor(
      name: map['name'] as String,
      description: map['description'] as String,
      cost: map['cost'] as int,
      id: id,
      castedBy: map['castedBy']
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': name,
      'description': description,
      'cost': cost,
      'castedBy': castedBy
    } as Map<String, dynamic>;
  }
}
