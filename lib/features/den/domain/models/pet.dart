class Pet {
  const Pet({
    required this.name,
    required this.energyLevel,
    required this.lastNapTime,
    required this.decor,
    required this.social,
    required this.kibble,
  });

  final String name;
  final double energyLevel;
  final DateTime lastNapTime;
  final Map<String, dynamic> decor;
  final int social;
  final int kibble;

  Pet copyWith({
    double? energyLevel,
    DateTime? lastNapTime,
    Map<String, dynamic>? decor,
    int? social,
    int? kibble,
  }) {
    return Pet(
      name: name,
      energyLevel: energyLevel ?? this.energyLevel,
      lastNapTime: lastNapTime ?? this.lastNapTime,
      decor: decor ?? this.decor,
      social: social ?? this.social,
      kibble: kibble ?? this.kibble,
    );
  }
}
