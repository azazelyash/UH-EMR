import 'package:aasa_emr/common/functions/functions.dart';
import 'package:aasa_emr/features/dashboard/data/models/appointment.dart';
import 'package:aasa_emr/features/user/data/models/settings_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:aasa_emr/common/constants/intake_constants.dart';
import 'package:aasa_emr/features/dashboard/data/models/rx_model.dart';

class RxPDF {
  static Widget buildHeading(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Divider(),
    );
  }

  static Widget buildHeader({
    required Image? image,
    String? doctorName,
    String? doctorEmail,
    String? doctorPhone,
    String? specialisation,
    String? doctorAddress,
    RxFormat? rxFormat,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            (rxFormat?.rxHeaderInfo?.logo ?? false || image != null)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      image!,
                      SizedBox(width: 16),
                    ],
                  )
                : SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  doctorName ?? "-",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  specialisation ?? "-",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            (rxFormat?.rxHeaderInfo?.contactNo ?? false)
                ? Text(
                    doctorPhone ?? "-",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                : SizedBox(),
            (rxFormat?.rxHeaderInfo?.emailId ?? false)
                ? Text(
                    doctorEmail ?? "-",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                : SizedBox(),
          ],
        ),
        (rxFormat?.rxHeaderInfo?.clinicAddress ?? false)
            ? Column(
                children: [
                  SizedBox(height: 6),
                  Text(
                    doctorAddress ?? "-",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              )
            : SizedBox(),
        SizedBox(height: 6),
        Divider(),
        SizedBox(height: 6),
      ],
    );
  }

  static Widget buildPatientDetails({
    required bool showAge,
    required bool showHeight,
    required bool showWeight,
    required bool showPulseRate,
    required bool showBloodPressure,
    required Appointment appointment,
    required bool showBodyTemperature,
    required bool showRespirationRate,
    required PatientBasicDetail patient,
  }) {
    return Column(
      children: <Widget>[
        // Name and Visit
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Patient Name:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  patient.name!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "Contact:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  patient.phone ?? "-",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Vital",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Value",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        (showAge)
            ? Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Age",
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      (appointment.userPatient?.dob != null) ? AppFunctions.calculatePatientAge(appointment.userPatient!.dob!).toString().split(" ").first : "-",
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              )
            : SizedBox(),
        (showWeight)
            ? Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Weight",
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      (patient.weight != null && patient.weight != "") ? patient.weight! : "-",
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              )
            : SizedBox(),
        (showHeight)
            ? Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Height",
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      (patient.height != null && patient.height != "") ? patient.height! : "-",
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              )
            : SizedBox(),
        (showBodyTemperature)
            ? Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Body Temperature",
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      (patient.bodyTemperature != null && patient.bodyTemperature != "") ? patient.bodyTemperature! : "-",
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              )
            : SizedBox(),
        (showBloodPressure)
            ? Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Blood Pressure",
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      (patient.bloodPressure != null && patient.bloodPressure != "") ? patient.bloodPressure! : "-",
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              )
            : SizedBox(),
        (showRespirationRate)
            ? Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Respiration Rate",
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      (patient.respirationRate != null && patient.respirationRate != "") ? patient.respirationRate! : "-",
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              )
            : SizedBox(),
        (showPulseRate)
            ? Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Pulse Rate",
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      (patient.pulseRate != null && patient.pulseRate != "") ? patient.pulseRate! : "-",
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              )
            : SizedBox(),

        SizedBox(height: 6),
        Divider(),
      ],
    );
  }

  /// Diagnosis

  static Widget buildDiagnosisList(List<Diagnosis>? data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(data!.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text(
            "${index + 1}. ${data[index].condition!.conditionName}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        );
      }),
    );
  }

  static Widget buildSymptoms(List<String?>? symptoms) {
    return (symptoms != null) ? Text(symptoms.join(",  ")) : Text("No Symptoms Added");
  }

  static Widget buildMedicationsTableHeadings() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Text(
                  "Test/Medicine",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Days",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Frequency",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Divider(
            color: PdfColor.fromHex("5F5F5F"),
          ),
        ],
      ),
    );
  }

  static Widget buildMedicationList(List<Medication>? data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        data!.length,
        (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Text(
                              data[index].medicineType ?? "Tablet",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            flex: 3,
                            child: Text(
                              data[index].medicine!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildConsumtionWidget(
                            morning: data[index].intake!.contains(IntakeConstants.morning),
                            noon: data[index].intake!.contains(IntakeConstants.noon),
                            evening: data[index].intake!.contains(IntakeConstants.night),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              data[index].foodTime!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        data[index].intake!.join(", "),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 6),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              data[index].days ?? "-",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 3),
                          Expanded(
                            flex: 2,
                            child: Text(
                              data[index].frequency ?? "-",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        data[index].note ?? "-",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Widget buildAdditionalNotes({required String? content}) {
    return Text(
      content ?? "-",
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  static Widget buildFooter({
    required String footerMessage,
    required Image? signatureImage,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          footerMessage,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (signatureImage != null)
          Container(
            height: 32,
            width: 64,
            child: signatureImage,
          ),
      ],
    );
  }

  static Row buildConsumtionWidget({
    required bool morning,
    required bool noon,
    required bool evening,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
            color: (morning) ? const PdfColor.fromInt(0xff000000) : const PdfColor.fromInt(0xffffffff),
            border: (morning) ? Border.all(width: 0, color: const PdfColor.fromInt(0x00ffffff)) : Border.all(color: const PdfColor.fromInt(0xff000000)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(
          width: 16,
          child: Divider(),
        ),
        Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
            color: (noon) ? const PdfColor.fromInt(0xff000000) : const PdfColor.fromInt(0xffffffff),
            border: (noon) ? Border.all(width: 0, color: const PdfColor.fromInt(0x00ffffff)) : Border.all(color: const PdfColor.fromInt(0xff000000)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(
          width: 16,
          child: Divider(),
        ),
        Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
            color: (evening) ? const PdfColor.fromInt(0xff000000) : const PdfColor.fromInt(0xffffffff),
            border: (evening) ? Border.all(width: 0, color: const PdfColor.fromInt(0x00ffffff)) : Border.all(color: const PdfColor.fromInt(0xff000000)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}
