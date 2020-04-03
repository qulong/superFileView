class StringUtils {
  static bool isNotEmp(String v) {
    if (v != null && v.isNotEmpty) {
      return true;
    }
    return false;
  }

  /// 检查对象或 List 或 Map 是否为空
 static bool isEmpty(Object object) {
    if (object == null) return true;
    if (object is String && object.isEmpty) {
      return true;
    } else if (object is List && object.isEmpty) {
      return true;
    } else if (object is Map && object.isEmpty) {
      return true;
    }
    return false;
  }
}
