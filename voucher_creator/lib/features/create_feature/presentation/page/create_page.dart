import 'dart:io';

import 'package:flutter/material.dart';
import 'package:voucher_creator/features/create_feature/presentation/page/preview_page.dart';
import 'package:voucher_creator/features/main_feature/data/model/pdf_data_model.dart';
import 'package:voucher_creator/features/main_feature/presentation/bloc/pdf_list/pdf_list_bloc.dart';
import 'package:voucher_creator/injection.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _voucherIdController = TextEditingController();
  final TextEditingController _tripDateController = TextEditingController();
  final TextEditingController _tripStartHourController =
      TextEditingController();
  final TextEditingController _tripEndHourController = TextEditingController();
  final TextEditingController _tripStartLocationController =
      TextEditingController();
  final TextEditingController _tripEndLocationController =
      TextEditingController();
  final TextEditingController _tripAmountController = TextEditingController();
  final TextEditingController _tripParticipantController =
      TextEditingController();

  List<String> names = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Voucher"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Voucher ID",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 5,
                          ),
                          child: TextField(
                            controller: _voucherIdController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: "ex. 13",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        "Trip Date",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 5,
                          ),
                          child: TextField(
                            controller: _tripDateController,
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                              hintText: "ex. 20/03/23",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Start Time",
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 5,
                              ),
                              child: TextField(
                                controller: _tripStartHourController,
                                keyboardType: TextInputType.datetime,
                                decoration: const InputDecoration(
                                  hintText: "ex. 20:30",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "End Time",
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 5,
                              ),
                              child: TextField(
                                controller: _tripEndHourController,
                                keyboardType: TextInputType.datetime,
                                decoration: const InputDecoration(
                                  hintText: "ex. 20:30",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        "Start Location",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 5,
                          ),
                          child: TextField(
                            controller: _tripStartLocationController,
                            decoration: const InputDecoration(
                              hintText: "ex. Θεσσαλονίκη",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        "Finish Location",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 5,
                          ),
                          child: TextField(
                            controller: _tripEndLocationController,
                            decoration: const InputDecoration(
                              hintText: "ex. Αθήνα",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        "Amount",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 5,
                          ),
                          child: TextField(
                            controller: _tripAmountController,
                            decoration: const InputDecoration(
                              hintText: "ex. 120",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Participants",
                    style: TextStyle(fontSize: 16),
                  ),
                  ListView.builder(
                    itemCount: names.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: ListTile(
                        tileColor: Colors.grey[200],
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        title: Text(names[index]),
                        trailing: IconButton(
                          onPressed: () {
                            names.removeAt(index);
                            setState(() {});
                          },
                          icon: const Icon(Icons.delete_rounded),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    tileColor: Colors.grey[200],
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    title: TextField(
                      controller: _tripParticipantController,
                      decoration: const InputDecoration(
                        hintText: "ex. Σπύρος",
                        border: InputBorder.none,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        if (names.length < 8) {
                          if (_tripParticipantController.text.isNotEmpty) {
                            names.add(_tripParticipantController.text.trim());
                            _tripParticipantController.clear();
                            setState(() {});
                          } else {
                            final SnackBar snackBar = SnackBar(
                              elevation: 0,
                              content: const Text(
                                "Please enter a name!",
                                textAlign: TextAlign.center,
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.red.shade300,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } else {
                          final SnackBar snackBar = SnackBar(
                            elevation: 0,
                            content: const Text(
                              "You can't add more than 8 participants!",
                              textAlign: TextAlign.center,
                            ),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Colors.red.shade300,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_tripDateController.text.isNotEmpty &&
              _tripAmountController.text.isNotEmpty &&
              _voucherIdController.text.isNotEmpty &&
              _tripEndHourController.text.isNotEmpty &&
              _tripStartHourController.text.isNotEmpty &&
              _tripEndLocationController.text.isNotEmpty &&
              _tripStartLocationController.text.isNotEmpty &&
              names.isNotEmpty) {
            try {
              PDFDataModel data = PDFDataModel(
                id: int.parse(_voucherIdController.text),
                date: _tripDateController.text,
                startHour: _tripStartHourController.text,
                endHour: _tripEndHourController.text,
                startLocation: _tripStartLocationController.text,
                endLocation: _tripEndLocationController.text,
                amount: _tripAmountController.text,
                names: names,
              );
              sl<PdfListBloc>().add(CreatePDFEvent(data));
              sl<PdfListBloc>().stream.listen((event) {
                print("test");
                if (mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => PreviewPage(pdfData: data),
                    ),
                    (route) => route.isFirst,
                  );
                }
              });
            } catch (e) {
              print(e);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    elevation: 0,
                    content: Text(
                      "Please enter a valid voucher id!",
                      textAlign: TextAlign.center,
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          } else {
            final SnackBar snackBar = SnackBar(
              elevation: 0,
              content: const Text(
                "Please fill all the fields!",
                textAlign: TextAlign.center,
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.red.shade300,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: const Icon(Icons.create_rounded),
      ),
    );
  }
}
