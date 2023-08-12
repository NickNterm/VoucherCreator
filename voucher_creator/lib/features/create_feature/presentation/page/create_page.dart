import 'package:flutter/material.dart';
import 'package:voucher_creator/features/create_feature/presentation/page/preview_page.dart';
import 'package:voucher_creator/features/main_feature/data/model/pdf_data_model.dart';
import 'package:voucher_creator/features/main_feature/domain/entities/pdf_data.dart';
import 'package:voucher_creator/features/main_feature/presentation/bloc/pdf_list/pdf_list_bloc.dart';
import 'package:voucher_creator/injection.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({
    super.key,
    this.pdfData,
  });
  final PDFData? pdfData;

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
  void initState() {
    super.initState();
    _voucherIdController.text = widget.pdfData?.id.toString() ?? "";
    _tripDateController.text = widget.pdfData?.date ?? "";
    _tripStartHourController.text = widget.pdfData?.startHour ?? "";
    _tripEndHourController.text = widget.pdfData?.endHour ?? "";
    _tripStartLocationController.text = widget.pdfData?.startLocation ?? "";
    _tripEndLocationController.text = widget.pdfData?.endLocation ?? "";
    _tripAmountController.text = widget.pdfData?.amount ?? "";
    names = widget.pdfData?.names ?? [];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Νέο Voucher"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  RowEntryWidget(
                    title: "Αριθμός Σύμβασης",
                    controller: _voucherIdController,
                    hint: "ex. 12",
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  RowEntryWidget(
                    title: "Ημερομηνία",
                    controller: _tripDateController,
                    hint: "ex. 12/04/2023",
                    keyboardType: TextInputType.datetime,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ColumnEntryWidget(
                          title: "Ώρα Εκκίνησης",
                          controller: _tripStartHourController,
                          hint: "ex. 12:30",
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ColumnEntryWidget(
                          title: "Ώρα Αφίξεως",
                          controller: _tripEndHourController,
                          hint: "ex. 16:00",
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  RowEntryWidget(
                    title: "Έναρξη",
                    controller: _tripStartLocationController,
                    hint: "ex. Ιωάννινα",
                  ),
                  const SizedBox(height: 16),
                  RowEntryWidget(
                    title: "Προορισμός",
                    controller: _tripEndLocationController,
                    hint: "ex. Αθήνα",
                  ),
                  const SizedBox(height: 16),
                  RowEntryWidget(
                    title: "Ποσό",
                    controller: _tripAmountController,
                    hint: "ex. 123",
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Συμμετέχοντες",
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
                                "Εισάγετε ένα όνομα",
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
                              "Μπορείτε να εισάγετε μέχρι 8 ονόματα",
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
                  SnackBar(
                    elevation: 0,
                    content: Text(
                      "Εισάγετε έναν αριθμό στο Αριθμός Σύμβασης",
                      textAlign: TextAlign.center,
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    backgroundColor: Colors.red.shade300,
                  ),
                );
              }
            }
          } else {
            final SnackBar snackBar = SnackBar(
              elevation: 0,
              content: const Text(
                "Συμπληρώστε όλα τα πεδία",
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

class ColumnEntryWidget extends StatelessWidget {
  const ColumnEntryWidget({
    super.key,
    required TextEditingController controller,
    required this.title,
    this.hint = '',
    this.keyboardType = TextInputType.text,
  }) : controller = controller;

  final TextEditingController controller;
  final String title;
  final String hint;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
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
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class RowEntryWidget extends StatelessWidget {
  const RowEntryWidget({
    super.key,
    required TextEditingController controller,
    required this.title,
    this.hint = "",
    this.keyboardType = TextInputType.text,
  }) : controller = controller;

  final TextEditingController controller;
  final String title;
  final String hint;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
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
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
