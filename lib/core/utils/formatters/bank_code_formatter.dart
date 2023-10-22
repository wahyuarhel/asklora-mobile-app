String bankCodeFormatter(bankCode) {
  return bankCode.toString().padLeft(3, '0');
}
