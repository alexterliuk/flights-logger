int extractInt(String maybeInt) {
  try {
    int integer = int.parse(maybeInt);
    return integer;
  } catch (e) {
    return -1;
    // return 0;
  }
}
