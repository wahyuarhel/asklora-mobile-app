String maskAccountNumber(String accountNumber, {int start = 3, int end = 3}) {
  return accountNumber.replaceRange(start, end, '*' * (end - start));
}
