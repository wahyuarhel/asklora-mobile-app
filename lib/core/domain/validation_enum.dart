enum ValidationCode {
  /// Internal Errors
  passwordChangeSuccessfully('passwordChangeSuccessfully'),
  linkPasswordResetIsSent('linkPasswordResetIsSent'),
  inputWrongEmailAddress('inputWrongEmailAddress'),
  enterValidEmail('enterValidEmail'),
  passwordDoesNotMatch('passwordDoesNotMatch'),
  enterValidPassword('enterValidPassword'),
  otpSentToYourPhone('otpSentToYourPhone'),
  otpSentToYourEmail('otpSentToYourEmail'),
  verifyOtpSuccess('verifyOtpSuccess'),
  noInternetConnection('noInternetConnection'),
  emailVerificationLinkSentSuccess('emailVerificationLinkSentSuccess'),
  couldNotGetUserDetails('couldNotGetUserDetails'),
  couldNotFetchOnfidoToken('couldNotGetUserDetails'),
  couldNotUpdateOnfidoResult('couldNotGetUserDetails'),
  redoIsq('tickersAreUnder5redoIsqError'),
  empty(''),

  ///
  /// Internal Errors

  /// Server Errors

  // AUTHENTICATION
  invalidToken('AU0001'),
  wrongCredentials('AU0002'),
  userNotFound('AU0003'),
  invalidPassword('AU0004'),
  invalidUser('AU0005'),
  otpRequired('AU0006'),
  otpInvalid('AU0007'),
  useOldPassword('AC0014'),

  // REGISTER
  accountExists('RX0001'),
  usernameExists('RX0002'),

  // PERMISSIONS
  unverifiedUser('PD0001'),
  userAlreadyActive('PD0002'),

  // Does not have Broker account
  tradeAuthorization('PD0003'),

  // kyc not finished
  userIncompletedAuthorization('PD0004'),

  //  phone not validated
  unverifiedPhone('PD0005'),

  // email  not validated
  unverifiedEmail('PD0006'),
  invalidOtpType('PD0007'),
  bankRequired('PD0008'),

  // ERRORS
  invalidEmailFormat('ER0001'),
  invalidPhoneFormat('ER0002'),
  invalidPasswordValidation('ER0003'),
  invalidSubscription('ER0004'),
  invalidPayload('ER1111'),
  twilioError('ER3001'),

  // CELERY
  celeryError('CE0001'),
  celeryTimeout('CE0002'),
  balanceCheckErrorBot('CE0003'),
  balanceCheckTimeoutBot('CE0004'),
  balanceCheckErrorWithdrawal('CE0005'),
  balanceCheckTimeoutWithdrawal('CE0006'),

  // BOT
  botCreateBalanceCheckError('BT0001'),
  botCreateBalanceSufficient('BT0002'),
  botCreateOrderExists('BT0003'),
  botCreateError('BT0004'),
  botCancelError('BT0005'),
  botCancelInactiveBot('BT0006'),
  botCancelCannotCancelBot('BT0007'),
  botCancelWaitingPool('BT0008'),
  botCancelWaitingTermination('BT0009'),
  botCancelNotFound('BT0010'),
  botTerminateError('BT0011'),
  botTerminateInactiveBot('BT0012'),
  botTerminateCannotCancelOrder('BT0013'),
  botTerminateWaitingPool('BT0014'),
  botTerminateWaitingTermination('BT0015'),
  botTerminateNotFound('BT0016'),
  botSuggestionsNoBotId('BT0017'),
  botSuggestionsBotNotFound('BT0018'),
  botSuggestionsNoTickerName('BT0019'),
  botSuggestionsTickerNotFound('BT0020'),
  botTypeNotFound('BT0021'),

// # Transactions
  depositError('TX0001'),
  depositNoPersonalInfo('TX0002'),
  depositRemittanceRequired('TX0003'),
  depositRemittanceFileInvalid('TX0004'),
  depositRemittanceFileError('TX0005'),
  depositAmountInvalid('TX0006'),
  depositCannotRequestToLedger('TX0007'),
  withdrawalError('TX0008'),
  withdrawalNoBankAccount('TX0009'),
  withdrawalBalanceCheckError('TX0010'),
  withdrawalBalanceInsufficient('TX0011'),
  withdrawalAlreadyJournalled('TX0012'),
  withdrawalCannotRequestToLedger('TX0013'),

// # BANKS
  bankCodeError('BK0001'),
  relativeBankAccountExists('BK0002'),

// # ORDERS
  noActiveOrderExists('OD0001'),

// # BROKER
  brokerApiError('BRK0001'),

// # SUBSCRIPTIONS
  subscriptionNotFound('SB0001'),
  subscriptionFailed('SB0002'),

// # TICKER
  tickerUnavailable('TK0001'),

// # KYC
  kycApplicantNotFound('KY0001'),

// # UNKOWN
  unknownError('XX0000'),
  thirdPartyError('XX0001'),
  unknownFirmAccountError('XX0002'),
  unknownClearingAccountError('XX0003'),
  unknown('UNKNOWN');

  const ValidationCode(this.code);

  final String code;

  static ValidationCode getTypeByCode(String code) =>
      ValidationCode.values.firstWhere((errorCode) => errorCode.code == code,
          orElse: () => ValidationCode.unknown);
}
