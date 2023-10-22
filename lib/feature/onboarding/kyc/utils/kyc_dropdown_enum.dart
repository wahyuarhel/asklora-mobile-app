import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

enum Occupations {
  accountant('Accountant'),
  analyst('Analyst'),
  architect('Architect'),
  attorney('Attorney'),
  auditor('Auditor'),
  businessOwner('Business Owner'),
  ceo('CEO'),
  cashier('Cashier'),
  collectionsAgent('Collections Agent'),
  complianceOfficer('Compliance Officer'),
  computerProgrammer('Computer Programmer'),
  courier('Courier'),
  customerServiceRepresentative('Customer Service Representative'),
  databaseAdministrator('Database Administrator'),
  doctor('Doctor'),
  director('Director'),
  engineer('Engineer'),
  entrepreneur('Entrepreneur'),
  executive('Executive'),
  humanResources('Human Resources'),
  insuranceAgent('Insurance Agent'),
  lawyer('Lawyer'),
  legalAssistant('Legal Assistant'),
  manager('Manager'),
  managingDirector('Managing Director'),
  nurse('Nurse'),
  paralegal('Paralegal'),
  president('President'),
  projectManager('Project Manager'),
  realEstateAgent('Real Estate Agent'),
  retail('Retail'),
  recruiter('Recruiter'),
  salesRepresentative('Sales Representative'),
  teacher('Teacher'),
  other('Other');

  final String value;

  const Occupations(this.value);

  static Occupations? findByString(String occupation) => Occupations.values
      .firstWhereOrNull((element) => element.value == occupation);
}

enum FundingSource {
  employmentIncome('Employment Income'),
  investments('Investments'),
  inheritance('Inheritance'),
  businessIncome('Business Income'),
  savings('Savings'),
  family('Family'),
  unknown('Unknown');

  final String value;

  const FundingSource(this.value);
}

enum EmploymentStatus {
  employed('Employed', 'EMPLOYED'),
  selfEmployed('Self Employed', 'SELFEMPLOYED'),
  retired('Retired', 'RETIRED'),
  student('Student', 'STUDENT'),
  businessOwner('Business Owner', 'BUSINESSOWNER'),
  homemaker('Homemaker', 'HOMEMAKER'),
  unemployed('Unemployed', 'UNEMPLOYED'),
  other('Other', 'OTHER'),
  unknown('Unknown', 'UNKNOWN');

  final String name;
  final String value;

  const EmploymentStatus(this.name, this.value);

  static EmploymentStatus? findByStringValue(String employmentStatus) =>
      EmploymentStatus.values
          .firstWhereOrNull((element) => element.value == employmentStatus);

  static EmploymentStatus findByStringName(String employmentStatus) =>
      EmploymentStatus.values
          .firstWhere((element) => element.name == employmentStatus);
  String text(BuildContext context) {
    switch (this) {
      case EmploymentStatus.employed:
        return S.of(context).employed;
      case EmploymentStatus.selfEmployed:
        return S.of(context).selfEmployed;
      case EmploymentStatus.retired:
        return S.of(context).retired;
      case EmploymentStatus.student:
        return S.of(context).student;
      case EmploymentStatus.businessOwner:
        return S.of(context).businessOwner;
      case EmploymentStatus.homemaker:
        return S.of(context).homeMaker;
      case EmploymentStatus.unemployed:
        return S.of(context).unEmployed;
      case EmploymentStatus.other:
        return S.of(context).other;
      case EmploymentStatus.unknown:
        return S.of(context).unknown;
    }
  }
}

enum NatureOfBusiness {
  architectureEngineering('Architecture / Engineering'),
  artDesign('Arts / Design'),
  businessNonFinance('Business, Non-Finance'),
  communitySocialService('Community / Social Service'),
  computerInformationTechnology('Computer / Information Technology'),
  construction('Construction'),
  educationTrainingLibrary('Education / Training / Library'),
  farmingFishingForestry('Farming, Fishing and Forestry'),
  financeBrokerDealerBank('Finance/ Broker Dealer /Bank'),
  foodBeverage('Food and Beverage'),
  healthcare('Healthcare'),
  installationMaintenanceRepair('Installation, Maintenance, and Repair'),
  legal('Legal'),
  lifePhysicalSocialService('Life, Physical and Social Service'),
  mediaCommunications('Media and Communications'),
  lawEnforcementGovernmentProtectiveService(
      'Law Enforcement, Government, Protective Service'),
  personalCareService('Personal Care / Service'),
  productionManufacturing('Production and Manufacturing'),
  transportationMaterialMoving('Transportation and Material Moving'),
  other('Other');

