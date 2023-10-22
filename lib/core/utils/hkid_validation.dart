final RegExp hkIdRegex = RegExp(r'^[A-Z]{1,2}[0-9]{6}[0-9A]$');

bool isHkIdNumberValid(String hkId) => hkIdRegex.hasMatch(hkId.toUpperCase());

final Map<String, int> _conversionTable = {
  '0': 0,
  '1': 1,
  '2': 2,
  '3': 3,
  '4': 4,
  '5': 5,
  '6': 6,
  '7': 7,
  '8': 8,
  '9': 9,
  'A': 10,
  'B': 11,
  'C': 12,
  'D': 13,
  'E': 14,
  'F': 15,
  'G': 16,
  'H': 17,
  'I': 18,
  'J': 19,
  'K': 20,
  'L': 21,
  'M': 22,
  'N': 23,
  'O': 24,
  'P': 25,
  'Q': 26,
  'R': 27,
  'S': 28,
  'T': 29,
  'U': 30,
  'V': 31,
  'W': 32,
  'X': 33,
  'Y': 34,
  'Z': 35,
  'SPACE': 36,
};

/// Source: https://github.com/shermanfcm/HKID
/// The HKID validation does not support parentheses in the last char.
bool isHkIdValid(String hkId) {
  hkId = hkId.toUpperCase();
  int checkSum = 0;
  int product = 0;
  List<String> letterArray = hkId.trim().split('');
  if (isHkIdNumberValid(hkId)) {
    if (letterArray.length == 9) {
      int multiplyBy = 9;
      for (int i = 0; i < 9; i++) {
        var conversion = _conversionTable[letterArray[i]] ?? 0;
        product = multiplyBy * conversion;
        checkSum = checkSum + product;
        --multiplyBy;
        product = 0;
      }
    } else {
      checkSum = 0;
      int multiplyBy = 8;
      product = 36 * 9;
      checkSum = product;
      for (int i = 0; i < 8; i++) {
        product = 0;
        var conversion = _conversionTable[letterArray[i]] ?? 0;
        product = multiplyBy * conversion;
        checkSum = checkSum + product;
        --multiplyBy;
      }
    }
    final int mod = checkSum % 11;
    return mod == 0;
  }
  return false;
}
