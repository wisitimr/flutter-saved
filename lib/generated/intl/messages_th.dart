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
  String get localeName => 'th';

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

  static String m17(year) => 'สมุดรายวัน (${year})';

  static String m18(count) =>
      "${Intl.plural(count, one: 'ผู้ใช้งาน', other: 'ผู้ใช้งาน')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "assets": MessageLookupByLibrary.simpleMessage("สินทรัพย์"),
        "liability": MessageLookupByLibrary.simpleMessage("หนี้สิน"),
        "shareholdersEquity":
            MessageLookupByLibrary.simpleMessage("ส่วนของผู้ถือหุ้น"),
        "income": MessageLookupByLibrary.simpleMessage("รายได้"),
        "expense": MessageLookupByLibrary.simpleMessage("ค่าใช้จ่าย"),
        "account": MessageLookupByLibrary.simpleMessage("บัญชี"),
        "accountGroup": MessageLookupByLibrary.simpleMessage("กลุ่มบัญชี"),
        "totalDebit": MessageLookupByLibrary.simpleMessage("รวมเดบิต"),
        "totalCredit": MessageLookupByLibrary.simpleMessage("รวมเครดิต"),
        "product": MessageLookupByLibrary.simpleMessage("สินค้า"),
        "material": MessageLookupByLibrary.simpleMessage("วัสดุ"),
        "adminPortalLogin":
            MessageLookupByLibrary.simpleMessage("Admin Portal Login"),
        "appTitle":
            MessageLookupByLibrary.simpleMessage("Financial Digital Service"),
        "appShortTitle": MessageLookupByLibrary.simpleMessage("FDS"),
        "backToLogin":
            MessageLookupByLibrary.simpleMessage("กลับไปหน้าเข้าสู่ระบบ"),
        "buttonEmphasis":
            MessageLookupByLibrary.simpleMessage("Button Emphasis"),
        "buttons": m0,
        "cancel": MessageLookupByLibrary.simpleMessage("ยกเลิก"),
        "successSelect": MessageLookupByLibrary.simpleMessage("เลือกสำเร็จ"),
        "closeNavigationMenu":
            MessageLookupByLibrary.simpleMessage("Close Navigation Menu"),
        "close": MessageLookupByLibrary.simpleMessage("ปิด"),
        "colorPalette": MessageLookupByLibrary.simpleMessage("Color Palette"),
        "colorScheme": MessageLookupByLibrary.simpleMessage("Color Scheme"),
        "colors": m1,
        "confirmDeleteRecord":
            MessageLookupByLibrary.simpleMessage("ยินยันการลบ?"),
        "confirmSubmitRecord":
            MessageLookupByLibrary.simpleMessage("ยืนยันการทำรายการ?"),
        "copy": MessageLookupByLibrary.simpleMessage("Copy"),
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "This field requires a valid credit card number."),
        "crudBack": MessageLookupByLibrary.simpleMessage("กลับ"),
        "crudDelete": MessageLookupByLibrary.simpleMessage("ลบ"),
        "crudDetail": MessageLookupByLibrary.simpleMessage("รายละเอียด"),
        "preview": MessageLookupByLibrary.simpleMessage("ดูตัวอย่าง"),
        "download": MessageLookupByLibrary.simpleMessage("ดาวน์โหลด"),
        "crudNew": MessageLookupByLibrary.simpleMessage("เพิ่ม"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Dark Theme"),
        "dashboard": MessageLookupByLibrary.simpleMessage("แผงควบคุม"),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "This field requires a valid date string."),
        "dialogs": m2,
        "dontHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("ไม่มีบัญชี?"),
        "email": MessageLookupByLibrary.simpleMessage("อีเมล"),
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
        "hi": MessageLookupByLibrary.simpleMessage("สวัสดี"),
        "homePage": MessageLookupByLibrary.simpleMessage("Home"),
        "iframeDemo": MessageLookupByLibrary.simpleMessage("IFrame Demo"),
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "This field requires a valid integer."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "This field requires a valid IP."),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Light Theme"),
        "login": MessageLookupByLibrary.simpleMessage("เข้าสู่ระบบ"),
        "loginNow": MessageLookupByLibrary.simpleMessage("เข้าสู่ระบบ!"),
        "logout": MessageLookupByLibrary.simpleMessage("ออกจากระบบ"),
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
        "password": MessageLookupByLibrary.simpleMessage("รหัสผ่าน"),
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
        "register": MessageLookupByLibrary.simpleMessage("ลงทะเบียน"),
        "registerANewAccount":
            MessageLookupByLibrary.simpleMessage("ลงทะเบียนบัญชีใหม่"),
        "registerNow": MessageLookupByLibrary.simpleMessage("ลงทะเบียน!"),
        "requiredErrorText":
            MessageLookupByLibrary.simpleMessage("This field cannot be empty."),
        "retypePassword":
            MessageLookupByLibrary.simpleMessage("ยืนยันรหัสผ่าน"),
        "save": MessageLookupByLibrary.simpleMessage("บันทึก"),
        "year": MessageLookupByLibrary.simpleMessage("ปี"),
        "search": MessageLookupByLibrary.simpleMessage("ค้นหา"),
        "ok": MessageLookupByLibrary.simpleMessage("ตกลง"),
        "text": MessageLookupByLibrary.simpleMessage("Text"),
        "textEmphasis": MessageLookupByLibrary.simpleMessage("Text Emphasis"),
        "textTheme": MessageLookupByLibrary.simpleMessage("Text Theme"),
        "todaySales": MessageLookupByLibrary.simpleMessage("Today Sales"),
        "typography": MessageLookupByLibrary.simpleMessage("Typography"),
        "uiElements": m16,
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "This field requires a valid URL address."),
        "yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "companies": MessageLookupByLibrary.simpleMessage("บริษัท"),
        "company": MessageLookupByLibrary.simpleMessage("บริษัท"),
        "code": MessageLookupByLibrary.simpleMessage("รหัส"),
        "name": MessageLookupByLibrary.simpleMessage("ชื่อ"),
        "month": MessageLookupByLibrary.simpleMessage("เดือน"),
        "date": MessageLookupByLibrary.simpleMessage("วันที่"),
        "select": MessageLookupByLibrary.simpleMessage("เลือก"),
        "description": MessageLookupByLibrary.simpleMessage("คำอธิบาย"),
        "tax": MessageLookupByLibrary.simpleMessage("ภาษี"),
        "address": MessageLookupByLibrary.simpleMessage("ที่อยู่"),
        "phone": MessageLookupByLibrary.simpleMessage("เบอร์ติดต่อ"),
        "contact": MessageLookupByLibrary.simpleMessage("ติดต่อ"),
        "enable": MessageLookupByLibrary.simpleMessage("เปิดการใช้งาน"),
        "report": MessageLookupByLibrary.simpleMessage("รายงาน"),
        "financialStatement": MessageLookupByLibrary.simpleMessage("งบการเงิน"),
        "daybook": MessageLookupByLibrary.simpleMessage("สมุดรายวัน"),
        "daybookHistory":
            MessageLookupByLibrary.simpleMessage("ประวัติสมุดรายวัน"),
        "ledgerAccount": MessageLookupByLibrary.simpleMessage("แยกประเภท"),
        "tb12": MessageLookupByLibrary.simpleMessage("TB12"),
        "task": MessageLookupByLibrary.simpleMessage("งานรอดำเนินการ"),
        "history": MessageLookupByLibrary.simpleMessage("ประวัติ"),
        "dDaybook": m17,
        "dUser": m18,
        "daybookDetail":
            MessageLookupByLibrary.simpleMessage("รายละเอียดสมุดรายวัน"),
        "daybookDetailHistory":
            MessageLookupByLibrary.simpleMessage("ประวัติรายละเอียดสมุดรายวัน"),
        "detail": MessageLookupByLibrary.simpleMessage("รายละเอียด"),
        "debit": MessageLookupByLibrary.simpleMessage("เดบิต"),
        "credit": MessageLookupByLibrary.simpleMessage("เครดิต"),
        "balance": MessageLookupByLibrary.simpleMessage("ยอดคงเหลือ"),
        "price": MessageLookupByLibrary.simpleMessage("ราคา"),
        "number": MessageLookupByLibrary.simpleMessage("เลขที่"),
        "folio": MessageLookupByLibrary.simpleMessage("หน้าบัญชี"),
        "invoice": MessageLookupByLibrary.simpleMessage("ใบแจ้งหนี้"),
        "type": MessageLookupByLibrary.simpleMessage("ประเภท"),
        "document": MessageLookupByLibrary.simpleMessage("ประเภทเอกสาร"),
        "supplier": MessageLookupByLibrary.simpleMessage("ผู้จัดหา"),
        "customer": MessageLookupByLibrary.simpleMessage("ลูกค้า"),
        "paymentMethod":
            MessageLookupByLibrary.simpleMessage("วิธีการชำระเงิน"),
        "amount": MessageLookupByLibrary.simpleMessage("จำนวน"),
        "transactionDate":
            MessageLookupByLibrary.simpleMessage("วันที่ทำรายการ"),
        "createdAt": MessageLookupByLibrary.simpleMessage("วันที่สร้าง"),
        "updatedAt": MessageLookupByLibrary.simpleMessage("วันที่แก้ไข"),
        "CR": MessageLookupByLibrary.simpleMessage("เครดิต"),
        "DR": MessageLookupByLibrary.simpleMessage("เดบิต"),
        "database": MessageLookupByLibrary.simpleMessage("ฐานข้อมูล"),
        "username": MessageLookupByLibrary.simpleMessage("ชื่อผู้ใช้"),
        "firstName": MessageLookupByLibrary.simpleMessage("ชื่อจริง"),
        "lastName": MessageLookupByLibrary.simpleMessage("นามสกุล"),
        "role": MessageLookupByLibrary.simpleMessage("บทบาท"),
        "ref": MessageLookupByLibrary.simpleMessage("อ้างอิง"),
      };
}
