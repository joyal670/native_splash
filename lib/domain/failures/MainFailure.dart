// class MainFailure {
//   factory MainFailure.clientFailure() => MainFailure.clientFailure();
//   factory MainFailure.serverFailure() => MainFailure.serverFailure();
//   factory MainFailure.serversFailure() => MainFailure.serversFailure();
// }

// Custom failure classes
class MainFailure {
  final String message;

  MainFailure(this.message);

  // Factory constructors for common failure scenarios
  factory MainFailure.serverFailure() {
    return MainFailure('Server error occurred');
  }

  factory MainFailure.clientFailure(
      [String message = 'Client error occurred']) {
    return MainFailure(message);
  }
}
