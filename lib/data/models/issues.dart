class Issues {
  String key;
  String value;
  bool isInProgress;
  Issues({required this.key, required this.value, required this.isInProgress});

  factory Issues.setData({required String key, required String value, required bool isInProgress}) => Issues(
    key: key,
        value: value,
    isInProgress:isInProgress ,
      );

}
