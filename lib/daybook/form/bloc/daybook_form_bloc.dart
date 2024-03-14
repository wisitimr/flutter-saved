import 'package:equatable/equatable.dart';
import 'package:findigitalservice/core/core.dart';
import 'package:findigitalservice/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/daybook/form/models/models.dart';
import 'package:findigitalservice/models/master/ms_supplier.dart';

part 'daybook_form_event.dart';
part 'daybook_form_state.dart';

class DaybookFormBloc extends Bloc<DaybookFormEvent, DaybookFormState> {
  DaybookFormBloc(AppProvider provider)
      : _provider = provider,
        super(DaybookFormLoading()) {
    on<DaybookFormStarted>(_onStarted);
    on<DaybookFormIdChanged>(_onIdChanged);
    on<DaybookFormNumberChanged>(_onNumberChanged);
    on<DaybookFormInvoiceChanged>(_onInvoiceChanged);
    on<DaybookFormDocumentChanged>(_onDocumentChanged);
    on<DaybookFormTransactionDateChanged>(_onTransactionDateChanged);
    on<DaybookFormCompanyChanged>(_onCompanyChanged);
    on<DaybookFormSupplierChanged>(_onSupplierChanged);
    on<DaybookFormCustomerChanged>(_onCustomerChanged);
    on<DaybookFormPaymentMethodChanged>(_onPaymentMethodChanged);
    on<DaybookFormSubmitConfirm>(_onSubmitConfirm);
    on<DaybookSubmitted>(_onSubmitted);
    on<DaybookFormDeleteConfirm>(_onDeleteConfirm);
    on<DaybookFormDelete>(_onDelete);
  }

  final AppProvider _provider;
  final DaybookService _daybookService = DaybookService();
  final DaybookDetailService _daybookDetailService = DaybookDetailService();
  final DocumentService _documentService = DocumentService();
  final SupplierService _supplierService = SupplierService();
  final CustomerService _customerService = CustomerService();
  final PaymentMethodService _paymentMethodService = PaymentMethodService();

  Future<void> _onStarted(
      DaybookFormStarted event, Emitter<DaybookFormState> emit) async {
    emit(state.copyWith(status: DaybookFormStatus.loading));
    try {
      final [docRes, supRes, cusRes, payRes] = await Future.wait([
        _documentService.findAll(_provider, {}),
        _supplierService.findAll(_provider, {}),
        _customerService.findAll(_provider, {}),
        _paymentMethodService.findAll(_provider, {}),
      ]);
      List<MsDocument> documents = [];
      List<MsSupplier> suppliers = [];
      List<MsCustomer> customers = [];
      List<MsPaymentMethod> paymentMethods = [];
      final form = DaybookFormTmp();
      form.company = _provider.companyId;
      if (event.id.isNotEmpty) {
        final invRes = await _daybookService.findById(_provider, event.id);
        if (invRes != null && invRes['statusCode'] == 200) {
          DaybookFormModel data = DaybookFormModel.fromJson(invRes['data']);
          form.id = data.id;
          form.number = data.number;
          form.invoice = data.invoice;
          form.document = data.document;
          form.transactionDate = data.transactionDate;
          form.supplier = data.supplier;
          form.customer = data.customer;
          form.paymentMethod = data.paymentMethod;
          form.daybookDetail = data.daybookDetail;
        }
      }
      if (docRes['statusCode'] == 200) {
        List data = docRes['data'];
        documents = data.map((item) => MsDocument.fromJson(item)).toList();
      }
      if (supRes['statusCode'] == 200) {
        List data = supRes['data'];
        suppliers.addAll([
          const MsSupplier(
            id: '',
            code: '',
            name: '-- Select --',
            address: '',
            phone: '',
            contact: '',
          ),
          ...data.map((item) => MsSupplier.fromJson(item)).toList(),
        ]);
      }
      if (cusRes['statusCode'] == 200) {
        List data = cusRes['data'];
        customers.addAll([
          const MsCustomer(
            id: '',
            code: '',
            name: '-- Select --',
            address: '',
            phone: '',
            contact: '',
          ),
          ...data.map((item) => MsCustomer.fromJson(item)).toList(),
        ]);
      }
      if (payRes['statusCode'] == 200) {
        List data = payRes['data'];
        paymentMethods.addAll([
          const MsPaymentMethod(
            id: '',
            name: '-- Select --',
          ),
          ...data.map((item) => MsPaymentMethod.fromJson(item)).toList(),
        ]);
      }
      if (documents.isNotEmpty) {
        if (form.document.isEmpty) {
          form.document = documents[0].id;
          form.documentType = documents[0].code;
        } else {
          for (var doc in documents) {
            if (doc.id == form.document) {
              form.documentType = doc.code;
              form.documentName = doc.name;
            }
          }
        }
      }
      if (suppliers.isNotEmpty) {
        if (form.supplier.isNotEmpty) {
          for (var sup in suppliers) {
            if (sup.id == form.supplier) {
              form.supplierName = sup.name;
            }
          }
        }
      }
      if (customers.isNotEmpty) {
        if (form.customer.isNotEmpty) {
          for (var cus in customers) {
            if (cus.id == form.customer) {
              form.customerName = cus.name;
            }
          }
        }
      }
      if (paymentMethods.isNotEmpty) {
        if (form.paymentMethod.isNotEmpty) {
          for (var cus in paymentMethods) {
            if (cus.id == form.paymentMethod) {
              form.paymentMethodName = cus.name;
            }
          }
        }
      }
      final id = Id.dirty(form.id);
      final number = Number.dirty(form.number);
      final invoice = Invoice.dirty(form.invoice);
      final document = Document.dirty(form.document);
      final transactionDate = TransactionDate.dirty(form.transactionDate);
      final company = Company.dirty(form.company);
      final supplier = Supplier.dirty(form.supplier);
      final customer = Customer.dirty(form.customer);
      final paymentMethod = PaymentMethod.dirty(form.paymentMethod);

      emit(state.copyWith(
        status: DaybookFormStatus.success,
        msDocument: documents,
        msSupplier: suppliers,
        msCustomer: customers,
        msPaymentMethod: paymentMethods,
        id: id,
        number: number,
        invoice: invoice,
        document: document,
        transactionDate: transactionDate,
        company: company,
        supplier: supplier,
        customer: customer,
        paymentMethod: paymentMethod,
        daybookDetail: form.daybookDetail,
        documentType: form.documentType,
        documentName: form.documentName,
        supplierName: form.supplierName,
        customerName: form.customerName,
        paymentMethodName: form.paymentMethodName,
        isValid: validateWithDocumentInput(
          [number, invoice, document, transactionDate, company],
          false,
        ),
        isHistory: event.isHistory,
        isNew: event.isNew,
        year: event.year,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DaybookFormStatus.failure,
        message: e.toString(),
      ));
    }
  }