  final String value;

  const NatureOfBusiness(this.value);

  static NatureOfBusiness? findByString(String natureOfBusiness) =>
      NatureOfBusiness.values
          .firstWhereOrNull((element) => element.value == natureOfBusiness);

  static NatureOfBusiness findByStringValue(String natureOfBusiness) =>
      NatureOfBusiness.values
          .firstWhere((element) => element.value == natureOfBusiness);

  String text(BuildContext context) {
    switch (this) {
      case NatureOfBusiness.architectureEngineering:
        return S.of(context).architectureEngineering;
      case NatureOfBusiness.artDesign:
        return S.of(context).artDesign;
      case NatureOfBusiness.businessNonFinance:
        return S.of(context).businessNonFinance;
      case NatureOfBusiness.communitySocialService:
        return S.of(context).communitySocialService;
      case NatureOfBusiness.computerInformationTechnology:
        return S.of(context).computerInformationTechnology;
      case NatureOfBusiness.construction:
        return S.of(context).construction;
      case NatureOfBusiness.educationTrainingLibrary:
        return S.of(context).educationTrainingLibrary;
      case NatureOfBusiness.farmingFishingForestry:
        return S.of(context).farmingFishingForestry;
      case NatureOfBusiness.financeBrokerDealerBank:
        return S.of(context).financeBrokerDealerBank;
      case NatureOfBusiness.foodBeverage:
        return S.of(context).foodBeverage;
      case NatureOfBusiness.healthcare:
        return S.of(context).healthcare;
      case NatureOfBusiness.installationMaintenanceRepair:
        return S.of(context).installationMaintenanceRepair;
      case NatureOfBusiness.legal:
        return S.of(context).legal;
      case NatureOfBusiness.lifePhysicalSocialService:
        return S.of(context).lifePhysicalSocialService;
      case NatureOfBusiness.mediaCommunications:
        return S.of(context).mediaCommunications;
      case NatureOfBusiness.lawEnforcementGovernmentProtectiveService:
        return S.of(context).lawEnforcementGovernmentProtectiveService;
      case NatureOfBusiness.personalCareService:
        return S.of(context).personalCareService;
      case NatureOfBusiness.productionManufacturing:
        return S.of(context).productionManufacturing;
      case NatureOfBusiness.transportationMaterialMoving:
        return S.of(context).transportationMaterialMoving;
      case NatureOfBusiness.other:
        return S.of(context).other;
    }
  }
}

enum Region {
  hongKongIsland('Hong Kong Island'),
  kowloon('Kowloon'),
  newTerritories('New Territories');

  final String value;

  const Region(this.value);

  static Region? findByString(String region) =>
      Region.values.firstWhereOrNull((element) => element.value == region);
}

enum District {
  islands('Islands'),
  kwaiTsing('Kwai Tsing'),
  north('North'),
  saiKung('Sai Kung'),
  shaTin('Sha Tin'),
  taiPo('Tai Po'),
  tsuenWan('Tsuen Wan'),
  tuenMun('Tuen Mun'),
  yuenLong('Yuen Long'),
  kowloonCity('Kowloon City'),
  kwunTong('Kwun Tong'),
  shamShuiPo('Sham Shui Po'),
  wongTaiSin('Wong Tai Sin'),
  yauTsimMong('Yau Tsim Mong'),
  centralAndWestern('Central and Western'),
  eastern('Eastern'),
  southern('Southern'),
  wanChai('Wan Chai');

  final String value;

  const District(this.value);

  static District? findByString(String district) =>
      District.values.firstWhereOrNull((element) => element.value == district);
}
