import 'dart:math';

import 'package:faker/faker.dart';

final random = Random();

final faker = Faker();

Future<void> fakeNetworkDelay({int seconds = 2}) async {
  await Future.delayed(Duration(seconds: seconds));
}
