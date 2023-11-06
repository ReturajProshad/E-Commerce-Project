import 'package:crafty_bay_app/data/models/payment_method.dart';
import 'package:crafty_bay_app/presentation/state_holders/create_invoice_controller.dart';
import 'package:crafty_bay_app/presentation/ui/screens/auth/complete_profile_screen.dart';
import 'package:crafty_bay_app/presentation/ui/screens/webview_screen.dart';
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
      Get.find<CreateInvoiceController>().createInvoice().then((value) {
        isCompleted = value;
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Check out'),
        ),
        body: GetBuilder<CreateInvoiceController>(builder: (controller) {
          if (controller.inProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!isCompleted) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text('Please complete your profile first'),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(const CompleteProfileScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Complete Profile"),
                  )
                ],
              ),
            );
          }
          return ListView.separated(
            itemCount:
                controller.invoiceCreateResponseModel?.paymentMethod?.length ??
                    0,
            itemBuilder: (context, index) {
              final PaymentMethod paymentMethod =
                  controller.invoiceCreateResponseModel!.paymentMethod![index];
              return ListTile(
                leading: Image.network(
                  paymentMethod.logo ?? '',
                  width: 60,
                ),
                title: Text(paymentMethod.name ?? ''),
                onTap: () {
                  Get.off(() => WebViewScreen(
                      paymentUrl: paymentMethod.redirectGatewayURL!));
                },
              );
            },
            separatorBuilder: (_, __) => const Divider(),
          );
        }));
  }
}
