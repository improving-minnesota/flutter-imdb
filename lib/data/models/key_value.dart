class KeyValue {
  const KeyValue({
    required this.key,
    required this.value,
  });

  final String key;
  final String value;

  factory KeyValue.fromJson(Map<String, dynamic> json) {
    return KeyValue(
        key: json['key'],
        value: json['value'],
    );
  }
}
