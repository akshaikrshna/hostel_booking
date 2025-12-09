import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Successpayment extends StatefulWidget {
  const Successpayment({super.key});

  @override
  State<Successpayment> createState() => _SuccesspaymentState();
}

class _SuccesspaymentState extends State<Successpayment> {
  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> downloadInvoice() async {
    final image = await screenshotController.capture();
    if (image == null) return;

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(child: pw.Image(pw.MemoryImage(image)));
        },
      ),
    );

    await Printing.sharePdf(bytes: await pdf.save(), filename: "invoice.pdf");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Screenshot(
                  controller: screenshotController,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            color: Colors.green,
                            size: 50,
                          ),
                        ),

                        const SizedBox(height: 15),

                        const Text(
                          "Payment Successful!",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          "Thank you for booking with us.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54),
                        ),

                        const SizedBox(height: 20),

                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Column(
                            children: [
                              invoiceRow("Booking ID", "#HBK928374"),
                              invoiceRow("Hostel Name", "Green Stay Hostel"),
                              invoiceRow("Room Type", "AC Deluxe Room"),
                              invoiceRow("Check-in Date", "12 Dec 2025"),
                              invoiceRow("Check-out Date", "15 Dec 2025"),
                              invoiceRow("Total Nights", "3"),
                              Divider(),
                              invoiceRow(
                                "Amount Paid",
                                "₹ 2,400",
                                isBold: true,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                ElevatedButton.icon(
                  onPressed: () {
                    downloadInvoice();
                  },
                  icon: const Icon(Icons.download),
                  label: const Text("Download Invoice"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget invoiceRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
