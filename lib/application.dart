import 'package:flutter/material.dart';
import 'package:my_chips/config/styles.dart';
import 'package:my_chips/features/chip/view/chip_view.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';
import 'package:provider/provider.dart';

void application() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChipViewModelFrameworks()
            ..init(
              url: 'http://127.0.0.1:5500/api/frameworks.json',
            ),
        ),
        ChangeNotifierProvider(
          create: (context) => ChipViewModelLanguages()
            ..init(
              url: 'http://127.0.0.1:5500/api/languages.json',
            ),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
        ),
        home: const ChipView(),
      ),
    );
  }
}
