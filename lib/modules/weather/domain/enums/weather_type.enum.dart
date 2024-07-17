enum WeatherType {
  clear,
  rain,
  clouds,
  sunny,
  windy,
}

WeatherType weatherTypeFromString(String s) {
  if (s.toLowerCase().contains('rain')) {
    return WeatherType.rain;
  } else if (s.toLowerCase().contains('clouds')) {
    return WeatherType.clouds;
  } else if (s.toLowerCase().contains('sunny')) {
    return WeatherType.sunny;
  } else if (s.toLowerCase().contains('drizzle')) {
    return WeatherType.windy;
  } else {
    return WeatherType.clear;
  }
}
