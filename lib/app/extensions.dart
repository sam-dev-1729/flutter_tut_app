// ignore_for_file: constant_identifier_names

const EMPTY = "";
const ZERO = 0;

extension NunNullableString on String? {
  String orEmpty() {
    if (this == null) {
      return EMPTY;
    } else {
      return this!;
    }
  }
}

extension NunNullableInteger on int? {
  int orZero() {
    if (this == null) {
      return ZERO;
    } else {
      return this!;
    }
  }
}
