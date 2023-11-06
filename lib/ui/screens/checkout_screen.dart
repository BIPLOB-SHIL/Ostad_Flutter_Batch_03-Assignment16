import 'package:assignment16/data/models/payment_method.dart';
import 'package:assignment16/presentation/state_holders/create_invoice_controller.dart';
import 'package:assignment16/ui/screens/webview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
     Get.find<CreateInvoiceController>().createInvoice().then((value){
       isCompleted = value;
       if(mounted){
         setState(() {});
       }
     });
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
            title: const Text(
              "Check out",
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0,
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
        ),
      body: GetBuilder<CreateInvoiceController>(
        builder: (createInvoiceController) {
          if(createInvoiceController.createInvoiceInProgress){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(!isCompleted){
            return const Center(
              child: Text("Please complete your profile first"),
            );
          }
          return ListView.separated(
              itemCount: createInvoiceController.invoiceCreateResponseModel?.paymentMethod?.length ?? 0,
              itemBuilder: (context, index){
                final PaymentMethod paymentMethod = createInvoiceController.invoiceCreateResponseModel!.paymentMethod![index];
                return  ListTile(
                  leading: Image.network(paymentMethod.logo ?? '',width: 60,),
                  title: Text(paymentMethod.name ?? ''),
                  onTap: (){
                    Get.off(() => WebViewScreen(
                        paymentUrl: paymentMethod.redirectGatewayURL!));
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
          },

            );
        }
      ),
    );


  }
}
