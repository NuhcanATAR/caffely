final class FirebaseServiceExceptions implements Exception {
  FirebaseServiceExceptions(this.description);

  final String description;
  @override
  String toString() {
    return "$this $description";
  }
}
