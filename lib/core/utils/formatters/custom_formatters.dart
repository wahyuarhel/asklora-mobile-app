import 'package:flutter/services.dart';

FilteringTextInputFormatter englishNameFormatter() =>
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'));

FilteringTextInputFormatter fullEnglishNameFormatter() =>
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'));

FilteringTextInputFormatter fullEnglishNameWithHyphenAndUnderScoreFormatter() =>
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z-_\s]'));

FilteringTextInputFormatter onlyAllowOneSpace() =>
    FilteringTextInputFormatter.deny(RegExp(r'\s '));

FilteringTextInputFormatter chineseNameFormatter() =>
    FilteringTextInputFormatter.allow(RegExp('[\u4e00-\u9fa5]'));

FilteringTextInputFormatter lettersAndNumberFormatter() =>
    FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z]'));

FilteringTextInputFormatter lettersAndNumberWithSpaceFormatter() =>
    FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z ]'));

FilteringTextInputFormatter denyEmoji() => FilteringTextInputFormatter.deny(RegExp(
    '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'));
