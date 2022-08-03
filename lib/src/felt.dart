import 'dart:typed_data';

import 'package:starknet/starknet.dart';

class Felt {
  /// Spec: https://docs.starknet.io/docs/Hashing/hash-functions/#domain-and-range
  static final prime =
      BigInt.two.pow(251) + BigInt.from(17) * BigInt.two.pow(192) + BigInt.one;

  late BigInt _bigInt;

  Felt(this._bigInt) {
    if (_bigInt >= prime) {
      throw ArgumentError('Value must be smaller than 2^251 + 17 * 2^192 + 1');
    }
  }

  factory Felt.fromInt(int int) {
    return Felt(BigInt.from(int));
  }

  factory Felt.fromIntString(String value, {int? radix = 10}) {
    return Felt(BigInt.parse(value, radix: radix));
  }

  factory Felt.fromString(String value) {
    return Felt(stringToBigInt(value));
  }

  factory Felt.fromHexString(String hex) {
    return Felt(hexStringToBigInt(hex));
  }

  factory Felt.fromBytes(Uint8List bytes) {
    return Felt(bytesToBigInt(bytes));
  }

  factory Felt.fromJson(String json) {
    return Felt.fromHexString(json);
  }

  String toJson() {
    return bigIntToHexString(_bigInt);
  }

  @override
  String toString() {
    return "Felt(${_bigInt.toString()})";
  }

  BigInt toBigInt() {
    return _bigInt;
  }

  @override
  bool operator ==(Object other) {
    return other is Felt && (_bigInt - other._bigInt) == BigInt.zero;
  }

  @override
  int get hashCode => _bigInt.hashCode;
}
