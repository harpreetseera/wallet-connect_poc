/// A mixin which provides the utility methods
mixin Utility {
  /// Check if the provided URI is a valid one to make a pair connection
  bool isValidWCUri(String? uri) {
    if (uri == null || uri.isEmpty) return false;
    final doesUriContainWCKeyword = uri.contains("wc:");
    return doesUriContainWCKeyword;
  }
}
