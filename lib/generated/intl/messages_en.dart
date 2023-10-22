// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(name) => "Just one more step to AI\ngreatness, ${name}!";

  static String m1(name) => "You are making great\nprogress, ${name}!";

  static String m2(availableAmount, minimumAmount) =>
      "You have ${availableAmount}, the minimum investment amount is ${minimumAmount}.";

  static String m3(availableAmount) => "You have ${availableAmount},";

  static String m4(minimumAmount) =>
      " the minimum investment amount is ${minimumAmount}.";

  static String m5(amount) =>
      "The investment amount and Bot management fee (HKD${amount}) will be returned to your account.";

  static String m6(botInformation) =>
      "You can end the Botstock now, and all stocks will be sold. Trading of ${botInformation} will stop.";

  static String m7(minimumAmount) =>
      "The minimum investment amount is ${minimumAmount} per trade.";

  static String m8(expiryTime) => "The new expiry date is ${expiryTime}";

  static String m9(amount) =>
      "Due to regulatory requirements, you need to deposit at least HK\$${amount} if you want to change bank account";

  static String m10(emailAddress) =>
      "We\'ve sent an email to\n ${emailAddress}\n\nPlease use your phone to click on the activation link!";

  static String m11(botName, botSymbol) =>
      "${botName} ${botSymbol} will end when the US market opens";

  static String m12(time) =>
      "Current Exchange Rate: HKD 1 = USD 0.137 (at HKT ${time})";

  static String m13(minDeposit) =>
      "Copy Asklora\'s bank details and transfer no less than HK\$${minDeposit} from your bank account via FPS or Wire transfer.";

  static String m14(minute) => "~${minute} min";

  static String m15(phoneNumber) =>
      "We\'ve sent you a code via SMS to verify your phone number (+852 ${phoneNumber}). Please enter the OTP code below.";

  static String m16(currency) => "Buying Power (${currency})";

  static String m17(bot, startDate, endDate, duration) =>
      "Past ${duration} performance of ${bot}  (${startDate} - ${endDate})";

  static String m18(dateTime) => "Expired at ${dateTime}";

  static String m19(dateTime) => "Expired in ${dateTime} days";

  static String m20(currency) => "Total Botstock Values (${currency})";

  static String m21(currency) => "Withdrawable Balance (${currency})";

  static String m22(seconds) => "RE-SEND IN ${seconds}S";

  static String m23(opennessScore, neuroticismScore, extrovertScore) =>
      "Based on your answer, ${opennessScore} and ${neuroticismScore}\n\n${extrovertScore}";

  static String m24(botName, botSymbol) =>
      "${botName} ${botSymbol} will start when the US market opens";

  static String m25(minDeposit) =>
      "Transfer at least HK\$${minDeposit} to Asklora\'s bank account. Any initial deposit less than HK\$${minDeposit} will be rejected and fees will be charged.";

  static String m26(updated) => "Updated at ${updated}";

  static String m27(minDeposit) =>
      "We will take information collected from your bank via API or submitted remittance advice to determine your designated bank account. All future deposits and withdrawals are accepted ONLY through this designated bank account. You may change the designated bank account but you will need to go through the same verification by way of a minimum HK\$ ${minDeposit} bank transfer is completed.";

  static String m28(dateTime) =>
      "Your Bank Account is under review and will be complete by ${dateTime}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "AskloraAgreementFile": MessageLookupByLibrary.simpleMessage(
            "Asklora Customer Agreement.pdf"),
        "LoraAi": MessageLookupByLibrary.simpleMessage("Lora AI"),
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "aboutAsklora": MessageLookupByLibrary.simpleMessage("About Asklora"),
        "aboutYourInvestment": MessageLookupByLibrary.simpleMessage(
            "about your investment, tap this icon to summon your "),
        "acceptedSignature":
            MessageLookupByLibrary.simpleMessage("Accepted signature(s):"),
        "accountInformation":
            MessageLookupByLibrary.simpleMessage("Account Information"),
        "accountIsNotActive": MessageLookupByLibrary.simpleMessage(
            "Your account is not active yet."),
        "accountName": MessageLookupByLibrary.simpleMessage("Account Name"),
        "accountNumber": MessageLookupByLibrary.simpleMessage("Account Number"),
        "accountOpeningAndDeposit": MessageLookupByLibrary.simpleMessage(
            "Account opening and deposit are the last few steps before investing."),
        "accountSettings":
            MessageLookupByLibrary.simpleMessage("Account Settings"),
        "active": MessageLookupByLibrary.simpleMessage("Active"),
        "activities": MessageLookupByLibrary.simpleMessage("Activities"),
        "addressProof": MessageLookupByLibrary.simpleMessage("Address Proof"),
        "afterPayDepositHeaderTitle": MessageLookupByLibrary.simpleMessage(
            "Your investment account will be ready soon!"),
        "agree": MessageLookupByLibrary.simpleMessage("Agree"),
        "agreed": MessageLookupByLibrary.simpleMessage("Agreed"),
        "agreements": MessageLookupByLibrary.simpleMessage("Agreements"),
        "aiIsqWelcomeSubTitle": MessageLookupByLibrary.simpleMessage(
            "Let\'s see what kind of stocks you prefer"),
        "aiIsqWelcomeTitle": MessageLookupByLibrary.simpleMessage(
            "It\'s time to find out your investment preferences"),
        "allSettings": MessageLookupByLibrary.simpleMessage("All Settings"),
        "almostFinished":
            MessageLookupByLibrary.simpleMessage("Almost finished!"),
        "anyQuestion": MessageLookupByLibrary.simpleMessage("any questions "),
        "architectureEngineering":
            MessageLookupByLibrary.simpleMessage("Architecture / Engineering"),
        "artDesign": MessageLookupByLibrary.simpleMessage("Arts / Design"),
        "askMeAnythingRelatedToFinance": MessageLookupByLibrary.simpleMessage(
            "Ask me anything related to finance"),
        "askNameScreenPlaceholder": MessageLookupByLibrary.simpleMessage(
            "I\'m Lora, your personal AI assistant.\n\nGet ready to crush your investment goals!\nWhat\'s your name? "),
        "askNameScreenTextFieldHint":
            MessageLookupByLibrary.simpleMessage("Your Name"),
        "askloraCustomerAgreement":
            MessageLookupByLibrary.simpleMessage("Asklora Customer Agreement"),
        "askloraWireDetails":
            MessageLookupByLibrary.simpleMessage("Asklora\'s Wire Details"),
        "askloraYouUltimateFinancialAdvisor":
            MessageLookupByLibrary.simpleMessage(
                "Asklora.\n Your ultimate\nfinancial advisor"),
        "atLeast1Lowercase":
            MessageLookupByLibrary.simpleMessage("at least 1 lowercase letter"),
        "atLeast1Number":
            MessageLookupByLibrary.simpleMessage("at least 1 number"),
        "atLeast1Uppercase": MessageLookupByLibrary.simpleMessage(
            "at least 1 upper case letter"),
        "backToAccountSettings":
            MessageLookupByLibrary.simpleMessage("Back to account settings"),
        "backToLogin": MessageLookupByLibrary.simpleMessage("Back To Login"),
        "bankAccountNumber":
            MessageLookupByLibrary.simpleMessage("Bank Account Number"),
        "bankName": MessageLookupByLibrary.simpleMessage("Bank Name"),
        "bankNumber": MessageLookupByLibrary.simpleMessage("Bank Number"),
        "beforeDepositHeaderTitle": m0,
        "beforeKYCHeaderTitle": m1,
        "bestSuitedFor":
            MessageLookupByLibrary.simpleMessage("Best Suited For"),
        "botDuration": MessageLookupByLibrary.simpleMessage("Bot Duration"),
        "botExplanationScreenTitle": MessageLookupByLibrary.simpleMessage(
            "A Botstock is a combination of a stock and a Bot. A Bot is a unique AI trading strategy will automatically manage your investment for you."),
        "botManagementFee":
            MessageLookupByLibrary.simpleMessage("Bot Management Fee"),
        "botManagementFeeTooltip": MessageLookupByLibrary.simpleMessage(
            "The Bot management fee is the monthly fee that you pay for a Bot (HKD40). If you’re on the Core Plan, then there are no management fees, as it’s included in your subscription!"),
        "botRecommendationScreenTitle": MessageLookupByLibrary.simpleMessage(
            "Investments tailored  for you"),
        "botRecommendationTutorialDesc1":
            MessageLookupByLibrary.simpleMessage("Here are "),
        "botRecommendationTutorialDesc2": MessageLookupByLibrary.simpleMessage(
            "your unique recommendations "),
        "botRecommendationTutorialDesc3": MessageLookupByLibrary.simpleMessage(
            "based on how you answered the ISQ section"),
        "botStockDoScreenPoint1":
            MessageLookupByLibrary.simpleMessage("Hit a home run!"),
        "botStockDoScreenPoint2":
            MessageLookupByLibrary.simpleMessage("Simple and easy!"),
        "botStockDoScreenPoint3":
            MessageLookupByLibrary.simpleMessage("Passive income!"),
        "botStockDoScreenTitle": MessageLookupByLibrary.simpleMessage(
            "A \'Bot\' is your personal AI manager that trades your stock for you."),
        "botStockExplanationScreenBottomButton":
            MessageLookupByLibrary.simpleMessage("Got it!"),
        "botStockExplanationScreenTitle": MessageLookupByLibrary.simpleMessage(
            "You pick the stock, and the \'Bot\' will trade it for you!"),
        "botStockId": MessageLookupByLibrary.simpleMessage("Botstock ID"),
        "botStockWelcomeScreenBottomButton":
            MessageLookupByLibrary.simpleMessage("Sure! What is a Botstock?"),
        "botStockWelcomeScreenTitle": MessageLookupByLibrary.simpleMessage(
            "You\'re all set!\nLet\'s begin a real AI trade!"),
        "botStocksDetails": MessageLookupByLibrary.simpleMessage(
            "Botstock’s details and estimated returns."),
        "botTradeBottomSheetAccountNotYetApprovedSubTitle":
            MessageLookupByLibrary.simpleMessage(
                "Est. to be approved by 2 working days."),
        "botTradeBottomSheetAccountNotYetApprovedTitle":
            MessageLookupByLibrary.simpleMessage(
                "You can trade after your account is approved."),
        "botTradeBottomSheetAmountMinimum": m2,
        "botTradeBottomSheetAmountMinimumFirst": m3,
        "botTradeBottomSheetAmountMinimumSecond": m4,
        "botTradeBottomSheetAmountTitle":
            MessageLookupByLibrary.simpleMessage("How much are you investing?"),
        "botTradeBottomSheetCancelBotStockConfirmationTitle": m5,
        "botTradeBottomSheetEndBotStockConfirmationSubTitle":
            MessageLookupByLibrary.simpleMessage(
                "The total Botstock value will be returned to your \naccount after the next community order."),
        "botTradeBottomSheetEndBotStockConfirmationTitle": m6,
        "botTradeBottomSheetFreeBotStockSuccessfullyAddedSubTitle":
            MessageLookupByLibrary.simpleMessage("Deposit To Start Trading"),
        "botTradeBottomSheetFreeBotStockSuccessfullyAddedTitle":
            MessageLookupByLibrary.simpleMessage(
                "Your free Botstock has been added to your portfolio!"),
        "botTradeBottomSheetInsufficientBalanceSubTitle": m7,
        "botTradeBottomSheetInsufficientBalanceTitle":
            MessageLookupByLibrary.simpleMessage(
                "You are running out of money! Fund your account now."),
        "botTradeBottomSheetRolloverConfirmationButton":
            MessageLookupByLibrary.simpleMessage("Confirm Rollover"),
        "botTradeBottomSheetRolloverConfirmationSubTitle": m8,
        "botTradeBottomSheetRolloverConfirmationTitle":
            MessageLookupByLibrary.simpleMessage(
                "Your Botstock will be extended for \n\n2 Weeks"),
        "botTradeBottomSheetRolloverDisclosureSubTitle":
            MessageLookupByLibrary.simpleMessage(
                "You will be charged HKD40 if you want to extend this Botstock. If you do not have enough funds, then your fees will be deducted when you have sufficient buying power"),
        "botTradeBottomSheetRolloverDisclosureTitle":
            MessageLookupByLibrary.simpleMessage(
                "If you extend the Botstock period, you will incur additional fees"),
        "botValues": MessageLookupByLibrary.simpleMessage("Bot Values"),
        "businessNonFinance":
            MessageLookupByLibrary.simpleMessage("Business, Non-Finance"),
        "businessOwner": MessageLookupByLibrary.simpleMessage("Business Owner"),
        "buttonAlreadyHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("Already Have An Account?"),
        "buttonBack": MessageLookupByLibrary.simpleMessage("Back"),
        "buttonBackToHome":
            MessageLookupByLibrary.simpleMessage("Back To Home"),
        "buttonBackToPortfolio":
            MessageLookupByLibrary.simpleMessage("Back To Portfolio"),
        "buttonCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "buttonCancelTrade":
            MessageLookupByLibrary.simpleMessage("Cancel Trade"),
        "buttonChangeInvestmentStyle":
            MessageLookupByLibrary.simpleMessage("Change Investment Style"),
        "buttonConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "buttonContactCustomerService":
            MessageLookupByLibrary.simpleMessage("Contact Customer Service"),
        "buttonContinue": MessageLookupByLibrary.simpleMessage("Continue"),
        "buttonDeposit": MessageLookupByLibrary.simpleMessage("Deposit"),
        "buttonDone": MessageLookupByLibrary.simpleMessage("Done"),
        "buttonForgetPassword":
            MessageLookupByLibrary.simpleMessage("Forget Password?"),
        "buttonGoBack": MessageLookupByLibrary.simpleMessage("Go Back"),
        "buttonGotIt": MessageLookupByLibrary.simpleMessage("Got it!"),
        "buttonHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("Have An Account?"),
        "buttonLetsBegin": MessageLookupByLibrary.simpleMessage("Let\'s Begin"),
        "buttonMaybeLater": MessageLookupByLibrary.simpleMessage("Maybe Later"),
        "buttonNext": MessageLookupByLibrary.simpleMessage("Next"),
        "buttonNotNow": MessageLookupByLibrary.simpleMessage("Not Now"),
        "buttonReloadPage": MessageLookupByLibrary.simpleMessage("Reload Page"),
        "buttonResendActivationLink":
            MessageLookupByLibrary.simpleMessage("Resend Activation Link"),
        "buttonSave": MessageLookupByLibrary.simpleMessage("Save"),
        "buttonSignOut": MessageLookupByLibrary.simpleMessage("Sign Out"),
        "buttonSignUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "buttonSignUpAgain":
            MessageLookupByLibrary.simpleMessage("Sign Up Again"),
        "buttonSubmit": MessageLookupByLibrary.simpleMessage("Submit"),
        "buttonSure": MessageLookupByLibrary.simpleMessage("Sure"),
        "buttonTryAgain": MessageLookupByLibrary.simpleMessage("Try Again"),
        "buttonVerify": MessageLookupByLibrary.simpleMessage("Verify"),
        "buttonViewDetails":
            MessageLookupByLibrary.simpleMessage("View Details"),
        "buttonViewTransactionHistory":
            MessageLookupByLibrary.simpleMessage("View Transaction History"),
        "buttonWithdraw": MessageLookupByLibrary.simpleMessage("Withdraw"),
        "buy": MessageLookupByLibrary.simpleMessage("Buy"),
        "cancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
        "cannotRememberEmailAddress": MessageLookupByLibrary.simpleMessage(
            "Can’t remember your email address?\nEmail us at cs@asklora.ai"),
        "cantRememberYourEmail": MessageLookupByLibrary.simpleMessage(
            "Can\'t remember your email address?\nEmail us at help@asklora.ai"),
        "carouselIntro1": MessageLookupByLibrary.simpleMessage(
            "Get your Investments in Shape"),
        "carouselIntro2": MessageLookupByLibrary.simpleMessage(
            "Guided by FinFit Coach, Lora"),
        "carouselIntro3": MessageLookupByLibrary.simpleMessage(
            "Invest with AI strategy, automated"),
        "carouselIntro4":
            MessageLookupByLibrary.simpleMessage("Personalised experience"),
        "ceo": MessageLookupByLibrary.simpleMessage("CEO"),
        "changeBankAccount":
            MessageLookupByLibrary.simpleMessage("Change Bank Account"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Change Password"),
        "checkBackLater": MessageLookupByLibrary.simpleMessage(
            "Check back later to see if\nthere are any new\ntransactions!"),
        "checkBotStockDetails":
            MessageLookupByLibrary.simpleMessage("Check Botstock Details"),
        "clickOnLora": MessageLookupByLibrary.simpleMessage("click on Lora "),
        "communitySocialService":
            MessageLookupByLibrary.simpleMessage("Community / Social Service"),
        "companyAddress":
            MessageLookupByLibrary.simpleMessage("Company Address"),
        "completed": MessageLookupByLibrary.simpleMessage("Completed"),
        "computerInformationTechnology": MessageLookupByLibrary.simpleMessage(
            "Computer / Information Technology"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmAndContinue":
            MessageLookupByLibrary.simpleMessage("Confirm And Continue"),
        "confirmNewPassword":
            MessageLookupByLibrary.simpleMessage("Confirm New Password"),
        "confirmTrade": MessageLookupByLibrary.simpleMessage(" Confirm Trade"),
        "construction": MessageLookupByLibrary.simpleMessage("Construction"),
        "contactUs": MessageLookupByLibrary.simpleMessage("Contact Us"),
        "continueAccountOpening":
            MessageLookupByLibrary.simpleMessage("Continue Account Opening"),
        "copyAskloraBankDetails": MessageLookupByLibrary.simpleMessage(
            "Copy Asklora\'s bank details and transfer from your bank account via FPS or Wire transfer."),
        "corePlan": MessageLookupByLibrary.simpleMessage("Core Plan"),
        "countryOfBirth":
            MessageLookupByLibrary.simpleMessage("Country of Birth"),
        "createAnAccount":
            MessageLookupByLibrary.simpleMessage("Create An Account"),
        "currentPrice": MessageLookupByLibrary.simpleMessage("Current Price"),
        "customerService":
            MessageLookupByLibrary.simpleMessage("Customer Service"),
        "dateJoined": MessageLookupByLibrary.simpleMessage("Date Joined"),
        "dateOfBirth": MessageLookupByLibrary.simpleMessage("Date of Birth"),
        "defineAgain": MessageLookupByLibrary.simpleMessage("Define again"),
        "defineInvestmentStyle":
            MessageLookupByLibrary.simpleMessage("Define Investment Style"),
        "deposit": MessageLookupByLibrary.simpleMessage("Deposit"),
        "depositAmount": MessageLookupByLibrary.simpleMessage("Deposit Amount"),
        "depositFund": MessageLookupByLibrary.simpleMessage("Deposit Funds"),
        "depositFundToStartInvesting": MessageLookupByLibrary.simpleMessage(
            "Deposit funds to start investing"),
        "depositHistory":
            MessageLookupByLibrary.simpleMessage("Deposit History"),
        "depositRegulatoryRequirements": m9,
        "depositRequestSubmittedSubTitleFirstTime":
            MessageLookupByLibrary.simpleMessage(
                "Your account opening application and initial deposit will be reviewed within 1-2 working days. You will be informed via email and app notification once your account is approved."),
        "depositRequestSubmittedSubTitleReturn":
            MessageLookupByLibrary.simpleMessage(
                "Your deposit request is submitted. We\'ll let you know via email and app notification as soon as your deposit arrives."),
        "depositRequestSubmittedTitle":
            MessageLookupByLibrary.simpleMessage("Deposit Request Submitted"),
        "depositViaFpsOrWireTransfer": MessageLookupByLibrary.simpleMessage(
            "Deposit via FPS or Wire Transfer"),
        "doAnyOfTheFollowingApply": MessageLookupByLibrary.simpleMessage(
            "Do any of the following apply to you or a member of your immediate family ?"),
        "educationTrainingLibrary": MessageLookupByLibrary.simpleMessage(
            "Education / Training / Library"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailActivationFailedTitle": MessageLookupByLibrary.simpleMessage(
            "Sorry! You were a bit late, your request has timed out. \n\nLet\'s try and activate your account again!"),
        "emailActivationSuccessTitle": m10,
        "emailAddress": MessageLookupByLibrary.simpleMessage("Email Address"),
        "emailNotExist": MessageLookupByLibrary.simpleMessage(
            "User does not exist with the given email"),
        "emailNotVerified":
            MessageLookupByLibrary.simpleMessage("User email is not verified"),
        "employed": MessageLookupByLibrary.simpleMessage("Employed"),
        "employees": MessageLookupByLibrary.simpleMessage("Employees"),
        "employment": MessageLookupByLibrary.simpleMessage("Employment"),
        "employmentStatus":
            MessageLookupByLibrary.simpleMessage("Employment Status"),
        "endBotStockAcknowledgement": m11,
        "endDate": MessageLookupByLibrary.simpleMessage("End Date"),
        "endedAmount": MessageLookupByLibrary.simpleMessage("Ended Amount"),
        "enterANewPassword":
            MessageLookupByLibrary.simpleMessage("Enter a new password"),
        "enterValidEmail":
            MessageLookupByLibrary.simpleMessage("Enter valid email"),
        "enterValidPassword":
            MessageLookupByLibrary.simpleMessage("Enter valid password"),
        "errorGettingInformationInvestmentDetailSubTitle":
            MessageLookupByLibrary.simpleMessage(
                "There was an error when trying to get the investment details. Please try reloading the page"),
        "errorGettingInformationInvestmentStyleQuestionSubTitle":
            MessageLookupByLibrary.simpleMessage(
                "There was an error when trying to get the investment style question. Please try reloading the page"),
        "errorGettingInformationPortfolioSubTitle":
            MessageLookupByLibrary.simpleMessage(
                "There was an error when trying to get your Portfolio. Please try reloading the page"),
        "errorGettingInformationTitle":
            MessageLookupByLibrary.simpleMessage("Unable to get information"),
        "errorGettingInformationTransactionHistorySubTitle":
            MessageLookupByLibrary.simpleMessage(
                "There was an error when trying to get the transaction history. Please try reloading the page"),
        "errorStoringData":
            MessageLookupByLibrary.simpleMessage("Error Storing Data"),
        "errorStoringDataDetails": MessageLookupByLibrary.simpleMessage(
            "Oops! We\'re having some technical difficulties trying to store your responses. Let\'s try retaking the questions"),
        "errorWithdrawalUnavailableSubTitle": MessageLookupByLibrary.simpleMessage(
            "You don\'t have any funds to withdraw. You haven\'t deposited yet or your deposit might still be processing "),
        "errorWithdrawalUnavailableTitle":
            MessageLookupByLibrary.simpleMessage("Withdrawal Unavailable"),
        "estMaxLossLevel":
            MessageLookupByLibrary.simpleMessage("Est. Max Loss Level"),
        "estMaxLossPercent":
            MessageLookupByLibrary.simpleMessage("Est. Max Loss %"),
        "estMaxProfitLevel":
            MessageLookupByLibrary.simpleMessage("Est. Max Profit Level"),
        "estMaxProfitPercent":
            MessageLookupByLibrary.simpleMessage("Est. Max Profit %"),
        "estStopLossLevel":
            MessageLookupByLibrary.simpleMessage("Est. Stop Loss Level"),
        "estStopLossPercent":
            MessageLookupByLibrary.simpleMessage("Est. Stop Loss %"),
        "estTakeProfitLevel":
            MessageLookupByLibrary.simpleMessage("Est. Take Profit Level"),
        "estTakeProfitPercent":
            MessageLookupByLibrary.simpleMessage("Est. Take Profit %"),
        "estimatedEndDate":
            MessageLookupByLibrary.simpleMessage("Estimated End Date"),
        "exchangeRateInDepositScreen": m12,
        "existingPassword":
            MessageLookupByLibrary.simpleMessage("Existing Password"),
        "expired": MessageLookupByLibrary.simpleMessage("Expired"),
        "expiresAt": MessageLookupByLibrary.simpleMessage("Expires at"),
        "extrovertLessThan8": MessageLookupByLibrary.simpleMessage(
            "You also seem to be a bit more reserved. But hey, introverts change the world!"),
        "extrovertMoreThan8": MessageLookupByLibrary.simpleMessage(
            "You also seem like a social butterfly - amplify that energy!"),
        "farmingFishingForestry": MessageLookupByLibrary.simpleMessage(
            "Farming, Fishing and Forestry"),
        "filledPrice": MessageLookupByLibrary.simpleMessage("Filled Price"),
        "financeBrokerDealerBank": MessageLookupByLibrary.simpleMessage(
            "Finance/ Broker Dealer /Bank"),
        "financialProfile":
            MessageLookupByLibrary.simpleMessage("Financial Profile"),
        "firstTimeCopyAskloraBankDetails": m13,
        "foodBeverage":
            MessageLookupByLibrary.simpleMessage("Food and Beverage"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot Password"),
        "forgotPasswordMessage": MessageLookupByLibrary.simpleMessage(
            "Please enter your email. Instructions will be sent to reset your password."),
        "formW8ben": MessageLookupByLibrary.simpleMessage("Form W-8BEN"),
        "founded": MessageLookupByLibrary.simpleMessage("Founded"),
        "free": MessageLookupByLibrary.simpleMessage("Free"),
        "freeTrial": MessageLookupByLibrary.simpleMessage("Free Trial"),
        "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
        "generalSettings":
            MessageLookupByLibrary.simpleMessage("General Settings"),
        "getHelp": MessageLookupByLibrary.simpleMessage("Get Help"),
        "getReadyForTheVerification": MessageLookupByLibrary.simpleMessage(
            "Get ready for the verification process. You will.."),
        "getReadyForTrading":
            MessageLookupByLibrary.simpleMessage("Get ready for AI trading."),
        "getTheFirstBotstockForFree": MessageLookupByLibrary.simpleMessage(
            "Get the First Botstock for Free"),
        "giftBotStockMessageScreenBottomButton":
            MessageLookupByLibrary.simpleMessage("See my recommendations"),
        "giftBotStockMessageScreenTitle": MessageLookupByLibrary.simpleMessage(
            "Every trade is unique, each time you invest with a new Botstock, I\'ll ask you some investment style questions to tailor new recommendations! "),
        "go": MessageLookupByLibrary.simpleMessage("Go"),
        "goToPortfolio":
            MessageLookupByLibrary.simpleMessage("Go To Portfolio"),
        "gotIt": MessageLookupByLibrary.simpleMessage("Got It"),
        "greatStart": MessageLookupByLibrary.simpleMessage("Great start!"),
        "greetingScreenSubTitle": MessageLookupByLibrary.simpleMessage(
            "Let\'s start the training with simple questions!\n\n  Remember - to lose patience is to lose the battle!"),
        "greetingScreenTitle": MessageLookupByLibrary.simpleMessage(
            "Ready to start your AI revolution?"),
        "halfWayThere": MessageLookupByLibrary.simpleMessage("Halfway there!"),
        "headquarters": MessageLookupByLibrary.simpleMessage("Headquarters"),
        "healthcare": MessageLookupByLibrary.simpleMessage("Healthcare"),
        "hereYouCanFind":
            MessageLookupByLibrary.simpleMessage("Here, you can find the "),
        "hkId": MessageLookupByLibrary.simpleMessage("HKID"),
        "hkIdNumber": MessageLookupByLibrary.simpleMessage("HKID Number"),
        "hkPhoneNo": MessageLookupByLibrary.simpleMessage("HK Phone Number"),
        "hkResidentQuestion": MessageLookupByLibrary.simpleMessage(
            "Are you a Hong Kong resident? By clicking yes, you acknowledge that you are also a Hong Kong tax resident"),
        "homeMaker": MessageLookupByLibrary.simpleMessage("Homemaker"),
        "homeTrader": MessageLookupByLibrary.simpleMessage("At-Home Trader"),
        "howItWorks": MessageLookupByLibrary.simpleMessage("How It Works"),
        "iAmADirector": MessageLookupByLibrary.simpleMessage(
            "I am a director/employee/licensed person of a licensed corporation registered with the HK Securities and Futures Commission. (Excluding Lora Advisors Limited)"),
        "iAmAFamily": MessageLookupByLibrary.simpleMessage(
            "I am a family member or relative of a senior political figure."),
        "iAmASeniorExecutive": MessageLookupByLibrary.simpleMessage(
            "I am a senior executive at or a 10% or greater shareholder of a publicly traded company."),
        "iAmASeniorPolitical": MessageLookupByLibrary.simpleMessage(
            "I am a senior political figure."),
        "iHaveReadAndAgreed": MessageLookupByLibrary.simpleMessage(
            "I have read, understood, and agree to be bound by LORA Advisors Limited’s account terms, and all other terms, disclosures and disclaimers applicable to me."),
        "iUnderstandSigningAgreement": MessageLookupByLibrary.simpleMessage(
            "I understand I am signing this agreement electronically, and that my electronic signature will have the same effect as physically signing and returning the Customer Agreement."),
        "ifYouveGot": MessageLookupByLibrary.simpleMessage("If you’ve got "),
        "inApp": MessageLookupByLibrary.simpleMessage("In-App"),
        "industry": MessageLookupByLibrary.simpleMessage("Industry"),
        "inputDepositAmount":
            MessageLookupByLibrary.simpleMessage("Input deposit amount"),
        "inputWrongEmail":
            MessageLookupByLibrary.simpleMessage("Input wrong email address"),
        "inputWrongEmailAddress":
            MessageLookupByLibrary.simpleMessage("Input wrong email address"),
        "installationMaintenanceRepair": MessageLookupByLibrary.simpleMessage(
            "Installation, Maintenance, and Repair"),
        "interactive":
            MessageLookupByLibrary.simpleMessage(" - (Interactive) "),
        "introduceBotPlank":
            MessageLookupByLibrary.simpleMessage("Introduce Bot - Plank"),
        "introduceBotPullup":
            MessageLookupByLibrary.simpleMessage("Introduce Bot - Pullup"),
        "introduceBotSquat":
            MessageLookupByLibrary.simpleMessage("Introduce Bot - Squat"),
        "invalidOtp": MessageLookupByLibrary.simpleMessage("Invalid OTP"),
        "invalidPassword":
            MessageLookupByLibrary.simpleMessage("Invalid Password"),
        "investmentAmount":
            MessageLookupByLibrary.simpleMessage("Investment Amount"),
        "investmentPeriod":
            MessageLookupByLibrary.simpleMessage("Investment Period"),
        "investmentPreferences":
            MessageLookupByLibrary.simpleMessage("Investment Preferences"),
        "investmentResultScreenDescription": MessageLookupByLibrary.simpleMessage(
            "You\'re one step closer to AI Investing. \n\nTime to open your account."),
        "investmentResultScreenTitle":
            MessageLookupByLibrary.simpleMessage("I like your style"),
        "investmentStyleWelcomeTitle": MessageLookupByLibrary.simpleMessage(
            "It’s time to define your investment style.Show me what you’re made of!"),
        "isq": MessageLookupByLibrary.simpleMessage(" - (ISQ) "),
        "isqNextButton": MessageLookupByLibrary.simpleMessage(
            "Please press to proceed to the next question"),
        "isqWillHelpMeUnderstandWhatKindOfStocks":
            MessageLookupByLibrary.simpleMessage(
                "Through our chat-style dialogue, we\'ll grasp your investment interests to tailor botstock recommendations for you."),
        "kycRejectedExplanationOfAffiliate": MessageLookupByLibrary.simpleMessage(
            "We do not accept any members who are affiliated with the organisations mentioned above"),
        "kycRejectedScreenTitle": MessageLookupByLibrary.simpleMessage(
            "Sorry ! You are not eligible for Asklora"),
        "kycResultScreenDesc": MessageLookupByLibrary.simpleMessage(
            "You will be informed when your application is approved.\n\nPlease remember to collect your gift."),
        "kycResultScreenTitle": MessageLookupByLibrary.simpleMessage(
            "Your investment account application is under review!"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "lawEnforcementGovernmentProtectiveService":
            MessageLookupByLibrary.simpleMessage(
                "Law Enforcement, Government, Protective Service"),
        "learnBotstockManagement":
            MessageLookupByLibrary.simpleMessage("Learn Botstock Management"),
        "left": MessageLookupByLibrary.simpleMessage("Left"),
        "legal": MessageLookupByLibrary.simpleMessage("Legal"),
        "legalFirstName":
            MessageLookupByLibrary.simpleMessage("Legal English First Name"),
        "legalLastName":
            MessageLookupByLibrary.simpleMessage("Legal English Last Name"),
        "letsGo": MessageLookupByLibrary.simpleMessage("Let’s Go"),
        "letsTrade": MessageLookupByLibrary.simpleMessage("LET\'S TRADE"),
        "licenseeName":
            MessageLookupByLibrary.simpleMessage("Licensee: Chang Yung Ching"),
        "licenseeNumber":
            MessageLookupByLibrary.simpleMessage("CE No.: AFF918"),
        "lifePhysicalSocialService": MessageLookupByLibrary.simpleMessage(
            "Life, Physical and Social Service"),
        "linkPasswordResetIsSent": MessageLookupByLibrary.simpleMessage(
            "Link for Password reset is sent to email."),
        "manageYourBotstock":
            MessageLookupByLibrary.simpleMessage("Manage Your Botstock"),
        "marketCap": MessageLookupByLibrary.simpleMessage("Market Cap"),
        "marketPrice": MessageLookupByLibrary.simpleMessage("Market Price"),
        "masterAiTrading":
            MessageLookupByLibrary.simpleMessage("Master AI Trading"),
        "mediaCommunications":
            MessageLookupByLibrary.simpleMessage("Media and Communications"),
        "middle": MessageLookupByLibrary.simpleMessage("Middle"),
        "milestones": MessageLookupByLibrary.simpleMessage("Milestones"),
        "min": m14,
        "min8Character":
            MessageLookupByLibrary.simpleMessage("min. 8 characters"),
        "nationality": MessageLookupByLibrary.simpleMessage("Nationality"),
        "natureOfBusiness":
            MessageLookupByLibrary.simpleMessage("Nature of Business"),
        "natureOfBusinessDesc": MessageLookupByLibrary.simpleMessage(
            "Nature of Business description"),
        "navBar": MessageLookupByLibrary.simpleMessage("nav bar"),
        "needHelp": MessageLookupByLibrary.simpleMessage("Need help?"),
        "neuroticismLessThan8": MessageLookupByLibrary.simpleMessage(
            "we think you can take on more risk."),
        "neuroticismMoreThan8": MessageLookupByLibrary.simpleMessage(
            "we think you should take on less risk."),
        "newPassword": MessageLookupByLibrary.simpleMessage("New Password"),
        "nextStep": MessageLookupByLibrary.simpleMessage("Next step"),
        "no": MessageLookupByLibrary.simpleMessage(" No"),
        "noTransactions":
            MessageLookupByLibrary.simpleMessage("No Transactions"),
        "noTransactionsYet": MessageLookupByLibrary.simpleMessage(
            "Looks like you haven’t made \nany transactions yet!"),
        "notFeelingIt": MessageLookupByLibrary.simpleMessage(
            "Not feeling it? Try something different."),
        "notTheStockYouWereLooking": MessageLookupByLibrary.simpleMessage(
            "Not the stocks you were looking for?"),
        "noteOnPaymentDetails": MessageLookupByLibrary.simpleMessage(
            "Note:\nWe will work with your bank in order to idenfity your bank account details (account name, bank code, account number). However, we may require additional details from you for transaction verification purposes."),
        "notes": MessageLookupByLibrary.simpleMessage("Notes"),
        "notificationSetting":
            MessageLookupByLibrary.simpleMessage("Notification Setting"),
        "notificationSettings":
            MessageLookupByLibrary.simpleMessage("Notification Settings"),
        "officeHours":
            MessageLookupByLibrary.simpleMessage("09:00-18:00 (HKT)"),
        "officeHoursLabel":
            MessageLookupByLibrary.simpleMessage("Office Hours"),
        "ok": MessageLookupByLibrary.simpleMessage("OK!"),
        "oldPasswordSameWithNewPasswordError":
            MessageLookupByLibrary.simpleMessage(
                "Your new password cannot be the same as your old password"),
        "onBoardingCompletionMessage": MessageLookupByLibrary.simpleMessage(
            "You\'ve completed all the steps to opening an account with Asklora! You\'ll be able to start trading as soon as your account is approved. It usually takes up to 2 business days."),
        "onceYouHaveStarted": MessageLookupByLibrary.simpleMessage(
            "Once you\'ve started, you can resume the process whenever you want."),
        "openAccountNow":
            MessageLookupByLibrary.simpleMessage("Open Account Now"),
        "openInvestmentAccount":
            MessageLookupByLibrary.simpleMessage("Open Investment Account"),
        "opennessLessThan8": MessageLookupByLibrary.simpleMessage(
            "investing can be simple with AI"),
        "opennessMoreThan8": MessageLookupByLibrary.simpleMessage(
            "our technology is perfect for you"),
        "orderCancelled":
            MessageLookupByLibrary.simpleMessage("Order Cancelled"),
        "orderExpired": MessageLookupByLibrary.simpleMessage("Order Expired"),
        "orderPlaced": MessageLookupByLibrary.simpleMessage("Order Placed"),
        "orderRejected": MessageLookupByLibrary.simpleMessage("Order Rejected"),
        "orderRollover": MessageLookupByLibrary.simpleMessage("Order Rollover"),
        "orderStarted": MessageLookupByLibrary.simpleMessage("Order Started"),
        "other": MessageLookupByLibrary.simpleMessage("Other"),
        "otpDigit": MessageLookupByLibrary.simpleMessage("000000 (6 digit)"),
        "otpScreenDescription": m15,
        "otpScreenTitle": MessageLookupByLibrary.simpleMessage("Mobile OTP"),
        "otpSentToYourEmail":
            MessageLookupByLibrary.simpleMessage("OTP code sent to your email"),
        "otpSentToYourPhone": MessageLookupByLibrary.simpleMessage(
            "OTP SMS is sent to your phone"),
        "ourPersonalisedRecommendationsAreUnique":
            MessageLookupByLibrary.simpleMessage(
                "Our personalised recommendations are unique. The recommended Botstocks are based on your risk tolerance, personality, and investment style."),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordChangeSuccess":
            MessageLookupByLibrary.simpleMessage("Password Change Success"),
        "passwordChangeSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Password changed successfully."),
        "passwordDoesNotMatch": MessageLookupByLibrary.simpleMessage(
            "Your password does not match."),
        "passwordLinkHasBeenSent": MessageLookupByLibrary.simpleMessage(
            "A Password reset email has been sent. Please check your email"),
        "payDepositToStartRealTrade": MessageLookupByLibrary.simpleMessage(
            "Pay Deposit to Start Real Trade"),
        "paymentDetails":
            MessageLookupByLibrary.simpleMessage("Payment Details"),
        "pending": MessageLookupByLibrary.simpleMessage("Pending"),
        "performance": MessageLookupByLibrary.simpleMessage("Performance"),
        "personalAIAssistant": MessageLookupByLibrary.simpleMessage(
            "personal AI assistant Asklora! "),
        "personalCareService":
            MessageLookupByLibrary.simpleMessage("Personal Care / Service"),
        "personalInfo": MessageLookupByLibrary.simpleMessage("Personal Info"),
        "personalInfoFormDesc": MessageLookupByLibrary.simpleMessage(
            "Please make sure your name matches the information on your identification document."),
        "personalisation":
            MessageLookupByLibrary.simpleMessage("Personalisation"),
        "personalizationResultScreenTitle": MessageLookupByLibrary.simpleMessage(
            "Alright!\n\nBased on your answers, my technology is perfect for you and you can take on more risks."),
        "phone": MessageLookupByLibrary.simpleMessage("Phone"),
        "pleaseAddAHkBankAccount": MessageLookupByLibrary.simpleMessage(
            "Please add a HK bank account that is under your name; other people\'s bank accounts or joint accounts will not be accepted."),
        "pleaseEnterYouEmail": MessageLookupByLibrary.simpleMessage(
            "Please enter your email. Instructions will be sent to reset your password."),
        "pleaseMakeSureYouHaveFinished": MessageLookupByLibrary.simpleMessage(
            "Please make sure you have finished the transfer and then inform us, if not, your deposit will be delayed."),
        "pleaseMakeSureYouPressSubmit": MessageLookupByLibrary.simpleMessage(
            "Please make sure you press \'SUBMIT\' after you have transferred the funds from your bank."),
        "pleaseProvideYourResidentialAddress": MessageLookupByLibrary.simpleMessage(
            "Please provide your residential address. This will also be your mailing address."),
        "pleaseReadTheAskloraCustomerAgreement":
            MessageLookupByLibrary.simpleMessage(
                "Please read the the Asklora Customer Agreement. You must click on the agreement and check all the boxes in order to proceed."),
        "pleaseSelect": MessageLookupByLibrary.simpleMessage("Please Select"),
        "porAddress": MessageLookupByLibrary.simpleMessage(
            "Proof of Residential Address"),
        "portfolio": MessageLookupByLibrary.simpleMessage("Portfolio"),
        "portfolioBuyingPower": m16,
        "portfolioBuyingPowerToolTip": MessageLookupByLibrary.simpleMessage(
            "Your Buying Power represents the amount of cash that you can use to buy Botstocks. Your Withdrawable Balance and your Buying Power may not always be the same. For example, starting a Botstock will reduce your Buying Power and the amount value will be added to Total Botstock Values. When the Botstock is expired or terminated, the amount will be added to Buying Power and after T + 2, the amount will be also added to Withdrawable Balance. This is called ‘settlement\'."),
        "portfolioCurrentPrice":
            MessageLookupByLibrary.simpleMessage("Current Price"),
        "portfolioDetailButtonCancelBotStock":
            MessageLookupByLibrary.simpleMessage("Cancel Botstock"),
        "portfolioDetailButtonEndBotStock":
            MessageLookupByLibrary.simpleMessage("End Botstock"),
        "portfolioDetailButtonRolloverBotStock":
            MessageLookupByLibrary.simpleMessage("Rollover Botstock"),
        "portfolioDetailChartCaption": m17,
        "portfolioDetailChartEmptyMessage":
            MessageLookupByLibrary.simpleMessage(
                "Performance data will be available once the Botstock starts"),
        "portfolioDetailExpiredAt": m18,
        "portfolioDetailExpiredIn": m19,
        "portfolioDetailKeyInfoAvgLoss":
            MessageLookupByLibrary.simpleMessage("Avg. Loss"),
        "portfolioDetailKeyInfoAvgPeriod":
            MessageLookupByLibrary.simpleMessage("Avg. Period (Days)"),
        "portfolioDetailKeyInfoAvgReturn":
            MessageLookupByLibrary.simpleMessage("Avg. Return"),
        "portfolioDetailKeyInfoBotStockNumberOfRollover":
            MessageLookupByLibrary.simpleMessage("Number of Rollovers"),
        "portfolioDetailKeyInfoBotStockStatus":
            MessageLookupByLibrary.simpleMessage("Botstock Status"),
        "portfolioDetailKeyInfoDaysTillExpiry":
            MessageLookupByLibrary.simpleMessage("Days Till Expiry"),
        "portfolioDetailKeyInfoEndTime":
            MessageLookupByLibrary.simpleMessage("End Time"),
        "portfolioDetailKeyInfoEstimatedMaxLoss":
            MessageLookupByLibrary.simpleMessage("Est. Max Loss %"),
        "portfolioDetailKeyInfoEstimatedMaxProfit":
            MessageLookupByLibrary.simpleMessage("Est, Max Profit %"),
        "portfolioDetailKeyInfoEstimatedStopLoss":
            MessageLookupByLibrary.simpleMessage("Est. Stop Loss %"),
        "portfolioDetailKeyInfoEstimatedTakeProfit":
            MessageLookupByLibrary.simpleMessage("Est. Take Profit %"),
        "portfolioDetailKeyInfoStartTime":
            MessageLookupByLibrary.simpleMessage("Start Time"),
        "portfolioDetailKeyInfoTitle":
            MessageLookupByLibrary.simpleMessage("Key Info"),
        "portfolioDetailPerformanceBotAssetsInStock":
            MessageLookupByLibrary.simpleMessage("Stock Holding %"),
        "portfolioDetailPerformanceBotAssetsInStockTooltip":
            MessageLookupByLibrary.simpleMessage(
                "Represents how much stock the bot is holding in terms of %. For example, for a HKD10,000 investment, if your Stock Values are HKD4,000 and your Cash is HKD6,000, your Stock Holding % is 40%."),
        "portfolioDetailPerformanceBotStockValues":
            MessageLookupByLibrary.simpleMessage("Botstock Values (HKD)"),
        "portfolioDetailPerformanceCash":
            MessageLookupByLibrary.simpleMessage("Cash (HKD)"),
        "portfolioDetailPerformanceInvestmentAmount":
            MessageLookupByLibrary.simpleMessage("Inv. Amount (HKD)"),
        "portfolioDetailPerformanceNumberOfShares":
            MessageLookupByLibrary.simpleMessage("No. of Shares"),
        "portfolioDetailPerformanceNumberOfSharesTooltip":
            MessageLookupByLibrary.simpleMessage(
                "Indicates how many shares of a company are currently owned by you."),
        "portfolioDetailPerformanceStockValues":
            MessageLookupByLibrary.simpleMessage("Stock Values (HKD)"),
        "portfolioDetailPerformanceTitle":
            MessageLookupByLibrary.simpleMessage("Performance"),
        "portfolioDetailPerformanceTotalPL":
            MessageLookupByLibrary.simpleMessage("Total P&L"),
        "portfolioPopUpContinueAccountOpeningSubTitle":
            MessageLookupByLibrary.simpleMessage(
                "You still need to complete your account opening until you can start trading. "),
        "portfolioPopUpContinueAccountOpeningTitle":
            MessageLookupByLibrary.simpleMessage("Continue Account Opening"),
        "portfolioPopUpCreateAnAccountSubTitle":
            MessageLookupByLibrary.simpleMessage(
                "You can manage all your investments here after you start trading. Create an account and start trading."),
        "portfolioPopUpCreateAnAccountTitle":
            MessageLookupByLibrary.simpleMessage(
                "Create an Account and Start Trading!"),
        "portfolioPopUpDefineInvestmentSubTitle":
            MessageLookupByLibrary.simpleMessage(
                "Looks like you haven\'t defined your Investment Style yet. Let\'s go and see what kind of Botstocks suit you best!"),
        "portfolioPopUpDefineInvestmentTitle":
            MessageLookupByLibrary.simpleMessage(
                "Define Your Investment Style"),
        "portfolioPopUpFundAccountSubTitle": MessageLookupByLibrary.simpleMessage(
            "Looks like you haven\'t funded your account yet. Deposit HKD 10,000 to activate your account."),
        "portfolioPopUpFundAccountTitle":
            MessageLookupByLibrary.simpleMessage("Fund your account"),
        "portfolioPopUpNoTradingHasStartedTitle":
            MessageLookupByLibrary.simpleMessage("No trading has started!"),
        "portfolioPopUpNoTradingHasStartedtSubTitle":
            MessageLookupByLibrary.simpleMessage(
                "You can manage all your investments here after you start trading. "),
        "portfolioPopUpPendingReviewSubTitle": MessageLookupByLibrary.simpleMessage(
            "You can manage all your investments here after your account has been opened!"),
        "portfolioPopUpPendingReviewTitle":
            MessageLookupByLibrary.simpleMessage(
                "Your Account is Pending Review"),
        "portfolioPopUpRedeemYourBotstockSubTitle":
            MessageLookupByLibrary.simpleMessage(
                "Looks like you haven\'t claimed your free Botstock yet. Let\'s get trading right away!"),
        "portfolioPopUpRedeemYourBotstockTitle":
            MessageLookupByLibrary.simpleMessage("Redeem Your Free Botstock"),
        "portfolioTotalBotStock": m20,
        "portfolioTotalPL": MessageLookupByLibrary.simpleMessage("Total P/L"),
        "portfolioTotalValue":
            MessageLookupByLibrary.simpleMessage("Total Portfolio Value"),
        "portfolioWithdrawableAmount": m21,
        "portfolioYourBotStock":
            MessageLookupByLibrary.simpleMessage("Your Botstocks"),
        "ppiGotIt": MessageLookupByLibrary.simpleMessage("Got It"),
        "pressBackAgain": MessageLookupByLibrary.simpleMessage(
            "Press back again to exit Asklora"),
        "pressToRedoISQ":
            MessageLookupByLibrary.simpleMessage("Press to redo ISQ"),
        "prevClose": MessageLookupByLibrary.simpleMessage("Prev Close"),
        "privacyEvaluation":
            MessageLookupByLibrary.simpleMessage("Privacy Evaluation"),
        "privacyFailedScreenDescription": MessageLookupByLibrary.simpleMessage(
            "Most likely, your risk score is too low to meet SFC requirements.\n\nIf you made a mistake and did not answer the questions correctly, please try again."),
        "privacyFailedScreenTitle": MessageLookupByLibrary.simpleMessage(
            "I\'m afraid you\'re not eligible for Asklora yet."),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "privacySuccessScreenDescription": MessageLookupByLibrary.simpleMessage(
            "Age is just a number, but your personality is what sets you apart.\n\nAnswer a few personality questions, and I\'ll help you find investments that fit your style."),
        "privacySuccessScreenTitle":
            MessageLookupByLibrary.simpleMessage("I appreciate your honesty."),
        "productionManufacturing": MessageLookupByLibrary.simpleMessage(
            "Production and Manufacturing"),
        "pushNotification":
            MessageLookupByLibrary.simpleMessage("Push-Notification"),
        "reSendOtp": m22,
        "readyToGo": MessageLookupByLibrary.simpleMessage("Ready to go?"),
        "recommendations":
            MessageLookupByLibrary.simpleMessage("Recommendations"),
        "redeemYourBotstockNow":
            MessageLookupByLibrary.simpleMessage("Redeem Your Botstock Now"),
        "rejected": MessageLookupByLibrary.simpleMessage("Rejected"),
        "relearn": MessageLookupByLibrary.simpleMessage("relearn"),
        "rememberYouCan":
            MessageLookupByLibrary.simpleMessage("Remember, you can always "),
        "requestedToEnd":
            MessageLookupByLibrary.simpleMessage("Requested To End"),
        "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
        "resetPasswordSuccessful":
            MessageLookupByLibrary.simpleMessage("Password Reset Successful"),
        "resetPasswordSuccessfulMessage": MessageLookupByLibrary.simpleMessage(
            "Your password has been reset. Please go back to the Login page and login again."),
        "resultOfPersonalizationQuestion": m23,
        "retakeInvestmentStyle":
            MessageLookupByLibrary.simpleMessage("Retake Investment Style"),
        "retired": MessageLookupByLibrary.simpleMessage("Retired"),
        "returningUserDepositNotes": MessageLookupByLibrary.simpleMessage(
            "We will work with your bank in order to identify your bank account details (account name, bank code, account number). However, we may require additional details from you for transaction verification purposes."),
        "reviewYourTradeSummary": MessageLookupByLibrary.simpleMessage(
            "Review your trade summary and hit "),
        "right": MessageLookupByLibrary.simpleMessage("Right"),
        "riskDisclosureStatement":
            MessageLookupByLibrary.simpleMessage("Risk Disclosure Statement"),
        "riskDisclosureStatementAcknowledgement":
            MessageLookupByLibrary.simpleMessage(
                "I have read, understood, and agree with the Risk Disclosure Statement."),
        "riskDisclosureStatementLabel":
            MessageLookupByLibrary.simpleMessage("Risk Disclosure Statement"),
        "riskDisclosureStatementString": MessageLookupByLibrary.simpleMessage(
            "1. The prices of securities fluctuate, sometimes dramatically. The price of a security may move up or down, and may become valueless. It is as likely that losses will be incurred rather than profit made as a result of buying and selling securities. Investors should not only base on this marketing material to make any investment decision, you should carefully consider whether the investment products or services are suitable for you according to your investment experience, purpose, risk tolerance, financial or related conditions. If you have any questions, please contact us or obtain independent advice.\n\n2. Investment in foreign securities carries additional risks not generally associated with securities in the domestic market. The value or income of foreign securities may be more volatile and could be adversely affected by changes in currency rates of exchange, foreign taxation practices, foreign laws, government practices, regulations, and political events. You may find it more difficult to liquidate investments in foreign securities where they have limited liquidity in the relevant market. Foreign laws, government practices, and regulations may also affect the transferability of foreign securities. Timely and reliable information about the value or the extent of the risks of foreign securities may not be readily available at all times.\n\n3. You acknowledge that you have fully understood the implications of the risks associated with the Electronic Trading Service as set out in the Client Agreement"),
        "saveForLater": MessageLookupByLibrary.simpleMessage("Save For Later"),
        "sectors": MessageLookupByLibrary.simpleMessage("Sector(s)"),
        "seeMyRecommendations":
            MessageLookupByLibrary.simpleMessage("See My Recommendations"),
        "selfEmployed": MessageLookupByLibrary.simpleMessage("Self-Employed"),
        "sell": MessageLookupByLibrary.simpleMessage("Sell"),
        "sendIcon": MessageLookupByLibrary.simpleMessage("send icon "),
        "sendOtp": MessageLookupByLibrary.simpleMessage("SEND OTP"),
        "setUpFinancialProfile":
            MessageLookupByLibrary.simpleMessage("Set Up Financial Profile"),
        "setupPersonalInfo":
            MessageLookupByLibrary.simpleMessage("Set up Personal Info"),
        "shares": MessageLookupByLibrary.simpleMessage("Shares"),
        "signAgreements":
            MessageLookupByLibrary.simpleMessage("Sign Agreements"),
        "signIn": MessageLookupByLibrary.simpleMessage("Sign In"),
        "signInElectronically": MessageLookupByLibrary.simpleMessage(
            "Sign this electronically by typing your name exactly as shown below."),
        "signOutConfirmation": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to sign out ?"),
        "signUpTitle": MessageLookupByLibrary.simpleMessage(
            "Start your AI revolution with\nAsklora. Go crush it."),
        "simplyTypeAQuestion": MessageLookupByLibrary.simpleMessage(
            "Simply type a question and tap the "),
        "sourceOfWealth":
            MessageLookupByLibrary.simpleMessage("Source of Wealth"),
        "startABotstock":
            MessageLookupByLibrary.simpleMessage("Start A Botstock"),
        "startAgain": MessageLookupByLibrary.simpleMessage("Start Again"),
        "startAnotherInvestments":
            MessageLookupByLibrary.simpleMessage("Start another investment"),
        "startBotStockAcknowledgement": m24,
        "startDate": MessageLookupByLibrary.simpleMessage("Start Date"),
        "startInvesting":
            MessageLookupByLibrary.simpleMessage("Start Investing"),
        "startInvestingOnMilestone":
            MessageLookupByLibrary.simpleMessage("Start investing"),
        "startsAt": MessageLookupByLibrary.simpleMessage("Starts at"),
        "status": MessageLookupByLibrary.simpleMessage("Status"),
        "student": MessageLookupByLibrary.simpleMessage("Student"),
        "submitApplication":
            MessageLookupByLibrary.simpleMessage("Submit Application"),
        "subscription": MessageLookupByLibrary.simpleMessage("Subscription"),
        "summary": MessageLookupByLibrary.simpleMessage("Summary"),
        "summaryAgreementInformation": MessageLookupByLibrary.simpleMessage(
            "The agreements will become binding subject to the approval of the information submitted by you. \n\nIf there is a material change to this information, please contact loracares@asklora.ai as soon as possible"),
        "suspendedScreenSubTitle": MessageLookupByLibrary.simpleMessage(
            "Your account has been suspended and is pending investigation from us. If you have any questions about your account, please contact our customer service team."),
        "suspendedScreenTitle":
            MessageLookupByLibrary.simpleMessage("Account Suspended"),
        "swiftCode": MessageLookupByLibrary.simpleMessage("Swift Code"),
        "takePhotoBack": MessageLookupByLibrary.simpleMessage(
            "Take a photo of the front of your HKID"),
        "takePhotoFront": MessageLookupByLibrary.simpleMessage(
            "Take a photo of the front of your HKID"),
        "takeSelfie": MessageLookupByLibrary.simpleMessage("Take a selfie"),
        "tapAnyWhere":
            MessageLookupByLibrary.simpleMessage("Tap anywhere to continue"),
        "taxAgreementCheckboxDesc": MessageLookupByLibrary.simpleMessage(
            "By checking this box, you consent to the collection and distribution of tax forms in an electronic format in lieu of paper"),
        "taxAgreementDesc1": MessageLookupByLibrary.simpleMessage(
            "Under penalties of perjury, I declare that I have examined the information in lines 1-7 and to the best of my knowledge and belief it is true, correct, and complete. I further certify under penalties of perjury that:"),
        "taxAgreementDesc2": MessageLookupByLibrary.simpleMessage(
            "Furthermore, I authorize this form to be provided to any withholding agent that has control, receipt, or custody of the income of which I am the beneficial owner or any withholding agent that can disburse or make payments of the income of which I am the beneficial owner. I agree I will submit a new form within 30 days if any certification made on this form becomes incorrect."),
        "taxAgreementDesc3": MessageLookupByLibrary.simpleMessage(
            "The US Internal Revenue Service does not require your consent to any provisions of this document other than the certifications required to establish your status as a non-U.S. person, and if applicable, obtain a reduced rate of witholding."),
        "taxAgreementDescPoint1": MessageLookupByLibrary.simpleMessage(
            "I am the individual that is the beneficial owner (or am authorized to sign for the individual that is the beneficial owner) of all the income or proceeds to which this form relates or am using this form to document myself for chapter 4 purposes;"),
        "taxAgreementDescPoint2": MessageLookupByLibrary.simpleMessage(
            "The person named on line 1 of this form is not a U.S. person;"),
        "taxAgreementDescPoint3":
            MessageLookupByLibrary.simpleMessage("This form relates to:"),
        "taxAgreementDescPoint3SubPoint1": MessageLookupByLibrary.simpleMessage(
            "income not effectively connected with the conduct of a trade or business in the United States;"),
        "taxAgreementDescPoint3SubPoint2": MessageLookupByLibrary.simpleMessage(
            "income effectively connected with the conduct of a trade or business in the United States but is not subject to tax under an applicable income tax treaty;"),
        "taxAgreementDescPoint3SubPoint3": MessageLookupByLibrary.simpleMessage(
            "the partner\'s share of a partnership\'s effectively connected taxable income;"),
        "taxAgreementDescPoint3SubPoint4": MessageLookupByLibrary.simpleMessage(
            "or the partner\'s amount realized from the transfer of a partnership interest subject to withholding under section 1446(f);"),
        "taxAgreementDescPoint4": MessageLookupByLibrary.simpleMessage(
            "The person named on line 1 of this form is a resident of the treaty country listed on line 9 of the form (if any) within the meaning of the income tax treaty between the United States and that country;"),
        "taxAgreementDescPoint5": MessageLookupByLibrary.simpleMessage(
            "and For broker transactions or barter exchanges, the beneficial owner is an exempt foreign person as defined in the instructions to IRS Form W-8BEN."),
        "taxAgreementSignatureDesc": MessageLookupByLibrary.simpleMessage(
            "By typing my signature and clicking ‘Agree’ below, I confirm that:"),
        "taxAgreementSignatureDescPoint1": MessageLookupByLibrary.simpleMessage(
            "(1) All information and/or documentation provided by me during the account application process is accurate, complete and up-to-date; "),
        "taxAgreementSignatureDescPoint2": MessageLookupByLibrary.simpleMessage(
            "(2) I have read and understood all of the information provided to me by LORA Advisors;"),
        "taxAgreementSignatureDescPoint3": MessageLookupByLibrary.simpleMessage(
            "(3) I consent and agree to the terms of all the above agreements and disclosures provided to me during the account application process: and"),
        "taxAgreementSignatureDescPoint4": MessageLookupByLibrary.simpleMessage(
            "(4) I understand and agree that my electronic signature is the legal equivalent of a manual written signature."),
        "taxAgreementSignatureTitle":
            MessageLookupByLibrary.simpleMessage("Signature"),
        "tellMeMore": MessageLookupByLibrary.simpleMessage("Tell Me More"),
        "terminateAccount":
            MessageLookupByLibrary.simpleMessage("Terminate Account"),
        "termsAndConditions":
            MessageLookupByLibrary.simpleMessage("Terms and Conditions"),
        "theAmountMustMatch": MessageLookupByLibrary.simpleMessage(
            "The amount must match with the actual transferred amount."),
        "theAmountMustMatchWithPor": MessageLookupByLibrary.simpleMessage(
            "The amount must match with the proof of remittance."),
        "theItemYouWillNeed":
            MessageLookupByLibrary.simpleMessage("The items you will need…"),
        "thePorShouldShowYourBank": MessageLookupByLibrary.simpleMessage(
            "The proof of remittance should show your bank account number, full name, and amount."),
        "theProofOfRemittanceShouldShowYourBankAccount":
            MessageLookupByLibrary.simpleMessage(
                "The proof of remittance should show your bank account number, full name, and amount."),
        "thisInteractiveGraph": MessageLookupByLibrary.simpleMessage(
            "This interactive graph shows the Botstock’s past "),
        "throughoutYourInvestmentJourney": MessageLookupByLibrary.simpleMessage(
            "Throughout your investment journey, you’ll see Lora on your bottom nav bar. Click on Lora at anytime to get advice or to ask anything related to finance."),
        "timeCompleted": MessageLookupByLibrary.simpleMessage("Time Completed"),
        "timeForInvestmentStyleQuestion": MessageLookupByLibrary.simpleMessage(
            "Now for the Investment Style Questions (ISQ)! These questions will feel more ChatGPT style."),
        "timeRequested": MessageLookupByLibrary.simpleMessage("Time Requested"),
        "to": MessageLookupByLibrary.simpleMessage("To"),
        "toAskAnyOtherQuestion": MessageLookupByLibrary.simpleMessage(
            "to ask any other questions you might have"),
        "toExecuteIt": MessageLookupByLibrary.simpleMessage(" to execute it!"),
        "toGiveYou": MessageLookupByLibrary.simpleMessage(
            "to give you a better idea of its trading potential!"),
        "toGoToDifferentPages":
            MessageLookupByLibrary.simpleMessage("to go to different pages."),
        "toOpenLora": MessageLookupByLibrary.simpleMessage(
            " to open Lora and get more details about your investment!"),
        "toStartAConversation": MessageLookupByLibrary.simpleMessage(
            "to start a conversation. Tap the icon again to dismiss Asklora"),
        "tokenInvalid": MessageLookupByLibrary.simpleMessage(
            "Token is invalid or expired."),
        "tooltipBotDetailsEstMaxLoss": MessageLookupByLibrary.simpleMessage(
            "This is the estimated maximum loss % level for the Bot strategy. The Bot will try to limit losses to this % level. This is an estimated level."),
        "tooltipBotDetailsEstMaxProfit": MessageLookupByLibrary.simpleMessage(
            "This is the estimated maximum target profit % level for the Bot strategy. The Bot will try to close the trade (sell stocks) and capture profits when profits reach this % level. This is an estimated level."),
        "tooltipBotDetailsEstStopLoss": MessageLookupByLibrary.simpleMessage(
            "The return % where the Plank Bot will sell try and limit losses. The Plank Bot will try to close the trade (sell stocks) when the stock reaches this level below your initial investment level."),
        "tooltipBotDetailsEstTakeProfit": MessageLookupByLibrary.simpleMessage(
            "The return % where the Plank Bot will sell to try and capture profits. The Plank Bot will try to close the trade (sell stocks) when the stock reaches this level above your initial investment level."),
        "tooltipBotDetailsInvestmentPeriod": MessageLookupByLibrary.simpleMessage(
            "The duration you set for Botstock where the Bot will automatically buy and sell."),
        "tooltipBotDetailsStartDate": MessageLookupByLibrary.simpleMessage(
            "Lora\'s date to start the Botstocks"),
        "tooltipDescOfTickerDetailsTutorial": MessageLookupByLibrary.simpleMessage(
            "Here\'s a brief description of the bot and stock you\'ve chosen"),
        "totalAmount": MessageLookupByLibrary.simpleMessage("Total amount"),
        "totalPnlIs": MessageLookupByLibrary.simpleMessage("Total P/L is"),
        "trade": MessageLookupByLibrary.simpleMessage("Trade"),
        "tradeCancelledSubtitle": MessageLookupByLibrary.simpleMessage(
            "The trade has been cancelled and your investment amount has been returned to your account"),
        "tradeCancelledTitle":
            MessageLookupByLibrary.simpleMessage("Trade Cancelled"),
        "tradeFee": MessageLookupByLibrary.simpleMessage("Trade Fee"),
        "tradeRequestSubmitted":
            MessageLookupByLibrary.simpleMessage("Trade Request Submitted"),
        "tradeSummary": MessageLookupByLibrary.simpleMessage("Trade Summary"),
        "tradeWithANewBotstock":
            MessageLookupByLibrary.simpleMessage("Trade with a New Botstock"),
        "tradeWithBots":
            MessageLookupByLibrary.simpleMessage("Trade with Bots"),
        "tradeWithYourFirstBotstock": MessageLookupByLibrary.simpleMessage(
            "Trade with Your First Botstock"),
        "transactionFee":
            MessageLookupByLibrary.simpleMessage("Transaction fee"),
        "transactionHistory":
            MessageLookupByLibrary.simpleMessage("Transaction History"),
        "transactionHistoryTabAll": MessageLookupByLibrary.simpleMessage("All"),
        "transactionHistoryTabOrders":
            MessageLookupByLibrary.simpleMessage("Orders"),
        "transactionHistoryTabTransfer":
            MessageLookupByLibrary.simpleMessage("Transfer"),
        "transactionHistoryTitle":
            MessageLookupByLibrary.simpleMessage("Transaction History"),
        "transactionHistoryToday":
            MessageLookupByLibrary.simpleMessage("Today"),
        "transferAtLeastWithMinimumDeposit": m25,
        "transferAtLeastWithNoMinimumDeposit": MessageLookupByLibrary.simpleMessage(
            "Transfer to Asklora bank account from the same bank account you used."),
        "transferFundToAsklora":
            MessageLookupByLibrary.simpleMessage("Transfer funds to Asklora"),
        "transferInitialFundToAsklora": MessageLookupByLibrary.simpleMessage(
            "Transfer initial funds to Asklora"),
        "transferTo": MessageLookupByLibrary.simpleMessage("Transfer to"),
        "transportationMaterialMoving": MessageLookupByLibrary.simpleMessage(
            "Transportation and Material Moving"),
        "twoWeekPerformance":
            MessageLookupByLibrary.simpleMessage("2 weeks performance "),
        "unEmployed": MessageLookupByLibrary.simpleMessage("Unemployed"),
        "unableToProcessDepositSubTitle": MessageLookupByLibrary.simpleMessage(
            "We\'re having some trouble processing your deposit request. Please try again"),
        "unableToProcessDepositTitle":
            MessageLookupByLibrary.simpleMessage("Unable to Process Deposit"),
        "unableToProcessWithdrawalSubTitle": MessageLookupByLibrary.simpleMessage(
            "We\'re having some trouble processing your withdrawal request. Please try again"),
        "unableToProcessWithdrawalTitle": MessageLookupByLibrary.simpleMessage(
            "Unable to Process Withdrawal"),
        "understood": MessageLookupByLibrary.simpleMessage("Understood!"),
        "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
        "updatedAt": m26,
        "uploadAddressProof":
            MessageLookupByLibrary.simpleMessage("Upload Address Proof"),
        "uploadProofOfRemittance":
            MessageLookupByLibrary.simpleMessage("Upload proof of remittance"),
        "usResidentQuestion": MessageLookupByLibrary.simpleMessage(
            "Are you a United States tax resident, green card holder, or citizen?"),
        "useThe": MessageLookupByLibrary.simpleMessage("Use the"),
        "userId": MessageLookupByLibrary.simpleMessage("User ID"),
        "userNotFound": MessageLookupByLibrary.simpleMessage("User Not Found"),
        "verifyIdentity":
            MessageLookupByLibrary.simpleMessage("Verify identity"),
        "verifyNow": MessageLookupByLibrary.simpleMessage("Verify Now"),
        "verifyOtpSuccess":
            MessageLookupByLibrary.simpleMessage("Verify OTP Success"),
        "version": MessageLookupByLibrary.simpleMessage("Version"),
        "viewDepositGuide":
            MessageLookupByLibrary.simpleMessage("View Deposit Guide"),
        "w8benForm": MessageLookupByLibrary.simpleMessage("W-8BEN Form"),
        "weAcceptHKDOnly":
            MessageLookupByLibrary.simpleMessage("We accept HKD only."),
        "weAcceptUtilityBill": MessageLookupByLibrary.simpleMessage(
            "(We accept utility bill, bank statement, or government correspondence within the last 3 months)"),
        "weNeedToVerifyYourId": MessageLookupByLibrary.simpleMessage(
            "We\'ll need to verify your identity via your HKID."),
        "weWillOnlyAcceptDepositViaBankTransfer":
            MessageLookupByLibrary.simpleMessage(
                "We will only accept deposits via bank transfer (wire/FPS) from your own account."),
        "weWillOnlyAcceptHKD":
            MessageLookupByLibrary.simpleMessage("We will only accept HKD."),
        "weWillTakeInformationCollectedFromYour": m27,
        "website": MessageLookupByLibrary.simpleMessage("Website"),
        "welcomeScreenFirstBenefit": MessageLookupByLibrary.simpleMessage(
            "Guidance from your own personal AI"),
        "welcomeScreenSecondBenefit":
            MessageLookupByLibrary.simpleMessage("Personalised Experience"),
        "welcomeScreenSubTitle": MessageLookupByLibrary.simpleMessage(
            "Say Goodbye to bad investing habits and embrace your new AI assistant, Asklora!"),
        "welcomeScreenThirdBenefit": MessageLookupByLibrary.simpleMessage(
            "Automated trading strategies"),
        "welcomeScreenTitle": MessageLookupByLibrary.simpleMessage(
            "Get your Investments in Shape"),
        "wireTransfer": MessageLookupByLibrary.simpleMessage("Wire Transfer"),
        "withdraw": MessageLookupByLibrary.simpleMessage("Withdraw"),
        "withdrawalAmount":
            MessageLookupByLibrary.simpleMessage("Withdrawal Amount"),
        "withdrawalHistory":
            MessageLookupByLibrary.simpleMessage("Withdrawal History"),
        "withdrawalRequestSubmittedSubTitle": MessageLookupByLibrary.simpleMessage(
            "You will be informed via email and app notification as soon as the funds are paid to your account."),
        "withdrawalRequestSubmittedTitle": MessageLookupByLibrary.simpleMessage(
            "Withdrawal Request Submitted"),
        "withdrawalWorkingDays": MessageLookupByLibrary.simpleMessage(
            "Your withdrawal can take up to 2 working days."),
        "yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "youCanClickOn":
            MessageLookupByLibrary.simpleMessage("You can click on "),
        "yourAddressProofMustContainFullName": MessageLookupByLibrary.simpleMessage(
            "Your address proof must contain your full name, full residential address and the issuing agency.\n\nWe accept water/electricity/gas bills, bank statement, or government correspondence within the last 3 months."),
        "yourBankAccount":
            MessageLookupByLibrary.simpleMessage("Your Bank Account"),
        "yourBankAccountIsUnderReview": m28,
        "yourDepositCanTakeUp2WorkingDays":
            MessageLookupByLibrary.simpleMessage(
                "Your deposit can take up to 2 working days"),
        "yourDepositMayBeRejected": MessageLookupByLibrary.simpleMessage(
            "Your deposit may be rejected if the informed amount is different from the actual transferred amount."),
        "yourPasswordHasBeenChanged": MessageLookupByLibrary.simpleMessage(
            "Your password has been changed"),
        "yourPaymentInformationIsUnderReview": MessageLookupByLibrary.simpleMessage(
            "Your payment information is under review. Your bank account details will be shown here once your account is approved. please note it can take up to 2 working days for the approval process.")
      };
}