  void _onIdChanged(
    DaybookFormIdChanged event,
    Emitter<DaybookFormState> emit,
  ) {
    final id = Id.dirty(event.id);
    emit(
      state.copyWith(
        id: id,
        isValid: validateWithDocumentInput(
          [
            state.number,
            state.invoice,
            state.document,
            state.transactionDate,
            state.company
          ],
          false,
        ),
      ),
    );
  }

  void _onNumberChanged(
    DaybookFormNumberChanged event,
    Emitter<DaybookFormState> emit,
  ) {
    final number = Number.dirty(event.number);
    emit(
      state.copyWith(
        number: number,
        isValid: validateWithDocumentInput(
          [
            number,
            state.invoice,
            state.document,
            state.transactionDate,
            state.company,
          ],
          false,
        ),
      ),
    );
  }

  void _onInvoiceChanged(
    DaybookFormInvoiceChanged event,
    Emitter<DaybookFormState> emit,
  ) {
    final invoice = Invoice.dirty(event.invoice);
    emit(
      state.copyWith(
        invoice: invoice,
        isValid: validateWithDocumentInput(
          [
            state.number,
            invoice,
            state.document,
            state.transactionDate,
            state.company,
          ],
          false,
        ),
      ),
    );
  }

  void _onDocumentChanged(
    DaybookFormDocumentChanged event,
    Emitter<DaybookFormState> emit,
  ) {
    final document = Document.dirty(event.document);
    String documentType = '';
    if (state.msDocument.isNotEmpty) {
      for (var doc in state.msDocument) {
        if (doc.id == document.value) {
          documentType = doc.code;
          break;
        }
      }
    }
    switch (documentType) {
      case 'PAY':
        emit(state.copyWith(customer: const Customer.dirty("")));
        break;
      case 'REC':
        emit(state.copyWith(supplier: const Supplier.dirty("")));
        break;
    }
    emit(
      state.copyWith(
        document: document,
        documentType: documentType,
        isValid: validateWithDocumentInput(
          [
            state.number,
            state.invoice,
            document,
            state.transactionDate,
            state.company,
          ],
          false,
        ),
      ),
    );
  }

  void _onTransactionDateChanged(
    DaybookFormTransactionDateChanged event,
    Emitter<DaybookFormState> emit,
  ) {
    final transactionDate = TransactionDate.dirty(event.transactionDate);
    emit(
      state.copyWith(
        transactionDate: transactionDate,
        isValid: validateWithDocumentInput(
          [
            state.number,
            state.invoice,
            state.document,
            transactionDate,
            state.company,
          ],
          false,
        ),
      ),
    );
  }

  void _onCompanyChanged(
    DaybookFormCompanyChanged event,
    Emitter<DaybookFormState> emit,
  ) {
    final company = Company.dirty(event.company);
    emit(
      state.copyWith(
        company: company,
        isValid: validateWithDocumentInput(
          [
            state.number,
            state.invoice,
            state.document,
            state.transactionDate,
            company,
          ],
          false,
        ),
      ),
    );
  }

  void _onSupplierChanged(
    DaybookFormSupplierChanged event,
    Emitter<DaybookFormState> emit,
  ) {
    final supplier = Supplier.dirty(event.supplier);
    emit(
      state.copyWith(
        supplier: supplier,
        isValid: validateWithDocumentInput(
          [
            state.number,
            state.invoice,
            state.document,
            state.transactionDate,
            state.company,
            supplier,
          ],
          true,
        ),
      ),
    );
  }

