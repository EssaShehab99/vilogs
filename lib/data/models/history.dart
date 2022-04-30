class History {
  String key;
  String value;

  History({required this.key, required this.value});

  factory History.setData({required String key,required String value,}) => History(
    key: key,
        value: value,
      );

}
