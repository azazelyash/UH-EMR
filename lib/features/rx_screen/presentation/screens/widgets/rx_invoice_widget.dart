import 'package:flutter/material.dart';
import 'rx_preview_medicine_tile.dart';
import 'rx_invoice_footer_widget.dart';
import 'rx_invoice_header_widget.dart';
import 'rx_invoice_additional_notes.dart';
import 'rx_invoice_patient_details_widget.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aasa_emr/features/dashboard/data/models/rx_model.dart';
import 'package:aasa_emr/features/dashboard/data/models/appointment.dart';

class RxInvoiceWidget extends StatelessWidget {
  const RxInvoiceWidget({
    super.key,
    this.logoUrl,
    required this.rxData,
    required this.appointment,
  });

  final RxModel? rxData;
  final String? logoUrl;
  final Appointment? appointment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RxInvoiceHeader(
          logoUrl: logoUrl,
        ),
        RxInvoicePatientDetails(
          appointment: appointment,
          selectedSymptoms: rxData?.symptoms,
          patientBasicDetail: rxData?.patientBasicDetail,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Diagnosis",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 10.h),
          ],
        ),
        (rxData != null)
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rxData!.diagnosis!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(
                            "${index + 1}.",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Text(
                            rxData!.diagnosis![index].condition!.conditionName ?? "-",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : const SizedBox(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),
            const DottedDashedLine(
              height: 1,
              width: double.infinity,
              axis: Axis.horizontal,
            ),
            SizedBox(height: 12.h),
            Text(
              "Medications",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 10.h),
            Row(
              children: <Widget>[
                const Expanded(
                  flex: 3,
                  child: Text("Tests/Medicine"),
                ),
                SizedBox(width: 6.w),
                const Expanded(
                  flex: 1,
                  child: Text("Days"),
                ),
                SizedBox(width: 3.w),
                const Expanded(
                  flex: 2,
                  child: Text("Frequency"),
                ),
              ],
            )
          ],
        ),
        (rxData != null)
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: rxData!.medication!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return RxPreviewMedicineTileWidget(
                    medType: rxData!.medication![index].medicineType ?? "Tablet",
                    medName: rxData!.medication![index].medicine,
                    noOfDays: rxData!.medication![index].days,
                    frequency: rxData!.medication![index].frequency,
                    foodTiming: rxData!.medication![index].foodTime,
                    doctorNote: rxData!.medication![index].note,
                    intake: rxData!.medication![index].intake,
                  );
                },
              )
            : const SizedBox(),
        RxInvoiceAdditionalNotes(
          content: rxData?.additionalNotes,
        ),
        const RxInvoiceFooter(),
      ],
    );
  }
}
