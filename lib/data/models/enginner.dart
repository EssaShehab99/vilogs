class Engineer {
  String? id;
  String name;
  bool availability;
  int rate;
  bool isCurrent;

  Engineer({
    this.id,
    required this.name,
    required this.availability,
    required this.rate,
    required this.isCurrent,
  });

  factory Engineer.fromJson(Map<String, dynamic> json) => Engineer(
        id: json["id"],
        name: json["name"],
        availability: json["availability"],
        rate: json["rate"],
    isCurrent: json["isCurrent"],
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "availability": availability,
      "isCurrent": isCurrent,
      "rate": rate
    };
  }
}
