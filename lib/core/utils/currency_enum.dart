enum CurrencyType {
  hkd('HKD', 'hkd'),
  usd('USD', 'usd');

  final String name;
  final String value;

  const CurrencyType(this.name, this.value);
}
