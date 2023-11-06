import 'package:get/get.dart';
import '../../data/models/invoice_create_response_model.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class CreateInvoiceController extends GetxController{

  bool _createInvoiceInProgress = false;
  bool get createInvoiceInProgress => _createInvoiceInProgress;

  String _message ='';
  String get message => _message;

  InvoiceCreateResponseModel _invoiceCreateResponseModel = InvoiceCreateResponseModel();
  InvoiceCreateData? get invoiceCreateResponseModel => _invoiceCreateResponseModel.data?.first;


  Future<bool> createInvoice() async {
    _createInvoiceInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller
        .getRequest(Urls.createInvoice);

    _createInvoiceInProgress = false;

    if (response.isSuccess) {
     _invoiceCreateResponseModel = InvoiceCreateResponseModel.fromJson(response.responseBody!);
      update();
      return true;

    } else {
      _message = 'Invoice creation failed! Try again';
      update();
      return false;
    }
  }

}