class StringUtils {
  static bool isNotEmp(String v) {
    if (v != null && v.isNotEmpty) {
      return true;
    }
    return false;
  }
}
