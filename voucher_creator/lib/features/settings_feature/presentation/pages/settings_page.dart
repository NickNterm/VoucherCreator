import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:voucher_creator/features/settings_feature/data/models/settings_model.dart';
import 'package:voucher_creator/features/settings_feature/presentation/bloc/settings/settings_bloc.dart';
import 'package:voucher_creator/injection.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String imagePath = '';
  @override
  void initState() {
    super.initState();
    _loadSignature();
  }

  void _loadSignature() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/signature.png');
      if (file.existsSync()) {
        setState(() {
          imagePath = file.path;
        });
        print(imagePath);
      }
    } catch (e) {
      imagePath = '';
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ρυθμίσεις'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<SettingsBloc, SettingsModel>(
          builder: (context, state) => Column(
            children: [
              ListTile(
                title: Text("Μεταξύ του"),
                subtitle: Text(
                  state.firstName,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final TextEditingController _controller =
                          TextEditingController();
                      return AlertDialog(
                        title: const Text('Μεταξύ αφενός του:'),
                        content: TextField(
                          decoration: const InputDecoration(
                            hintText: 'ΓΙΑΝΝΟΥ ΣΠΥΡΙΔΩΝ',
                          ),
                          controller: _controller,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Ακύρωση'),
                          ),
                          TextButton(
                            onPressed: () async {
                              var bloc = sl<SettingsBloc>();
                              bloc.add(
                                SetSettingsEvent(
                                  bloc.state.copyWith(
                                    firstName: _controller.text.trim(),
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            },
                            child: const Text('Αποθήκευση'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              ListTile(
                title: const Text("Με την επωνυμία"),
                subtitle: Text(
                  state.secondName,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final TextEditingController _controller =
                          TextEditingController();
                      return AlertDialog(
                        title: const Text('Με την επωνυμία:'),
                        content: TextField(
                          decoration: const InputDecoration(
                            hintText: 'ΓΙΑΝΝΟΣ ΣΠΥΡΙΔΩΝ',
                          ),
                          controller: _controller,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Ακύρωση'),
                          ),
                          TextButton(
                            onPressed: () async {
                              var bloc = sl<SettingsBloc>();
                              bloc.add(
                                SetSettingsEvent(
                                  bloc.state.copyWith(
                                    secondName: _controller.text.trim(),
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            },
                            child: const Text('Αποθήκευση'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      GlobalKey<SfSignaturePadState> _signaturePadKey =
                          GlobalKey();
                      return AlertDialog(
                        title: const Text('Επιλογή υπογραφής'),
                        content: Container(
                          height: 200,
                          width: 300,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: SfSignaturePad(
                              backgroundColor: Colors.transparent,
                              key: _signaturePadKey,
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Ακύρωση'),
                          ),
                          TextButton(
                            onPressed: () async {
                              ui.Image image =
                                  await _signaturePadKey.currentState!.toImage(
                                pixelRatio: 3,
                              );
                              final bytedata = await image.toByteData(
                                format: ui.ImageByteFormat.png,
                              );
                              final Directory dir =
                                  await getApplicationDocumentsDirectory();

                              final String path = dir.path;
                              final File file = File('$path/signature.png');
                              await file.writeAsBytes(
                                bytedata!.buffer.asUint8List(
                                  bytedata.offsetInBytes,
                                  bytedata.lengthInBytes,
                                ),
                              );
                              if (mounted) {
                                imagePath = file.path;
                                setState(() {});
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Αποθήκευση'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  height: 300,
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Επιλογή υπογραφής",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      imagePath != ''
                          ? Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Image.memory(
                                    Uint8List.fromList(
                                      File(imagePath).readAsBytesSync(),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
