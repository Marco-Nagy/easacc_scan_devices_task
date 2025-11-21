import 'failure.dart';

sealed class DataResult<T> {}

class Success<T> implements DataResult<T> {
  T data;

  Success(this.data);
}

class Fail<T> extends DataResult<T> {
  final Failure failure;
   Fail(this.failure);
}

