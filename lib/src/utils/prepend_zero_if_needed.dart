String prependZeroIfNeeded(String numStr) {
  return numStr.length == 1 ? '0$numStr' : numStr;
}
