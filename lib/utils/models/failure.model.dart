import 'dart:developer';

import 'package:weather_app/config/app_config.dart';
import 'package:weather_app/config/locators/locator.dart';

class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class InternalFailure extends Failure {
  InternalFailure() : super('Something went wrong');
}

class PermissionFailure extends Failure {
  PermissionFailure(super.message);
}

Future<T> fetchDataAndHandleErrors<T>(Future<T> Function() callback) async {
  try {
    return await callback();
  } catch (e, s) {
    log(e.toString());
    log(s.toString());

    if (environment == AppEnvironment.qa) {
      if (e is PermissionFailure) {
        rethrow;
      }

      throw Failure(e.toString());
    }

    if (e is PermissionFailure) {
      rethrow;
    }

    if (e is Failure) {
      rethrow;
    }

    throw InternalFailure();
  }
}

void handleError(e, s) {
  log(e.toString());
  log(s.toString());

  if (environment == AppEnvironment.qa) {
    throw Failure(e.toString());
  }

  if (e is Failure) {
    throw e;
  }

  throw InternalFailure();
}
