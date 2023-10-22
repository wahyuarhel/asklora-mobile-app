// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  static String m0(name) => "離AI投資之道\n又近左一步，${name}！";

  static String m1(name) => "進度好好吖,\n${name}！";

  static String m2(availableAmount, minimumAmount) =>
      "你有 ${availableAmount} 可供使用，每單交易最小金額為 ${minimumAmount} 。";

  static String m3(availableAmount) => "你有 ${availableAmount} 可供使用，";

  static String m4(minimumAmount) => "每單交易最小金額為 ${minimumAmount} 。";

  static String m5(amount) => "投資額及交易費用 (HKD${amount}) 會自動轉至你嘅賬戶。";

  static String m6(botInformation) =>
      "你可以選擇依家結束，所有 ${botInformation} 嘅交易活動會立即停止。";

  static String m7(minimumAmount) => "每單交易最小金額為 ${minimumAmount} 。";

  static String m8(expiryTime) => "更新到期時間為 ${expiryTime}";

  static String m9(amount) => "基於監管要求，如要更改銀行戶口，你必須重新入金最少HKD\$${amount}";

  static String m10(emailAddress) =>
      "已發送電子郵件至\n ${emailAddress}\n\n請用手機點擊開通連結！";

  static String m11(botName, botSymbol) =>
      "${botName} ${botSymbol} will end when the US market opens";

  static String m12(time) => "現時匯率: HKD 1 = USD 0.137 (於 HKT ${time})";

  static String m13(minDeposit) =>
      "複製 Asklora 銀行資料，並從你銀行戶口透過 FPS 或 電匯 轉賬不少於 HK\$${minDeposit}。";

  static String m14(minute) => " ~${minute} 分鐘";

  static String m15(phoneNumber) =>
      "我們已透過SMS傳送一組號碼以核實你所登記電話，請於下面輸入一次性密碼 (OTP)。";

  static String m16(currency) => "購買力 (${currency})";

  static String m17(bot, startDate, endDate, duration) =>
      "${bot} 於過去 ${duration} 星期之表現  (${startDate} - ${endDate})";

  static String m18(dateTime) => "到期日期 ${dateTime}";

  static String m19(dateTime) => "${dateTime}日後到期";

  static String m20(currency) => "Botstock 總價值 (${currency})";

  static String m21(currency) => "可提取金額 (${currency})";

  static String m22(seconds) => "在${seconds}秒後重發 ";

  static String m23(opennessScore, neuroticismScore, extrovertScore) =>
      "${opennessScore} ${neuroticismScore}\n\n${extrovertScore}";

  static String m24(botName, botSymbol) =>
      "${botName} ${botSymbol} will start when the US market opens";

  static String m25(minDeposit) =>
      "請轉賬最少 HK\$${minDeposit} 至 Asklora 銀行戶口。任何少於 HK\$${minDeposit} 的首次入金均會被拒收，並會被徵收手續費。";

  static String m26(updated) => "於 ${updated} 更新";

  static String m27(minDeposit) =>
      "我們會提取由你銀行透過 API 或匯款通知書收集的資訊， 確定你指定的銀行戶口。我們只會接受透過此指定戶口進行所有將來的入金與提取。你可轉換指定銀行戶口，但你需要完成最少匯款 HK\$${minDeposit} 以通過相同的認證。";

  static String m28(dateTime) => "銀行賬戶正在審批當中，並會於${dateTime} 完成。";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "AskloraAgreementFile":
            MessageLookupByLibrary.simpleMessage("Asklora 客戶協議.pdf"),
        "LoraAi": MessageLookupByLibrary.simpleMessage("Lora AI"),
        "about": MessageLookupByLibrary.simpleMessage("關於"),
        "aboutAsklora": MessageLookupByLibrary.simpleMessage("關於 Asklora"),
        "aboutYourInvestment":
            MessageLookupByLibrary.simpleMessage("關於投資嘅問題，可以點擊此處 "),
        "acceptedSignature":
            MessageLookupByLibrary.simpleMessage("Accepted signature(s):"),
        "accountInformation": MessageLookupByLibrary.simpleMessage("帳戶資訊"),
        "accountIsNotActive": MessageLookupByLibrary.simpleMessage(
            "Your account is not active yet."),
        "accountName": MessageLookupByLibrary.simpleMessage("戶口名稱"),
        "accountNumber": MessageLookupByLibrary.simpleMessage("戶口號碼"),
        "accountOpeningAndDeposit":
            MessageLookupByLibrary.simpleMessage("以下部分係確保你帳戶安全，我哋你的將安全放在第一位。"),
        "accountSettings": MessageLookupByLibrary.simpleMessage("帳戶設定"),
        "active": MessageLookupByLibrary.simpleMessage("交易中"),
        "activities": MessageLookupByLibrary.simpleMessage("交易記錄"),
        "addressProof": MessageLookupByLibrary.simpleMessage("住址證明"),
        "afterPayDepositHeaderTitle":
            MessageLookupByLibrary.simpleMessage("投資賬戶\n即將 Ready！"),
        "agree": MessageLookupByLibrary.simpleMessage("Agree"),
        "agreed": MessageLookupByLibrary.simpleMessage("Agreed"),
        "agreements": MessageLookupByLibrary.simpleMessage("Agreements"),
        "aiIsqWelcomeSubTitle":
            MessageLookupByLibrary.simpleMessage("界定你嘅投資風格先！"),
        "aiIsqWelcomeTitle":
            MessageLookupByLibrary.simpleMessage("想知Asklora有咩投資秘技？"),
        "allSettings": MessageLookupByLibrary.simpleMessage("設定"),
        "almostFinished": MessageLookupByLibrary.simpleMessage("馬上就好"),
        "anyQuestion": MessageLookupByLibrary.simpleMessage("任何"),
        "architectureEngineering":
            MessageLookupByLibrary.simpleMessage("Architecture / Engineering"),
        "artDesign": MessageLookupByLibrary.simpleMessage("Arts / Design"),
        "askMeAnythingRelatedToFinance":
            MessageLookupByLibrary.simpleMessage("有咩投資問題都可以問我！"),
        "askNameScreenPlaceholder": MessageLookupByLibrary.simpleMessage(
            "Hi! 我係 Lora，\n你嘅 AI 顧問。\n\n準備好向投資目標進發未？\n我可以點叫你？"),
        "askNameScreenTextFieldHint":
            MessageLookupByLibrary.simpleMessage("你的名字"),
        "askloraCustomerAgreement":
            MessageLookupByLibrary.simpleMessage("Asklora Customer Agreement"),
        "askloraWireDetails":
            MessageLookupByLibrary.simpleMessage("Asklora 電匯 詳情"),
        "askloraYouUltimateFinancialAdvisor":
            MessageLookupByLibrary.simpleMessage("Asklora.\n你嘅 AI 投資顧問"),
        "atLeast1Lowercase":
            MessageLookupByLibrary.simpleMessage("最少 1 個小寫英文字母"),
        "atLeast1Number": MessageLookupByLibrary.simpleMessage("最少 1 個數字"),
        "atLeast1Uppercase":
            MessageLookupByLibrary.simpleMessage("最少 1 個大寫英文字母"),
        "backToLogin": MessageLookupByLibrary.simpleMessage("返回登入"),
        "bankAccountNumber": MessageLookupByLibrary.simpleMessage("銀行戶口號碼"),
        "bankName": MessageLookupByLibrary.simpleMessage("銀行名稱"),
        "bankNumber": MessageLookupByLibrary.simpleMessage("銀行號碼"),
        "beforeDepositHeaderTitle": m0,
        "beforeKYCHeaderTitle": m1,
        "bestSuitedFor": MessageLookupByLibrary.simpleMessage("最適合"),
        "botDuration": MessageLookupByLibrary.simpleMessage("Bot 期限"),
        "botExplanationScreenTitle": MessageLookupByLibrary.simpleMessage(
            "Botstock 由一隻股票及一個 Bot 組成。 每一個 Bot 各代表一個獨一無二的 AI 投資策略。而Lora會幫你管理策略。"),
        "botManagementFee": MessageLookupByLibrary.simpleMessage("Bot 管理費用"),
        "botManagementFeeTooltip": MessageLookupByLibrary.simpleMessage(
            "The Bot management fee is the monthly fee that you pay for a Bot (HKD40). If you’re on the Core Plan, then there are no management fees, as it’s included in your subscription!"),
        "botRecommendationScreenTitle":
            MessageLookupByLibrary.simpleMessage("最夾你嘅投資風格"),
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
            "A ‘Bot’ is your personal AI manager that trades your stock for you."),
        "botStockExplanationScreenBottomButton":
            MessageLookupByLibrary.simpleMessage("明白！咁Bot可以做啲咩？"),
        "botStockExplanationScreenTitle": MessageLookupByLibrary.simpleMessage(
            "You pick the stock, and the \'Bot\' will trade it for you!"),
        "botStockWelcomeScreenBottomButton":
            MessageLookupByLibrary.simpleMessage("好！咩咩Botstock話？"),
        "botStockWelcomeScreenTitle":
            MessageLookupByLibrary.simpleMessage("萬事具備, 即刻開始交易你嘅第一隻Botstock!"),
        "botStocksDetails":
            MessageLookupByLibrary.simpleMessage("Botstock 嘅詳情同預計回報。 "),
        "botTradeBottomSheetAccountNotYetApprovedSubTitle":
            MessageLookupByLibrary.simpleMessage("預計批核時間為 2 個工作天。"),
        "botTradeBottomSheetAccountNotYetApprovedTitle":
            MessageLookupByLibrary.simpleMessage("賬戶成功批核後就可以開始交易。"),
        "botTradeBottomSheetAmountMinimum": m2,
        "botTradeBottomSheetAmountMinimumFirst": m3,
        "botTradeBottomSheetAmountMinimumSecond": m4,
        "botTradeBottomSheetAmountTitle":
            MessageLookupByLibrary.simpleMessage("你想投資嘅金額係？"),
        "botTradeBottomSheetCancelBotStockConfirmationTitle": m5,
        "botTradeBottomSheetEndBotStockConfirmationSubTitle":
            MessageLookupByLibrary.simpleMessage(" Botstock 的總價值會自動轉至你的賬戶。"),
        "botTradeBottomSheetEndBotStockConfirmationTitle": m6,
        "botTradeBottomSheetFreeBotStockSuccessfullyAddedSubTitle":
            MessageLookupByLibrary.simpleMessage("存入資金正式交易"),
        "botTradeBottomSheetFreeBotStockSuccessfullyAddedTitle":
            MessageLookupByLibrary.simpleMessage("免費 Botstock 已成功加至\n你嘅投資組合！"),
        "botTradeBottomSheetInsufficientBalanceSubTitle": m7,
        "botTradeBottomSheetInsufficientBalanceTitle":
            MessageLookupByLibrary.simpleMessage("唔夠資金，幫你唔到，係時候入錢入戶口！"),
        "botTradeBottomSheetRolloverConfirmationButton":
            MessageLookupByLibrary.simpleMessage("延長"),
        "botTradeBottomSheetRolloverConfirmationSubTitle": m8,
        "botTradeBottomSheetRolloverConfirmationTitle":
            MessageLookupByLibrary.simpleMessage(
                "你想延長 Botstock 投資期\n以繼續交易？\n\n2 星期"),
        "botTradeBottomSheetRolloverDisclosureSubTitle":
            MessageLookupByLibrary.simpleMessage(
                "延長期費用為每個Botstock 每月 HKD40， \n如你賬戶裡金額不足，收費金額將會在你有\n足夠的購買力的時候扣除。"),
        "botTradeBottomSheetRolloverDisclosureTitle":
            MessageLookupByLibrary.simpleMessage(
                "你將延長 Botstock 投資期，\n 並需繳付額外延長費用。"),
        "botValues": MessageLookupByLibrary.simpleMessage("當前價格"),
        "businessNonFinance":
            MessageLookupByLibrary.simpleMessage("Business, Non-Finance"),
        "businessOwner": MessageLookupByLibrary.simpleMessage("企業主"),
        "buttonAlreadyHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("已有帳戶"),
        "buttonBackToHome": MessageLookupByLibrary.simpleMessage("返回主頁"),
        "buttonBackToPortfolio":
            MessageLookupByLibrary.simpleMessage("返回投資組合頁"),
        "buttonCancel": MessageLookupByLibrary.simpleMessage("取消"),
        "buttonCancelTrade": MessageLookupByLibrary.simpleMessage("取消交易"),
        "buttonChangeInvestmentStyle":
            MessageLookupByLibrary.simpleMessage("更改投資風格"),
        "buttonConfirm": MessageLookupByLibrary.simpleMessage("確定"),
        "buttonContinue": MessageLookupByLibrary.simpleMessage("繼續"),
        "buttonDeposit": MessageLookupByLibrary.simpleMessage("入金"),
        "buttonDone": MessageLookupByLibrary.simpleMessage("完成"),
        "buttonForgetPassword": MessageLookupByLibrary.simpleMessage("忘記密碼？"),
        "buttonGoBack": MessageLookupByLibrary.simpleMessage("返回"),
        "buttonGotIt": MessageLookupByLibrary.simpleMessage("Got it!"),
        "buttonHaveAnAccount": MessageLookupByLibrary.simpleMessage("已有賬戶？"),
        "buttonLetsBegin": MessageLookupByLibrary.simpleMessage("立即開始"),
        "buttonMaybeLater": MessageLookupByLibrary.simpleMessage("稍後再說"),
        "buttonNext": MessageLookupByLibrary.simpleMessage("下一步"),
        "buttonNotNow": MessageLookupByLibrary.simpleMessage("稍後再說"),
        "buttonReloadPage": MessageLookupByLibrary.simpleMessage("重新加載"),
        "buttonResendActivationLink":
            MessageLookupByLibrary.simpleMessage("再發送開通連結"),
        "buttonSave": MessageLookupByLibrary.simpleMessage("儲存"),
        "buttonSignOut": MessageLookupByLibrary.simpleMessage("登出"),
        "buttonSignUp": MessageLookupByLibrary.simpleMessage("註冊"),
        "buttonSignUpAgain": MessageLookupByLibrary.simpleMessage("再次註冊"),
        "buttonSubmit": MessageLookupByLibrary.simpleMessage("提交"),
        "buttonSure": MessageLookupByLibrary.simpleMessage("好"),
        "buttonTryAgain": MessageLookupByLibrary.simpleMessage("再試一次"),
        "buttonVerify": MessageLookupByLibrary.simpleMessage("核實"),
        "buttonViewDetails": MessageLookupByLibrary.simpleMessage("查看詳情"),
        "buttonViewTransactionHistory":
            MessageLookupByLibrary.simpleMessage("查看交易歷史"),
        "buttonWithdraw": MessageLookupByLibrary.simpleMessage("提取"),
        "buy": MessageLookupByLibrary.simpleMessage("買入"),
        "cancelled": MessageLookupByLibrary.simpleMessage("已取消"),
        "cannotRememberEmailAddress": MessageLookupByLibrary.simpleMessage(
            "忘記登入電郵地址？\n請發送電郵至 cs@asklora.ai"),
        "cantRememberYourEmail": MessageLookupByLibrary.simpleMessage(
            "忘記登入電郵地址？\n請發送電郵至 help@asklora.ai"),
        "carouselIntro1": MessageLookupByLibrary.simpleMessage("投資一樣\n要夠Fit"),
        "carouselIntro2":
            MessageLookupByLibrary.simpleMessage("FinFit教練，Lora 全程教路"),
        "carouselIntro3": MessageLookupByLibrary.simpleMessage("AI策略，\n自動交易"),
        "carouselIntro4": MessageLookupByLibrary.simpleMessage("個人化體驗，\n前所未見"),
        "changeBankAccount": MessageLookupByLibrary.simpleMessage("更改銀行戶口"),
        "changePassword": MessageLookupByLibrary.simpleMessage("更改密碼"),
        "checkBackLater": MessageLookupByLibrary.simpleMessage("稍後再來查看!"),
        "checkBotStockDetails":
            MessageLookupByLibrary.simpleMessage("查看 Botstock 資訊"),
        "clickOnLora": MessageLookupByLibrary.simpleMessage("click on Lora "),
        "communitySocialService":
            MessageLookupByLibrary.simpleMessage("Community / Social Service"),
        "companyAddress": MessageLookupByLibrary.simpleMessage("銀行地址"),
        "completed": MessageLookupByLibrary.simpleMessage("已完成"),
        "computerInformationTechnology": MessageLookupByLibrary.simpleMessage(
            "Computer / Information Technology"),
        "confirmAndContinue": MessageLookupByLibrary.simpleMessage("確認並繼續"),
        "confirmNewPassword": MessageLookupByLibrary.simpleMessage("確認新密碼"),
        "confirmTrade": MessageLookupByLibrary.simpleMessage(" \"確認買入\""),
        "construction": MessageLookupByLibrary.simpleMessage("Construction"),
        "contactUs": MessageLookupByLibrary.simpleMessage("聯絡我們"),
        "continueAccountOpening":
            MessageLookupByLibrary.simpleMessage("開立投資賬戶"),
        "copyAskloraBankDetails": MessageLookupByLibrary.simpleMessage(
            "複製 Asklora 銀行資料，並從你銀行戶口透過 FPS或電匯轉。"),
        "corePlan": MessageLookupByLibrary.simpleMessage("核心計劃"),
        "countryOfBirth": MessageLookupByLibrary.simpleMessage("出生地點"),
        "createAnAccount": MessageLookupByLibrary.simpleMessage("開立賬戶"),
        "currentPrice": MessageLookupByLibrary.simpleMessage("當前價格"),
        "customerService": MessageLookupByLibrary.simpleMessage("客戶服務"),
        "dateJoined": MessageLookupByLibrary.simpleMessage("加入日期"),
        "dateOfBirth": MessageLookupByLibrary.simpleMessage("出生日期"),
        "defineAgain": MessageLookupByLibrary.simpleMessage("重新界定"),
        "defineInvestmentStyle": MessageLookupByLibrary.simpleMessage("界定投資風格"),
        "deposit": MessageLookupByLibrary.simpleMessage("存入資金"),
        "depositAmount": MessageLookupByLibrary.simpleMessage("存入金額"),
        "depositFund": MessageLookupByLibrary.simpleMessage("存入資金"),
        "depositFundToStartInvesting":
            MessageLookupByLibrary.simpleMessage("存入資金開始投資"),
        "depositHistory": MessageLookupByLibrary.simpleMessage("入金歷史"),
        "depositRegulatoryRequirements": m9,
        "depositRequestSubmittedSubTitleFirstTime":
            MessageLookupByLibrary.simpleMessage(
                "我們會於 1 至 2 個工作天內檢視你的開戶申請及首次入金。當賬戶批核後會以電郵或應用程式通知。"),
        "depositRequestSubmittedSubTitleReturn":
            MessageLookupByLibrary.simpleMessage(
                "你已提交入金請求，當收到入金後，\n我們會盡快以電郵或應用程式通知。"),
        "depositRequestSubmittedTitle":
            MessageLookupByLibrary.simpleMessage("已收到入金申請"),
        "depositViaFpsOrWireTransfer":
            MessageLookupByLibrary.simpleMessage("以 FPS 或電匯入金"),
        "doAnyOfTheFollowingApply":
            MessageLookupByLibrary.simpleMessage("以下描述適用於你或你的直系親屬？"),
        "educationTrainingLibrary": MessageLookupByLibrary.simpleMessage(
            "Education / Training / Library"),
        "email": MessageLookupByLibrary.simpleMessage("電郵"),
        "emailActivationFailedTitle":
            MessageLookupByLibrary.simpleMessage("Sorry！你嘅請求已經逾時。\n請重新開通帳戶。"),
        "emailActivationSuccessTitle": m10,
        "emailAddress": MessageLookupByLibrary.simpleMessage("電郵地址"),
        "emailNotExist": MessageLookupByLibrary.simpleMessage("此電郵地址的用戶不存在"),
        "emailNotVerified": MessageLookupByLibrary.simpleMessage("用戶電郵未認證"),
        "employed": MessageLookupByLibrary.simpleMessage("受僱"),
        "employees": MessageLookupByLibrary.simpleMessage("員工人數"),
        "employment": MessageLookupByLibrary.simpleMessage("雇傭"),
        "employmentStatus": MessageLookupByLibrary.simpleMessage("就業狀況"),
        "endBotStockAcknowledgement": m11,
        "endDate": MessageLookupByLibrary.simpleMessage("結束日期"),
        "endedAmount": MessageLookupByLibrary.simpleMessage("到期價值"),
        "enterANewPassword": MessageLookupByLibrary.simpleMessage("請輸入新密碼"),
        "enterValidEmail": MessageLookupByLibrary.simpleMessage("請輸入有效電郵地址"),
        "enterValidPassword": MessageLookupByLibrary.simpleMessage("請輸入有效密碼"),
        "errorGettingInformationInvestmentDetailSubTitle":
            MessageLookupByLibrary.simpleMessage("載入你投資細節時出咗少少問題，Reload一次試下？"),
        "errorGettingInformationPortfolioSubTitle":
            MessageLookupByLibrary.simpleMessage("載入你投資組合時出咗少少問題，Reload一次試下？"),
        "errorGettingInformationTitle":
            MessageLookupByLibrary.simpleMessage("咦，無法獲取資料"),
        "errorStoringData": MessageLookupByLibrary.simpleMessage("數據存取發生錯誤"),
        "errorStoringDataDetails": MessageLookupByLibrary.simpleMessage(
            "Oops！我們在嘗試存儲你的回覆時遇到一些技術困難。讓我們重新做題"),
        "estMaxLossPercent": MessageLookupByLibrary.simpleMessage("預計最大損失%"),
        "estMaxProfitPercent": MessageLookupByLibrary.simpleMessage("預計最大收益%"),
        "estStopLossPercent": MessageLookupByLibrary.simpleMessage("預計止損 %"),
        "estTakeProfitPercent": MessageLookupByLibrary.simpleMessage("預計止賺%"),
        "estimatedEndDate": MessageLookupByLibrary.simpleMessage("預計結束日期"),
        "exchangeRateInDepositScreen": m12,
        "existingPassword": MessageLookupByLibrary.simpleMessage("現有密碼"),
        "expired": MessageLookupByLibrary.simpleMessage("已到期"),
        "expiresAt": MessageLookupByLibrary.simpleMessage("到期日期"),
        "extrovertLessThan8":
            MessageLookupByLibrary.simpleMessage("每個人都需要me time，獨個觀看世間變幻事情"),
        "extrovertMoreThan8":
            MessageLookupByLibrary.simpleMessage("你一定係交際花, 將你嘅vibe發光發亮!"),
        "farmingFishingForestry": MessageLookupByLibrary.simpleMessage(
            "Farming, Fishing and Forestry"),
        "filledPrice": MessageLookupByLibrary.simpleMessage("成交價格"),
        "financeBrokerDealerBank": MessageLookupByLibrary.simpleMessage(
            "Finance/ Broker Dealer /Bank"),
        "financialProfile":
            MessageLookupByLibrary.simpleMessage("Financial Profile"),
        "firstTimeCopyAskloraBankDetails": m13,
        "foodBeverage":
            MessageLookupByLibrary.simpleMessage("Food and Beverage"),
        "forgotPassword": MessageLookupByLibrary.simpleMessage("忘記密碼"),
        "forgotPasswordMessage":
            MessageLookupByLibrary.simpleMessage("請輸入你的電郵地址，我們會發送重設密碼的指示給你。"),
        "formW8ben": MessageLookupByLibrary.simpleMessage("Form W-8BEN"),
        "founded": MessageLookupByLibrary.simpleMessage("成立年份"),
        "free": MessageLookupByLibrary.simpleMessage("免費"),
        "freeTrial": MessageLookupByLibrary.simpleMessage("免費試用期"),
        "fullName": MessageLookupByLibrary.simpleMessage("姓名"),
        "generalSettings": MessageLookupByLibrary.simpleMessage("設定"),
        "getHelp": MessageLookupByLibrary.simpleMessage("獲得幫助"),
        "getReadyForTheVerification":
            MessageLookupByLibrary.simpleMessage("核實程序即將開始，你將要......"),
        "getReadyForTrading": MessageLookupByLibrary.simpleMessage("準備好AI 交易"),
        "getTheFirstBotstockForFree":
            MessageLookupByLibrary.simpleMessage("獲取首個免費 Botstock "),
        "giftBotStockMessageScreenBottomButton":
            MessageLookupByLibrary.simpleMessage("OK! 睇下畀我嘅推薦"),
        "giftBotStockMessageScreenTitle": MessageLookupByLibrary.simpleMessage(
            "每一次你投資新嘅Botstock, 我都會問你投資風格問題，咁我就可以提供新嘅個人化投資建議畀你！"),
        "go": MessageLookupByLibrary.simpleMessage("繼續"),
        "goToPortfolio":
            MessageLookupByLibrary.simpleMessage("Go To Portfolio"),
        "gotIt": MessageLookupByLibrary.simpleMessage("知道了"),
        "greatStart": MessageLookupByLibrary.simpleMessage("開始投資"),
        "greetingScreenSubTitle": MessageLookupByLibrary.simpleMessage(
            "訓練開始，會問下基本問題先！\n記住，冇耐性，就輸梗！ "),
        "greetingScreenTitle":
            MessageLookupByLibrary.simpleMessage("Alright! 準備好\n開始你嘅 AI 旅程未？"),
        "halfWayThere": MessageLookupByLibrary.simpleMessage("進展順利"),
        "headquarters": MessageLookupByLibrary.simpleMessage("總部地點"),
        "healthcare": MessageLookupByLibrary.simpleMessage("Healthcare"),
        "hereYouCanFind": MessageLookupByLibrary.simpleMessage("你可以係度搵到 "),
        "hkId": MessageLookupByLibrary.simpleMessage("香港身份證"),
        "hkIdNumber": MessageLookupByLibrary.simpleMessage("香港身份證號碼"),
        "hkPhoneNo": MessageLookupByLibrary.simpleMessage("香港電話號碼"),
        "hkResidentQuestion": MessageLookupByLibrary.simpleMessage(
            "你是否香港居民？如果你選擇【是】， 你將會被視爲香港稅務居民。"),
        "homeMaker": MessageLookupByLibrary.simpleMessage("家庭主婦"),
        "homeTrader": MessageLookupByLibrary.simpleMessage("At-Home Trader"),
        "howItWorks": MessageLookupByLibrary.simpleMessage("如何運作"),
        "iAmADirector": MessageLookupByLibrary.simpleMessage(
            "我是香港證券及期貨事務監察委員會註冊持牌機構的董事、員工、或註冊持牌人士。(除了Lora Advisors Limited）"),
        "iAmAFamily": MessageLookupByLibrary.simpleMessage("我是高級政治人物的家庭成員或親屬。"),
        "iAmASeniorExecutive": MessageLookupByLibrary.simpleMessage(
            "我是上市公司的高級行政人員或持有 10% 或以上的股份。"),
        "iAmASeniorPolitical":
            MessageLookupByLibrary.simpleMessage("我是高級政治人物。"),
        "iHaveReadAndAgreed": MessageLookupByLibrary.simpleMessage(
            "我已細閱、理解及同意受 LORA Advisors Limited 戶口條款約束，引用的所有其他條款， 披露及免責聲明對我同樣適用。"),
        "iUnderstandSigningAgreement": MessageLookupByLibrary.simpleMessage(
            "我理解我以電子方式簽署協議，我的電子簽署會與親筆簽署及提交申請協議同樣有效。"),
        "ifYouveGot": MessageLookupByLibrary.simpleMessage("如果你有"),
        "inApp": MessageLookupByLibrary.simpleMessage("In-app通知"),
        "industry": MessageLookupByLibrary.simpleMessage("行業"),
        "inputDepositAmount": MessageLookupByLibrary.simpleMessage("輸入金額"),
        "inputWrongEmail": MessageLookupByLibrary.simpleMessage("電郵地址錯誤"),
        "inputWrongEmailAddress":
            MessageLookupByLibrary.simpleMessage("電郵地址錯誤"),
        "installationMaintenanceRepair": MessageLookupByLibrary.simpleMessage(
            "Installation, Maintenance, and Repair"),
        "introduceBotPlank":
            MessageLookupByLibrary.simpleMessage("簡介 Bot - Plank"),
        "introduceBotPullup":
            MessageLookupByLibrary.simpleMessage("簡介 Bot - Pullup"),
        "introduceBotSquat":
            MessageLookupByLibrary.simpleMessage("簡介 Bot - Squat"),
        "invalidOtp": MessageLookupByLibrary.simpleMessage("無效OTP"),
        "invalidPassword": MessageLookupByLibrary.simpleMessage("無效密碼"),
        "investmentAmount": MessageLookupByLibrary.simpleMessage("投資金額"),
        "investmentPeriod": MessageLookupByLibrary.simpleMessage("投資期"),
        "investmentPreferences": MessageLookupByLibrary.simpleMessage("投資偏好"),
        "investmentResultScreenDescription":
            MessageLookupByLibrary.simpleMessage("仲差少少就可以開波!\n\n開戶喇!"),
        "investmentResultScreenTitle":
            MessageLookupByLibrary.simpleMessage("你嘅投資風格已經界定"),
        "investmentStyleWelcomeTitle": MessageLookupByLibrary.simpleMessage(
            "想知Asklora有咩投資秘技？\n界定你嘅投資風格先！\n"),
        "isqNextButton": MessageLookupByLibrary.simpleMessage(
            "Please press to proceed to the next question"),
        "isqWillHelpMeUnderstandWhatKindOfStocks":
            MessageLookupByLibrary.simpleMessage("ISQ會幫到我了解你對咩類型股票有興趣"),
        "kycRejectedExplanationOfAffiliate":
            MessageLookupByLibrary.simpleMessage("我們不接受上述類別人士\n開立賬戶。"),
        "kycRejectedScreenTitle":
            MessageLookupByLibrary.simpleMessage("Sorry，原來你唔合資格用 Asklora！"),
        "kycResultScreenDesc": MessageLookupByLibrary.simpleMessage(
            "你嘅投資賬戶正在審核中\n一有進度Asklora會馬上同你聯絡"),
        "kycResultScreenTitle":
            MessageLookupByLibrary.simpleMessage("幫緊你,幫緊你!"),
        "language": MessageLookupByLibrary.simpleMessage("語言"),
        "lawEnforcementGovernmentProtectiveService":
            MessageLookupByLibrary.simpleMessage(
                "Law Enforcement, Government, Protective Service"),
        "learnBotstockManagement":
            MessageLookupByLibrary.simpleMessage("學䲾 Botstock 管理"),
        "left": MessageLookupByLibrary.simpleMessage("Left"),
        "legal": MessageLookupByLibrary.simpleMessage("Legal"),
        "legalFirstName": MessageLookupByLibrary.simpleMessage("法定英文名字"),
        "legalLastName": MessageLookupByLibrary.simpleMessage("法定英文姓氏"),
        "letsGo": MessageLookupByLibrary.simpleMessage("Let’s Go"),
        "letsTrade": MessageLookupByLibrary.simpleMessage("LET\'S TRADE"),
        "licenseeName": MessageLookupByLibrary.simpleMessage("持牌人：張永經"),
        "licenseeNumber": MessageLookupByLibrary.simpleMessage("CE 編號: AFF918"),
        "lifePhysicalSocialService": MessageLookupByLibrary.simpleMessage(
            "Life, Physical and Social Service"),
        "linkPasswordResetIsSent":
            MessageLookupByLibrary.simpleMessage("重設密碼連結已發送至電子郵件。"),
        "manageYourBotstock":
            MessageLookupByLibrary.simpleMessage("管理 Botstock"),
        "marketCap": MessageLookupByLibrary.simpleMessage("市值"),
        "marketPrice": MessageLookupByLibrary.simpleMessage("市場價格"),
        "masterAiTrading":
            MessageLookupByLibrary.simpleMessage("Master AI Trading"),
        "mediaCommunications":
            MessageLookupByLibrary.simpleMessage("Media and Communications"),
        "middle": MessageLookupByLibrary.simpleMessage("Middle"),
        "milestones": MessageLookupByLibrary.simpleMessage("目標"),
        "min": m14,
        "min8Character": MessageLookupByLibrary.simpleMessage("最少 8 個字母"),
        "nationality": MessageLookupByLibrary.simpleMessage("國籍"),
        "natureOfBusiness": MessageLookupByLibrary.simpleMessage("業務性質"),
        "natureOfBusinessDesc": MessageLookupByLibrary.simpleMessage("業務性質描述"),
        "navBar": MessageLookupByLibrary.simpleMessage("nav bar"),
        "needHelp": MessageLookupByLibrary.simpleMessage("需要幫助？"),
        "neuroticismLessThan8":
            MessageLookupByLibrary.simpleMessage("我哋可以進取少少, 承受一定嘅風險"),
        "neuroticismMoreThan8":
            MessageLookupByLibrary.simpleMessage("我哋一步一步嚟, 控制住風險"),
        "newPassword": MessageLookupByLibrary.simpleMessage("新密碼"),
        "nextStep": MessageLookupByLibrary.simpleMessage("下一步"),
        "no": MessageLookupByLibrary.simpleMessage(" 否"),
        "noTransactions": MessageLookupByLibrary.simpleMessage("暫時沒有交易"),
        "noTransactionsYet":
            MessageLookupByLibrary.simpleMessage("你似乎未進行過任何交易！"),
        "notFeelingIt": MessageLookupByLibrary.simpleMessage("唔啱心水？當然仲有得揀！"),
        "notTheStockYouWereLooking":
            MessageLookupByLibrary.simpleMessage("唔係你想要嘅股票?"),
        "noteOnPaymentDetails": MessageLookupByLibrary.simpleMessage(
            "注意\n我們會與你所登記銀行協作藉以核實你的銀行資料（賬戶姓名、銀行編號、銀行賬戶 號碼）。我們亦可能會因核實交易，向你要求更多附加資料。"),
        "notes": MessageLookupByLibrary.simpleMessage("說明"),
        "notificationSetting": MessageLookupByLibrary.simpleMessage("通知設定"),
        "notificationSettings": MessageLookupByLibrary.simpleMessage("通知設定"),
        "officeHours":
            MessageLookupByLibrary.simpleMessage("09:00-18:00 (HKT)"),
        "officeHoursLabel": MessageLookupByLibrary.simpleMessage("辦公時間"),
        "oldPasswordSameWithNewPasswordError":
            MessageLookupByLibrary.simpleMessage("設置的新密碼不能和舊密碼相同"),
        "onBoardingCompletionMessage": MessageLookupByLibrary.simpleMessage(
            "您已經完成了在Asklora開立賬戶的所有步驟！您的賬戶一\n經審核通過，即可開始交易。審核通常需要1至2個工作日。"),
        "onceYouHaveStarted":
            MessageLookupByLibrary.simpleMessage("當你開始後，你亦可以隨時於任何時間再繼續。"),
        "openAccountNow": MessageLookupByLibrary.simpleMessage("立即開戶"),
        "openInvestmentAccount":
            MessageLookupByLibrary.simpleMessage("開立新投資賬戶"),
        "opennessLessThan8":
            MessageLookupByLibrary.simpleMessage("用AI投資其實可以好簡單。"),
        "opennessMoreThan8": MessageLookupByLibrary.simpleMessage("我哋一定好夾!"),
        "orderCancelled": MessageLookupByLibrary.simpleMessage("訂單己取消"),
        "orderExpired": MessageLookupByLibrary.simpleMessage("訂單已過期"),
        "orderPlaced": MessageLookupByLibrary.simpleMessage("已提交訂單"),
        "orderRollover": MessageLookupByLibrary.simpleMessage("訂單已續期"),
        "orderStarted": MessageLookupByLibrary.simpleMessage("訂單已開始"),
        "other": MessageLookupByLibrary.simpleMessage("Other"),
        "otpDigit": MessageLookupByLibrary.simpleMessage("000000 (6 位數字)"),
        "otpScreenDescription": m15,
        "otpScreenTitle": MessageLookupByLibrary.simpleMessage("一次性密碼"),
        "otpSentToYourEmail":
            MessageLookupByLibrary.simpleMessage("OTP code sent to your email"),
        "otpSentToYourPhone": MessageLookupByLibrary.simpleMessage(
            "Otp SMS is sent to your phone"),
        "ourPersonalisedRecommendationsAreUnique":
            MessageLookupByLibrary.simpleMessage(
                "每個個人化建議均獨一無二。所建議的 Botstock 都是根據你能承受的風險、個性測試及投資風格所提供。"),
        "password": MessageLookupByLibrary.simpleMessage("密碼"),
        "passwordChangeSuccess":
            MessageLookupByLibrary.simpleMessage("Password Change Success"),
        "passwordChangeSuccessfully":
            MessageLookupByLibrary.simpleMessage("密碼更改成功"),
        "passwordDoesNotMatch": MessageLookupByLibrary.simpleMessage("兩組密碼不相符"),
        "passwordLinkHasBeenSent":
            MessageLookupByLibrary.simpleMessage("已發送重設密碼電郵，\n請檢查你的電郵。"),
        "payDepositToStartRealTrade":
            MessageLookupByLibrary.simpleMessage("入金以開始正式交易"),
        "paymentDetails": MessageLookupByLibrary.simpleMessage("銀行賬戶詳情"),
        "pending": MessageLookupByLibrary.simpleMessage("處理中"),
        "performance": MessageLookupByLibrary.simpleMessage("表現"),
        "personalAIAssistant":
            MessageLookupByLibrary.simpleMessage("問你嘅AI助手Asklora! "),
        "personalCareService":
            MessageLookupByLibrary.simpleMessage("Personal Care / Service"),
        "personalInfo": MessageLookupByLibrary.simpleMessage("個人資料"),
        "personalInfoFormDesc":
            MessageLookupByLibrary.simpleMessage("請確保名字與身份證明文件一致。"),
        "personalisation": MessageLookupByLibrary.simpleMessage("個人化"),
        "personalizationResultScreenTitle":
            MessageLookupByLibrary.simpleMessage(
                "Alright!\n\n你嘅答案顯示我嘅科技同你都幾夾，我哋都可以進取少少！"),
        "phone": MessageLookupByLibrary.simpleMessage("電話"),
        "pleaseAddAHkBankAccount": MessageLookupByLibrary.simpleMessage(
            "請確保加入的香港銀行戶口是在你名下。其他人的銀行戶口及聯名戶口將不會接受。"),
        "pleaseEnterYouEmail":
            MessageLookupByLibrary.simpleMessage("請輸入你的電郵地址，我們會發送重設密碼的指示給你。"),
        "pleaseMakeSureYouHaveFinished":
            MessageLookupByLibrary.simpleMessage("匯款證明需要顯示你的銀行戶口號碼，全名 及金額。"),
        "pleaseMakeSureYouPressSubmit":
            MessageLookupByLibrary.simpleMessage("請確保於你的銀行轉賬資金後才按「提交」鍵。"),
        "pleaseProvideYourResidentialAddress":
            MessageLookupByLibrary.simpleMessage("請提供你的住宅地址。這也將是你的郵寄地址。"),
        "pleaseReadTheAskloraCustomerAgreement":
            MessageLookupByLibrary.simpleMessage(
                "請細閱 Asklora 客戶協議。你必須剔選所有勾選框並提供你的簽名才能繼續。"),
        "pleaseSelect": MessageLookupByLibrary.simpleMessage("請選擇"),
        "porAddress": MessageLookupByLibrary.simpleMessage("住址證明"),
        "portfolio": MessageLookupByLibrary.simpleMessage("Portfolio"),
        "portfolioBuyingPower": m16,
        "portfolioBuyingPowerToolTip": MessageLookupByLibrary.simpleMessage(
            "購買力代表了你可以用來購買Botstock的現金額。你的可提取金額和購買力會出現不一樣的情況。例如，開始Botstock後，你的購買力會相對減少，而Botstock總價值會相對提高。或當你的Botstock已到期或被終止，其價值將會增加至購買力，而在「T+2」日，T為交易當日， 該價值也會同時顯示在可提取金額。 "),
        "portfolioCurrentPrice": MessageLookupByLibrary.simpleMessage("當前價格"),
        "portfolioDetailButtonCancelBotStock":
            MessageLookupByLibrary.simpleMessage("取消BOTSTOCK"),
        "portfolioDetailButtonEndBotStock":
            MessageLookupByLibrary.simpleMessage("取消Botstock"),
        "portfolioDetailButtonRolloverBotStock":
            MessageLookupByLibrary.simpleMessage("續期Botstock"),
        "portfolioDetailChartCaption": m17,
        "portfolioDetailExpiredAt": m18,
        "portfolioDetailExpiredIn": m19,
        "portfolioDetailKeyInfoAvgLoss":
            MessageLookupByLibrary.simpleMessage("平均虧損"),
        "portfolioDetailKeyInfoAvgPeriod":
            MessageLookupByLibrary.simpleMessage("平均時期 (日數)"),
        "portfolioDetailKeyInfoAvgReturn":
            MessageLookupByLibrary.simpleMessage("平均回報"),
        "portfolioDetailKeyInfoBotStockNumberOfRollover":
            MessageLookupByLibrary.simpleMessage("Number of Rollovers"),
        "portfolioDetailKeyInfoBotStockStatus":
            MessageLookupByLibrary.simpleMessage("Botstock 狀態"),
        "portfolioDetailKeyInfoDaysTillExpiry":
            MessageLookupByLibrary.simpleMessage("續期時間"),
        "portfolioDetailKeyInfoEndTime":
            MessageLookupByLibrary.simpleMessage("結束時間"),
        "portfolioDetailKeyInfoEstimatedMaxLoss":
            MessageLookupByLibrary.simpleMessage("預計最大損失%"),
        "portfolioDetailKeyInfoEstimatedMaxProfit":
            MessageLookupByLibrary.simpleMessage("預計最大收益% "),
        "portfolioDetailKeyInfoEstimatedStopLoss":
            MessageLookupByLibrary.simpleMessage("預計止損 %"),
        "portfolioDetailKeyInfoEstimatedTakeProfit":
            MessageLookupByLibrary.simpleMessage("預計止賺%"),
        "portfolioDetailKeyInfoStartTime":
            MessageLookupByLibrary.simpleMessage("開始時間"),
        "portfolioDetailKeyInfoTitle":
            MessageLookupByLibrary.simpleMessage("主要資訊"),
        "portfolioDetailPerformanceBotAssetsInStock":
            MessageLookupByLibrary.simpleMessage("股票/現金比例"),
        "portfolioDetailPerformanceBotStockValues":
            MessageLookupByLibrary.simpleMessage("Botstock 價值 (HKD)"),
        "portfolioDetailPerformanceCash":
            MessageLookupByLibrary.simpleMessage("現金 (HKD)"),
        "portfolioDetailPerformanceInvestmentAmount":
            MessageLookupByLibrary.simpleMessage("投資金額 (HKD)"),
        "portfolioDetailPerformanceNumberOfShares":
            MessageLookupByLibrary.simpleMessage("持股數量"),
        "portfolioDetailPerformanceStockValues":
            MessageLookupByLibrary.simpleMessage("股票價值 (HKD)"),
        "portfolioDetailPerformanceTitle":
            MessageLookupByLibrary.simpleMessage("表現"),
        "portfolioDetailPerformanceTotalPL":
            MessageLookupByLibrary.simpleMessage("總盈虧"),
        "portfolioPopUpContinueAccountOpeningSubTitle":
            MessageLookupByLibrary.simpleMessage("喺可以開始正式交易之前，你需要完成開戶。"),
        "portfolioPopUpContinueAccountOpeningTitle":
            MessageLookupByLibrary.simpleMessage("尚未完成開戶"),
        "portfolioPopUpCreateAnAccountSubTitle":
            MessageLookupByLibrary.simpleMessage(
                "開始交易後，你可以喺度管理你所有投資。快啲建立賬戶進行交易啦！"),
        "portfolioPopUpCreateAnAccountTitle":
            MessageLookupByLibrary.simpleMessage("建立賬戶，開始交易"),
        "portfolioPopUpDefineInvestmentSubTitle":
            MessageLookupByLibrary.simpleMessage(
                "你仲未界定你嘅投資風格。快啲去睇下咩\nBotstocks 最適合你喇！"),
        "portfolioPopUpDefineInvestmentTitle":
            MessageLookupByLibrary.simpleMessage("界定投資風格，立即交易！"),
        "portfolioPopUpFundAccountSubTitle":
            MessageLookupByLibrary.simpleMessage(
                "你好似仲未入錢喎，入咗 HKD 10,000 就可以正式完成開戶手續！"),
        "portfolioPopUpFundAccountTitle":
            MessageLookupByLibrary.simpleMessage("尚未入金"),
        "portfolioPopUpNoTradingHasStartedTitle":
            MessageLookupByLibrary.simpleMessage("尚未開始任何交易!"),
        "portfolioPopUpNoTradingHasStartedtSubTitle":
            MessageLookupByLibrary.simpleMessage(" 開始交易後你就可以一次過管理所有投資。"),
        "portfolioTotalBotStock": m20,
        "portfolioTotalPL": MessageLookupByLibrary.simpleMessage("總盈虧"),
        "portfolioTotalValue": MessageLookupByLibrary.simpleMessage("總價值 "),
        "portfolioWithdrawableAmount": m21,
        "portfolioYourBotStock":
            MessageLookupByLibrary.simpleMessage("你的Botstocks"),
        "ppiGotIt": MessageLookupByLibrary.simpleMessage("了解!"),
        "pressBackAgain": MessageLookupByLibrary.simpleMessage("再按一次登出Asklora"),
        "pressToRedoISQ": MessageLookupByLibrary.simpleMessage("重新界定投資風格"),
        "prevClose": MessageLookupByLibrary.simpleMessage("上日收市"),
        "privacyEvaluation": MessageLookupByLibrary.simpleMessage("私隱評估"),
        "privacyFailedScreenDescription": MessageLookupByLibrary.simpleMessage(
            "有可能你的風險評級太低，\n或者年齡未合乎要求。\n\n如有答案填錯，\n麻煩再試一次。"),
        "privacyFailedScreenTitle":
            MessageLookupByLibrary.simpleMessage("你尚未符合資格使用Asklora"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("私隱政策"),
        "privacySuccessScreenDescription": MessageLookupByLibrary.simpleMessage(
            "識揀 Asklora，\n證明你精明過好多人！\n\nOk！係時候再了解你多啲！"),
        "privacySuccessScreenTitle":
            MessageLookupByLibrary.simpleMessage("年齡只不過係個數字。"),
        "productionManufacturing": MessageLookupByLibrary.simpleMessage(
            "Production and Manufacturing"),
        "pushNotification": MessageLookupByLibrary.simpleMessage("推送通知"),
        "reSendOtp": m22,
        "readyToGo": MessageLookupByLibrary.simpleMessage("準備好未？"),
        "recommendations":
            MessageLookupByLibrary.simpleMessage("Recommendations"),
        "rejected": MessageLookupByLibrary.simpleMessage("已拒絕"),
        "relearn": MessageLookupByLibrary.simpleMessage("再次學習"),
        "rememberYouCan":
            MessageLookupByLibrary.simpleMessage("Remember, you can always "),
        "requestedToEnd":
            MessageLookupByLibrary.simpleMessage("Requested To End"),
        "resetPassword": MessageLookupByLibrary.simpleMessage("重設密碼"),
        "resetPasswordSuccessful":
            MessageLookupByLibrary.simpleMessage("密碼重設成功"),
        "resetPasswordSuccessfulMessage":
            MessageLookupByLibrary.simpleMessage("你的密碼已經被重設。請返回登入頁面重新登入。"),
        "resultOfPersonalizationQuestion": m23,
        "retired": MessageLookupByLibrary.simpleMessage("退休"),
        "returningUserDepositNotes": MessageLookupByLibrary.simpleMessage(
            "我們會與你所登記銀行協作藉以核實你的銀行資料（賬戶姓名、銀行編號、銀行賬戶號碼）。不過，我們亦可能會因核實交易，向你要求更多附加資料。"),
        "reviewYourTradeSummary":
            MessageLookupByLibrary.simpleMessage("查看你嘅交易摘要，點擊 "),
        "right": MessageLookupByLibrary.simpleMessage("Right"),
        "riskDisclosureStatement":
            MessageLookupByLibrary.simpleMessage("Risk Disclosure Statement"),
        "riskDisclosureStatementAcknowledgement":
            MessageLookupByLibrary.simpleMessage("我已閱讀、理解，及同意風險披露聲明。"),
        "riskDisclosureStatementLabel":
            MessageLookupByLibrary.simpleMessage("風險披露聲明"),
        "riskDisclosureStatementString": MessageLookupByLibrary.simpleMessage(
            "1. The prices of securities fluctuate, sometimes dramatically. The price of a security may move up or down, and may become valueless. It is as likely that losses will be incurred rather than profit made as a result of buying and selling securities. Investors should not only base on this marketing material to make any investment decision, you should carefully consider whether the investment products or services are suitable for you according to your investment experience, purpose, risk tolerance, financial or related conditions. If you have any questions, please contact us or obtain independent advice.\n\n2. Investment in foreign securities carries additional risks not generally associated with securities in the domestic market. The value or income of foreign securities may be more volatile and could be adversely affected by changes in currency rates of exchange, foreign taxation practices, foreign laws, government practices, regulations, and political events. You may find it more difficult to liquidate investments in foreign securities where they have limited liquidity in the relevant market. Foreign laws, government practices, and regulations may also affect the transferability of foreign securities. Timely and reliable information about the value or the extent of the risks of foreign securities may not be readily available at all times.\n\n3. You acknowledge that you have fully understood the implications of the risks associated with the Electronic Trading Service as set out in the Client Agreement"),
        "saveForLater": MessageLookupByLibrary.simpleMessage("儲存並離開"),
        "sectors": MessageLookupByLibrary.simpleMessage("領域"),
        "seeMyRecommendations":
            MessageLookupByLibrary.simpleMessage("See My Recommendations"),
        "selfEmployed": MessageLookupByLibrary.simpleMessage("自僱"),
        "sell": MessageLookupByLibrary.simpleMessage("賣出"),
        "sendIcon": MessageLookupByLibrary.simpleMessage("send icon "),
        "sendOtp": MessageLookupByLibrary.simpleMessage("發送 OTP"),
        "setUpFinancialProfile": MessageLookupByLibrary.simpleMessage("設定財務概況"),
        "setupPersonalInfo": MessageLookupByLibrary.simpleMessage("設定個人資料"),
        "shares": MessageLookupByLibrary.simpleMessage("數量"),
        "signAgreements": MessageLookupByLibrary.simpleMessage("簽署協議"),
        "signIn": MessageLookupByLibrary.simpleMessage("登入"),
        "signInElectronically": MessageLookupByLibrary.simpleMessage(
            "Sign this electronically by typing your name exactly as shown below."),
        "signOutConfirmation": MessageLookupByLibrary.simpleMessage(" 真係要登出？"),
        "signUpTitle":
            MessageLookupByLibrary.simpleMessage(" 踏入AI新世代，\n展開AI投資之旅"),
        "simplyTypeAQuestion": MessageLookupByLibrary.simpleMessage(
            "Simply type a question and tap the "),
        "sourceOfWealth": MessageLookupByLibrary.simpleMessage("財富來源"),
        "startABotstock": MessageLookupByLibrary.simpleMessage("開始交易"),
        "startAgain": MessageLookupByLibrary.simpleMessage("Start Again"),
        "startAnotherInvestments":
            MessageLookupByLibrary.simpleMessage("Start another investment"),
        "startBotStockAcknowledgement": m24,
        "startDate": MessageLookupByLibrary.simpleMessage("最佳開始日期"),
        "startInvesting": MessageLookupByLibrary.simpleMessage("開始投資 "),
        "startInvestingOnMilestone":
            MessageLookupByLibrary.simpleMessage("即將進入投資狀態！"),
        "startsAt": MessageLookupByLibrary.simpleMessage("開始日期"),
        "status": MessageLookupByLibrary.simpleMessage("狀態"),
        "student": MessageLookupByLibrary.simpleMessage("學生"),
        "submitApplication":
            MessageLookupByLibrary.simpleMessage("Submit Application"),
        "subscription": MessageLookupByLibrary.simpleMessage("訂購"),
        "summary": MessageLookupByLibrary.simpleMessage("摘要"),
        "summaryAgreementInformation": MessageLookupByLibrary.simpleMessage(
            "The agreements will become binding subject to the approval of the information submitted by you. \n\nIf there is a material change to this information, please contact loracares@asklora.ai as soon as possible"),
        "swiftCode": MessageLookupByLibrary.simpleMessage("Swift 代碼"),
        "takePhotoBack": MessageLookupByLibrary.simpleMessage("拍攝香港身份證背面"),
        "takePhotoFront": MessageLookupByLibrary.simpleMessage("拍攝香港身份證正面"),
        "takeSelfie": MessageLookupByLibrary.simpleMessage("自拍照一張"),
        "tapAnyWhere":
            MessageLookupByLibrary.simpleMessage("Tap anywhere to continue"),
        "taxAgreementCheckboxDesc": MessageLookupByLibrary.simpleMessage(
            "By checking this box, you consent to the collection and distribution of tax forms in an electronic format in lieu of paper"),
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
        "terminateAccount": MessageLookupByLibrary.simpleMessage("終止賬戶"),
        "termsAndConditions": MessageLookupByLibrary.simpleMessage("條款與約束"),
        "theAmountMustMatch":
            MessageLookupByLibrary.simpleMessage("輸入金額須與匯款輸入證明必須一致。"),
        "theAmountMustMatchWithPor":
            MessageLookupByLibrary.simpleMessage("金額須與匯款證明一致。"),
        "theItemYouWillNeed": MessageLookupByLibrary.simpleMessage("你需要以下文件.."),
        "thePorShouldShowYourBank":
            MessageLookupByLibrary.simpleMessage("匯款證明需要顯示你的銀行戶口號碼，全名 及金額。"),
        "theProofOfRemittanceShouldShowYourBankAccount":
            MessageLookupByLibrary.simpleMessage("匯款證明需要顯示你的銀行戶口號碼，全名 及金額。"),
        "thisInteractiveGraph":
            MessageLookupByLibrary.simpleMessage("你可以係下面見到Botstock最近"),
        "throughoutYourInvestmentJourney": MessageLookupByLibrary.simpleMessage(
            "Throughout your investment journey, you’ll see Lora on your bottom nav bar. Click on Lora at anytime to get advice or to ask anything related to finance."),
        "timeCompleted": MessageLookupByLibrary.simpleMessage("完成時間"),
        "timeForInvestmentStyleQuestion":
            MessageLookupByLibrary.simpleMessage("想知Asklora有咩投資技？ 界定你嘅投資風格先！"),
        "timeRequested": MessageLookupByLibrary.simpleMessage("請求時間"),
        "to": MessageLookupByLibrary.simpleMessage("至"),
        "toAskAnyOtherQuestion": MessageLookupByLibrary.simpleMessage(
            "to ask any other questions you might have"),
        "toExecuteIt": MessageLookupByLibrary.simpleMessage(" 就可以立即執行指示！"),
        "toGiveYou":
            MessageLookupByLibrary.simpleMessage("嘅表現，希望幫到你理解Botstock係點樣交易！"),
        "toGoToDifferentPages":
            MessageLookupByLibrary.simpleMessage("to go to different pages."),
        "toOpenLora": MessageLookupByLibrary.simpleMessage(
            " to open Lora and get more details about your investment!"),
        "toStartAConversation": MessageLookupByLibrary.simpleMessage(
            "to start a conversation. Tap the icon again to dismiss Asklora"),
        "tokenInvalid": MessageLookupByLibrary.simpleMessage(
            "Token is invalid or expired."),
        "tooltipBotDetailsEstMaxLoss":
            MessageLookupByLibrary.simpleMessage("Bot將出售以限制損失的最低股票價位。"),
        "tooltipBotDetailsEstMaxProfit":
            MessageLookupByLibrary.simpleMessage("Bot將出售以獲取最大利潤的股票價位。"),
        "tooltipBotDetailsEstStopLoss": MessageLookupByLibrary.simpleMessage(
            "Plank Bot將出售以限制過分損失的預設最低股票價位"),
        "tooltipBotDetailsEstTakeProfit":
            MessageLookupByLibrary.simpleMessage("Plank Bot將出售以獲取利潤的預設最高股票價位"),
        "tooltipBotDetailsInvestmentPeriod":
            MessageLookupByLibrary.simpleMessage(
                "你定下的投資時間，Botstock將會於此期間內自動買賣股票。"),
        "tooltipBotDetailsStartDate":
            MessageLookupByLibrary.simpleMessage("Lora開始Botstocks交易"),
        "tooltipDescOfTickerDetailsTutorial": MessageLookupByLibrary.simpleMessage(
            "Here\'s a brief description of the bot and stock you\'ve chosen"),
        "totalAmount": MessageLookupByLibrary.simpleMessage("總金額"),
        "totalPnlIs": MessageLookupByLibrary.simpleMessage("總盈虧"),
        "trade": MessageLookupByLibrary.simpleMessage("交易"),
        "tradeCancelledSubtitle":
            MessageLookupByLibrary.simpleMessage("交易已取消，你的投資金額已轉至你嘅賬戶。"),
        "tradeCancelledTitle": MessageLookupByLibrary.simpleMessage("交易已取消"),
        "tradeFee": MessageLookupByLibrary.simpleMessage("交易費用"),
        "tradeRequestSubmitted":
            MessageLookupByLibrary.simpleMessage("已經收到交易指令"),
        "tradeSummary": MessageLookupByLibrary.simpleMessage("交易摘要"),
        "tradeWithANewBotstock":
            MessageLookupByLibrary.simpleMessage("以一隻新 Botstock 交易"),
        "tradeWithBots": MessageLookupByLibrary.simpleMessage("以 Bot 交易"),
        "tradeWithYourFirstBotstock":
            MessageLookupByLibrary.simpleMessage("以首隻 Botstock 交易"),
        "transactionFee": MessageLookupByLibrary.simpleMessage("交易費用"),
        "transactionHistory": MessageLookupByLibrary.simpleMessage("交易歷史"),
        "transactionHistoryTabAll": MessageLookupByLibrary.simpleMessage("全部"),
        "transactionHistoryTabOrders":
            MessageLookupByLibrary.simpleMessage("訂單"),
        "transactionHistoryTabTransfer":
            MessageLookupByLibrary.simpleMessage("提存 "),
        "transactionHistoryTitle": MessageLookupByLibrary.simpleMessage("交易歷史"),
        "transactionHistoryToday": MessageLookupByLibrary.simpleMessage("今日"),
        "transferAtLeastWithMinimumDeposit": m25,
        "transferAtLeastWithNoMinimumDeposit":
            MessageLookupByLibrary.simpleMessage(
                "請由你之前使用的銀行戶口轉賬至Asklora 銀行戶口。"),
        "transferFundToAsklora":
            MessageLookupByLibrary.simpleMessage("轉賬資金予Asklora"),
        "transferInitialFundToAsklora":
            MessageLookupByLibrary.simpleMessage("轉賬首筆資金予Asklora"),
        "transferTo": MessageLookupByLibrary.simpleMessage("轉賬至"),
        "transportationMaterialMoving": MessageLookupByLibrary.simpleMessage(
            "Transportation and Material Moving"),
        "twoWeekPerformance": MessageLookupByLibrary.simpleMessage("兩個星期"),
        "unEmployed": MessageLookupByLibrary.simpleMessage("失業"),
        "understood": MessageLookupByLibrary.simpleMessage("明白！"),
        "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
        "updatedAt": m26,
        "uploadAddressProof": MessageLookupByLibrary.simpleMessage("上傳住址證明"),
        "uploadProofOfRemittance":
            MessageLookupByLibrary.simpleMessage("上載匯款證明"),
        "usResidentQuestion":
            MessageLookupByLibrary.simpleMessage("你是否擁有美國稅務居民身份、持有綠卡，或公民身份？"),
        "useThe": MessageLookupByLibrary.simpleMessage("Use the"),
        "userId": MessageLookupByLibrary.simpleMessage("用戶 ID"),
        "userNotFound": MessageLookupByLibrary.simpleMessage("User Not Found"),
        "verifyIdentity": MessageLookupByLibrary.simpleMessage("核實身份"),
        "verifyNow": MessageLookupByLibrary.simpleMessage("立即核實"),
        "verifyOtpSuccess":
            MessageLookupByLibrary.simpleMessage("Verify OTP Success"),
        "viewDepositGuide": MessageLookupByLibrary.simpleMessage("查看入金提示"),
        "w8benForm": MessageLookupByLibrary.simpleMessage("W-8BEN Form"),
        "weAcceptHKDOnly": MessageLookupByLibrary.simpleMessage("我們只接受港幣。"),
        "weAcceptUtilityBill": MessageLookupByLibrary.simpleMessage(
            "(我們接受最近3個月的水/電/煤氣繳費單、銀行結單或政府函件)"),
        "weNeedToVerifyYourId":
            MessageLookupByLibrary.simpleMessage("我們需要你的身份證核實你的身份。"),
        "weWillOnlyAcceptDepositViaBankTransfer":
            MessageLookupByLibrary.simpleMessage(
                "我們只接受由你戶口透過銀行轉賬 (電匯/FPS) 的入金。"),
        "weWillOnlyAcceptHKD": MessageLookupByLibrary.simpleMessage("我們只接受港幣"),
        "weWillTakeInformationCollectedFromYour": m27,
        "website": MessageLookupByLibrary.simpleMessage("網站"),
        "welcomeScreenFirstBenefit":
            MessageLookupByLibrary.simpleMessage("度身訂做AI指導"),
        "welcomeScreenSecondBenefit":
            MessageLookupByLibrary.simpleMessage("個人化體驗"),
        "welcomeScreenSubTitle": MessageLookupByLibrary.simpleMessage(
            "踢走投資壞習慣！\n由AI 顧問 Asklora 帶你一齊體驗嶄新科技！"),
        "welcomeScreenThirdBenefit":
            MessageLookupByLibrary.simpleMessage("AI 全自動交易"),
        "welcomeScreenTitle":
            MessageLookupByLibrary.simpleMessage("投資都要夠 Fit "),
        "wireTransfer": MessageLookupByLibrary.simpleMessage("電匯"),
        "withdraw": MessageLookupByLibrary.simpleMessage("提取資金"),
        "withdrawalAmount": MessageLookupByLibrary.simpleMessage("提取金額"),
        "withdrawalHistory": MessageLookupByLibrary.simpleMessage("提款歷史"),
        "withdrawalRequestSubmittedSubTitle":
            MessageLookupByLibrary.simpleMessage(
                "當資金已繳付至你戶口後，我們會盡快透過電郵或應用程式通知。"),
        "withdrawalRequestSubmittedTitle":
            MessageLookupByLibrary.simpleMessage("已收到提取申請"),
        "withdrawalWorkingDays":
            MessageLookupByLibrary.simpleMessage("提取款項最多需時2個工作天。"),
        "yes": MessageLookupByLibrary.simpleMessage("是"),
        "youCanClickOn":
            MessageLookupByLibrary.simpleMessage("You can click on "),
        "yourAddressProofMustContainFullName":
            MessageLookupByLibrary.simpleMessage(
                " 你的住址證明必須包含你全名、詳細住址及發行機構。\n\n我們接受最近3個月的水/電/煤氣繳費單、銀行結單或政府函件。"),
        "yourBankAccount": MessageLookupByLibrary.simpleMessage("銀行賬戶"),
        "yourBankAccountIsUnderReview": m28,
        "yourDepositCanTakeUp2WorkingDays":
            MessageLookupByLibrary.simpleMessage("入金程序最多需時 2 個工作天"),
        "yourDepositMayBeRejected": MessageLookupByLibrary.simpleMessage(
            "若所通知的金額與實際轉賬金額不符，你的入金可能會被拒絕。"),
        "yourPasswordHasBeenChanged": MessageLookupByLibrary.simpleMessage(
            "Your password has been changed"),
        "yourPaymentInformationIsUnderReview":
            MessageLookupByLibrary.simpleMessage(
                "您的銀行帳戶信息正在審核中。一旦您的開戶申請獲批，您的銀行帳戶詳細信息將顯示在此處。請注意，審核過程最多可能需要 2 個工作日。")
      };
}
