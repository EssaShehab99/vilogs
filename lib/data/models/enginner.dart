class Engineer {
  String? id;
  String? docID;
  String name;
  bool availability;
  int rate;
  bool isCurrent;

  Engineer({
    this.id,
    this.docID,
    required this.name,
    required this.availability,
    required this.rate,
    required this.isCurrent,
  });

  factory Engineer.fromJson({required Map<String, dynamic> json, required String docID}) => Engineer(
    docID: docID,
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
