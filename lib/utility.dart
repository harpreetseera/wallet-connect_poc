mixin Utility {
  bool isValidWCUri(String? uri) {
    if (uri == null || uri.isEmpty) return false;
    final doesUriContainWCKeyword = uri.contains("wc:");
    return doesUriContainWCKeyword;
  }
}
