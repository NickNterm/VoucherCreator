import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voucher_creator/features/create_feature/presentation/page/create_page.dart';
import 'package:voucher_creator/features/loading_feature/presentation/loading_page.dart';
import 'package:voucher_creator/features/main_feature/presentation/bloc/pdf_list/pdf_list_bloc.dart';
import 'package:voucher_creator/features/main_feature/presentation/page/main_page.dart';
import 'package:voucher_creator/features/settings_feature/presentation/bloc/settings/settings_bloc.dart';
import 'package:voucher_creator/features/settings_feature/presentation/pages/settings_page.dart';
import 'package:voucher_creator/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await depencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<PdfListBloc>()),
        BlocProvider(create: (context) => sl<SettingsBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.lightGreen,
          ),
          fontFamily: GoogleFonts.ubuntu().fontFamily,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.lightGreen,
            centerTitle: true,
            foregroundColor: Colors.white,
          ),
          useMaterial3: true,
        ),
        home: const LoadingPage(),
        routes: {
          '/loading': (context) => const LoadingPage(),
          '/main': (context) => const MainPage(),
          '/create': (context) => const CreatePage(),
          '/settings': (context) => const SettingsPage(),
        },
      ),
    );
  }
}