  void _onCustomerChanged(
    DaybookFormCustomerChanged event,
    Emitter<DaybookFormState> emit,
  ) {
    final customer = Customer.dirty(event.customer);
    emit(
      state.copyWith(
        customer: customer,
        isValid: validateWithDocumentInput(
          [
            state.number,
            state.invoice,
            state.document,
            state.transactionDate,
            state.company,
            customer,
          ],
          true,
        ),
      ),
    );
  }

  void _onPaymentMethodChanged(
    DaybookFormPaymentMethodChanged event,
    Emitter<DaybookFormState> emit,
  ) {
    final paymentMethod = PaymentMethod.dirty(event.paymentMethod);
    emit(
      state.copyWith(
        paymentMethod: paymentMethod,
        isValid: validateWithDocumentInput(
          [
            state.number,
            state.invoice,
            state.document,
            state.transactionDate,
            state.company,
            paymentMethod,
          ],
          true,
        ),
      ),
    );
  }

  Future<void> _onSubmitConfirm(
    DaybookFormSubmitConfirm event,
    Emitter<DaybookFormState> emit,
  ) async {
    emit(state.copyWith(status: DaybookFormStatus.loading));
    try {
      emit(
        state.copyWith(
          status: DaybookFormStatus.submitConfirmation,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: DaybookFormStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onSubmitted(
    DaybookSubmitted event,
    Emitter<DaybookFormState> emit,
  ) async {
    if (state.isValid) {
      try {
        final Map<String, dynamic> data = {};
        data['id'] = state.id.value;
        data['number'] = state.number.value;
        data['invoice'] = state.invoice.value;
        data['document'] = state.document.value;
        data['transactionDate'] = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'")
            .format(DateTime.parse(state.transactionDate.value));
        data['company'] = state.company.value;
        switch (state.documentType) {
          case 'PAY':
            data['supplier'] = state.supplier.value;
            data['customer'] = null;
            break;
          case 'REC':
            data['supplier'] = null;
            data['customer'] = state.customer.value;
            break;
        }
        List<String> daybookDetail = [];
        if (state.daybookDetail.isNotEmpty) {
          for (var d in state.daybookDetail) {
            daybookDetail.add(d.id);
          }
        }
        data['paymentMethod'] = state.paymentMethod.value;
        data['daybookDetails'] = daybookDetail;
        dynamic res = await _daybookService.save(_provider, data);

        if (res['statusCode'] == 200 || res['statusCode'] == 201) {
          emit(
            state.copyWith(
              status: DaybookFormStatus.submited,
              message: res['statusMessage'],
              isNew: res['statusCode'] == 201,
              id: Id.dirty(res['data']['id']),
              isHistory: false,
              year: DateTime.parse(state.transactionDate.value).year.toString(),
            ),
          );
        } else {
          emit(state.copyWith(
            status: DaybookFormStatus.failure,
            message: res['statusMessage'],
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          status: DaybookFormStatus.failure,
          message: e.toString(),
        ));
      }
    }
  }

  bool validateWithDocumentInput(
      List<FormzInput<dynamic, dynamic>> validateInput, bool ignore) {
    if (!ignore) {
      switch (state.documentType) {
        case 'PAY':
          validateInput.add(state.supplier);
          break;
        case 'REC':
          validateInput.add(state.customer);
          break;
      }
    }
    return Formz.validate(validateInput);
  }

  Future<void> _onDeleteConfirm(
    DaybookFormDeleteConfirm event,
    Emitter<DaybookFormState> emit,
  ) async {
    emit(state.copyWith(status: DaybookFormStatus.loading));
    try {
      emit(
        state.copyWith(
          status: DaybookFormStatus.deleteConfirmation,
          selectedDeleteRowId: event.id,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: DaybookFormStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onDelete(
    DaybookFormDelete event,
    Emitter<DaybookFormState> emit,
  ) async {
    emit(state.copyWith(status: DaybookFormStatus.loading));
    try {
      if (state.selectedDeleteRowId.isNotEmpty) {
        final res = await _daybookDetailService.delete(
            _provider, state.selectedDeleteRowId);
        if (res['statusCode'] == 200) {
          emit(
            state.copyWith(
              status: DaybookFormStatus.deleted,
              message: res['statusMessage'],
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: DaybookFormStatus.failure,
              message: res['statusMessage'],
            ),
          );
        }
      } else {
        emit(state.copyWith(
          status: DaybookFormStatus.failure,
          message: "Invalid parameter",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: DaybookFormStatus.failure,
        message: e.toString(),
      ));
    }
  }
}

class DaybookFormTmp {
  String id = '';
  String number = '';
  String invoice = '';
  String document = '';
  String documentType = '';
  String documentName = '';
  String supplierName = '';
  String customerName = '';
  String paymentMethodName = '';
  String transactionDate =
      DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(DateTime.now());
  String company = '';
  String supplier = '';
  String customer = '';
  String paymentMethod = '';
  List<DaybookDetailListModel> daybookDetail = [];
}
