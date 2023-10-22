const v1 = '/api/v1/';
const v2 = '/api/v2/';
const accounts = 'accounts/';
const bots = 'bots/';
const transactions = 'transactions/';
const orders = 'orders/';
const activities = 'activities/';
const user = 'user/';

const String endpointSignInV1 = '${v1}auth/';
const String endpointSignIn = '${v2}auth/';
const String endpointSignOut = '${v1}auth/revoke/';
const String endpointSignUp = '$v1$accounts';
const String endpointResetPassword = '$v1$accounts/reset-password/';
const String endpointForgotPassword = '$v2${accounts}request-reset-password/';
const String endpointConfirmPassword = '$v2${accounts}confirm-password';
const String endpointChangePassword = '$v2${accounts}change-password';
const String endpointGetOtp = '$v1${accounts}otp/';
const String endpointGetSmsOtp = '$v2${accounts}request-sms-otp/';
const String endpointValidateEmail = '$v2${accounts}validate-email/';
const String endpointValidatePhone = '$v2${accounts}validate-phone/';
const String endpointVerifyEmail = '$v1${accounts}verify-email/';
const String endpointPersonalInfo = '$v2${accounts}upgrade/personal-info/';
const String endpointUpgradeAccount = '$v2${accounts}upgrade/ibkr/';
const String endpointGetAccount = '$v2$accounts';
const String endpointGetOnfidoToken = '$v2${accounts}onfido/token/';
const String endpointOnfidoOutcome = '$v2${accounts}onfido/outcome/';
const String endpointTokenVerify = '${v1}auth/verify/';
const String endpointTokenRefresh = '${v1}auth/refresh/';
const String endpointTaxInfo = '$v1${accounts}tax-info/';
const String endpointBankAccount = '$v1${accounts}bank-account-related/';
const String endpointOrders = '$v1$orders';
const String endpointUserJourney = '$v2${activities}user-journey/';
const String endpointLedgerBalance = '$v2${accounts}ledger/balance/';

///
/// Transaction
///
const String endpointWithdrawal = '$v1${transactions}withdraw/';
const String endpointProofOfRemittance = '$v1${transactions}remitance/';
const String endpointTransferTransactionHistory = '$v1/$transactions/history/';
const String endpointBalance = '$v1/$transactions/balance/';

///
/// PPI related
///
const endpointQuestion = 'questions';
const String endpointGetUser = 'user';
const String endpointGetSnapshotByDeviceId = 'user/device-id';
const String endpointGetSnapshotByAskloraId = 'user/asklora-id';
const String endpointAddAnswer = 'user/add-answer';
const String endpointAddBotChoice = 'user/add-choices';
const String endpointLinkedUser = '$endpointGetUser/linked';

///
///bot orders
///
const String endpointBotActiveOrder = '$v1$bots/';

String endpointBotActiveOrderPerformance(String botUid) =>
    '$v1$bots$botUid/performance';

const String endpointBotCreateOrder = '$v1${bots}create-order/';
const String endpointBotCancelOrder = '$v1${bots}cancel-order/';
const String endpointBotRolloverOrder = '$v1${bots}rollover-order/';
const String endpointBotTerminateOrder = '$v1${bots}terminate-order/';
const String endpointBotRecommendation = '${user}recomendation_bots/';
const String endpointBotOrderHistory = '$v1/$bots/history-order/';
const String endpointBotTransactionHistory = '$v1/$bots/history-order/';
const String endpointBotDetail = '$v1${bots}bot_detail/';

///
/// URLS
///
const String depositGuideUrl = 'https://asklora.ai/faq/deposit-guide';
const String endpointIexCloud = 'https://iexcloud.io';
const String askloraFaq = 'https://www.asklora.ai/faq';
const String askloraSite = 'https://www.asklora.ai/';
const String mailToLoraCare = 'mailto:loracares@asklora.ai';
const String mailToHelpAsklora = 'mailto:help@asklora.ai';
const String helpAskloraEmail = 'help@asklora.ai';
const String askloraPrivacyPolicy = 'https://www.asklora.ai/privacy-policy';
const String askloraTermAndConditions =
    'https://www.asklora.ai/terms-and-condtions';

///
/// LoraGPT
///
const String endpointChat = 'chat/general';
const String endpointPortfolio = 'chat/portfolio_page';
const String endpointPortfolioDetailPage =
    'chat/experimental/with_botstock_data';
const String endpointInvestmentStyle = 'chat/isq_main';

const String endpointBotIntro = '/miscellaneous/bot_starter_omit_earnings';
const String endpointBotEarning = '/miscellaneous/earnings_analysis';
const String endpointWelcomeStarter = '/miscellaneous/welcome_starter';
const String endpointWelcomeNews = '/miscellaneous/welcome_news';

const String aiPlatform = 'asklora';
