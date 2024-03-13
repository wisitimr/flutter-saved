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

class Lang {
  Lang();

  static Lang? _current;

  static Lang get current {
    assert(_current != null,
        'No instance of Lang was loaded. Try to initialize the Lang delegate before accessing Lang.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Lang> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Lang();
      Lang._current = instance;

      return instance;
    });
  }

  static Lang of(BuildContext context) {
    final instance = Lang.maybeOf(context);
    assert(instance != null,
        'No instance of Lang present in the widget tree. Did you add Lang.delegate in localizationsDelegates?');
    return instance!;
  }

  static Lang? maybeOf(BuildContext context) {
    return Localizations.of<Lang>(context, Lang);
  }

  String getAccoutGroup(String type) {
    return Intl.message(
      '',
      name: type,
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  String get accountCode {
    return Intl.message(
      'Account Code',
      name: 'accountCode',
      desc: '',
      args: [],
    );
  }

  String get accountName {
    return Intl.message(
      'Account Name',
      name: 'accountName',
      desc: '',
      args: [],
    );
  }

  String get accountGroup {
    return Intl.message(
      'Account Group',
      name: 'accountGroup',
      desc: '',
      args: [],
    );
  }

  String get totalDebit {
    return Intl.message(
      'Total Debit',
      name: 'totalDebit',
      desc: '',
      args: [],
    );
  }

  String get totalCredit {
    return Intl.message(
      'Total Credit',
      name: 'totalCredit',
      desc: '',
      args: [],
    );
  }

  String get product {
    return Intl.message(
      'Product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  String get material {
    return Intl.message(
      'Material',
      name: 'material',
      desc: '',
      args: [],
    );
  }

  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Admin Portal Login`
  String get adminPortalLogin {
    return Intl.message(
      'Admin Portal Login',
      name: 'adminPortalLogin',
      desc: '',
      args: [],
    );
  }

  /// `Web Admin`
  String get appTitle {
    return Intl.message(
      'Financial Digital Service',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  String get appShortTitle {
    return Intl.message(
      'FDS',
      name: 'appShortTitle',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get backToLogin {
    return Intl.message(
      'Back to Login',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Button Emphasis`
  String get buttonEmphasis {
    return Intl.message(
      'Button Emphasis',
      name: 'buttonEmphasis',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{Button} other{Buttons}}`
  String buttons(num count) {
    return Intl.plural(
      count,
      one: 'Button',
      other: 'Buttons',
      name: 'buttons',
      desc: '',
      args: [count],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  String get successSelect {
    return Intl.message(
      'Successfully selected',
      name: 'successSelect',
      desc: '',
      args: [],
    );
  }

  /// `Close Navigation Menu`
  String get closeNavigationMenu {
    return Intl.message(
      'Close Navigation Menu',
      name: 'closeNavigationMenu',
      desc: '',
      args: [],
    );
  }

  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{Color} other{Colors}}`
  String colors(num count) {
    return Intl.plural(
      count,
      one: 'Color',
      other: 'Colors',
      name: 'colors',
      desc: '',
      args: [count],
    );
  }

  /// `Color Palette`
  String get colorPalette {
    return Intl.message(
      'Color Palette',
      name: 'colorPalette',
      desc: '',
      args: [],
    );
  }

  /// `Color Scheme`
  String get colorScheme {
    return Intl.message(
      'Color Scheme',
      name: 'colorScheme',
      desc: '',
      args: [],
    );
  }

  /// `Confirm delete this record?`
  String get confirmDeleteRecord {
    return Intl.message(
      'Confirm delete this record?',
      name: 'confirmDeleteRecord',
      desc: '',
      args: [],
    );
  }

  /// `Confirm submit this record?`
  String get confirmSubmitRecord {
    return Intl.message(
      'Confirm submit this record?',
      name: 'confirmSubmitRecord',
      desc: '',
      args: [],
    );
  }

  String get confirm {
    return Intl.message(
      'Confirm?',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message(
      'Copy',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `This field requires a valid credit card number.`
  String get creditCardErrorText {
    return Intl.message(
      'This field requires a valid credit card number.',
      name: 'creditCardErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get crudBack {
    return Intl.message(
      'Back',
      name: 'crudBack',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get crudDelete {
    return Intl.message(
      'Delete',
      name: 'crudDelete',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get crudDetail {
    return Intl.message(
      'Detail',
      name: 'crudDetail',
      desc: '',
      args: [],
    );
  }

  String get preview {
    return Intl.message(
      'Preview',
      name: 'preview',
      desc: '',
      args: [],
    );
  }

  String get download {
    return Intl.message(
      'Download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get crudNew {
    return Intl.message(
      'New',
      name: 'crudNew',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get darkTheme {
    return Intl.message(
      'Dark Theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `This field requires a valid date string.`
  String get dateStringErrorText {
    return Intl.message(
      'This field requires a valid date string.',
      name: 'dateStringErrorText',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{Dialog} other{Dialogs}}`
  String dialogs(num count) {
    return Intl.plural(
      count,
      one: 'Dialog',
      other: 'Dialogs',
      name: 'dialogs',
      desc: '',
      args: [count],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAnAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAnAccount',
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

  /// `This field requires a valid email address.`
  String get emailErrorText {
    return Intl.message(
      'This field requires a valid email address.',
      name: 'emailErrorText',
      desc: '',
      args: [],
    );
  }

  /// `This field value must be equal to {value}.`
  String equalErrorText(Object value) {
    return Intl.message(
      'This field value must be equal to $value.',
      name: 'equalErrorText',
      desc: '',
      args: [value],
    );
  }

  /// `Error 404`
  String get error404 {
    return Intl.message(
      'Error 404',
      name: 'error404',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, the page you are looking for has been removed or not exists.`
  String get error404Message {
    return Intl.message(
      'Sorry, the page you are looking for has been removed or not exists.',
      name: 'error404Message',
      desc: '',
      args: [],
    );
  }

  /// `Page not found`
  String get error404Title {
    return Intl.message(
      'Page not found',
      name: 'error404Title',
      desc: '',
      args: [],
    );
  }

  /// `Example`
  String get example {
    return Intl.message(
      'Example',
      name: 'example',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{Extension} other{Extensions}}`
  String extensions(num count) {
    return Intl.plural(
      count,
      one: 'Extension',
      other: 'Extensions',
      name: 'extensions',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, one{Form} other{Forms}}`
  String forms(num count) {
    return Intl.plural(
      count,
      one: 'Form',
      other: 'Forms',
      name: 'forms',
      desc: '',
      args: [count],
    );
  }

  /// `General UI`
  String get generalUi {
    return Intl.message(
      'General UI',
      name: 'generalUi',
      desc: '',
      args: [],
    );
  }

  /// `Hi`
  String get hi {
    return Intl.message(
      'Hi',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homePage {
    return Intl.message(
      'Home',
      name: 'homePage',
      desc: '',
      args: [],
    );
  }

  /// `IFrame Demo`
  String get iframeDemo {
    return Intl.message(
      'IFrame Demo',
      name: 'iframeDemo',
      desc: '',
      args: [],
    );
  }

  /// `This field requires a valid integer.`
  String get integerErrorText {
    return Intl.message(
      'This field requires a valid integer.',
      name: 'integerErrorText',
      desc: '',
      args: [],
    );
  }

  /// `This field requires a valid IP.`
  String get ipErrorText {
    return Intl.message(
      'This field requires a valid IP.',
      name: 'ipErrorText',
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

  /// `Light Theme`
  String get lightTheme {
    return Intl.message(
      'Light Theme',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Login now!`
  String get loginNow {
    return Intl.message(
      'Login now!',
      name: 'loginNow',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Lorem ipsum dolor sit amet, consectetur adipiscing elit`
  String get loremIpsum {
    return Intl.message(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
      name: 'loremIpsum',
      desc: '',
      args: [],
    );
  }

  /// `Value does not match pattern.`
  String get matchErrorText {
    return Intl.message(
      'Value does not match pattern.',
      name: 'matchErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Value must be less than or equal to {max}`
  String maxErrorText(Object max) {
    return Intl.message(
      'Value must be less than or equal to $max',
      name: 'maxErrorText',
      desc: '',
      args: [max],
    );
  }

  /// `Value must have a length less than or equal to {maxLength}`
  String maxLengthErrorText(Object maxLength) {
    return Intl.message(
      'Value must have a length less than or equal to $maxLength',
      name: 'maxLengthErrorText',
      desc: '',
      args: [maxLength],
    );
  }

  /// `Value must be greater than or equal to {min}.`
  String minErrorText(Object min) {
    return Intl.message(
      'Value must be greater than or equal to $min.',
      name: 'minErrorText',
      desc: '',
      args: [min],
    );
  }

  /// `Value must have a length greater than or equal to {minLength}`
  String minLengthErrorText(Object minLength) {
    return Intl.message(
      'Value must have a length greater than or equal to $minLength',
      name: 'minLengthErrorText',
      desc: '',
      args: [minLength],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{New Order} other{New Orders}}`
  String newOrders(num count) {
    return Intl.plural(
      count,
      one: 'New Order',
      other: 'New Orders',
      name: 'newOrders',
      desc: '',
      args: [count],
    );
  }

  String dDaybook(String value) {
    return Intl.message(
      'Daybook - $value.',
      name: 'dDaybook',
      desc: '',
      args: [value],
    );
  }

  /// `{count, plural, one{New User} other{New Users}}`
  String newUsers(num count) {
    return Intl.plural(
      count,
      one: 'New User',
      other: 'New Users',
      name: 'newUsers',
      desc: '',
      args: [count],
    );
  }

  String user(num count) {
    return Intl.plural(
      count,
      one: 'User',
      other: 'Users',
      name: 'dUser',
      desc: '',
      args: [count],
    );
  }

  /// `This field value must not be equal to {value}.`
  String notEqualErrorText(Object value) {
    return Intl.message(
      'This field value must not be equal to $value.',
      name: 'notEqualErrorText',
      desc: '',
      args: [value],
    );
  }

  /// `Value must be numeric.`
  String get numericErrorText {
    return Intl.message(
      'Value must be numeric.',
      name: 'numericErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Open in new tab`
  String get openInNewTab {
    return Intl.message(
      'Open in new tab',
      name: 'openInNewTab',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{Page} other{Pages}}`
  String pages(num count) {
    return Intl.plural(
      count,
      one: 'Page',
      other: 'Pages',
      name: 'pages',
      desc: '',
      args: [count],
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

  /// `* 6 - 18 characters`
  String get passwordHelperText {
    return Intl.message(
      '* 6 - 18 characters',
      name: 'passwordHelperText',
      desc: '',
      args: [],
    );
  }

  /// `Password not match.`
  String get passwordNotMatch {
    return Intl.message(
      'Password not match.',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{Pending Issue} other{Pending Issues}}`
  String pendingIssues(num count) {
    return Intl.plural(
      count,
      one: 'Pending Issue',
      other: 'Pending Issues',
      name: 'pendingIssues',
      desc: '',
      args: [count],
    );
  }

  String get company {
    return Intl.message(
      'Company',
      name: 'company',
      desc: '',
      args: [],
    );
  }

  String get companies {
    return Intl.message(
      'Companies',
      name: 'companies',
      desc: '',
      args: [],
    );
  }

  /// `Record deleted successfully.`
  String get recordDeletedSuccessfully {
    return Intl.message(
      'Record deleted successfully.',
      name: 'recordDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Record Saved successfully.`
  String get recordSavedSuccessfully {
    return Intl.message(
      'Record findigitalservice successfully.',
      name: 'recordSavedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Record submitted successfully.`
  String get recordSubmittedSuccessfully {
    return Intl.message(
      'Record submitted successfully.',
      name: 'recordSubmittedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Register a new account`
  String get registerANewAccount {
    return Intl.message(
      'Register a new account',
      name: 'registerANewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register now!`
  String get registerNow {
    return Intl.message(
      'Register!',
      name: 'registerNow',
      desc: '',
      args: [],
    );
  }

  /// `This field cannot be empty.`
  String get requiredErrorText {
    return Intl.message(
      'This field cannot be empty.',
      name: 'requiredErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Retype Password`
  String get retypePassword {
    return Intl.message(
      'Retype Password',
      name: 'retypePassword',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Text`
  String get text {
    return Intl.message(
      'Text',
      name: 'text',
      desc: '',
      args: [],
    );
  }

  String get ref {
    return Intl.message(
      'Ref',
      name: 'ref',
      desc: '',
      args: [],
    );
  }

  /// `Text Emphasis`
  String get textEmphasis {
    return Intl.message(
      'Text Emphasis',
      name: 'textEmphasis',
      desc: '',
      args: [],
    );
  }

  /// `Text Theme`
  String get textTheme {
    return Intl.message(
      'Text Theme',
      name: 'textTheme',
      desc: '',
      args: [],
    );
  }

  /// `Today Sales`
  String get todaySales {
    return Intl.message(
      'Today Sales',
      name: 'todaySales',
      desc: '',
      args: [],
    );
  }

  /// `Typography`
  String get typography {
    return Intl.message(
      'Typography',
      name: 'typography',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{UI Element} other{UI Elements}}`
  String uiElements(num count) {
    return Intl.plural(
      count,
      one: 'UI Element',
      other: 'UI Elements',
      name: 'uiElements',
      desc: '',
      args: [count],
    );
  }

  /// `This field requires a valid URL address.`
  String get urlErrorText {
    return Intl.message(
      'This field requires a valid URL address.',
      name: 'urlErrorText',
      desc: '',
      args: [],
    );
  }

  String get database {
    return Intl.message(
      'Database',
      name: 'database',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  String get role {
    return Intl.message(
      'Role',
      name: 'role',
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

  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  String get daybook {
    return Intl.message(
      'Daybook',
      name: 'daybook',
      desc: '',
      args: [],
    );
  }

  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  String get financialStatement {
    return Intl.message(
      'Financial Statement',
      name: 'financialStatement',
      desc: '',
      args: [],
    );
  }

  String get daybookHistory {
    return Intl.message(
      'Daybook History',
      name: 'daybookHistory',
      desc: '',
      args: [],
    );
  }

  String get ledgerAccount {
    return Intl.message(
      'Ledger Account',
      name: 'ledgerAccount',
      desc: '',
      args: [],
    );
  }

  String get tb12 {
    return Intl.message(
      'TB12',
      name: 'tb12',
      desc: '',
      args: [],
    );
  }

  String get task {
    return Intl.message(
      'Task',
      name: 'task',
      desc: '',
      args: [],
    );
  }

  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  String get daybookDetail {
    return Intl.message(
      'DaybookDetail',
      name: 'daybookDetail',
      desc: '',
      args: [],
    );
  }

  String get daybookDetailHistory {
    return Intl.message(
      'DaybookDetail History',
      name: 'daybookDetailHistory',
      desc: '',
      args: [],
    );
  }

  String get detail {
    return Intl.message(
      'Detail',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  String get debit {
    return Intl.message(
      'Debit',
      name: 'debit',
      desc: '',
      args: [],
    );
  }

  String get credit {
    return Intl.message(
      'Credit',
      name: 'credit',
      desc: '',
      args: [],
    );
  }

  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  String get number {
    return Intl.message(
      'Number',
      name: 'number',
      desc: '',
      args: [],
    );
  }

  String get folio {
    return Intl.message(
      'Folio',
      name: 'folio',
      desc: '',
      args: [],
    );
  }

  String get invoice {
    return Intl.message(
      'Invoice',
      name: 'invoice',
      desc: '',
      args: [],
    );
  }

  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  String get document {
    return Intl.message(
      'Document',
      name: 'document',
      desc: '',
      args: [],
    );
  }

  String get supplier {
    return Intl.message(
      'Supplier',
      name: 'supplier',
      desc: '',
      args: [],
    );
  }

  String get customer {
    return Intl.message(
      'Customer',
      name: 'customer',
      desc: '',
      args: [],
    );
  }

  String get paymentMethod {
    return Intl.message(
      'Payment Type',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  String getAccoutingType(String type) {
    if (type == '') {
      return '-- Select --';
    } else {
      return Intl.message(
        '',
        name: type,
        desc: '',
        args: [],
      );
    }
  }

  String get transactionDate {
    return Intl.message(
      'TransactionDate',
      name: 'transactionDate',
      desc: '',
      args: [],
    );
  }

  String get createdAt {
    return Intl.message(
      'CreatedAt',
      name: 'createdAt',
      desc: '',
      args: [],
    );
  }

  String get updatedAt {
    return Intl.message(
      'UpdatedAt',
      name: 'updatedAt',
      desc: '',
      args: [],
    );
  }

  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  String get tax {
    return Intl.message(
      'Tax',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  String get contact {
    return Intl.message(
      'Contact',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  String get enable {
    return Intl.message(
      'Enable',
      name: 'enable',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Lang> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'th'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Lang> load(Locale locale) => Lang.load(locale);
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
