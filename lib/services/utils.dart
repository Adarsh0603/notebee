class Utils {
  static String trimString(String strToTrim, [int trimLimit = 40]) {
    if (strToTrim.length > trimLimit) return strToTrim.substring(0, trimLimit);
    return strToTrim;
  }
}
