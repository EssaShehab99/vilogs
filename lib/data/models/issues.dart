class Issues {
  String key;
  String value;
  bool isInProgress;
  Issues({required this.key, required this.value, required this.isInProgress});

  factory Issues.fromJson(Map<String, dynamic> json) => Issues(
    key: json["key"],
        value: json["value"],
    isInProgress: json["isInProgress"],
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "key": key,
      "value": value,
      "isInProgress": isInProgress,
    };
  }
}
