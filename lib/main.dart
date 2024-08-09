import 'package:ccv_manager/settings_widget/provider/theme_provider.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firedart/firedart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'constants/constants.dart';
import 'env/env.dart';
import 'home_page/landing_page/user_checker.dart';
import 'theme/theme_data.dart';
import 'dart:io' show Platform, exit;

//TODO: https://www.youtube.com/watch?v=lcc7eKcQVWQ , firebase deploy
//TODO: https://www.youtube.com/watch?v=9qmSrt-DLiA, deploy to firebase with github CI/CD
//TODO: Add library user object to firestore
//TODO: Tornar os items to task form nos eventos tiles expansíveis.

//TODO: Corrigir Rebuilds
//TODO: corrigir exportar de turnos/ausências. Verificar os intervalos de datas para todos.
//TODO: Corrigir filtro de funcionários nos turnos e ausências
//TODO: Clicar em célula de funcionário nos Turnos/Ausências. Não aparece folga na timeline
//TODO: Aviso de password incorreta
//TODO: Inserir preço no evento. disponibilizar essa informação dependendo da função do utilizador
//TODO: Adicionar objeto no firebase para a extensão do formulário de eventos com referência ao id do evento
//TODO: Contabilização das ausências e turnos, bem como do tipo de turno
//TODO: Descrições desaparecem no calendário quando se muda de mês
//TODO: Exportar apenas informação necessária para csv
//TODO: Bug no daily line chart, não aparecem os turnos e ausências
//TODO: Criar notificação quando termina o prazo de entrega de livros na biblioteca, que cria um item no todo list

//TODO: Criar notificação de avaliação agendada para o dia a seguir ao evento (com sinalização de concluída, deverá conter comentário e número de atendentes).

//! Firebase for web and android: https://www.youtube.com/watch?v=uOTaHoB-YmA

//* TODO: Dados estatísticos

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) {
      exit(1);
    }
  };
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Env.frbApiKey,
            authDomain: Env.authDomain,
            databaseURL: Env.databaseURL,
            projectId: Env.projectId,
            storageBucket: Env.storageBucket,
            messagingSenderId: Env.messagingSenderId,
            appId: Env.appId,
            measurementId: Env.measurementId));
  } else {
    await Firebase.initializeApp();
  }

  if (kIsWeb) {
    print("Running on the web!");
  } else {
    if (Platform.isAndroid) {
      print("Running on Android device");
    } else if (Platform.isIOS) {
      print("Running on iOS device");
    } else if (Platform.isMacOS) {
      print("Running on macOS");
    } else if (Platform.isWindows) {
      await DesktopWindow.setMinWindowSize(const Size(1000, 800));
      await DesktopWindow.setWindowSize(const Size(1400, 1000));
      print("Running on Windows");
    } else if (Platform.isLinux) {
      print("Running on Linux");
    }
  }

  // For windows desktop, using firedart dependency
  // Firestore.initialize(Env.pIdKey);
  // FirebaseAuth.initialize(Env.frbApiKey, VolatileStore());

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'PT'), // Portuguese Brazil
        // Other locales your app supports...
      ],
      locale: const Locale('pt', 'PT'), // Set the locale
      debugShowCheckedModeBanner: false,
      title: 'CCV Manager',
      theme: theme == ThemeType.light
          ? lightTheme
          : ThemeData(
              brightness: Brightness.dark,
              /* dark theme settings */
            ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   /* dark theme settings */
      // ),
      // themeMode: ThemeMode.dark,
      /* ThemeMode.system to follow system theme, 
         ThemeMode.light for light theme, 
         ThemeMode.dark for dark theme
      */
      home: const UserChecker(),
      //const HomePage(),
    );
  }
}
