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

  static String m0(count) =>
      "${Intl.plural(count, one: 'Button', other: 'Buttons')}";

  static String m1(count) =>
      "${Intl.plural(count, one: 'Color', other: 'Colors')}";

  static String m2(count) =>
      "${Intl.plural(count, one: 'Dialog', other: 'Dialogs')}";

  static String m3(value) => "This field value must be equal to ${value}.";

  static String m4(count) =>
      "${Intl.plural(count, one: 'Extension', other: 'Extensions')}";

  static String m5(count) =>
      "${Intl.plural(count, one: 'Form', other: 'Forms')}";

  static String m6(max) => "Value must be less than or equal to ${max}";

  static String m7(maxLength) =>
      "Value must have a length less than or equal to ${maxLength}";

  static String m8(min) => "Value must be greater than or equal to ${min}.";

  static String m9(minLength) =>
      "Value must have a length greater than or equal to ${minLength}";

  static String m10(count) =>
      "${Intl.plural(count, one: 'New Order', other: 'New Orders')}";

  static String m11(count) =>
      "${Intl.plural(count, one: 'New User', other: 'New Users')}";

  static String m12(value) => "This field value must not be equal to ${value}.";

  static String m13(count) =>
      "${Intl.plural(count, one: 'Page', other: 'Pages')}";

  static String m14(count) =>
      "${Intl.plural(count, one: 'Pending Issue', other: 'Pending Issues')}";

  static String m15(count) =>
      "${Intl.plural(count, one: 'Recent Order', other: 'Recent Orders')}";

  static String m16(count) =>
      "${Intl.plural(count, one: 'UI Element', other: 'UI Elements')}";

  static String m17(year) => 'Daybook (${year})';

  static String m18(count) =>
      "${Intl.plural(count, one: 'User', other: 'Users')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "product": MessageLookupByLibrary.simpleMessage("Product"),
        "material": MessageLookupByLibrary.simpleMessage("Material"),
        "adminPortalLogin":
            MessageLookupByLibrary.simpleMessage("Admin Portal Login"),
        "appTitle":
            MessageLookupByLibrary.simpleMessage("Financial Digital Service"),
        "appShortTitle": MessageLookupByLibrary.simpleMessage("FDS"),
        "backToLogin": MessageLookupByLibrary.simpleMessage("Back to Login"),
        "buttonEmphasis":
            MessageLookupByLibrary.simpleMessage("Button Emphasis"),
        "buttons": m0,
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "successSelect":
            MessageLookupByLibrary.simpleMessage("Successfully selected"),
        "closeNavigationMenu":
            MessageLookupByLibrary.simpleMessage("Close Navigation Menu"),
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "colorPalette": MessageLookupByLibrary.simpleMessage("Color Palette"),
        "colorScheme": MessageLookupByLibrary.simpleMessage("Color Scheme"),
        "colors": m1,
        "confirmDeleteRecord":
            MessageLookupByLibrary.simpleMessage("Confirm delete this record?"),
        "confirmSubmitRecord":
            MessageLookupByLibrary.simpleMessage("Confirm submit this record?"),
        "copy": MessageLookupByLibrary.simpleMessage("Copy"),
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "This field requires a valid credit card number."),
        "crudBack": MessageLookupByLibrary.simpleMessage("Back"),
        "crudDelete": MessageLookupByLibrary.simpleMessage("Delete"),
        "crudDetail": MessageLookupByLibrary.simpleMessage("Detail"),
        "preview": MessageLookupByLibrary.simpleMessage("Preview"),
        "download": MessageLookupByLibrary.simpleMessage("Download"),
        "crudNew": MessageLookupByLibrary.simpleMessage("New"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Dark Theme"),
        "dashboard": MessageLookupByLibrary.simpleMessage("Dashboard"),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "This field requires a valid date string."),
        "dialogs": m2,
        "dontHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "This field requires a valid email address."),
        "equalErrorText": m3,
        "error404": MessageLookupByLibrary.simpleMessage("Error 404"),
        "error404Message": MessageLookupByLibrary.simpleMessage(
            "Sorry, the page you are looking for has been removed or not exists."),
        "error404Title": MessageLookupByLibrary.simpleMessage("Page not found"),
        "example": MessageLookupByLibrary.simpleMessage("Example"),
        "extensions": m4,
        "forms": m5,
        "generalUi": MessageLookupByLibrary.simpleMessage("General UI"),
        "hi": MessageLookupByLibrary.simpleMessage("Hi"),
        "homePage": MessageLookupByLibrary.simpleMessage("Home"),
        "iframeDemo": MessageLookupByLibrary.simpleMessage("IFrame Demo"),
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "This field requires a valid integer."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "This field requires a valid IP."),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Light Theme"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginNow": MessageLookupByLibrary.simpleMessage("Login now!"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "loremIpsum": MessageLookupByLibrary.simpleMessage(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit"),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "Value does not match pattern."),
        "maxErrorText": m6,
        "maxLengthErrorText": m7,
        "minErrorText": m8,
        "minLengthErrorText": m9,
        "myProfile": MessageLookupByLibrary.simpleMessage("My Profile"),
        "newOrders": m10,
        "newUsers": m11,
        "notEqualErrorText": m12,
        "numericErrorText":
            MessageLookupByLibrary.simpleMessage("Value must be numeric."),
        "openInNewTab": MessageLookupByLibrary.simpleMessage("Open in new tab"),
        "pages": m13,
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordHelperText":
            MessageLookupByLibrary.simpleMessage("* 6 - 18 characters"),
        "passwordNotMatch":
            MessageLookupByLibrary.simpleMessage("Password not match."),
        "pendingIssues": m14,
        "recentOrders": m15,
        "recordDeletedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Record deleted successfully."),
        "recordFinancial Digital ServiceSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Record findigitalservice successfully."),
        "recordSubmittedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Record submitted successfully."),
        "register": MessageLookupByLibrary.simpleMessage("Register"),
        "registerANewAccount":
            MessageLookupByLibrary.simpleMessage("Register a new account"),
        "registerNow": MessageLookupByLibrary.simpleMessage("Register!"),
        "requiredErrorText":
            MessageLookupByLibrary.simpleMessage("This field cannot be empty."),
        "retypePassword":
            MessageLookupByLibrary.simpleMessage("Retype Password"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "year": MessageLookupByLibrary.simpleMessage("Year"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "text": MessageLookupByLibrary.simpleMessage("Text"),
        "textEmphasis": MessageLookupByLibrary.simpleMessage("Text Emphasis"),
        "textTheme": MessageLookupByLibrary.simpleMessage("Text Theme"),
        "todaySales": MessageLookupByLibrary.simpleMessage("Today Sales"),
        "typography": MessageLookupByLibrary.simpleMessage("Typography"),
        "uiElements": m16,
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "This field requires a valid URL address."),
        "yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "company": MessageLookupByLibrary.simpleMessage("Company"),
        "companies": MessageLookupByLibrary.simpleMessage("Companies"),
        "code": MessageLookupByLibrary.simpleMessage("Code"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "month": MessageLookupByLibrary.simpleMessage("Month"),
        "date": MessageLookupByLibrary.simpleMessage("Date"),
        "select": MessageLookupByLibrary.simpleMessage("Select"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "address": MessageLookupByLibrary.simpleMessage("Address"),
        "tax": MessageLookupByLibrary.simpleMessage("Tax"),
        "phone": MessageLookupByLibrary.simpleMessage("Phone"),
        "contact": MessageLookupByLibrary.simpleMessage("Contact"),
        "enable": MessageLookupByLibrary.simpleMessage("Enable"),
        "pay": MessageLookupByLibrary.simpleMessage("Daybook journal"),
        "receive":
            MessageLookupByLibrary.simpleMessage("Money received journal"),
        "report": MessageLookupByLibrary.simpleMessage("Report"),
        "financialStatement":
            MessageLookupByLibrary.simpleMessage("Financial Statement"),
        "daybook": MessageLookupByLibrary.simpleMessage("Daybook"),
        "daybookHistory":
            MessageLookupByLibrary.simpleMessage("Daybook History"),
        "ledgerAccount": MessageLookupByLibrary.simpleMessage("Ledger Account"),
        "tb12": MessageLookupByLibrary.simpleMessage("TB12"),
        "task": MessageLookupByLibrary.simpleMessage("Task"),
        "history": MessageLookupByLibrary.simpleMessage("History"),
        "dDaybook": m17,
        "dUser": m18,
        "daybookDetail": MessageLookupByLibrary.simpleMessage("Daybook Detail"),
        "daybookDetailHistory":
            MessageLookupByLibrary.simpleMessage("Daybook Detail History"),
        "detail": MessageLookupByLibrary.simpleMessage("Detail"),
        "debit": MessageLookupByLibrary.simpleMessage("Debit"),
        "credit": MessageLookupByLibrary.simpleMessage("Credit"),
        "balance": MessageLookupByLibrary.simpleMessage("Balance"),
        "price": MessageLookupByLibrary.simpleMessage("Price"),
        "number": MessageLookupByLibrary.simpleMessage("Number"),
        "folio": MessageLookupByLibrary.simpleMessage("Folio"),
        "invoice": MessageLookupByLibrary.simpleMessage("Invoice"),
        "type": MessageLookupByLibrary.simpleMessage("Type"),
        "document": MessageLookupByLibrary.simpleMessage("Document Type"),
        "supplier": MessageLookupByLibrary.simpleMessage("Supplier"),
        "paymentMethod": MessageLookupByLibrary.simpleMessage("Payment Method"),
        "amount": MessageLookupByLibrary.simpleMessage("Amount"),
        "transactionDate":
            MessageLookupByLibrary.simpleMessage("Transaction Date"),
        "createdAt": MessageLookupByLibrary.simpleMessage("Create Date"),
        "updatedAt": MessageLookupByLibrary.simpleMessage("Update Date"),
        "CR": MessageLookupByLibrary.simpleMessage("Credit"),
        "DR": MessageLookupByLibrary.simpleMessage("Debit"),
        "database": MessageLookupByLibrary.simpleMessage("Database"),
        "username": MessageLookupByLibrary.simpleMessage("Username"),
        "firstName": MessageLookupByLibrary.simpleMessage("First Name"),
        "lastName": MessageLookupByLibrary.simpleMessage("Last Name"),
        "role": MessageLookupByLibrary.simpleMessage("Role"),
        "ref": MessageLookupByLibrary.simpleMessage("Reference"),
      };
}
