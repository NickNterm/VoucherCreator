import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:voucher_creator/features/main_feature/domain/entities/pdf_data.dart';
import 'package:voucher_creator/features/main_feature/presentation/bloc/pdf_list/pdf_list_bloc.dart';
import 'package:voucher_creator/features/settings_feature/presentation/bloc/settings/settings_bloc.dart';
import 'package:voucher_creator/injection.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    sl<PdfListBloc>().add(GetCachedPDFsEvent());
    sl<SettingsBloc>().add(GetSettingsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voucher Creator"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: BlocBuilder<PdfListBloc, List<PDFData>>(
        builder: (context, state) {
          if (state.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.create_new_folder_rounded,
                    color: Colors.grey.shade400,
                    size: 100,
                  ),
                  const Text(
                    'No PDFs created yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: state.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Stack(
                  clipBehavior: Clip.antiAlias,
                  children: [
                    Container(
                      height: 180,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16),
                      margin: const EdgeInsets.symmetric(
                          vertical: 9, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red.shade400,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.delete,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    Dismissible(
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) async {
                        return await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Are you sure?'),
                              content: const Text(
                                  'Do you want to delete this voucher?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      behavior: HitTestBehavior.opaque,
                      onDismissed: (direction) {
                        sl<PdfListBloc>().add(DeletePDFEvent(state[index].id));
                      },
                      key: Key(state[index].id.toString()),
                      child: Container(
                        height: 180,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.symmetric(
                            vertical: 9, horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Voucher ${state[index].id}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Date: ${state[index].date}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'From: ${state[index].startLocation}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    'To: ${state[index].endLocation}',
                                    softWrap: true,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Amount: ${state[index].amount}€',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              width: 100,
                              height: 100 * 1.414,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SfPdfViewer.file(
                                  File(
                                    '/storage/emulated/0/Documents/VoucherCreator/Voucher_${state[index].id}.pdf',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var settings = sl<SettingsBloc>().state;
          final Directory dir = await getApplicationDocumentsDirectory();
          File signature = File('${dir.path}/signature.png');
          if (settings.firstName == '' ||
              settings.secondName == '' ||
              !signature.existsSync()) {
            final snackBar = SnackBar(
              content: const Text(
                  'Please fill in your name and signature in the settings'),
              action: SnackBarAction(
                label: 'Settings',
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            );
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          } else {
            if (mounted) {
              Navigator.pushNamed(context, '/create');
            }
          }
          //var status = await Permission.storage.status;
          //if (!status.isGranted) {
          //  // We didn't ask for permission yet or the permission has been denied before but not permanently.
          //  await Permission.storage.request();
          //}

          //const pdfData = PDFDataModel(
          //  id: 1,
          //  date: "2021-10-10",
          //  startHour: "10:00",
          //  endHour: "12:00",
          //  startLocation: "Location 1",
          //  endLocation: "Location 2",
          //  amount: "100",
          //  names: ["Name 1", "Name 2", "Name 3"],
          //);
          //if (!await Directory('/storage/emulated/0/Documents/VoucherCreator')
          //    .exists()) {
          //  await Directory('/storage/emulated/0/Documents/VoucherCreator')
          //      .create(recursive: true);
          //}
          //final pdf = await pdfData.toPDF();
          //final file = File(
          //    '/storage/emulated/0/Documents/VoucherCreator/Voucher_${pdfData.id}.pdf');
          //await file.writeAsBytes(await pdf.save());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
