import 'data_result.dart';
import 'failure.dart';

Future<DataResult<T>> executeData<T>(Future<T> Function() apiCall) async {
  try {
    var result = await apiCall.call();
    return Success(result);
  } on Exception catch (e) {
    return Fail(Failure(e.toString()));
  }
}