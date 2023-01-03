import 'package:flutter/material.dart';

class HttpException implements Exception {
  final String? massage;
  HttpException(this.massage);

  @override
  String toString() {
    // TODO: implement toString
    return massage!;
  }
}
