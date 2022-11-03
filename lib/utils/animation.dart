import 'dart:math';

double linearValueMap(
  double variable, {
  List<double>? from,
  List<double>? to,
  double? fromBegin,
  double? fromEnd,
  double? toBegin,
  double? toEnd,
  double? gradient,
}) {
  fromBegin ??= from?[0] ?? 0;
  fromEnd ??= from?[1];
  toBegin ??= to?[0] ?? 0;
  toEnd ??= to?[1];
  if (fromEnd != null) {
    toEnd ??= toBegin + fromEnd - fromBegin;
    if (fromBegin > fromEnd) {
      var temp = fromBegin;
      fromBegin = fromEnd;
      fromEnd = temp;
      temp = toBegin;
      toBegin = toEnd;
      toEnd = temp;
    }
    gradient ??= (toEnd - toBegin) / (fromEnd - fromBegin);

    // print('from: $fromBegin -> $fromEnd, to: $toBegin -> $toEnd, ${toBegin + max(max(variable - fromBegin, 0) * gradient, toEnd - toBegin)}');
    var value = max(variable - fromBegin, 0) * gradient;
    return gradient <= 0 ? toBegin + max(value, toEnd - toBegin) : toBegin + min(value, toEnd - toBegin);
  } else if (toEnd != null) {
    gradient ??= (toEnd - toBegin).sign;
    // print('from: $fromBegin, to: $toBegin -> $toEnd');
    return toBegin + max(max(variable - fromBegin, 0) * gradient, toEnd - toBegin);
  } else {
    gradient ??= 1.0;
    return toBegin + max((variable - fromBegin) * gradient, 0);
  }
}
