class Temperature {
  final double value;

  const Temperature(this.value);

  String get formatted => '${value.toStringAsFixed(1)}°C';
}
