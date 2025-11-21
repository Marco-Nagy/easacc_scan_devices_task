class Failure {
  final String message;
  final FailureType type;
  const Failure(this.message, {this.type = FailureType.unknown});
}

enum FailureType { network, server, cache, unknown }
