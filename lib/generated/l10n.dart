// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Agree`
  String get agree {
    return Intl.message(
      'Agree',
      name: 'agree',
      desc: '',
      args: [],
    );
  }

  /// `Get Help`
  String get getHelp {
    return Intl.message(
      'Get Help',
      name: 'getHelp',
      desc: '',
      args: [],
    );
  }

  /// `Customer Service`
  String get customerService {
    return Intl.message(
      'Customer Service',
      name: 'customerService',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `About Asklora`
  String get aboutAsklora {
    return Intl.message(
      'About Asklora',
      name: 'aboutAsklora',
      desc: '',
      args: [],
    );
  }

  /// `Website`
  String get website {
    return Intl.message(
      'Website',
      name: 'website',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message(
      'Contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Office Hours`
  String get officeHoursLabel {
    return Intl.message(
      'Office Hours',
      name: 'officeHoursLabel',
      desc: '',
      args: [],
    );
  }

  /// `09:00-18:00 (HKT)`
  String get officeHours {
    return Intl.message(
      '09:00-18:00 (HKT)',
      name: 'officeHours',
      desc: '',
      args: [],
    );
  }

  /// `Bot Duration`
  String get botDuration {
    return Intl.message(
      'Bot Duration',
      name: 'botDuration',
      desc: '',
      args: [],
    );
  }

  /// `Bot Management Fee`
  String get botManagementFee {
    return Intl.message(
      'Bot Management Fee',
      name: 'botManagementFee',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get buttonSignUp {
    return Intl.message(
      'Sign Up',
      name: 'buttonSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Already Have An Account?`
  String get buttonAlreadyHaveAnAccount {
    return Intl.message(
      'Already Have An Account?',
      name: 'buttonAlreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Resend Activation Link`
  String get buttonResendActivationLink {
    return Intl.message(
      'Resend Activation Link',
      name: 'buttonResendActivationLink',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up Again`
  String get buttonSignUpAgain {
    return Intl.message(
      'Sign Up Again',
      name: 'buttonSignUpAgain',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get buttonCancel {
    return Intl.message(
      'Cancel',
      name: 'buttonCancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get buttonConfirm {
    return Intl.message(
      'Confirm',
      name: 'buttonConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get buttonDone {
    return Intl.message(
      'Done',
      name: 'buttonDone',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get buttonNext {
    return Intl.message(
      'Next',
      name: 'buttonNext',
      desc: '',
      args: [],
    );
  }

  /// `Not Now`
  String get buttonNotNow {
    return Intl.message(
      'Not Now',
      name: 'buttonNotNow',
      desc: '',
      args: [],
    );
  }

  /// `Reload Page`
  String get buttonReloadPage {
    return Intl.message(
      'Reload Page',
      name: 'buttonReloadPage',
      desc: '',
      args: [],
    );
  }

  /// `Deposit`
  String get buttonDeposit {
    return Intl.message(
      'Deposit',
      name: 'buttonDeposit',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Trade`
  String get buttonCancelTrade {
    return Intl.message(
      'Cancel Trade',
      name: 'buttonCancelTrade',
      desc: '',
      args: [],
    );
  }

  /// `Have An Account?`
  String get buttonHaveAnAccount {
    return Intl.message(
      'Have An Account?',
      name: 'buttonHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Let's Begin`
  String get buttonLetsBegin {
    return Intl.message(
      'Let\'s Begin',
      name: 'buttonLetsBegin',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get buttonSignOut {
    return Intl.message(
      'Sign Out',
      name: 'buttonSignOut',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get buttonBack {
    return Intl.message(
      'Back',
      name: 'buttonBack',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get buttonContinue {
    return Intl.message(
      'Continue',
      name: 'buttonContinue',
      desc: '',
      args: [],
    );
  }

  /// `Maybe Later`
  String get buttonMaybeLater {
    return Intl.message(
      'Maybe Later',
      name: 'buttonMaybeLater',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw`
  String get buttonWithdraw {
    return Intl.message(
      'Withdraw',
      name: 'buttonWithdraw',
      desc: '',
      args: [],
    );
  }

  /// `Back To Portfolio`
  String get buttonBackToPortfolio {
    return Intl.message(
      'Back To Portfolio',
      name: 'buttonBackToPortfolio',
      desc: '',
      args: [],
    );
  }

  /// `Back To Home`
  String get buttonBackToHome {
    return Intl.message(
      'Back To Home',
      name: 'buttonBackToHome',
      desc: '',
      args: [],
    );
  }

  /// `Contact Customer Service`
  String get buttonContactCustomerService {
    return Intl.message(
      'Contact Customer Service',
      name: 'buttonContactCustomerService',
      desc: '',
      args: [],
    );
  }

  /// `Change Investment Style`
  String get buttonChangeInvestmentStyle {
    return Intl.message(
      'Change Investment Style',
      name: 'buttonChangeInvestmentStyle',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password?`
  String get buttonForgetPassword {
    return Intl.message(
      'Forget Password?',
      name: 'buttonForgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `View Transaction History`
  String get buttonViewTransactionHistory {
    return Intl.message(
      'View Transaction History',
      name: 'buttonViewTransactionHistory',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get buttonSave {
    return Intl.message(
      'Save',
      name: 'buttonSave',
      desc: '',
      args: [],
    );
  }

  /// `Current Price`
  String get currentPrice {
    return Intl.message(
      'Current Price',
      name: 'currentPrice',
      desc: '',
      args: [],
    );
  }

  /// `Deposit Amount`
  String get depositAmount {
    return Intl.message(
      'Deposit Amount',
      name: 'depositAmount',
      desc: '',
      args: [],
    );
  }

  /// `Deposit`
  String get deposit {
    return Intl.message(
      'Deposit',
      name: 'deposit',
      desc: '',
      args: [],
    );
  }

  /// `Due to regulatory requirements, you need to deposit at least HK${amount} if you want to change bank account`
  String depositRegulatoryRequirements(String amount) {
    return Intl.message(
      'Due to regulatory requirements, you need to deposit at least HK\$$amount if you want to change bank account',
      name: 'depositRegulatoryRequirements',
      desc: '',
      args: [amount],
    );
  }

  /// `Deposit Request Submitted`
  String get depositRequestSubmittedTitle {
    return Intl.message(
      'Deposit Request Submitted',
      name: 'depositRequestSubmittedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your account opening application and initial deposit will be reviewed within 1-2 working days. You will be informed via email and app notification once your account is approved.`
  String get depositRequestSubmittedSubTitleFirstTime {
    return Intl.message(
      'Your account opening application and initial deposit will be reviewed within 1-2 working days. You will be informed via email and app notification once your account is approved.',
      name: 'depositRequestSubmittedSubTitleFirstTime',
      desc: '',
      args: [],
    );
  }

  /// `Your deposit request is submitted. We'll let you know via email and app notification as soon as your deposit arrives.`
  String get depositRequestSubmittedSubTitleReturn {
    return Intl.message(
      'Your deposit request is submitted. We\'ll let you know via email and app notification as soon as your deposit arrives.',
      name: 'depositRequestSubmittedSubTitleReturn',
      desc: '',
      args: [],
    );
  }

  /// `We've sent an email to\n {emailAddress}\n\nPlease use your phone to click on the activation link!`
  String emailActivationSuccessTitle(String emailAddress) {
    return Intl.message(
      'We\'ve sent an email to\n $emailAddress\n\nPlease use your phone to click on the activation link!',
      name: 'emailActivationSuccessTitle',
      desc: '',
      args: [emailAddress],
    );
  }

  /// `Sorry! You were a bit late, your request has timed out. \n\nLet's try and activate your account again!`
  String get emailActivationFailedTitle {
    return Intl.message(
      'Sorry! You were a bit late, your request has timed out. \n\nLet\'s try and activate your account again!',
      name: 'emailActivationFailedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Est. Stop Loss Level`
  String get estStopLossLevel {
    return Intl.message(
      'Est. Stop Loss Level',
      name: 'estStopLossLevel',
      desc: '',
      args: [],
    );
  }

  /// `Est. Max Loss Level`
  String get estMaxLossLevel {
    return Intl.message(
      'Est. Max Loss Level',
      name: 'estMaxLossLevel',
      desc: '',
      args: [],
    );
  }

  /// `Est. Take Profit Level`
  String get estTakeProfitLevel {
    return Intl.message(
      'Est. Take Profit Level',
      name: 'estTakeProfitLevel',
      desc: '',
      args: [],
    );
  }

  /// `Est. Max Profit Level`
  String get estMaxProfitLevel {
    return Intl.message(
      'Est. Max Profit Level',
      name: 'estMaxProfitLevel',
      desc: '',
      args: [],
    );
  }

  /// `Est. Stop Loss %`
  String get estStopLossPercent {
    return Intl.message(
      'Est. Stop Loss %',
      name: 'estStopLossPercent',
      desc: '',
      args: [],
    );
  }

  /// `Est. Max Loss %`
  String get estMaxLossPercent {
    return Intl.message(
      'Est. Max Loss %',
      name: 'estMaxLossPercent',
      desc: '',
      args: [],
    );
  }

  /// `Est. Take Profit %`
  String get estTakeProfitPercent {
    return Intl.message(
      'Est. Take Profit %',
      name: 'estTakeProfitPercent',
      desc: '',
      args: [],
    );
  }

  /// `Est. Max Profit %`
  String get estMaxProfitPercent {
    return Intl.message(
      'Est. Max Profit %',
      name: 'estMaxProfitPercent',
      desc: '',
      args: [],
    );
  }

  /// `Estimated End Date`
  String get estimatedEndDate {
    return Intl.message(
      'Estimated End Date',
      name: 'estimatedEndDate',
      desc: '',
      args: [],
    );
  }

  /// `Employees`
  String get employees {
    return Intl.message(
      'Employees',
      name: 'employees',
      desc: '',
      args: [],
    );
  }

  /// `Expires at`
  String get expiresAt {
    return Intl.message(
      'Expires at',
      name: 'expiresAt',
      desc: '',
      args: [],
    );
  }

  /// `Starts at`
  String get startsAt {
    return Intl.message(
      'Starts at',
      name: 'startsAt',
      desc: '',
      args: [],
    );
  }

  /// `CEO`
  String get ceo {
    return Intl.message(
      'CEO',
      name: 'ceo',
      desc: '',
      args: [],
    );
  }

  /// `Founded`
  String get founded {
    return Intl.message(
      'Founded',
      name: 'founded',
      desc: '',
      args: [],
    );
  }

  /// `Got It`
  String get gotIt {
    return Intl.message(
      'Got It',
      name: 'gotIt',
      desc: '',
      args: [],
    );
  }

  /// `Headquarters`
  String get headquarters {
    return Intl.message(
      'Headquarters',
      name: 'headquarters',
      desc: '',
      args: [],
    );
  }

  /// `Account Settings`
  String get accountSettings {
    return Intl.message(
      'Account Settings',
      name: 'accountSettings',
      desc: '',
      args: [],
    );
  }

  /// `Core Plan`
  String get corePlan {
    return Intl.message(
      'Core Plan',
      name: 'corePlan',
      desc: '',
      args: [],
    );
  }

  /// `Free Trial`
  String get freeTrial {
    return Intl.message(
      'Free Trial',
      name: 'freeTrial',
      desc: '',
      args: [],
    );
  }

  /// `All Settings`
  String get allSettings {
    return Intl.message(
      'All Settings',
      name: 'allSettings',
      desc: '',
      args: [],
    );
  }

  /// `Investment Preferences`
  String get investmentPreferences {
    return Intl.message(
      'Investment Preferences',
      name: 'investmentPreferences',
      desc: '',
      args: [],
    );
  }

  /// `Transaction History`
  String get transactionHistory {
    return Intl.message(
      'Transaction History',
      name: 'transactionHistory',
      desc: '',
      args: [],
    );
  }

  /// `Account Information`
  String get accountInformation {
    return Intl.message(
      'Account Information',
      name: 'accountInformation',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Payment Details`
  String get paymentDetails {
    return Intl.message(
      'Payment Details',
      name: 'paymentDetails',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Notification Settings`
  String get notificationSettings {
    return Intl.message(
      'Notification Settings',
      name: 'notificationSettings',
      desc: '',
      args: [],
    );
  }

  /// `Terminate Account`
  String get terminateAccount {
    return Intl.message(
      'Terminate Account',
      name: 'terminateAccount',
      desc: '',
      args: [],
    );
  }

  /// `User ID`
  String get userId {
    return Intl.message(
      'User ID',
      name: 'userId',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Date Joined`
  String get dateJoined {
    return Intl.message(
      'Date Joined',
      name: 'dateJoined',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get free {
    return Intl.message(
      'Free',
      name: 'free',
      desc: '',
      args: [],
    );
  }

  /// `Botstock ID`
  String get botStockId {
    return Intl.message(
      'Botstock ID',
      name: 'botStockId',
      desc: '',
      args: [],
    );
  }

  /// `Investment Amount`
  String get investmentAmount {
    return Intl.message(
      'Investment Amount',
      name: 'investmentAmount',
      desc: '',
      args: [],
    );
  }

  /// `It’s time to define your investment style.Show me what you’re made of!`
  String get investmentStyleWelcomeTitle {
    return Intl.message(
      'It’s time to define your investment style.Show me what you’re made of!',
      name: 'investmentStyleWelcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Trade Fee`
  String get tradeFee {
    return Intl.message(
      'Trade Fee',
      name: 'tradeFee',
      desc: '',
      args: [],
    );
  }

  /// `Ended Amount`
  String get endedAmount {
    return Intl.message(
      'Ended Amount',
      name: 'endedAmount',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get summary {
    return Intl.message(
      'Summary',
      name: 'summary',
      desc: '',
      args: [],
    );
  }

  /// `Activities`
  String get activities {
    return Intl.message(
      'Activities',
      name: 'activities',
      desc: '',
      args: [],
    );
  }

  /// `Filled Price`
  String get filledPrice {
    return Intl.message(
      'Filled Price',
      name: 'filledPrice',
      desc: '',
      args: [],
    );
  }

  /// `Shares`
  String get shares {
    return Intl.message(
      'Shares',
      name: 'shares',
      desc: '',
      args: [],
    );
  }

  /// `Order Cancelled`
  String get orderCancelled {
    return Intl.message(
      'Order Cancelled',
      name: 'orderCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Order Rejected`
  String get orderRejected {
    return Intl.message(
      'Order Rejected',
      name: 'orderRejected',
      desc: '',
      args: [],
    );
  }

  /// `Order Placed`
  String get orderPlaced {
    return Intl.message(
      'Order Placed',
      name: 'orderPlaced',
      desc: '',
      args: [],
    );
  }

  /// `Order Started`
  String get orderStarted {
    return Intl.message(
      'Order Started',
      name: 'orderStarted',
      desc: '',
      args: [],
    );
  }

  /// `Order Rollover`
  String get orderRollover {
    return Intl.message(
      'Order Rollover',
      name: 'orderRollover',
      desc: '',
      args: [],
    );
  }

  /// `Order Expired`
  String get orderExpired {
    return Intl.message(
      'Order Expired',
      name: 'orderExpired',
      desc: '',
      args: [],
    );
  }

  /// `Retake Investment Style`
  String get retakeInvestmentStyle {
    return Intl.message(
      'Retake Investment Style',
      name: 'retakeInvestmentStyle',
      desc: '',
      args: [],
    );
  }

  /// `Unable to get information`
  String get errorGettingInformationTitle {
    return Intl.message(
      'Unable to get information',
      name: 'errorGettingInformationTitle',
      desc: '',
      args: [],
    );
  }

  /// `There was an error when trying to get your Portfolio. Please try reloading the page`
  String get errorGettingInformationPortfolioSubTitle {
    return Intl.message(
      'There was an error when trying to get your Portfolio. Please try reloading the page',
      name: 'errorGettingInformationPortfolioSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `There was an error when trying to get the investment details. Please try reloading the page`
  String get errorGettingInformationInvestmentDetailSubTitle {
    return Intl.message(
      'There was an error when trying to get the investment details. Please try reloading the page',
      name: 'errorGettingInformationInvestmentDetailSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `There was an error when trying to get the investment style question. Please try reloading the page`
  String get errorGettingInformationInvestmentStyleQuestionSubTitle {
    return Intl.message(
      'There was an error when trying to get the investment style question. Please try reloading the page',
      name: 'errorGettingInformationInvestmentStyleQuestionSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `There was an error when trying to get the transaction history. Please try reloading the page`
  String get errorGettingInformationTransactionHistorySubTitle {
    return Intl.message(
      'There was an error when trying to get the transaction history. Please try reloading the page',
      name: 'errorGettingInformationTransactionHistorySubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal Unavailable`
  String get errorWithdrawalUnavailableTitle {
    return Intl.message(
      'Withdrawal Unavailable',
      name: 'errorWithdrawalUnavailableTitle',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any funds to withdraw. You haven't deposited yet or your deposit might still be processing `
  String get errorWithdrawalUnavailableSubTitle {
    return Intl.message(
      'You don\'t have any funds to withdraw. You haven\'t deposited yet or your deposit might still be processing ',
      name: 'errorWithdrawalUnavailableSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Get your Investments in Shape`
  String get carouselIntro1 {
    return Intl.message(
      'Get your Investments in Shape',
      name: 'carouselIntro1',
      desc: '',
      args: [],
    );
  }

  /// `Guided by FinFit Coach, Lora`
  String get carouselIntro2 {
    return Intl.message(
      'Guided by FinFit Coach, Lora',
      name: 'carouselIntro2',
      desc: '',
      args: [],
    );
  }

  /// `Invest with AI strategy, automated`
  String get carouselIntro3 {
    return Intl.message(
      'Invest with AI strategy, automated',
      name: 'carouselIntro3',
      desc: '',
      args: [],
    );
  }

  /// `Personalised experience`
  String get carouselIntro4 {
    return Intl.message(
      'Personalised experience',
      name: 'carouselIntro4',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `I'm Lora, your personal AI assistant.\n\nGet ready to crush your investment goals!\nWhat's your name? `
  String get askNameScreenPlaceholder {
    return Intl.message(
      'I\'m Lora, your personal AI assistant.\n\nGet ready to crush your investment goals!\nWhat\'s your name? ',
      name: 'askNameScreenPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Your Name`
  String get askNameScreenTextFieldHint {
    return Intl.message(
      'Your Name',
      name: 'askNameScreenTextFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Bank Account Number`
  String get bankAccountNumber {
    return Intl.message(
      'Bank Account Number',
      name: 'bankAccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Best Suited For`
  String get bestSuitedFor {
    return Intl.message(
      'Best Suited For',
      name: 'bestSuitedFor',
      desc: '',
      args: [],
    );
  }

  /// `Ready to start your AI revolution?`
  String get greetingScreenTitle {
    return Intl.message(
      'Ready to start your AI revolution?',
      name: 'greetingScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Let's start the training with simple questions!\n\n  Remember - to lose patience is to lose the battle!`
  String get greetingScreenSubTitle {
    return Intl.message(
      'Let\'s start the training with simple questions!\n\n  Remember - to lose patience is to lose the battle!',
      name: 'greetingScreenSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Lora's date to start the Botstocks`
  String get tooltipBotDetailsStartDate {
    return Intl.message(
      'Lora\'s date to start the Botstocks',
      name: 'tooltipBotDetailsStartDate',
      desc: '',
      args: [],
    );
  }

  /// `The duration you set for Botstock where the Bot will automatically buy and sell.`
  String get tooltipBotDetailsInvestmentPeriod {
    return Intl.message(
      'The duration you set for Botstock where the Bot will automatically buy and sell.',
      name: 'tooltipBotDetailsInvestmentPeriod',
      desc: '',
      args: [],
    );
  }

  /// `This is the estimated maximum target profit % level for the Bot strategy. The Bot will try to close the trade (sell stocks) and capture profits when profits reach this % level. This is an estimated level.`
  String get tooltipBotDetailsEstMaxProfit {
    return Intl.message(
      'This is the estimated maximum target profit % level for the Bot strategy. The Bot will try to close the trade (sell stocks) and capture profits when profits reach this % level. This is an estimated level.',
      name: 'tooltipBotDetailsEstMaxProfit',
      desc: '',
      args: [],
    );
  }

  /// `This is the estimated maximum loss % level for the Bot strategy. The Bot will try to limit losses to this % level. This is an estimated level.`
  String get tooltipBotDetailsEstMaxLoss {
    return Intl.message(
      'This is the estimated maximum loss % level for the Bot strategy. The Bot will try to limit losses to this % level. This is an estimated level.',
      name: 'tooltipBotDetailsEstMaxLoss',
      desc: '',
      args: [],
    );
  }

  /// `The return % where the Plank Bot will sell to try and capture profits. The Plank Bot will try to close the trade (sell stocks) when the stock reaches this level above your initial investment level.`
  String get tooltipBotDetailsEstTakeProfit {
    return Intl.message(
      'The return % where the Plank Bot will sell to try and capture profits. The Plank Bot will try to close the trade (sell stocks) when the stock reaches this level above your initial investment level.',
      name: 'tooltipBotDetailsEstTakeProfit',
      desc: '',
      args: [],
    );
  }

  /// `The return % where the Plank Bot will sell try and limit losses. The Plank Bot will try to close the trade (sell stocks) when the stock reaches this level below your initial investment level.`
  String get tooltipBotDetailsEstStopLoss {
    return Intl.message(
      'The return % where the Plank Bot will sell try and limit losses. The Plank Bot will try to close the trade (sell stocks) when the stock reaches this level below your initial investment level.',
      name: 'tooltipBotDetailsEstStopLoss',
      desc: '',
      args: [],
    );
  }

  /// `You have {availableAmount}, the minimum investment amount is {minimumAmount}.`
  String botTradeBottomSheetAmountMinimum(
      String availableAmount, String minimumAmount) {
    return Intl.message(
      'You have $availableAmount, the minimum investment amount is $minimumAmount.',
      name: 'botTradeBottomSheetAmountMinimum',
      desc: '',
      args: [availableAmount, minimumAmount],
    );
  }

  /// `How much are you investing?`
  String get botTradeBottomSheetAmountTitle {
    return Intl.message(
      'How much are you investing?',
      name: 'botTradeBottomSheetAmountTitle',
      desc: '',
      args: [],
    );
  }

  /// `You are running out of money! Fund your account now.`
  String get botTradeBottomSheetInsufficientBalanceTitle {
    return Intl.message(
      'You are running out of money! Fund your account now.',
      name: 'botTradeBottomSheetInsufficientBalanceTitle',
      desc: '',
      args: [],
    );
  }

  /// `The minimum investment amount is {minimumAmount} per trade.`
  String botTradeBottomSheetInsufficientBalanceSubTitle(String minimumAmount) {
    return Intl.message(
      'The minimum investment amount is $minimumAmount per trade.',
      name: 'botTradeBottomSheetInsufficientBalanceSubTitle',
      desc: '',
      args: [minimumAmount],
    );
  }

  /// `You can trade after your account is approved.`
  String get botTradeBottomSheetAccountNotYetApprovedTitle {
    return Intl.message(
      'You can trade after your account is approved.',
      name: 'botTradeBottomSheetAccountNotYetApprovedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Est. to be approved by 2 working days.`
  String get botTradeBottomSheetAccountNotYetApprovedSubTitle {
    return Intl.message(
      'Est. to be approved by 2 working days.',
      name: 'botTradeBottomSheetAccountNotYetApprovedSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `If you extend the Botstock period, you will incur additional fees`
  String get botTradeBottomSheetRolloverDisclosureTitle {
    return Intl.message(
      'If you extend the Botstock period, you will incur additional fees',
      name: 'botTradeBottomSheetRolloverDisclosureTitle',
      desc: '',
      args: [],
    );
  }

  /// `You will be charged HKD40 if you want to extend this Botstock. If you do not have enough funds, then your fees will be deducted when you have sufficient buying power`
  String get botTradeBottomSheetRolloverDisclosureSubTitle {
    return Intl.message(
      'You will be charged HKD40 if you want to extend this Botstock. If you do not have enough funds, then your fees will be deducted when you have sufficient buying power',
      name: 'botTradeBottomSheetRolloverDisclosureSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your Botstock will be extended for \n\n2 Weeks`
  String get botTradeBottomSheetRolloverConfirmationTitle {
    return Intl.message(
      'Your Botstock will be extended for \n\n2 Weeks',
      name: 'botTradeBottomSheetRolloverConfirmationTitle',
      desc: '',
      args: [],
    );
  }

  /// `The new expiry date is {expiryTime}`
  String botTradeBottomSheetRolloverConfirmationSubTitle(String expiryTime) {
    return Intl.message(
      'The new expiry date is $expiryTime',
      name: 'botTradeBottomSheetRolloverConfirmationSubTitle',
      desc: '',
      args: [expiryTime],
    );
  }

  /// `You can end the Botstock now, and all stocks will be sold. Trading of {botInformation} will stop.`
  String botTradeBottomSheetEndBotStockConfirmationTitle(
      String botInformation) {
    return Intl.message(
      'You can end the Botstock now, and all stocks will be sold. Trading of $botInformation will stop.',
      name: 'botTradeBottomSheetEndBotStockConfirmationTitle',
      desc: '',
      args: [botInformation],
    );
  }

  /// `The total Botstock value will be returned to your \naccount after the next community order.`
  String get botTradeBottomSheetEndBotStockConfirmationSubTitle {
    return Intl.message(
      'The total Botstock value will be returned to your \naccount after the next community order.',
      name: 'botTradeBottomSheetEndBotStockConfirmationSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your free Botstock has been added to your portfolio!`
  String get botTradeBottomSheetFreeBotStockSuccessfullyAddedTitle {
    return Intl.message(
      'Your free Botstock has been added to your portfolio!',
      name: 'botTradeBottomSheetFreeBotStockSuccessfullyAddedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Deposit To Start Trading`
  String get botTradeBottomSheetFreeBotStockSuccessfullyAddedSubTitle {
    return Intl.message(
      'Deposit To Start Trading',
      name: 'botTradeBottomSheetFreeBotStockSuccessfullyAddedSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `The investment amount and Bot management fee (HKD{amount}) will be returned to your account.`
  String botTradeBottomSheetCancelBotStockConfirmationTitle(String amount) {
    return Intl.message(
      'The investment amount and Bot management fee (HKD$amount) will be returned to your account.',
      name: 'botTradeBottomSheetCancelBotStockConfirmationTitle',
      desc: '',
      args: [amount],
    );
  }

  /// `Confirm Rollover`
  String get botTradeBottomSheetRolloverConfirmationButton {
    return Intl.message(
      'Confirm Rollover',
      name: 'botTradeBottomSheetRolloverConfirmationButton',
      desc: '',
      args: [],
    );
  }

  /// `How It Works`
  String get howItWorks {
    return Intl.message(
      'How It Works',
      name: 'howItWorks',
      desc: '',
      args: [],
    );
  }

  /// `Market Cap`
  String get marketCap {
    return Intl.message(
      'Market Cap',
      name: 'marketCap',
      desc: '',
      args: [],
    );
  }

  /// `Prev Close`
  String get prevClose {
    return Intl.message(
      'Prev Close',
      name: 'prevClose',
      desc: '',
      args: [],
    );
  }

  /// `Your Buying Power represents the amount of cash that you can use to buy Botstocks. Your Withdrawable Balance and your Buying Power may not always be the same. For example, starting a Botstock will reduce your Buying Power and the amount value will be added to Total Botstock Values. When the Botstock is expired or terminated, the amount will be added to Buying Power and after T + 2, the amount will be also added to Withdrawable Balance. This is called ‘settlement'.`
  String get portfolioBuyingPowerToolTip {
    return Intl.message(
      'Your Buying Power represents the amount of cash that you can use to buy Botstocks. Your Withdrawable Balance and your Buying Power may not always be the same. For example, starting a Botstock will reduce your Buying Power and the amount value will be added to Total Botstock Values. When the Botstock is expired or terminated, the amount will be added to Buying Power and after T + 2, the amount will be also added to Withdrawable Balance. This is called ‘settlement\'.',
      name: 'portfolioBuyingPowerToolTip',
      desc: '',
      args: [],
    );
  }

  /// `Performance`
  String get portfolioDetailPerformanceTitle {
    return Intl.message(
      'Performance',
      name: 'portfolioDetailPerformanceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Botstock Values (HKD)`
  String get portfolioDetailPerformanceBotStockValues {
    return Intl.message(
      'Botstock Values (HKD)',
      name: 'portfolioDetailPerformanceBotStockValues',
      desc: '',
      args: [],
    );
  }

  /// `Inv. Amount (HKD)`
  String get portfolioDetailPerformanceInvestmentAmount {
    return Intl.message(
      'Inv. Amount (HKD)',
      name: 'portfolioDetailPerformanceInvestmentAmount',
      desc: '',
      args: [],
    );
  }

  /// `Total P&L`
  String get portfolioDetailPerformanceTotalPL {
    return Intl.message(
      'Total P&L',
      name: 'portfolioDetailPerformanceTotalPL',
      desc: '',
      args: [],
    );
  }

  /// `Current Price`
  String get portfolioCurrentPrice {
    return Intl.message(
      'Current Price',
      name: 'portfolioCurrentPrice',
      desc: '',
      args: [],
    );
  }

  /// `Expired at {dateTime}`
  String portfolioDetailExpiredAt(String dateTime) {
    return Intl.message(
      'Expired at $dateTime',
      name: 'portfolioDetailExpiredAt',
      desc: '',
      args: [dateTime],
    );
  }

  /// `Expired in {dateTime} days`
  String portfolioDetailExpiredIn(String dateTime) {
    return Intl.message(
      'Expired in $dateTime days',
      name: 'portfolioDetailExpiredIn',
      desc: '',
      args: [dateTime],
    );
  }

  /// `No. of Shares`
  String get portfolioDetailPerformanceNumberOfShares {
    return Intl.message(
      'No. of Shares',
      name: 'portfolioDetailPerformanceNumberOfShares',
      desc: '',
      args: [],
    );
  }

  /// `Stock Values (HKD)`
  String get portfolioDetailPerformanceStockValues {
    return Intl.message(
      'Stock Values (HKD)',
      name: 'portfolioDetailPerformanceStockValues',
      desc: '',
      args: [],
    );
  }

  /// `Cash (HKD)`
  String get portfolioDetailPerformanceCash {
    return Intl.message(
      'Cash (HKD)',
      name: 'portfolioDetailPerformanceCash',
      desc: '',
      args: [],
    );
  }

  /// `Stock Holding %`
  String get portfolioDetailPerformanceBotAssetsInStock {
    return Intl.message(
      'Stock Holding %',
      name: 'portfolioDetailPerformanceBotAssetsInStock',
      desc: '',
      args: [],
    );
  }

  /// `Indicates how many shares of a company are currently owned by you.`
  String get portfolioDetailPerformanceNumberOfSharesTooltip {
    return Intl.message(
      'Indicates how many shares of a company are currently owned by you.',
      name: 'portfolioDetailPerformanceNumberOfSharesTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Key Info`
  String get portfolioDetailKeyInfoTitle {
    return Intl.message(
      'Key Info',
      name: 'portfolioDetailKeyInfoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Days Till Expiry`
  String get portfolioDetailKeyInfoDaysTillExpiry {
    return Intl.message(
      'Days Till Expiry',
      name: 'portfolioDetailKeyInfoDaysTillExpiry',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get portfolioDetailKeyInfoStartTime {
    return Intl.message(
      'Start Time',
      name: 'portfolioDetailKeyInfoStartTime',
      desc: '',
      args: [],
    );
  }

  /// `End Time`
  String get portfolioDetailKeyInfoEndTime {
    return Intl.message(
      'End Time',
      name: 'portfolioDetailKeyInfoEndTime',
      desc: '',
      args: [],
    );
  }

  /// `Est. Stop Loss %`
  String get portfolioDetailKeyInfoEstimatedStopLoss {
    return Intl.message(
      'Est. Stop Loss %',
      name: 'portfolioDetailKeyInfoEstimatedStopLoss',
      desc: '',
      args: [],
    );
  }

  /// `Est. Take Profit %`
  String get portfolioDetailKeyInfoEstimatedTakeProfit {
    return Intl.message(
      'Est. Take Profit %',
      name: 'portfolioDetailKeyInfoEstimatedTakeProfit',
      desc: '',
      args: [],
    );
  }

  /// `Est. Max Loss %`
  String get portfolioDetailKeyInfoEstimatedMaxLoss {
    return Intl.message(
      'Est. Max Loss %',
      name: 'portfolioDetailKeyInfoEstimatedMaxLoss',
      desc: '',
      args: [],
    );
  }

  /// `Est, Max Profit %`
  String get portfolioDetailKeyInfoEstimatedMaxProfit {
    return Intl.message(
      'Est, Max Profit %',
      name: 'portfolioDetailKeyInfoEstimatedMaxProfit',
      desc: '',
      args: [],
    );
  }

  /// `Botstock Status`
  String get portfolioDetailKeyInfoBotStockStatus {
    return Intl.message(
      'Botstock Status',
      name: 'portfolioDetailKeyInfoBotStockStatus',
      desc: '',
      args: [],
    );
  }

  /// `Number of Rollovers`
  String get portfolioDetailKeyInfoBotStockNumberOfRollover {
    return Intl.message(
      'Number of Rollovers',
      name: 'portfolioDetailKeyInfoBotStockNumberOfRollover',
      desc: '',
      args: [],
    );
  }

  /// `Avg. Return`
  String get portfolioDetailKeyInfoAvgReturn {
    return Intl.message(
      'Avg. Return',
      name: 'portfolioDetailKeyInfoAvgReturn',
      desc: '',
      args: [],
    );
  }

  /// `Avg. Loss`
  String get portfolioDetailKeyInfoAvgLoss {
    return Intl.message(
      'Avg. Loss',
      name: 'portfolioDetailKeyInfoAvgLoss',
      desc: '',
      args: [],
    );
  }

  /// `Avg. Period (Days)`
  String get portfolioDetailKeyInfoAvgPeriod {
    return Intl.message(
      'Avg. Period (Days)',
      name: 'portfolioDetailKeyInfoAvgPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Botstock`
  String get portfolioDetailButtonCancelBotStock {
    return Intl.message(
      'Cancel Botstock',
      name: 'portfolioDetailButtonCancelBotStock',
      desc: '',
      args: [],
    );
  }

  /// `End Botstock`
  String get portfolioDetailButtonEndBotStock {
    return Intl.message(
      'End Botstock',
      name: 'portfolioDetailButtonEndBotStock',
      desc: '',
      args: [],
    );
  }

  /// `Rollover Botstock`
  String get portfolioDetailButtonRolloverBotStock {
    return Intl.message(
      'Rollover Botstock',
      name: 'portfolioDetailButtonRolloverBotStock',
      desc: '',
      args: [],
    );
  }

  /// `Performance data will be available once the Botstock starts`
  String get portfolioDetailChartEmptyMessage {
    return Intl.message(
      'Performance data will be available once the Botstock starts',
      name: 'portfolioDetailChartEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Past {duration} performance of {bot}  ({startDate} - {endDate})`
  String portfolioDetailChartCaption(
      String bot, String startDate, String endDate, String duration) {
    return Intl.message(
      'Past $duration performance of $bot  ($startDate - $endDate)',
      name: 'portfolioDetailChartCaption',
      desc: '',
      args: [bot, startDate, endDate, duration],
    );
  }

  /// `Total Portfolio Value`
  String get portfolioTotalValue {
    return Intl.message(
      'Total Portfolio Value',
      name: 'portfolioTotalValue',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawable Balance ({currency})`
  String portfolioWithdrawableAmount(String currency) {
    return Intl.message(
      'Withdrawable Balance ($currency)',
      name: 'portfolioWithdrawableAmount',
      desc: '',
      args: [currency],
    );
  }

  /// `Buying Power ({currency})`
  String portfolioBuyingPower(String currency) {
    return Intl.message(
      'Buying Power ($currency)',
      name: 'portfolioBuyingPower',
      desc: '',
      args: [currency],
    );
  }

  /// `Total Botstock Values ({currency})`
  String portfolioTotalBotStock(String currency) {
    return Intl.message(
      'Total Botstock Values ($currency)',
      name: 'portfolioTotalBotStock',
      desc: '',
      args: [currency],
    );
  }

  /// `Create An Account`
  String get createAnAccount {
    return Intl.message(
      'Create An Account',
      name: 'createAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Back to account settings`
  String get backToAccountSettings {
    return Intl.message(
      'Back to account settings',
      name: 'backToAccountSettings',
      desc: '',
      args: [],
    );
  }

  /// `Existing Password`
  String get existingPassword {
    return Intl.message(
      'Existing Password',
      name: 'existingPassword',
      desc: '',
      args: [],
    );
  }

  /// `Your password does not match.`
  String get passwordDoesNotMatch {
    return Intl.message(
      'Your password does not match.',
      name: 'passwordDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password Change Success`
  String get passwordChangeSuccess {
    return Intl.message(
      'Password Change Success',
      name: 'passwordChangeSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been changed`
  String get yourPasswordHasBeenChanged {
    return Intl.message(
      'Your password has been changed',
      name: 'yourPasswordHasBeenChanged',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid password`
  String get enterValidPassword {
    return Intl.message(
      'Enter valid password',
      name: 'enterValidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Your new password cannot be the same as your old password`
  String get oldPasswordSameWithNewPasswordError {
    return Intl.message(
      'Your new password cannot be the same as your old password',
      name: 'oldPasswordSameWithNewPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Create an Account and Start Trading!`
  String get portfolioPopUpCreateAnAccountTitle {
    return Intl.message(
      'Create an Account and Start Trading!',
      name: 'portfolioPopUpCreateAnAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `You can manage all your investments here after you start trading. Create an account and start trading.`
  String get portfolioPopUpCreateAnAccountSubTitle {
    return Intl.message(
      'You can manage all your investments here after you start trading. Create an account and start trading.',
      name: 'portfolioPopUpCreateAnAccountSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Define Investment Style`
  String get defineInvestmentStyle {
    return Intl.message(
      'Define Investment Style',
      name: 'defineInvestmentStyle',
      desc: '',
      args: [],
    );
  }

  /// `Define Your Investment Style`
  String get portfolioPopUpDefineInvestmentTitle {
    return Intl.message(
      'Define Your Investment Style',
      name: 'portfolioPopUpDefineInvestmentTitle',
      desc: '',
      args: [],
    );
  }

  /// `Looks like you haven't defined your Investment Style yet. Let's go and see what kind of Botstocks suit you best!`
  String get portfolioPopUpDefineInvestmentSubTitle {
    return Intl.message(
      'Looks like you haven\'t defined your Investment Style yet. Let\'s go and see what kind of Botstocks suit you best!',
      name: 'portfolioPopUpDefineInvestmentSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Continue Account Opening`
  String get continueAccountOpening {
    return Intl.message(
      'Continue Account Opening',
      name: 'continueAccountOpening',
      desc: '',
      args: [],
    );
  }

  /// `Continue Account Opening`
  String get portfolioPopUpContinueAccountOpeningTitle {
    return Intl.message(
      'Continue Account Opening',
      name: 'portfolioPopUpContinueAccountOpeningTitle',
      desc: '',
      args: [],
    );
  }

  /// `You still need to complete your account opening until you can start trading. `
  String get portfolioPopUpContinueAccountOpeningSubTitle {
    return Intl.message(
      'You still need to complete your account opening until you can start trading. ',
      name: 'portfolioPopUpContinueAccountOpeningSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `OK!`
  String get ok {
    return Intl.message(
      'OK!',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Fund your account`
  String get portfolioPopUpFundAccountTitle {
    return Intl.message(
      'Fund your account',
      name: 'portfolioPopUpFundAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `Looks like you haven't funded your account yet. Deposit HKD 10,000 to activate your account.`
  String get portfolioPopUpFundAccountSubTitle {
    return Intl.message(
      'Looks like you haven\'t funded your account yet. Deposit HKD 10,000 to activate your account.',
      name: 'portfolioPopUpFundAccountSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Start A Botstock`
  String get startABotstock {
    return Intl.message(
      'Start A Botstock',
      name: 'startABotstock',
      desc: '',
      args: [],
    );
  }

  /// `No trading has started!`
  String get portfolioPopUpNoTradingHasStartedTitle {
    return Intl.message(
      'No trading has started!',
      name: 'portfolioPopUpNoTradingHasStartedTitle',
      desc: '',
      args: [],
    );
  }

  /// `You can manage all your investments here after you start trading. `
  String get portfolioPopUpNoTradingHasStartedtSubTitle {
    return Intl.message(
      'You can manage all your investments here after you start trading. ',
      name: 'portfolioPopUpNoTradingHasStartedtSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your Account is Pending Review`
  String get portfolioPopUpPendingReviewTitle {
    return Intl.message(
      'Your Account is Pending Review',
      name: 'portfolioPopUpPendingReviewTitle',
      desc: '',
      args: [],
    );
  }

  /// `You can manage all your investments here after your account has been opened!`
  String get portfolioPopUpPendingReviewSubTitle {
    return Intl.message(
      'You can manage all your investments here after your account has been opened!',
      name: 'portfolioPopUpPendingReviewSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Redeem Your Botstock Now`
  String get redeemYourBotstockNow {
    return Intl.message(
      'Redeem Your Botstock Now',
      name: 'redeemYourBotstockNow',
      desc: '',
      args: [],
    );
  }

  /// `Redeem Your Free Botstock`
  String get portfolioPopUpRedeemYourBotstockTitle {
    return Intl.message(
      'Redeem Your Free Botstock',
      name: 'portfolioPopUpRedeemYourBotstockTitle',
      desc: '',
      args: [],
    );
  }

  /// `Looks like you haven't claimed your free Botstock yet. Let's get trading right away!`
  String get portfolioPopUpRedeemYourBotstockSubTitle {
    return Intl.message(
      'Looks like you haven\'t claimed your free Botstock yet. Let\'s get trading right away!',
      name: 'portfolioPopUpRedeemYourBotstockSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Total P/L`
  String get portfolioTotalPL {
    return Intl.message(
      'Total P/L',
      name: 'portfolioTotalPL',
      desc: '',
      args: [],
    );
  }

  /// `Your Botstocks`
  String get portfolioYourBotStock {
    return Intl.message(
      'Your Botstocks',
      name: 'portfolioYourBotStock',
      desc: '',
      args: [],
    );
  }

  /// `Transaction History`
  String get transactionHistoryTitle {
    return Intl.message(
      'Transaction History',
      name: 'transactionHistoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get transactionHistoryTabAll {
    return Intl.message(
      'All',
      name: 'transactionHistoryTabAll',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get transactionHistoryTabOrders {
    return Intl.message(
      'Orders',
      name: 'transactionHistoryTabOrders',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get transactionHistoryTabTransfer {
    return Intl.message(
      'Transfer',
      name: 'transactionHistoryTabTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get transactionHistoryToday {
    return Intl.message(
      'Today',
      name: 'transactionHistoryToday',
      desc: '',
      args: [],
    );
  }

  /// `Total P/L is`
  String get totalPnlIs {
    return Intl.message(
      'Total P/L is',
      name: 'totalPnlIs',
      desc: '',
      args: [],
    );
  }

  /// `Notification Setting`
  String get notificationSetting {
    return Intl.message(
      'Notification Setting',
      name: 'notificationSetting',
      desc: '',
      args: [],
    );
  }

  /// `In-App`
  String get inApp {
    return Intl.message(
      'In-App',
      name: 'inApp',
      desc: '',
      args: [],
    );
  }

  /// `Industry`
  String get industry {
    return Intl.message(
      'Industry',
      name: 'industry',
      desc: '',
      args: [],
    );
  }

  /// `Investment Period`
  String get investmentPeriod {
    return Intl.message(
      'Investment Period',
      name: 'investmentPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Push-Notification`
  String get pushNotification {
    return Intl.message(
      'Push-Notification',
      name: 'pushNotification',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sector(s)`
  String get sectors {
    return Intl.message(
      'Sector(s)',
      name: 'sectors',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to sign out ?`
  String get signOutConfirmation {
    return Intl.message(
      'Are you sure you want to sign out ?',
      name: 'signOutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get startDate {
    return Intl.message(
      'Start Date',
      name: 'startDate',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Trade`
  String get trade {
    return Intl.message(
      'Trade',
      name: 'trade',
      desc: '',
      args: [],
    );
  }

  /// `Set Up Financial Profile`
  String get setUpFinancialProfile {
    return Intl.message(
      'Set Up Financial Profile',
      name: 'setUpFinancialProfile',
      desc: '',
      args: [],
    );
  }

  /// `Do any of the following apply to you or a member of your immediate family ?`
  String get doAnyOfTheFollowingApply {
    return Intl.message(
      'Do any of the following apply to you or a member of your immediate family ?',
      name: 'doAnyOfTheFollowingApply',
      desc: '',
      args: [],
    );
  }

  /// `I am a senior executive at or a 10% or greater shareholder of a publicly traded company.`
  String get iAmASeniorExecutive {
    return Intl.message(
      'I am a senior executive at or a 10% or greater shareholder of a publicly traded company.',
      name: 'iAmASeniorExecutive',
      desc: '',
      args: [],
    );
  }

  /// `I am a senior political figure.`
  String get iAmASeniorPolitical {
    return Intl.message(
      'I am a senior political figure.',
      name: 'iAmASeniorPolitical',
      desc: '',
      args: [],
    );
  }

  /// `I am a family member or relative of a senior political figure.`
  String get iAmAFamily {
    return Intl.message(
      'I am a family member or relative of a senior political figure.',
      name: 'iAmAFamily',
      desc: '',
      args: [],
    );
  }

  /// `I am a director/employee/licensed person of a licensed corporation registered with the HK Securities and Futures Commission. (Excluding Lora Advisors Limited)`
  String get iAmADirector {
    return Intl.message(
      'I am a director/employee/licensed person of a licensed corporation registered with the HK Securities and Futures Commission. (Excluding Lora Advisors Limited)',
      name: 'iAmADirector',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// ` No`
  String get no {
    return Intl.message(
      ' No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Save For Later`
  String get saveForLater {
    return Intl.message(
      'Save For Later',
      name: 'saveForLater',
      desc: '',
      args: [],
    );
  }

  /// `Confirm And Continue`
  String get confirmAndContinue {
    return Intl.message(
      'Confirm And Continue',
      name: 'confirmAndContinue',
      desc: '',
      args: [],
    );
  }

  /// `Your Bank Account`
  String get yourBankAccount {
    return Intl.message(
      'Your Bank Account',
      name: 'yourBankAccount',
      desc: '',
      args: [],
    );
  }

  /// `Your Bank Account is under review and will be complete by {dateTime}`
  String yourBankAccountIsUnderReview(String dateTime) {
    return Intl.message(
      'Your Bank Account is under review and will be complete by $dateTime',
      name: 'yourBankAccountIsUnderReview',
      desc: '',
      args: [dateTime],
    );
  }

  /// `Change Bank Account`
  String get changeBankAccount {
    return Intl.message(
      'Change Bank Account',
      name: 'changeBankAccount',
      desc: '',
      args: [],
    );
  }

  /// `Note:\nWe will work with your bank in order to idenfity your bank account details (account name, bank code, account number). However, we may require additional details from you for transaction verification purposes.`
  String get noteOnPaymentDetails {
    return Intl.message(
      'Note:\nWe will work with your bank in order to idenfity your bank account details (account name, bank code, account number). However, we may require additional details from you for transaction verification purposes.',
      name: 'noteOnPaymentDetails',
      desc: '',
      args: [],
    );
  }

  /// `Your payment information is under review. Your bank account details will be shown here once your account is approved. please note it can take up to 2 working days for the approval process.`
  String get yourPaymentInformationIsUnderReview {
    return Intl.message(
      'Your payment information is under review. Your bank account details will be shown here once your account is approved. please note it can take up to 2 working days for the approval process.',
      name: 'yourPaymentInformationIsUnderReview',
      desc: '',
      args: [],
    );
  }

  /// `Need help?`
  String get needHelp {
    return Intl.message(
      'Need help?',
      name: 'needHelp',
      desc: '',
      args: [],
    );
  }

  /// `No Transactions`
  String get noTransactions {
    return Intl.message(
      'No Transactions',
      name: 'noTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Looks like you haven’t made \nany transactions yet!`
  String get noTransactionsYet {
    return Intl.message(
      'Looks like you haven’t made \nany transactions yet!',
      name: 'noTransactionsYet',
      desc: '',
      args: [],
    );
  }

  /// `Check back later to see if\nthere are any new\ntransactions!`
  String get checkBackLater {
    return Intl.message(
      'Check back later to see if\nthere are any new\ntransactions!',
      name: 'checkBackLater',
      desc: '',
      args: [],
    );
  }

  /// `Performance`
  String get performance {
    return Intl.message(
      'Performance',
      name: 'performance',
      desc: '',
      args: [],
    );
  }

  /// `Milestones`
  String get milestones {
    return Intl.message(
      'Milestones',
      name: 'milestones',
      desc: '',
      args: [],
    );
  }

  /// `Start Investing`
  String get startInvesting {
    return Intl.message(
      'Start Investing',
      name: 'startInvesting',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Evaluation`
  String get privacyEvaluation {
    return Intl.message(
      'Privacy Evaluation',
      name: 'privacyEvaluation',
      desc: '',
      args: [],
    );
  }

  /// `Personalisation`
  String get personalisation {
    return Intl.message(
      'Personalisation',
      name: 'personalisation',
      desc: '',
      args: [],
    );
  }

  /// `Open Investment Account`
  String get openInvestmentAccount {
    return Intl.message(
      'Open Investment Account',
      name: 'openInvestmentAccount',
      desc: '',
      args: [],
    );
  }

  /// `Get the First Botstock for Free`
  String get getTheFirstBotstockForFree {
    return Intl.message(
      'Get the First Botstock for Free',
      name: 'getTheFirstBotstockForFree',
      desc: '',
      args: [],
    );
  }

  /// `Pay Deposit to Start Real Trade`
  String get payDepositToStartRealTrade {
    return Intl.message(
      'Pay Deposit to Start Real Trade',
      name: 'payDepositToStartRealTrade',
      desc: '',
      args: [],
    );
  }

  /// `Trade with Bots`
  String get tradeWithBots {
    return Intl.message(
      'Trade with Bots',
      name: 'tradeWithBots',
      desc: '',
      args: [],
    );
  }

  /// `Introduce Bot - Plank`
  String get introduceBotPlank {
    return Intl.message(
      'Introduce Bot - Plank',
      name: 'introduceBotPlank',
      desc: '',
      args: [],
    );
  }

  /// `Introduce Bot - Pullup`
  String get introduceBotPullup {
    return Intl.message(
      'Introduce Bot - Pullup',
      name: 'introduceBotPullup',
      desc: '',
      args: [],
    );
  }

  /// `Introduce Bot - Squat`
  String get introduceBotSquat {
    return Intl.message(
      'Introduce Bot - Squat',
      name: 'introduceBotSquat',
      desc: '',
      args: [],
    );
  }

  /// `Trade with Your First Botstock`
  String get tradeWithYourFirstBotstock {
    return Intl.message(
      'Trade with Your First Botstock',
      name: 'tradeWithYourFirstBotstock',
      desc: '',
      args: [],
    );
  }

  /// `Master AI Trading`
  String get masterAiTrading {
    return Intl.message(
      'Master AI Trading',
      name: 'masterAiTrading',
      desc: '',
      args: [],
    );
  }

  /// `Learn Botstock Management`
  String get learnBotstockManagement {
    return Intl.message(
      'Learn Botstock Management',
      name: 'learnBotstockManagement',
      desc: '',
      args: [],
    );
  }

  /// `Manage Your Botstock`
  String get manageYourBotstock {
    return Intl.message(
      'Manage Your Botstock',
      name: 'manageYourBotstock',
      desc: '',
      args: [],
    );
  }

  /// `Trade with a New Botstock`
  String get tradeWithANewBotstock {
    return Intl.message(
      'Trade with a New Botstock',
      name: 'tradeWithANewBotstock',
      desc: '',
      args: [],
    );
  }

  /// `Unable to Process Deposit`
  String get unableToProcessDepositTitle {
    return Intl.message(
      'Unable to Process Deposit',
      name: 'unableToProcessDepositTitle',
      desc: '',
      args: [],
    );
  }

  /// `We're having some trouble processing your deposit request. Please try again`
  String get unableToProcessDepositSubTitle {
    return Intl.message(
      'We\'re having some trouble processing your deposit request. Please try again',
      name: 'unableToProcessDepositSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Unable to Process Withdrawal`
  String get unableToProcessWithdrawalTitle {
    return Intl.message(
      'Unable to Process Withdrawal',
      name: 'unableToProcessWithdrawalTitle',
      desc: '',
      args: [],
    );
  }

  /// `We're having some trouble processing your withdrawal request. Please try again`
  String get unableToProcessWithdrawalSubTitle {
    return Intl.message(
      'We\'re having some trouble processing your withdrawal request. Please try again',
      name: 'unableToProcessWithdrawalSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Account Suspended`
  String get suspendedScreenTitle {
    return Intl.message(
      'Account Suspended',
      name: 'suspendedScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been suspended and is pending investigation from us. If you have any questions about your account, please contact our customer service team.`
  String get suspendedScreenSubTitle {
    return Intl.message(
      'Your account has been suspended and is pending investigation from us. If you have any questions about your account, please contact our customer service team.',
      name: 'suspendedScreenSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Start your AI revolution with\nAsklora. Go crush it.`
  String get signUpTitle {
    return Intl.message(
      'Start your AI revolution with\nAsklora. Go crush it.',
      name: 'signUpTitle',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Transaction fee`
  String get transactionFee {
    return Intl.message(
      'Transaction fee',
      name: 'transactionFee',
      desc: '',
      args: [],
    );
  }

  /// `Transfer to`
  String get transferTo {
    return Intl.message(
      'Transfer to',
      name: 'transferTo',
      desc: '',
      args: [],
    );
  }

  /// `Time Requested`
  String get timeRequested {
    return Intl.message(
      'Time Requested',
      name: 'timeRequested',
      desc: '',
      args: [],
    );
  }

  /// `Time Completed`
  String get timeCompleted {
    return Intl.message(
      'Time Completed',
      name: 'timeCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Total amount`
  String get totalAmount {
    return Intl.message(
      'Total amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Get your Investments in Shape`
  String get welcomeScreenTitle {
    return Intl.message(
      'Get your Investments in Shape',
      name: 'welcomeScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Say Goodbye to bad investing habits and embrace your new AI assistant, Asklora!`
  String get welcomeScreenSubTitle {
    return Intl.message(
      'Say Goodbye to bad investing habits and embrace your new AI assistant, Asklora!',
      name: 'welcomeScreenSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Guidance from your own personal AI`
  String get welcomeScreenFirstBenefit {
    return Intl.message(
      'Guidance from your own personal AI',
      name: 'welcomeScreenFirstBenefit',
      desc: '',
      args: [],
    );
  }

  /// `Personalised Experience`
  String get welcomeScreenSecondBenefit {
    return Intl.message(
      'Personalised Experience',
      name: 'welcomeScreenSecondBenefit',
      desc: '',
      args: [],
    );
  }

  /// `Automated trading strategies`
  String get welcomeScreenThirdBenefit {
    return Intl.message(
      'Automated trading strategies',
      name: 'welcomeScreenThirdBenefit',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal Amount`
  String get withdrawalAmount {
    return Intl.message(
      'Withdrawal Amount',
      name: 'withdrawalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Your withdrawal can take up to 2 working days.`
  String get withdrawalWorkingDays {
    return Intl.message(
      'Your withdrawal can take up to 2 working days.',
      name: 'withdrawalWorkingDays',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal Request Submitted`
  String get withdrawalRequestSubmittedTitle {
    return Intl.message(
      'Withdrawal Request Submitted',
      name: 'withdrawalRequestSubmittedTitle',
      desc: '',
      args: [],
    );
  }

  /// `You will be informed via email and app notification as soon as the funds are paid to your account.`
  String get withdrawalRequestSubmittedSubTitle {
    return Intl.message(
      'You will be informed via email and app notification as soon as the funds are paid to your account.',
      name: 'withdrawalRequestSubmittedSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw`
  String get withdraw {
    return Intl.message(
      'Withdraw',
      name: 'withdraw',
      desc: '',
      args: [],
    );
  }

  /// `relearn`
  String get relearn {
    return Intl.message(
      'relearn',
      name: 'relearn',
      desc: '',
      args: [],
    );
  }

  /// `~{minute} min`
  String min(String minute) {
    return Intl.message(
      '~$minute min',
      name: 'min',
      desc: '',
      args: [minute],
    );
  }

  /// `View Deposit Guide`
  String get viewDepositGuide {
    return Intl.message(
      'View Deposit Guide',
      name: 'viewDepositGuide',
      desc: '',
      args: [],
    );
  }

  /// `Press back again to exit Asklora`
  String get pressBackAgain {
    return Intl.message(
      'Press back again to exit Asklora',
      name: 'pressBackAgain',
      desc: '',
      args: [],
    );
  }

  /// `Review your trade summary and hit `
  String get reviewYourTradeSummary {
    return Intl.message(
      'Review your trade summary and hit ',
      name: 'reviewYourTradeSummary',
      desc: '',
      args: [],
    );
  }

  /// ` to execute it!`
  String get toExecuteIt {
    return Intl.message(
      ' to execute it!',
      name: 'toExecuteIt',
      desc: '',
      args: [],
    );
  }

  /// `Here, you can find the `
  String get hereYouCanFind {
    return Intl.message(
      'Here, you can find the ',
      name: 'hereYouCanFind',
      desc: '',
      args: [],
    );
  }

  /// `Botstock’s details and estimated returns.`
  String get botStocksDetails {
    return Intl.message(
      'Botstock’s details and estimated returns.',
      name: 'botStocksDetails',
      desc: '',
      args: [],
    );
  }

  /// `This interactive graph shows the Botstock’s past `
  String get thisInteractiveGraph {
    return Intl.message(
      'This interactive graph shows the Botstock’s past ',
      name: 'thisInteractiveGraph',
      desc: '',
      args: [],
    );
  }

  /// `2 weeks performance `
  String get twoWeekPerformance {
    return Intl.message(
      '2 weeks performance ',
      name: 'twoWeekPerformance',
      desc: '',
      args: [],
    );
  }

  /// `to give you a better idea of its trading potential!`
  String get toGiveYou {
    return Intl.message(
      'to give you a better idea of its trading potential!',
      name: 'toGiveYou',
      desc: '',
      args: [],
    );
  }

  /// `If you’ve got `
  String get ifYouveGot {
    return Intl.message(
      'If you’ve got ',
      name: 'ifYouveGot',
      desc: '',
      args: [],
    );
  }

  /// `any questions `
  String get anyQuestion {
    return Intl.message(
      'any questions ',
      name: 'anyQuestion',
      desc: '',
      args: [],
    );
  }

  /// `about your investment, tap this icon to summon your `
  String get aboutYourInvestment {
    return Intl.message(
      'about your investment, tap this icon to summon your ',
      name: 'aboutYourInvestment',
      desc: '',
      args: [],
    );
  }

  /// `personal AI assistant Asklora! `
  String get personalAIAssistant {
    return Intl.message(
      'personal AI assistant Asklora! ',
      name: 'personalAIAssistant',
      desc: '',
      args: [],
    );
  }

  /// `Simply type a question and tap the `
  String get simplyTypeAQuestion {
    return Intl.message(
      'Simply type a question and tap the ',
      name: 'simplyTypeAQuestion',
      desc: '',
      args: [],
    );
  }

  /// `send icon `
  String get sendIcon {
    return Intl.message(
      'send icon ',
      name: 'sendIcon',
      desc: '',
      args: [],
    );
  }

  /// `to start a conversation. Tap the icon again to dismiss Asklora`
  String get toStartAConversation {
    return Intl.message(
      'to start a conversation. Tap the icon again to dismiss Asklora',
      name: 'toStartAConversation',
      desc: '',
      args: [],
    );
  }

  /// `Trade Summary`
  String get tradeSummary {
    return Intl.message(
      'Trade Summary',
      name: 'tradeSummary',
      desc: '',
      args: [],
    );
  }

  /// `Market Price`
  String get marketPrice {
    return Intl.message(
      'Market Price',
      name: 'marketPrice',
      desc: '',
      args: [],
    );
  }

  /// `End Date`
  String get endDate {
    return Intl.message(
      'End Date',
      name: 'endDate',
      desc: '',
      args: [],
    );
  }

  /// ` Confirm Trade`
  String get confirmTrade {
    return Intl.message(
      ' Confirm Trade',
      name: 'confirmTrade',
      desc: '',
      args: [],
    );
  }

  /// `Check Botstock Details`
  String get checkBotStockDetails {
    return Intl.message(
      'Check Botstock Details',
      name: 'checkBotStockDetails',
      desc: '',
      args: [],
    );
  }

  /// `Trade Request Submitted`
  String get tradeRequestSubmitted {
    return Intl.message(
      'Trade Request Submitted',
      name: 'tradeRequestSubmitted',
      desc: '',
      args: [],
    );
  }

  /// `Trade Cancelled`
  String get tradeCancelledTitle {
    return Intl.message(
      'Trade Cancelled',
      name: 'tradeCancelledTitle',
      desc: '',
      args: [],
    );
  }

  /// `The trade has been cancelled and your investment amount has been returned to your account`
  String get tradeCancelledSubtitle {
    return Intl.message(
      'The trade has been cancelled and your investment amount has been returned to your account',
      name: 'tradeCancelledSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `{botName} {botSymbol} will start when the US market opens`
  String startBotStockAcknowledgement(String botName, String botSymbol) {
    return Intl.message(
      '$botName $botSymbol will start when the US market opens',
      name: 'startBotStockAcknowledgement',
      desc: '',
      args: [botName, botSymbol],
    );
  }

  /// `You are making great\nprogress, {name}!`
  String beforeKYCHeaderTitle(String name) {
    return Intl.message(
      'You are making great\nprogress, $name!',
      name: 'beforeKYCHeaderTitle',
      desc: '',
      args: [name],
    );
  }

  /// `{botName} {botSymbol} will end when the US market opens`
  String endBotStockAcknowledgement(String botName, String botSymbol) {
    return Intl.message(
      '$botName $botSymbol will end when the US market opens',
      name: 'endBotStockAcknowledgement',
      desc: '',
      args: [botName, botSymbol],
    );
  }

  /// `Just one more step to AI\ngreatness, {name}!`
  String beforeDepositHeaderTitle(String name) {
    return Intl.message(
      'Just one more step to AI\ngreatness, $name!',
      name: 'beforeDepositHeaderTitle',
      desc: '',
      args: [name],
    );
  }

  /// `Your investment account will be ready soon!`
  String get afterPayDepositHeaderTitle {
    return Intl.message(
      'Your investment account will be ready soon!',
      name: 'afterPayDepositHeaderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Great start!`
  String get greatStart {
    return Intl.message(
      'Great start!',
      name: 'greatStart',
      desc: '',
      args: [],
    );
  }

  /// `Halfway there!`
  String get halfWayThere {
    return Intl.message(
      'Halfway there!',
      name: 'halfWayThere',
      desc: '',
      args: [],
    );
  }

  /// `Almost finished!`
  String get almostFinished {
    return Intl.message(
      'Almost finished!',
      name: 'almostFinished',
      desc: '',
      args: [],
    );
  }

  /// `Start investing`
  String get startInvestingOnMilestone {
    return Intl.message(
      'Start investing',
      name: 'startInvestingOnMilestone',
      desc: '',
      args: [],
    );
  }

  /// `Deposit funds to start investing`
  String get depositFundToStartInvesting {
    return Intl.message(
      'Deposit funds to start investing',
      name: 'depositFundToStartInvesting',
      desc: '',
      args: [],
    );
  }

  /// `You've completed all the steps to opening an account with Asklora! You'll be able to start trading as soon as your account is approved. It usually takes up to 2 business days.`
  String get onBoardingCompletionMessage {
    return Intl.message(
      'You\'ve completed all the steps to opening an account with Asklora! You\'ll be able to start trading as soon as your account is approved. It usually takes up to 2 business days.',
      name: 'onBoardingCompletionMessage',
      desc: '',
      args: [],
    );
  }

  /// `Next step`
  String get nextStep {
    return Intl.message(
      'Next step',
      name: 'nextStep',
      desc: '',
      args: [],
    );
  }

  /// `Go`
  String get go {
    return Intl.message(
      'Go',
      name: 'go',
      desc: '',
      args: [],
    );
  }

  /// `Deposit via FPS or Wire Transfer`
  String get depositViaFpsOrWireTransfer {
    return Intl.message(
      'Deposit via FPS or Wire Transfer',
      name: 'depositViaFpsOrWireTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Transfer to Asklora bank account from the same bank account you used.`
  String get transferAtLeastWithNoMinimumDeposit {
    return Intl.message(
      'Transfer to Asklora bank account from the same bank account you used.',
      name: 'transferAtLeastWithNoMinimumDeposit',
      desc: '',
      args: [],
    );
  }

  /// `Transfer at least HK${minDeposit} to Asklora's bank account. Any initial deposit less than HK${minDeposit} will be rejected and fees will be charged.`
  String transferAtLeastWithMinimumDeposit(String minDeposit) {
    return Intl.message(
      'Transfer at least HK\$$minDeposit to Asklora\'s bank account. Any initial deposit less than HK\$$minDeposit will be rejected and fees will be charged.',
      name: 'transferAtLeastWithMinimumDeposit',
      desc: '',
      args: [minDeposit],
    );
  }

  /// `Upload proof of remittance`
  String get uploadProofOfRemittance {
    return Intl.message(
      'Upload proof of remittance',
      name: 'uploadProofOfRemittance',
      desc: '',
      args: [],
    );
  }

  /// `The proof of remittance should show your bank account number, full name, and amount.`
  String get theProofOfRemittanceShouldShowYourBankAccount {
    return Intl.message(
      'The proof of remittance should show your bank account number, full name, and amount.',
      name: 'theProofOfRemittanceShouldShowYourBankAccount',
      desc: '',
      args: [],
    );
  }

  /// `Input deposit amount`
  String get inputDepositAmount {
    return Intl.message(
      'Input deposit amount',
      name: 'inputDepositAmount',
      desc: '',
      args: [],
    );
  }

  /// `The amount must match with the actual transferred amount.`
  String get theAmountMustMatch {
    return Intl.message(
      'The amount must match with the actual transferred amount.',
      name: 'theAmountMustMatch',
      desc: '',
      args: [],
    );
  }

  /// `Your deposit can take up to 2 working days`
  String get yourDepositCanTakeUp2WorkingDays {
    return Intl.message(
      'Your deposit can take up to 2 working days',
      name: 'yourDepositCanTakeUp2WorkingDays',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `We will work with your bank in order to identify your bank account details (account name, bank code, account number). However, we may require additional details from you for transaction verification purposes.`
  String get returningUserDepositNotes {
    return Intl.message(
      'We will work with your bank in order to identify your bank account details (account name, bank code, account number). However, we may require additional details from you for transaction verification purposes.',
      name: 'returningUserDepositNotes',
      desc: '',
      args: [],
    );
  }

  /// `We will take information collected from your bank via API or submitted remittance advice to determine your designated bank account. All future deposits and withdrawals are accepted ONLY through this designated bank account. You may change the designated bank account but you will need to go through the same verification by way of a minimum HK$ {minDeposit} bank transfer is completed.`
  String weWillTakeInformationCollectedFromYour(String minDeposit) {
    return Intl.message(
      'We will take information collected from your bank via API or submitted remittance advice to determine your designated bank account. All future deposits and withdrawals are accepted ONLY through this designated bank account. You may change the designated bank account but you will need to go through the same verification by way of a minimum HK\$ $minDeposit bank transfer is completed.',
      name: 'weWillTakeInformationCollectedFromYour',
      desc: '',
      args: [minDeposit],
    );
  }

  /// `Please add a HK bank account that is under your name; other people's bank accounts or joint accounts will not be accepted.`
  String get pleaseAddAHkBankAccount {
    return Intl.message(
      'Please add a HK bank account that is under your name; other people\'s bank accounts or joint accounts will not be accepted.',
      name: 'pleaseAddAHkBankAccount',
      desc: '',
      args: [],
    );
  }

  /// `We will only accept deposits via bank transfer (wire/FPS) from your own account.`
  String get weWillOnlyAcceptDepositViaBankTransfer {
    return Intl.message(
      'We will only accept deposits via bank transfer (wire/FPS) from your own account.',
      name: 'weWillOnlyAcceptDepositViaBankTransfer',
      desc: '',
      args: [],
    );
  }

  /// `We will only accept HKD.`
  String get weWillOnlyAcceptHKD {
    return Intl.message(
      'We will only accept HKD.',
      name: 'weWillOnlyAcceptHKD',
      desc: '',
      args: [],
    );
  }

  /// `Transfer initial funds to Asklora`
  String get transferInitialFundToAsklora {
    return Intl.message(
      'Transfer initial funds to Asklora',
      name: 'transferInitialFundToAsklora',
      desc: '',
      args: [],
    );
  }

  /// `Transfer funds to Asklora`
  String get transferFundToAsklora {
    return Intl.message(
      'Transfer funds to Asklora',
      name: 'transferFundToAsklora',
      desc: '',
      args: [],
    );
  }

  /// `Copy Asklora's bank details and transfer no less than HK${minDeposit} from your bank account via FPS or Wire transfer.`
  String firstTimeCopyAskloraBankDetails(String minDeposit) {
    return Intl.message(
      'Copy Asklora\'s bank details and transfer no less than HK\$$minDeposit from your bank account via FPS or Wire transfer.',
      name: 'firstTimeCopyAskloraBankDetails',
      desc: '',
      args: [minDeposit],
    );
  }

  /// `Copy Asklora's bank details and transfer from your bank account via FPS or Wire transfer.`
  String get copyAskloraBankDetails {
    return Intl.message(
      'Copy Asklora\'s bank details and transfer from your bank account via FPS or Wire transfer.',
      name: 'copyAskloraBankDetails',
      desc: '',
      args: [],
    );
  }

  /// `The amount must match with the proof of remittance.`
  String get theAmountMustMatchWithPor {
    return Intl.message(
      'The amount must match with the proof of remittance.',
      name: 'theAmountMustMatchWithPor',
      desc: '',
      args: [],
    );
  }

  /// `The proof of remittance should show your bank account number, full name, and amount.`
  String get thePorShouldShowYourBank {
    return Intl.message(
      'The proof of remittance should show your bank account number, full name, and amount.',
      name: 'thePorShouldShowYourBank',
      desc: '',
      args: [],
    );
  }

  /// `Please make sure you have finished the transfer and then inform us, if not, your deposit will be delayed.`
  String get pleaseMakeSureYouHaveFinished {
    return Intl.message(
      'Please make sure you have finished the transfer and then inform us, if not, your deposit will be delayed.',
      name: 'pleaseMakeSureYouHaveFinished',
      desc: '',
      args: [],
    );
  }

  /// `Please make sure you press 'SUBMIT' after you have transferred the funds from your bank.`
  String get pleaseMakeSureYouPressSubmit {
    return Intl.message(
      'Please make sure you press \'SUBMIT\' after you have transferred the funds from your bank.',
      name: 'pleaseMakeSureYouPressSubmit',
      desc: '',
      args: [],
    );
  }

  /// `Your deposit may be rejected if the informed amount is different from the actual transferred amount.`
  String get yourDepositMayBeRejected {
    return Intl.message(
      'Your deposit may be rejected if the informed amount is different from the actual transferred amount.',
      name: 'yourDepositMayBeRejected',
      desc: '',
      args: [],
    );
  }

  /// `We accept HKD only.`
  String get weAcceptHKDOnly {
    return Intl.message(
      'We accept HKD only.',
      name: 'weAcceptHKDOnly',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get buttonSubmit {
    return Intl.message(
      'Submit',
      name: 'buttonSubmit',
      desc: '',
      args: [],
    );
  }

  /// `min. 8 characters`
  String get min8Character {
    return Intl.message(
      'min. 8 characters',
      name: 'min8Character',
      desc: '',
      args: [],
    );
  }

  /// `at least 1 lowercase letter`
  String get atLeast1Lowercase {
    return Intl.message(
      'at least 1 lowercase letter',
      name: 'atLeast1Lowercase',
      desc: '',
      args: [],
    );
  }

  /// `at least 1 upper case letter`
  String get atLeast1Uppercase {
    return Intl.message(
      'at least 1 upper case letter',
      name: 'atLeast1Uppercase',
      desc: '',
      args: [],
    );
  }

  /// `at least 1 number`
  String get atLeast1Number {
    return Intl.message(
      'at least 1 number',
      name: 'atLeast1Number',
      desc: '',
      args: [],
    );
  }

  /// `Ready to go?`
  String get readyToGo {
    return Intl.message(
      'Ready to go?',
      name: 'readyToGo',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Password`
  String get invalidPassword {
    return Intl.message(
      'Invalid Password',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign Agreements`
  String get signAgreements {
    return Intl.message(
      'Sign Agreements',
      name: 'signAgreements',
      desc: '',
      args: [],
    );
  }

  /// `Licensee: Chang Yung Ching`
  String get licenseeName {
    return Intl.message(
      'Licensee: Chang Yung Ching',
      name: 'licenseeName',
      desc: '',
      args: [],
    );
  }

  /// `CE No.: AFF918`
  String get licenseeNumber {
    return Intl.message(
      'CE No.: AFF918',
      name: 'licenseeNumber',
      desc: '',
      args: [],
    );
  }

  /// `Risk Disclosure Statement`
  String get riskDisclosureStatementLabel {
    return Intl.message(
      'Risk Disclosure Statement',
      name: 'riskDisclosureStatementLabel',
      desc: '',
      args: [],
    );
  }

  /// `1. The prices of securities fluctuate, sometimes dramatically. The price of a security may move up or down, and may become valueless. It is as likely that losses will be incurred rather than profit made as a result of buying and selling securities. Investors should not only base on this marketing material to make any investment decision, you should carefully consider whether the investment products or services are suitable for you according to your investment experience, purpose, risk tolerance, financial or related conditions. If you have any questions, please contact us or obtain independent advice.\n\n2. Investment in foreign securities carries additional risks not generally associated with securities in the domestic market. The value or income of foreign securities may be more volatile and could be adversely affected by changes in currency rates of exchange, foreign taxation practices, foreign laws, government practices, regulations, and political events. You may find it more difficult to liquidate investments in foreign securities where they have limited liquidity in the relevant market. Foreign laws, government practices, and regulations may also affect the transferability of foreign securities. Timely and reliable information about the value or the extent of the risks of foreign securities may not be readily available at all times.\n\n3. You acknowledge that you have fully understood the implications of the risks associated with the Electronic Trading Service as set out in the Client Agreement`
  String get riskDisclosureStatementString {
    return Intl.message(
      '1. The prices of securities fluctuate, sometimes dramatically. The price of a security may move up or down, and may become valueless. It is as likely that losses will be incurred rather than profit made as a result of buying and selling securities. Investors should not only base on this marketing material to make any investment decision, you should carefully consider whether the investment products or services are suitable for you according to your investment experience, purpose, risk tolerance, financial or related conditions. If you have any questions, please contact us or obtain independent advice.\n\n2. Investment in foreign securities carries additional risks not generally associated with securities in the domestic market. The value or income of foreign securities may be more volatile and could be adversely affected by changes in currency rates of exchange, foreign taxation practices, foreign laws, government practices, regulations, and political events. You may find it more difficult to liquidate investments in foreign securities where they have limited liquidity in the relevant market. Foreign laws, government practices, and regulations may also affect the transferability of foreign securities. Timely and reliable information about the value or the extent of the risks of foreign securities may not be readily available at all times.\n\n3. You acknowledge that you have fully understood the implications of the risks associated with the Electronic Trading Service as set out in the Client Agreement',
      name: 'riskDisclosureStatementString',
      desc: '',
      args: [],
    );
  }

  /// `I have read, understood, and agree with the Risk Disclosure Statement.`
  String get riskDisclosureStatementAcknowledgement {
    return Intl.message(
      'I have read, understood, and agree with the Risk Disclosure Statement.',
      name: 'riskDisclosureStatementAcknowledgement',
      desc: '',
      args: [],
    );
  }

  /// `Personal Info`
  String get personalInfo {
    return Intl.message(
      'Personal Info',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Financial Profile`
  String get financialProfile {
    return Intl.message(
      'Financial Profile',
      name: 'financialProfile',
      desc: '',
      args: [],
    );
  }

  /// `Agreements`
  String get agreements {
    return Intl.message(
      'Agreements',
      name: 'agreements',
      desc: '',
      args: [],
    );
  }

  /// `Submit Application`
  String get submitApplication {
    return Intl.message(
      'Submit Application',
      name: 'submitApplication',
      desc: '',
      args: [],
    );
  }

  /// `The agreements will become binding subject to the approval of the information submitted by you. \n\nIf there is a material change to this information, please contact loracares@asklora.ai as soon as possible`
  String get summaryAgreementInformation {
    return Intl.message(
      'The agreements will become binding subject to the approval of the information submitted by you. \n\nIf there is a material change to this information, please contact loracares@asklora.ai as soon as possible',
      name: 'summaryAgreementInformation',
      desc: '',
      args: [],
    );
  }

  /// `Enter a new password`
  String get enterANewPassword {
    return Intl.message(
      'Enter a new password',
      name: 'enterANewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `A Password reset email has been sent. Please check your email`
  String get passwordLinkHasBeenSent {
    return Intl.message(
      'A Password reset email has been sent. Please check your email',
      name: 'passwordLinkHasBeenSent',
      desc: '',
      args: [],
    );
  }

  /// `Input wrong email address`
  String get inputWrongEmailAddress {
    return Intl.message(
      'Input wrong email address',
      name: 'inputWrongEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Can’t remember your email address?\nEmail us at cs@asklora.ai`
  String get cannotRememberEmailAddress {
    return Intl.message(
      'Can’t remember your email address?\nEmail us at cs@asklora.ai',
      name: 'cannotRememberEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email. Instructions will be sent to reset your password.`
  String get forgotPasswordMessage {
    return Intl.message(
      'Please enter your email. Instructions will be sent to reset your password.',
      name: 'forgotPasswordMessage',
      desc: '',
      args: [],
    );
  }

  /// `Password Reset Successful`
  String get resetPasswordSuccessful {
    return Intl.message(
      'Password Reset Successful',
      name: 'resetPasswordSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been reset. Please go back to the Login page and login again.`
  String get resetPasswordSuccessfulMessage {
    return Intl.message(
      'Your password has been reset. Please go back to the Login page and login again.',
      name: 'resetPasswordSuccessfulMessage',
      desc: '',
      args: [],
    );
  }

  /// `Back To Login`
  String get backToLogin {
    return Intl.message(
      'Back To Login',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Asklora.\n Your ultimate\nfinancial advisor`
  String get askloraYouUltimateFinancialAdvisor {
    return Intl.message(
      'Asklora.\n Your ultimate\nfinancial advisor',
      name: 'askloraYouUltimateFinancialAdvisor',
      desc: '',
      args: [],
    );
  }

  /// `Ask me anything related to finance`
  String get askMeAnythingRelatedToFinance {
    return Intl.message(
      'Ask me anything related to finance',
      name: 'askMeAnythingRelatedToFinance',
      desc: '',
      args: [],
    );
  }

  /// `I like your style`
  String get investmentResultScreenTitle {
    return Intl.message(
      'I like your style',
      name: 'investmentResultScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `You're one step closer to AI Investing. \n\nTime to open your account.`
  String get investmentResultScreenDescription {
    return Intl.message(
      'You\'re one step closer to AI Investing. \n\nTime to open your account.',
      name: 'investmentResultScreenDescription',
      desc: '',
      args: [],
    );
  }

  /// `I'm afraid you're not eligible for Asklora yet.`
  String get privacyFailedScreenTitle {
    return Intl.message(
      'I\'m afraid you\'re not eligible for Asklora yet.',
      name: 'privacyFailedScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Most likely, your risk score is too low to meet SFC requirements.\n\nIf you made a mistake and did not answer the questions correctly, please try again.`
  String get privacyFailedScreenDescription {
    return Intl.message(
      'Most likely, your risk score is too low to meet SFC requirements.\n\nIf you made a mistake and did not answer the questions correctly, please try again.',
      name: 'privacyFailedScreenDescription',
      desc: '',
      args: [],
    );
  }

  /// `I appreciate your honesty.`
  String get privacySuccessScreenTitle {
    return Intl.message(
      'I appreciate your honesty.',
      name: 'privacySuccessScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Age is just a number, but your personality is what sets you apart.\n\nAnswer a few personality questions, and I'll help you find investments that fit your style.`
  String get privacySuccessScreenDescription {
    return Intl.message(
      'Age is just a number, but your personality is what sets you apart.\n\nAnswer a few personality questions, and I\'ll help you find investments that fit your style.',
      name: 'privacySuccessScreenDescription',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get buttonTryAgain {
    return Intl.message(
      'Try Again',
      name: 'buttonTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Sure`
  String get buttonSure {
    return Intl.message(
      'Sure',
      name: 'buttonSure',
      desc: '',
      args: [],
    );
  }

  /// `Alright!\n\nBased on your answers, my technology is perfect for you and you can take on more risks.`
  String get personalizationResultScreenTitle {
    return Intl.message(
      'Alright!\n\nBased on your answers, my technology is perfect for you and you can take on more risks.',
      name: 'personalizationResultScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `investing can be simple with AI`
  String get opennessLessThan8 {
    return Intl.message(
      'investing can be simple with AI',
      name: 'opennessLessThan8',
      desc: '',
      args: [],
    );
  }

  /// `our technology is perfect for you`
  String get opennessMoreThan8 {
    return Intl.message(
      'our technology is perfect for you',
      name: 'opennessMoreThan8',
      desc: '',
      args: [],
    );
  }

  /// `we think you can take on more risk.`
  String get neuroticismLessThan8 {
    return Intl.message(
      'we think you can take on more risk.',
      name: 'neuroticismLessThan8',
      desc: '',
      args: [],
    );
  }

  /// `we think you should take on less risk.`
  String get neuroticismMoreThan8 {
    return Intl.message(
      'we think you should take on less risk.',
      name: 'neuroticismMoreThan8',
      desc: '',
      args: [],
    );
  }

  /// `You also seem to be a bit more reserved. But hey, introverts change the world!`
  String get extrovertLessThan8 {
    return Intl.message(
      'You also seem to be a bit more reserved. But hey, introverts change the world!',
      name: 'extrovertLessThan8',
      desc: '',
      args: [],
    );
  }

  /// `You also seem like a social butterfly - amplify that energy!`
  String get extrovertMoreThan8 {
    return Intl.message(
      'You also seem like a social butterfly - amplify that energy!',
      name: 'extrovertMoreThan8',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Investments tailored  for you`
  String get botRecommendationScreenTitle {
    return Intl.message(
      'Investments tailored  for you',
      name: 'botRecommendationScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Not feeling it? Try something different.`
  String get notFeelingIt {
    return Intl.message(
      'Not feeling it? Try something different.',
      name: 'notFeelingIt',
      desc: '',
      args: [],
    );
  }

  /// `Asklora's Wire Details`
  String get askloraWireDetails {
    return Intl.message(
      'Asklora\'s Wire Details',
      name: 'askloraWireDetails',
      desc: '',
      args: [],
    );
  }

  /// `View Details`
  String get buttonViewDetails {
    return Intl.message(
      'View Details',
      name: 'buttonViewDetails',
      desc: '',
      args: [],
    );
  }

  /// `Wire Transfer`
  String get wireTransfer {
    return Intl.message(
      'Wire Transfer',
      name: 'wireTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Bank Number`
  String get bankNumber {
    return Intl.message(
      'Bank Number',
      name: 'bankNumber',
      desc: '',
      args: [],
    );
  }

  /// `Account Number`
  String get accountNumber {
    return Intl.message(
      'Account Number',
      name: 'accountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Bank Name`
  String get bankName {
    return Intl.message(
      'Bank Name',
      name: 'bankName',
      desc: '',
      args: [],
    );
  }

  /// `Swift Code`
  String get swiftCode {
    return Intl.message(
      'Swift Code',
      name: 'swiftCode',
      desc: '',
      args: [],
    );
  }

  /// `Account Name`
  String get accountName {
    return Intl.message(
      'Account Name',
      name: 'accountName',
      desc: '',
      args: [],
    );
  }

  /// `Company Address`
  String get companyAddress {
    return Intl.message(
      'Company Address',
      name: 'companyAddress',
      desc: '',
      args: [],
    );
  }

  /// `Current Exchange Rate: HKD 1 = USD 0.137 (at HKT {time})`
  String exchangeRateInDepositScreen(String time) {
    return Intl.message(
      'Current Exchange Rate: HKD 1 = USD 0.137 (at HKT $time)',
      name: 'exchangeRateInDepositScreen',
      desc: '',
      args: [time],
    );
  }

  /// `Error Storing Data`
  String get errorStoringData {
    return Intl.message(
      'Error Storing Data',
      name: 'errorStoringData',
      desc: '',
      args: [],
    );
  }

  /// `Oops! We're having some technical difficulties trying to store your responses. Let's try retaking the questions`
  String get errorStoringDataDetails {
    return Intl.message(
      'Oops! We\'re having some technical difficulties trying to store your responses. Let\'s try retaking the questions',
      name: 'errorStoringDataDetails',
      desc: '',
      args: [],
    );
  }

  /// `User does not exist with the given email`
  String get emailNotExist {
    return Intl.message(
      'User does not exist with the given email',
      name: 'emailNotExist',
      desc: '',
      args: [],
    );
  }

  /// `User email is not verified`
  String get emailNotVerified {
    return Intl.message(
      'User email is not verified',
      name: 'emailNotVerified',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid email`
  String get enterValidEmail {
    return Intl.message(
      'Enter valid email',
      name: 'enterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully.`
  String get passwordChangeSuccessfully {
    return Intl.message(
      'Password changed successfully.',
      name: 'passwordChangeSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Token is invalid or expired.`
  String get tokenInvalid {
    return Intl.message(
      'Token is invalid or expired.',
      name: 'tokenInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Invalid OTP`
  String get invalidOtp {
    return Intl.message(
      'Invalid OTP',
      name: 'invalidOtp',
      desc: '',
      args: [],
    );
  }

  /// `Link for Password reset is sent to email.`
  String get linkPasswordResetIsSent {
    return Intl.message(
      'Link for Password reset is sent to email.',
      name: 'linkPasswordResetIsSent',
      desc: '',
      args: [],
    );
  }

  /// `Your account is not active yet.`
  String get accountIsNotActive {
    return Intl.message(
      'Your account is not active yet.',
      name: 'accountIsNotActive',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email. Instructions will be sent to reset your password.`
  String get pleaseEnterYouEmail {
    return Intl.message(
      'Please enter your email. Instructions will be sent to reset your password.',
      name: 'pleaseEnterYouEmail',
      desc: '',
      args: [],
    );
  }

  /// `Can't remember your email address?\nEmail us at help@asklora.ai`
  String get cantRememberYourEmail {
    return Intl.message(
      'Can\'t remember your email address?\nEmail us at help@asklora.ai',
      name: 'cantRememberYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Input wrong email address`
  String get inputWrongEmail {
    return Intl.message(
      'Input wrong email address',
      name: 'inputWrongEmail',
      desc: '',
      args: [],
    );
  }

  /// `Based on your answer, {opennessScore} and {neuroticismScore}\n\n{extrovertScore}`
  String resultOfPersonalizationQuestion(
      String opennessScore, String neuroticismScore, String extrovertScore) {
    return Intl.message(
      'Based on your answer, $opennessScore and $neuroticismScore\n\n$extrovertScore',
      name: 'resultOfPersonalizationQuestion',
      desc: '',
      args: [opennessScore, neuroticismScore, extrovertScore],
    );
  }

  /// `Define again`
  String get defineAgain {
    return Intl.message(
      'Define again',
      name: 'defineAgain',
      desc: '',
      args: [],
    );
  }

  /// `Updated at {updated}`
  String updatedAt(String updated) {
    return Intl.message(
      'Updated at $updated',
      name: 'updatedAt',
      desc: '',
      args: [updated],
    );
  }

  /// `Mobile OTP`
  String get otpScreenTitle {
    return Intl.message(
      'Mobile OTP',
      name: 'otpScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `We've sent you a code via SMS to verify your phone number (+852 {phoneNumber}). Please enter the OTP code below.`
  String otpScreenDescription(String phoneNumber) {
    return Intl.message(
      'We\'ve sent you a code via SMS to verify your phone number (+852 $phoneNumber). Please enter the OTP code below.',
      name: 'otpScreenDescription',
      desc: '',
      args: [phoneNumber],
    );
  }

  /// `Verify`
  String get buttonVerify {
    return Intl.message(
      'Verify',
      name: 'buttonVerify',
      desc: '',
      args: [],
    );
  }

  /// `OTP SMS is sent to your phone`
  String get otpSentToYourPhone {
    return Intl.message(
      'OTP SMS is sent to your phone',
      name: 'otpSentToYourPhone',
      desc: '',
      args: [],
    );
  }

  /// `Verify OTP Success`
  String get verifyOtpSuccess {
    return Intl.message(
      'Verify OTP Success',
      name: 'verifyOtpSuccess',
      desc: '',
      args: [],
    );
  }

  /// `OTP code sent to your email`
  String get otpSentToYourEmail {
    return Intl.message(
      'OTP code sent to your email',
      name: 'otpSentToYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `000000 (6 digit)`
  String get otpDigit {
    return Intl.message(
      '000000 (6 digit)',
      name: 'otpDigit',
      desc: '',
      args: [],
    );
  }

  /// `SEND OTP`
  String get sendOtp {
    return Intl.message(
      'SEND OTP',
      name: 'sendOtp',
      desc: '',
      args: [],
    );
  }

  /// `RE-SEND IN {seconds}S`
  String reSendOtp(String seconds) {
    return Intl.message(
      'RE-SEND IN ${seconds}S',
      name: 'reSendOtp',
      desc: '',
      args: [seconds],
    );
  }

  /// `It's time to find out your investment preferences`
  String get aiIsqWelcomeTitle {
    return Intl.message(
      'It\'s time to find out your investment preferences',
      name: 'aiIsqWelcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Let's see what kind of stocks you prefer`
  String get aiIsqWelcomeSubTitle {
    return Intl.message(
      'Let\'s see what kind of stocks you prefer',
      name: 'aiIsqWelcomeSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please press to proceed to the next question`
  String get isqNextButton {
    return Intl.message(
      'Please press to proceed to the next question',
      name: 'isqNextButton',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message(
      'Cancelled',
      name: 'cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get expired {
    return Intl.message(
      'Expired',
      name: 'expired',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get rejected {
    return Intl.message(
      'Rejected',
      name: 'rejected',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get buy {
    return Intl.message(
      'Buy',
      name: 'buy',
      desc: '',
      args: [],
    );
  }

  /// `Sell`
  String get sell {
    return Intl.message(
      'Sell',
      name: 'sell',
      desc: '',
      args: [],
    );
  }

  /// `Deposit History`
  String get depositHistory {
    return Intl.message(
      'Deposit History',
      name: 'depositHistory',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal History`
  String get withdrawalHistory {
    return Intl.message(
      'Withdrawal History',
      name: 'withdrawalHistory',
      desc: '',
      args: [],
    );
  }

  /// `Sorry ! You are not eligible for Asklora`
  String get kycRejectedScreenTitle {
    return Intl.message(
      'Sorry ! You are not eligible for Asklora',
      name: 'kycRejectedScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `We do not accept any members who are affiliated with the organisations mentioned above`
  String get kycRejectedExplanationOfAffiliate {
    return Intl.message(
      'We do not accept any members who are affiliated with the organisations mentioned above',
      name: 'kycRejectedExplanationOfAffiliate',
      desc: '',
      args: [],
    );
  }

  /// `Go Back`
  String get buttonGoBack {
    return Intl.message(
      'Go Back',
      name: 'buttonGoBack',
      desc: '',
      args: [],
    );
  }

  /// `Employment`
  String get employment {
    return Intl.message(
      'Employment',
      name: 'employment',
      desc: '',
      args: [],
    );
  }

  /// `Employment Status`
  String get employmentStatus {
    return Intl.message(
      'Employment Status',
      name: 'employmentStatus',
      desc: '',
      args: [],
    );
  }

  /// `Employed`
  String get employed {
    return Intl.message(
      'Employed',
      name: 'employed',
      desc: '',
      args: [],
    );
  }

  /// `Self-Employed`
  String get selfEmployed {
    return Intl.message(
      'Self-Employed',
      name: 'selfEmployed',
      desc: '',
      args: [],
    );
  }

  /// `Retired`
  String get retired {
    return Intl.message(
      'Retired',
      name: 'retired',
      desc: '',
      args: [],
    );
  }

  /// `Student`
  String get student {
    return Intl.message(
      'Student',
      name: 'student',
      desc: '',
      args: [],
    );
  }

  /// `Business Owner`
  String get businessOwner {
    return Intl.message(
      'Business Owner',
      name: 'businessOwner',
      desc: '',
      args: [],
    );
  }

  /// `Homemaker`
  String get homeMaker {
    return Intl.message(
      'Homemaker',
      name: 'homeMaker',
      desc: '',
      args: [],
    );
  }

  /// `Unemployed`
  String get unEmployed {
    return Intl.message(
      'Unemployed',
      name: 'unEmployed',
      desc: '',
      args: [],
    );
  }

  /// `At-Home Trader`
  String get homeTrader {
    return Intl.message(
      'At-Home Trader',
      name: 'homeTrader',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Nature of Business`
  String get natureOfBusiness {
    return Intl.message(
      'Nature of Business',
      name: 'natureOfBusiness',
      desc: '',
      args: [],
    );
  }

  /// `Nature of Business description`
  String get natureOfBusinessDesc {
    return Intl.message(
      'Nature of Business description',
      name: 'natureOfBusinessDesc',
      desc: '',
      args: [],
    );
  }

  /// `Architecture / Engineering`
  String get architectureEngineering {
    return Intl.message(
      'Architecture / Engineering',
      name: 'architectureEngineering',
      desc: '',
      args: [],
    );
  }

  /// `Arts / Design`
  String get artDesign {
    return Intl.message(
      'Arts / Design',
      name: 'artDesign',
      desc: '',
      args: [],
    );
  }

  /// `Business, Non-Finance`
  String get businessNonFinance {
    return Intl.message(
      'Business, Non-Finance',
      name: 'businessNonFinance',
      desc: '',
      args: [],
    );
  }

  /// `Community / Social Service`
  String get communitySocialService {
    return Intl.message(
      'Community / Social Service',
      name: 'communitySocialService',
      desc: '',
      args: [],
    );
  }

  /// `Computer / Information Technology`
  String get computerInformationTechnology {
    return Intl.message(
      'Computer / Information Technology',
      name: 'computerInformationTechnology',
      desc: '',
      args: [],
    );
  }

  /// `Construction`
  String get construction {
    return Intl.message(
      'Construction',
      name: 'construction',
      desc: '',
      args: [],
    );
  }

  /// `Education / Training / Library`
  String get educationTrainingLibrary {
    return Intl.message(
      'Education / Training / Library',
      name: 'educationTrainingLibrary',
      desc: '',
      args: [],
    );
  }

  /// `Farming, Fishing and Forestry`
  String get farmingFishingForestry {
    return Intl.message(
      'Farming, Fishing and Forestry',
      name: 'farmingFishingForestry',
      desc: '',
      args: [],
    );
  }

  /// `Finance/ Broker Dealer /Bank`
  String get financeBrokerDealerBank {
    return Intl.message(
      'Finance/ Broker Dealer /Bank',
      name: 'financeBrokerDealerBank',
      desc: '',
      args: [],
    );
  }

  /// `Food and Beverage`
  String get foodBeverage {
    return Intl.message(
      'Food and Beverage',
      name: 'foodBeverage',
      desc: '',
      args: [],
    );
  }

  /// `Healthcare`
  String get healthcare {
    return Intl.message(
      'Healthcare',
      name: 'healthcare',
      desc: '',
      args: [],
    );
  }

  /// `Installation, Maintenance, and Repair`
  String get installationMaintenanceRepair {
    return Intl.message(
      'Installation, Maintenance, and Repair',
      name: 'installationMaintenanceRepair',
      desc: '',
      args: [],
    );
  }

  /// `Legal`
  String get legal {
    return Intl.message(
      'Legal',
      name: 'legal',
      desc: '',
      args: [],
    );
  }

  /// `Life, Physical and Social Service`
  String get lifePhysicalSocialService {
    return Intl.message(
      'Life, Physical and Social Service',
      name: 'lifePhysicalSocialService',
      desc: '',
      args: [],
    );
  }

  /// `Media and Communications`
  String get mediaCommunications {
    return Intl.message(
      'Media and Communications',
      name: 'mediaCommunications',
      desc: '',
      args: [],
    );
  }

  /// `Law Enforcement, Government, Protective Service`
  String get lawEnforcementGovernmentProtectiveService {
    return Intl.message(
      'Law Enforcement, Government, Protective Service',
      name: 'lawEnforcementGovernmentProtectiveService',
      desc: '',
      args: [],
    );
  }

  /// `Personal Care / Service`
  String get personalCareService {
    return Intl.message(
      'Personal Care / Service',
      name: 'personalCareService',
      desc: '',
      args: [],
    );
  }

  /// `Production and Manufacturing`
  String get productionManufacturing {
    return Intl.message(
      'Production and Manufacturing',
      name: 'productionManufacturing',
      desc: '',
      args: [],
    );
  }

  /// `Transportation and Material Moving`
  String get transportationMaterialMoving {
    return Intl.message(
      'Transportation and Material Moving',
      name: 'transportationMaterialMoving',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Source of Wealth`
  String get sourceOfWealth {
    return Intl.message(
      'Source of Wealth',
      name: 'sourceOfWealth',
      desc: '',
      args: [],
    );
  }

  /// `Account opening and deposit are the last few steps before investing.`
  String get accountOpeningAndDeposit {
    return Intl.message(
      'Account opening and deposit are the last few steps before investing.',
      name: 'accountOpeningAndDeposit',
      desc: '',
      args: [],
    );
  }

  /// `Get ready for AI trading.`
  String get getReadyForTrading {
    return Intl.message(
      'Get ready for AI trading.',
      name: 'getReadyForTrading',
      desc: '',
      args: [],
    );
  }

  /// `Set up Personal Info`
  String get setupPersonalInfo {
    return Intl.message(
      'Set up Personal Info',
      name: 'setupPersonalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Verify identity`
  String get verifyIdentity {
    return Intl.message(
      'Verify identity',
      name: 'verifyIdentity',
      desc: '',
      args: [],
    );
  }

  /// `The items you will need…`
  String get theItemYouWillNeed {
    return Intl.message(
      'The items you will need…',
      name: 'theItemYouWillNeed',
      desc: '',
      args: [],
    );
  }

  /// `HKID`
  String get hkId {
    return Intl.message(
      'HKID',
      name: 'hkId',
      desc: '',
      args: [],
    );
  }

  /// `Proof of Residential Address`
  String get porAddress {
    return Intl.message(
      'Proof of Residential Address',
      name: 'porAddress',
      desc: '',
      args: [],
    );
  }

  /// `(We accept utility bill, bank statement, or government correspondence within the last 3 months)`
  String get weAcceptUtilityBill {
    return Intl.message(
      '(We accept utility bill, bank statement, or government correspondence within the last 3 months)',
      name: 'weAcceptUtilityBill',
      desc: '',
      args: [],
    );
  }

  /// `Once you've started, you can resume the process whenever you want.`
  String get onceYouHaveStarted {
    return Intl.message(
      'Once you\'ve started, you can resume the process whenever you want.',
      name: 'onceYouHaveStarted',
      desc: '',
      args: [],
    );
  }

  /// `Open Account Now`
  String get openAccountNow {
    return Intl.message(
      'Open Account Now',
      name: 'openAccountNow',
      desc: '',
      args: [],
    );
  }

  /// `Are you a United States tax resident, green card holder, or citizen?`
  String get usResidentQuestion {
    return Intl.message(
      'Are you a United States tax resident, green card holder, or citizen?',
      name: 'usResidentQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Are you a Hong Kong resident? By clicking yes, you acknowledge that you are also a Hong Kong tax resident`
  String get hkResidentQuestion {
    return Intl.message(
      'Are you a Hong Kong resident? By clicking yes, you acknowledge that you are also a Hong Kong tax resident',
      name: 'hkResidentQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Please make sure your name matches the information on your identification document.`
  String get personalInfoFormDesc {
    return Intl.message(
      'Please make sure your name matches the information on your identification document.',
      name: 'personalInfoFormDesc',
      desc: '',
      args: [],
    );
  }

  /// `Legal English First Name`
  String get legalFirstName {
    return Intl.message(
      'Legal English First Name',
      name: 'legalFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Legal English Last Name`
  String get legalLastName {
    return Intl.message(
      'Legal English Last Name',
      name: 'legalLastName',
      desc: '',
      args: [],
    );
  }

  /// `HKID Number`
  String get hkIdNumber {
    return Intl.message(
      'HKID Number',
      name: 'hkIdNumber',
      desc: '',
      args: [],
    );
  }

  /// `Nationality`
  String get nationality {
    return Intl.message(
      'Nationality',
      name: 'nationality',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get dateOfBirth {
    return Intl.message(
      'Date of Birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Country of Birth`
  String get countryOfBirth {
    return Intl.message(
      'Country of Birth',
      name: 'countryOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `HK Phone Number`
  String get hkPhoneNo {
    return Intl.message(
      'HK Phone Number',
      name: 'hkPhoneNo',
      desc: '',
      args: [],
    );
  }

  /// `Please provide your residential address. This will also be your mailing address.`
  String get pleaseProvideYourResidentialAddress {
    return Intl.message(
      'Please provide your residential address. This will also be your mailing address.',
      name: 'pleaseProvideYourResidentialAddress',
      desc: '',
      args: [],
    );
  }

  /// `Upload Address Proof`
  String get uploadAddressProof {
    return Intl.message(
      'Upload Address Proof',
      name: 'uploadAddressProof',
      desc: '',
      args: [],
    );
  }

  /// `Your address proof must contain your full name, full residential address and the issuing agency.\n\nWe accept water/electricity/gas bills, bank statement, or government correspondence within the last 3 months.`
  String get yourAddressProofMustContainFullName {
    return Intl.message(
      'Your address proof must contain your full name, full residential address and the issuing agency.\n\nWe accept water/electricity/gas bills, bank statement, or government correspondence within the last 3 months.',
      name: 'yourAddressProofMustContainFullName',
      desc: '',
      args: [],
    );
  }

  /// `Address Proof`
  String get addressProof {
    return Intl.message(
      'Address Proof',
      name: 'addressProof',
      desc: '',
      args: [],
    );
  }

  /// `Please Select`
  String get pleaseSelect {
    return Intl.message(
      'Please Select',
      name: 'pleaseSelect',
      desc: '',
      args: [],
    );
  }

  /// `Subscription`
  String get subscription {
    return Intl.message(
      'Subscription',
      name: 'subscription',
      desc: '',
      args: [],
    );
  }

  /// `Please read the the Asklora Customer Agreement. You must click on the agreement and check all the boxes in order to proceed.`
  String get pleaseReadTheAskloraCustomerAgreement {
    return Intl.message(
      'Please read the the Asklora Customer Agreement. You must click on the agreement and check all the boxes in order to proceed.',
      name: 'pleaseReadTheAskloraCustomerAgreement',
      desc: '',
      args: [],
    );
  }

  /// `I have read, understood, and agree to be bound by LORA Advisors Limited’s account terms, and all other terms, disclosures and disclaimers applicable to me.`
  String get iHaveReadAndAgreed {
    return Intl.message(
      'I have read, understood, and agree to be bound by LORA Advisors Limited’s account terms, and all other terms, disclosures and disclaimers applicable to me.',
      name: 'iHaveReadAndAgreed',
      desc: '',
      args: [],
    );
  }

  /// `I understand I am signing this agreement electronically, and that my electronic signature will have the same effect as physically signing and returning the Customer Agreement.`
  String get iUnderstandSigningAgreement {
    return Intl.message(
      'I understand I am signing this agreement electronically, and that my electronic signature will have the same effect as physically signing and returning the Customer Agreement.',
      name: 'iUnderstandSigningAgreement',
      desc: '',
      args: [],
    );
  }

  /// `Asklora Customer Agreement.pdf`
  String get AskloraAgreementFile {
    return Intl.message(
      'Asklora Customer Agreement.pdf',
      name: 'AskloraAgreementFile',
      desc: '',
      args: [],
    );
  }

  /// `Under penalties of perjury, I declare that I have examined the information in lines 1-7 and to the best of my knowledge and belief it is true, correct, and complete. I further certify under penalties of perjury that:`
  String get taxAgreementDesc1 {
    return Intl.message(
      'Under penalties of perjury, I declare that I have examined the information in lines 1-7 and to the best of my knowledge and belief it is true, correct, and complete. I further certify under penalties of perjury that:',
      name: 'taxAgreementDesc1',
      desc: '',
      args: [],
    );
  }

  /// `I am the individual that is the beneficial owner (or am authorized to sign for the individual that is the beneficial owner) of all the income or proceeds to which this form relates or am using this form to document myself for chapter 4 purposes;`
  String get taxAgreementDescPoint1 {
    return Intl.message(
      'I am the individual that is the beneficial owner (or am authorized to sign for the individual that is the beneficial owner) of all the income or proceeds to which this form relates or am using this form to document myself for chapter 4 purposes;',
      name: 'taxAgreementDescPoint1',
      desc: '',
      args: [],
    );
  }

  /// `The person named on line 1 of this form is not a U.S. person;`
  String get taxAgreementDescPoint2 {
    return Intl.message(
      'The person named on line 1 of this form is not a U.S. person;',
      name: 'taxAgreementDescPoint2',
      desc: '',
      args: [],
    );
  }

  /// `This form relates to:`
  String get taxAgreementDescPoint3 {
    return Intl.message(
      'This form relates to:',
      name: 'taxAgreementDescPoint3',
      desc: '',
      args: [],
    );
  }

  /// `income not effectively connected with the conduct of a trade or business in the United States;`
  String get taxAgreementDescPoint3SubPoint1 {
    return Intl.message(
      'income not effectively connected with the conduct of a trade or business in the United States;',
      name: 'taxAgreementDescPoint3SubPoint1',
      desc: '',
      args: [],
    );
  }

  /// `income effectively connected with the conduct of a trade or business in the United States but is not subject to tax under an applicable income tax treaty;`
  String get taxAgreementDescPoint3SubPoint2 {
    return Intl.message(
      'income effectively connected with the conduct of a trade or business in the United States but is not subject to tax under an applicable income tax treaty;',
      name: 'taxAgreementDescPoint3SubPoint2',
      desc: '',
      args: [],
    );
  }

  /// `the partner's share of a partnership's effectively connected taxable income;`
  String get taxAgreementDescPoint3SubPoint3 {
    return Intl.message(
      'the partner\'s share of a partnership\'s effectively connected taxable income;',
      name: 'taxAgreementDescPoint3SubPoint3',
      desc: '',
      args: [],
    );
  }

  /// `or the partner's amount realized from the transfer of a partnership interest subject to withholding under section 1446(f);`
  String get taxAgreementDescPoint3SubPoint4 {
    return Intl.message(
      'or the partner\'s amount realized from the transfer of a partnership interest subject to withholding under section 1446(f);',
      name: 'taxAgreementDescPoint3SubPoint4',
      desc: '',
      args: [],
    );
  }

  /// `The person named on line 1 of this form is a resident of the treaty country listed on line 9 of the form (if any) within the meaning of the income tax treaty between the United States and that country;`
  String get taxAgreementDescPoint4 {
    return Intl.message(
      'The person named on line 1 of this form is a resident of the treaty country listed on line 9 of the form (if any) within the meaning of the income tax treaty between the United States and that country;',
      name: 'taxAgreementDescPoint4',
      desc: '',
      args: [],
    );
  }

  /// `and For broker transactions or barter exchanges, the beneficial owner is an exempt foreign person as defined in the instructions to IRS Form W-8BEN.`
  String get taxAgreementDescPoint5 {
    return Intl.message(
      'and For broker transactions or barter exchanges, the beneficial owner is an exempt foreign person as defined in the instructions to IRS Form W-8BEN.',
      name: 'taxAgreementDescPoint5',
      desc: '',
      args: [],
    );
  }

  /// `Furthermore, I authorize this form to be provided to any withholding agent that has control, receipt, or custody of the income of which I am the beneficial owner or any withholding agent that can disburse or make payments of the income of which I am the beneficial owner. I agree I will submit a new form within 30 days if any certification made on this form becomes incorrect.`
  String get taxAgreementDesc2 {
    return Intl.message(
      'Furthermore, I authorize this form to be provided to any withholding agent that has control, receipt, or custody of the income of which I am the beneficial owner or any withholding agent that can disburse or make payments of the income of which I am the beneficial owner. I agree I will submit a new form within 30 days if any certification made on this form becomes incorrect.',
      name: 'taxAgreementDesc2',
      desc: '',
      args: [],
    );
  }

  /// `The US Internal Revenue Service does not require your consent to any provisions of this document other than the certifications required to establish your status as a non-U.S. person, and if applicable, obtain a reduced rate of witholding.`
  String get taxAgreementDesc3 {
    return Intl.message(
      'The US Internal Revenue Service does not require your consent to any provisions of this document other than the certifications required to establish your status as a non-U.S. person, and if applicable, obtain a reduced rate of witholding.',
      name: 'taxAgreementDesc3',
      desc: '',
      args: [],
    );
  }

  /// `By checking this box, you consent to the collection and distribution of tax forms in an electronic format in lieu of paper`
  String get taxAgreementCheckboxDesc {
    return Intl.message(
      'By checking this box, you consent to the collection and distribution of tax forms in an electronic format in lieu of paper',
      name: 'taxAgreementCheckboxDesc',
      desc: '',
      args: [],
    );
  }

  /// `Signature`
  String get taxAgreementSignatureTitle {
    return Intl.message(
      'Signature',
      name: 'taxAgreementSignatureTitle',
      desc: '',
      args: [],
    );
  }

  /// `By typing my signature and clicking ‘Agree’ below, I confirm that:`
  String get taxAgreementSignatureDesc {
    return Intl.message(
      'By typing my signature and clicking ‘Agree’ below, I confirm that:',
      name: 'taxAgreementSignatureDesc',
      desc: '',
      args: [],
    );
  }

  /// `(1) All information and/or documentation provided by me during the account application process is accurate, complete and up-to-date; `
  String get taxAgreementSignatureDescPoint1 {
    return Intl.message(
      '(1) All information and/or documentation provided by me during the account application process is accurate, complete and up-to-date; ',
      name: 'taxAgreementSignatureDescPoint1',
      desc: '',
      args: [],
    );
  }

  /// `(2) I have read and understood all of the information provided to me by LORA Advisors;`
  String get taxAgreementSignatureDescPoint2 {
    return Intl.message(
      '(2) I have read and understood all of the information provided to me by LORA Advisors;',
      name: 'taxAgreementSignatureDescPoint2',
      desc: '',
      args: [],
    );
  }

  /// `(3) I consent and agree to the terms of all the above agreements and disclosures provided to me during the account application process: and`
  String get taxAgreementSignatureDescPoint3 {
    return Intl.message(
      '(3) I consent and agree to the terms of all the above agreements and disclosures provided to me during the account application process: and',
      name: 'taxAgreementSignatureDescPoint3',
      desc: '',
      args: [],
    );
  }

  /// `(4) I understand and agree that my electronic signature is the legal equivalent of a manual written signature.`
  String get taxAgreementSignatureDescPoint4 {
    return Intl.message(
      '(4) I understand and agree that my electronic signature is the legal equivalent of a manual written signature.',
      name: 'taxAgreementSignatureDescPoint4',
      desc: '',
      args: [],
    );
  }

  /// `Sign this electronically by typing your name exactly as shown below.`
  String get signInElectronically {
    return Intl.message(
      'Sign this electronically by typing your name exactly as shown below.',
      name: 'signInElectronically',
      desc: '',
      args: [],
    );
  }

  /// `Accepted signature(s):`
  String get acceptedSignature {
    return Intl.message(
      'Accepted signature(s):',
      name: 'acceptedSignature',
      desc: '',
      args: [],
    );
  }

  /// `Asklora Customer Agreement`
  String get askloraCustomerAgreement {
    return Intl.message(
      'Asklora Customer Agreement',
      name: 'askloraCustomerAgreement',
      desc: '',
      args: [],
    );
  }

  /// `Risk Disclosure Statement`
  String get riskDisclosureStatement {
    return Intl.message(
      'Risk Disclosure Statement',
      name: 'riskDisclosureStatement',
      desc: '',
      args: [],
    );
  }

  /// `W-8BEN Form`
  String get w8benForm {
    return Intl.message(
      'W-8BEN Form',
      name: 'w8benForm',
      desc: '',
      args: [],
    );
  }

  /// `Form W-8BEN`
  String get formW8ben {
    return Intl.message(
      'Form W-8BEN',
      name: 'formW8ben',
      desc: '',
      args: [],
    );
  }

  /// `Agreed`
  String get agreed {
    return Intl.message(
      'Agreed',
      name: 'agreed',
      desc: '',
      args: [],
    );
  }

  /// `We'll need to verify your identity via your HKID.`
  String get weNeedToVerifyYourId {
    return Intl.message(
      'We\'ll need to verify your identity via your HKID.',
      name: 'weNeedToVerifyYourId',
      desc: '',
      args: [],
    );
  }

  /// `Get ready for the verification process. You will..`
  String get getReadyForTheVerification {
    return Intl.message(
      'Get ready for the verification process. You will..',
      name: 'getReadyForTheVerification',
      desc: '',
      args: [],
    );
  }

  /// `Take a photo of the front of your HKID`
  String get takePhotoFront {
    return Intl.message(
      'Take a photo of the front of your HKID',
      name: 'takePhotoFront',
      desc: '',
      args: [],
    );
  }

  /// `Take a photo of the front of your HKID`
  String get takePhotoBack {
    return Intl.message(
      'Take a photo of the front of your HKID',
      name: 'takePhotoBack',
      desc: '',
      args: [],
    );
  }

  /// `Take a selfie`
  String get takeSelfie {
    return Intl.message(
      'Take a selfie',
      name: 'takeSelfie',
      desc: '',
      args: [],
    );
  }

  /// `Verify Now`
  String get verifyNow {
    return Intl.message(
      'Verify Now',
      name: 'verifyNow',
      desc: '',
      args: [],
    );
  }

  /// `Your investment account application is under review!`
  String get kycResultScreenTitle {
    return Intl.message(
      'Your investment account application is under review!',
      name: 'kycResultScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `You will be informed when your application is approved.\n\nPlease remember to collect your gift.`
  String get kycResultScreenDesc {
    return Intl.message(
      'You will be informed when your application is approved.\n\nPlease remember to collect your gift.',
      name: 'kycResultScreenDesc',
      desc: '',
      args: [],
    );
  }

  /// `Deposit Funds`
  String get depositFund {
    return Intl.message(
      'Deposit Funds',
      name: 'depositFund',
      desc: '',
      args: [],
    );
  }

  /// `The Bot management fee is the monthly fee that you pay for a Bot (HKD40). If you’re on the Core Plan, then there are no management fees, as it’s included in your subscription!`
  String get botManagementFeeTooltip {
    return Intl.message(
      'The Bot management fee is the monthly fee that you pay for a Bot (HKD40). If you’re on the Core Plan, then there are no management fees, as it’s included in your subscription!',
      name: 'botManagementFeeTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Our personalised recommendations are unique. The recommended Botstocks are based on your risk tolerance, personality, and investment style.`
  String get ourPersonalisedRecommendationsAreUnique {
    return Intl.message(
      'Our personalised recommendations are unique. The recommended Botstocks are based on your risk tolerance, personality, and investment style.',
      name: 'ourPersonalisedRecommendationsAreUnique',
      desc: '',
      args: [],
    );
  }

  /// `General Settings`
  String get generalSettings {
    return Intl.message(
      'General Settings',
      name: 'generalSettings',
      desc: '',
      args: [],
    );
  }

  /// `Not the stocks you were looking for?`
  String get notTheStockYouWereLooking {
    return Intl.message(
      'Not the stocks you were looking for?',
      name: 'notTheStockYouWereLooking',
      desc: '',
      args: [],
    );
  }

  /// `A Botstock is a combination of a stock and a Bot. A Bot is a unique AI trading strategy will automatically manage your investment for you.`
  String get botExplanationScreenTitle {
    return Intl.message(
      'A Botstock is a combination of a stock and a Bot. A Bot is a unique AI trading strategy will automatically manage your investment for you.',
      name: 'botExplanationScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Got it!`
  String get botStockExplanationScreenBottomButton {
    return Intl.message(
      'Got it!',
      name: 'botStockExplanationScreenBottomButton',
      desc: '',
      args: [],
    );
  }

  /// `A 'Bot' is your personal AI manager that trades your stock for you.`
  String get botStockDoScreenTitle {
    return Intl.message(
      'A \'Bot\' is your personal AI manager that trades your stock for you.',
      name: 'botStockDoScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hit a home run!`
  String get botStockDoScreenPoint1 {
    return Intl.message(
      'Hit a home run!',
      name: 'botStockDoScreenPoint1',
      desc: '',
      args: [],
    );
  }

  /// `Simple and easy!`
  String get botStockDoScreenPoint2 {
    return Intl.message(
      'Simple and easy!',
      name: 'botStockDoScreenPoint2',
      desc: '',
      args: [],
    );
  }

  /// `Passive income!`
  String get botStockDoScreenPoint3 {
    return Intl.message(
      'Passive income!',
      name: 'botStockDoScreenPoint3',
      desc: '',
      args: [],
    );
  }

  /// `Got it!`
  String get buttonGotIt {
    return Intl.message(
      'Got it!',
      name: 'buttonGotIt',
      desc: '',
      args: [],
    );
  }

  /// `Understood!`
  String get understood {
    return Intl.message(
      'Understood!',
      name: 'understood',
      desc: '',
      args: [],
    );
  }

  /// `You're all set!\nLet's begin a real AI trade!`
  String get botStockWelcomeScreenTitle {
    return Intl.message(
      'You\'re all set!\nLet\'s begin a real AI trade!',
      name: 'botStockWelcomeScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sure! What is a Botstock?`
  String get botStockWelcomeScreenBottomButton {
    return Intl.message(
      'Sure! What is a Botstock?',
      name: 'botStockWelcomeScreenBottomButton',
      desc: '',
      args: [],
    );
  }

  /// `Press to redo ISQ`
  String get pressToRedoISQ {
    return Intl.message(
      'Press to redo ISQ',
      name: 'pressToRedoISQ',
      desc: '',
      args: [],
    );
  }

  /// `See My Recommendations`
  String get seeMyRecommendations {
    return Intl.message(
      'See My Recommendations',
      name: 'seeMyRecommendations',
      desc: '',
      args: [],
    );
  }

  /// `Start Again`
  String get startAgain {
    return Intl.message(
      'Start Again',
      name: 'startAgain',
      desc: '',
      args: [],
    );
  }

  /// `You have {availableAmount},`
  String botTradeBottomSheetAmountMinimumFirst(String availableAmount) {
    return Intl.message(
      'You have $availableAmount,',
      name: 'botTradeBottomSheetAmountMinimumFirst',
      desc: '',
      args: [availableAmount],
    );
  }

  /// ` the minimum investment amount is {minimumAmount}.`
  String botTradeBottomSheetAmountMinimumSecond(String minimumAmount) {
    return Intl.message(
      ' the minimum investment amount is $minimumAmount.',
      name: 'botTradeBottomSheetAmountMinimumSecond',
      desc: '',
      args: [minimumAmount],
    );
  }

  /// `Got It`
  String get ppiGotIt {
    return Intl.message(
      'Got It',
      name: 'ppiGotIt',
      desc: '',
      args: [],
    );
  }

  /// `Every trade is unique, each time you invest with a new Botstock, I'll ask you some investment style questions to tailor new recommendations! `
  String get giftBotStockMessageScreenTitle {
    return Intl.message(
      'Every trade is unique, each time you invest with a new Botstock, I\'ll ask you some investment style questions to tailor new recommendations! ',
      name: 'giftBotStockMessageScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `See my recommendations`
  String get giftBotStockMessageScreenBottomButton {
    return Intl.message(
      'See my recommendations',
      name: 'giftBotStockMessageScreenBottomButton',
      desc: '',
      args: [],
    );
  }

  /// `Go To Portfolio`
  String get goToPortfolio {
    return Intl.message(
      'Go To Portfolio',
      name: 'goToPortfolio',
      desc: '',
      args: [],
    );
  }

  /// `Start another investment`
  String get startAnotherInvestments {
    return Intl.message(
      'Start another investment',
      name: 'startAnotherInvestments',
      desc: '',
      args: [],
    );
  }

  /// `Bot Values`
  String get botValues {
    return Intl.message(
      'Bot Values',
      name: 'botValues',
      desc: '',
      args: [],
    );
  }

  /// `Here are `
  String get botRecommendationTutorialDesc1 {
    return Intl.message(
      'Here are ',
      name: 'botRecommendationTutorialDesc1',
      desc: '',
      args: [],
    );
  }

  /// `your unique recommendations `
  String get botRecommendationTutorialDesc2 {
    return Intl.message(
      'your unique recommendations ',
      name: 'botRecommendationTutorialDesc2',
      desc: '',
      args: [],
    );
  }

  /// `based on how you answered the ISQ section`
  String get botRecommendationTutorialDesc3 {
    return Intl.message(
      'based on how you answered the ISQ section',
      name: 'botRecommendationTutorialDesc3',
      desc: '',
      args: [],
    );
  }

  /// `Represents how much stock the bot is holding in terms of %. For example, for a HKD10,000 investment, if your Stock Values are HKD4,000 and your Cash is HKD6,000, your Stock Holding % is 40%.`
  String get portfolioDetailPerformanceBotAssetsInStockTooltip {
    return Intl.message(
      'Represents how much stock the bot is holding in terms of %. For example, for a HKD10,000 investment, if your Stock Values are HKD4,000 and your Cash is HKD6,000, your Stock Holding % is 40%.',
      name: 'portfolioDetailPerformanceBotAssetsInStockTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Here's a brief description of the bot and stock you've chosen`
  String get tooltipDescOfTickerDetailsTutorial {
    return Intl.message(
      'Here\'s a brief description of the bot and stock you\'ve chosen',
      name: 'tooltipDescOfTickerDetailsTutorial',
      desc: '',
      args: [],
    );
  }

  /// `Tap anywhere to continue`
  String get tapAnyWhere {
    return Intl.message(
      'Tap anywhere to continue',
      name: 'tapAnyWhere',
      desc: '',
      args: [],
    );
  }

  /// `You can click on `
  String get youCanClickOn {
    return Intl.message(
      'You can click on ',
      name: 'youCanClickOn',
      desc: '',
      args: [],
    );
  }

  /// `Tell Me More`
  String get tellMeMore {
    return Intl.message(
      'Tell Me More',
      name: 'tellMeMore',
      desc: '',
      args: [],
    );
  }

  /// ` to open Lora and get more details about your investment!`
  String get toOpenLora {
    return Intl.message(
      ' to open Lora and get more details about your investment!',
      name: 'toOpenLora',
      desc: '',
      args: [],
    );
  }

  /// `LET'S TRADE`
  String get letsTrade {
    return Intl.message(
      'LET\'S TRADE',
      name: 'letsTrade',
      desc: '',
      args: [],
    );
  }

  /// `Requested To End`
  String get requestedToEnd {
    return Intl.message(
      'Requested To End',
      name: 'requestedToEnd',
      desc: '',
      args: [],
    );
  }

  /// `User Not Found`
  String get userNotFound {
    return Intl.message(
      'User Not Found',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Now for the Investment Style Questions (ISQ)! These questions will feel more ChatGPT style.`
  String get timeForInvestmentStyleQuestion {
    return Intl.message(
      'Now for the Investment Style Questions (ISQ)! These questions will feel more ChatGPT style.',
      name: 'timeForInvestmentStyleQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Through our chat-style dialogue, we'll grasp your investment interests to tailor botstock recommendations for you.`
  String get isqWillHelpMeUnderstandWhatKindOfStocks {
    return Intl.message(
      'Through our chat-style dialogue, we\'ll grasp your investment interests to tailor botstock recommendations for you.',
      name: 'isqWillHelpMeUnderstandWhatKindOfStocks',
      desc: '',
      args: [],
    );
  }

  /// `Remember, you can always `
  String get rememberYouCan {
    return Intl.message(
      'Remember, you can always ',
      name: 'rememberYouCan',
      desc: '',
      args: [],
    );
  }

  /// `click on Lora `
  String get clickOnLora {
    return Intl.message(
      'click on Lora ',
      name: 'clickOnLora',
      desc: '',
      args: [],
    );
  }

  /// `to ask any other questions you might have`
  String get toAskAnyOtherQuestion {
    return Intl.message(
      'to ask any other questions you might have',
      name: 'toAskAnyOtherQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Use the`
  String get useThe {
    return Intl.message(
      'Use the',
      name: 'useThe',
      desc: '',
      args: [],
    );
  }

  /// `nav bar`
  String get navBar {
    return Intl.message(
      'nav bar',
      name: 'navBar',
      desc: '',
      args: [],
    );
  }

  /// `to go to different pages.`
  String get toGoToDifferentPages {
    return Intl.message(
      'to go to different pages.',
      name: 'toGoToDifferentPages',
      desc: '',
      args: [],
    );
  }

  /// `Left`
  String get left {
    return Intl.message(
      'Left',
      name: 'left',
      desc: '',
      args: [],
    );
  }

  /// `Recommendations`
  String get recommendations {
    return Intl.message(
      'Recommendations',
      name: 'recommendations',
      desc: '',
      args: [],
    );
  }

  /// `Middle`
  String get middle {
    return Intl.message(
      'Middle',
      name: 'middle',
      desc: '',
      args: [],
    );
  }

  /// `Lora AI`
  String get LoraAi {
    return Intl.message(
      'Lora AI',
      name: 'LoraAi',
      desc: '',
      args: [],
    );
  }

  /// `Right`
  String get right {
    return Intl.message(
      'Right',
      name: 'right',
      desc: '',
      args: [],
    );
  }

  /// `Portfolio`
  String get portfolio {
    return Intl.message(
      'Portfolio',
      name: 'portfolio',
      desc: '',
      args: [],
    );
  }

  /// `Throughout your investment journey, you’ll see Lora on your bottom nav bar. Click on Lora at anytime to get advice or to ask anything related to finance.`
  String get throughoutYourInvestmentJourney {
    return Intl.message(
      'Throughout your investment journey, you’ll see Lora on your bottom nav bar. Click on Lora at anytime to get advice or to ask anything related to finance.',
      name: 'throughoutYourInvestmentJourney',
      desc: '',
      args: [],
    );
  }

  /// `Let’s Go`
  String get letsGo {
    return Intl.message(
      'Let’s Go',
      name: 'letsGo',
      desc: '',
      args: [],
    );
  }

  /// ` - (ISQ) `
  String get isq {
    return Intl.message(
      ' - (ISQ) ',
      name: 'isq',
      desc: '',
      args: [],
    );
  }

  /// ` - (Interactive) `
  String get interactive {
    return Intl.message(
      ' - (Interactive) ',
      name: 'interactive',
      desc: '',
      args: [],
    );
  }

  /// `You pick the stock, and the 'Bot' will trade it for you!`
  String get botStockExplanationScreenTitle {
    return Intl.message(
      'You pick the stock, and the \'Bot\' will trade it for you!',
      name: 'botStockExplanationScreenTitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
