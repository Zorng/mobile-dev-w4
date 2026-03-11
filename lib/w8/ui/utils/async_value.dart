enum AsyncValueState { loading, error, success }

class AsyncValue<T> {
  final T? data;
  final Object? error;
  final AsyncValueState state;

  AsyncValue.loading():data = null, error = null, state = AsyncValueState.loading;

  AsyncValue.error({required this.error}):data = null, state = AsyncValueState.error;

  AsyncValue.success({required this.data}): error = null, state = AsyncValueState.success;


}
