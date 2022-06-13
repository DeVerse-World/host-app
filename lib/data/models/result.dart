class Result<DATA, ERROR extends Exception> {
  Result._(this.data, this.error);

  final DATA? data;

  final ERROR? error;

  factory Result.success(DATA data) => Result(data, null);

  factory Result.failure(ERROR error) => Result(null, error);

  DATA? getOrNull() => data;

  ERROR? getErrorOrNull() => error;

  DATA? get() => data!;

  ERROR? getError() => error!;

  Result(this.data, this.error);

  bool get isSuccess => error == null;

  bool get isFailure => error != null;
}

Future<Result<V, Exception>> getResult<V>(Function function) async {
  try {
    final result = await function.call();
    return Result.success(result);
  } on Exception catch (error) {
    return Result.failure(error);
  }
}