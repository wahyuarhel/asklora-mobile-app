class FeatureFlags {
  static const bool isDemoEnable = false;
  static const bool byPassOtpOnSlack = true;
  static const bool enableSentry = true;
  static const bool byPassFreeBots = true;

  /// This flag is being used for hiding the new chat session in the AI screen.
  static const bool isNewChatHide = true;

  /// Currently only being used for Deposits.
  /// This flag is being used for setting the 100HKD is minimum deposits in the UAT.
  static const bool isProdTestEnabled = true;

  static const bool isMockApp = true;
  static const bool showAiDebugWidget = false;
}
