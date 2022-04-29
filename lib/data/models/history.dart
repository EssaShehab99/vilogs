class History {
  String key;
  String value;

  History({required this.key, required this.value});

  factory History.fromJson(Map<String, dynamic> json) => History(
    key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "key": key,
      "value": value,
    };
  }
}
