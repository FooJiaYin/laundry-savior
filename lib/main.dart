import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'generated/l10n.dart';
import 'models/global_state.dart';
import 'services/fake_data.dart';
import 'services/notification.dart';
import 'theme/theme.dart';
import 'utils/config.dart';
import 'views/route.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  AppConfig config = AppConfig();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    FakeData.updateMachinesPeriodically();
  }

  Widget app(BuildContext context) {
    return MaterialApp(
      title: AppConfig.title,
      home: const App(),
      routes: AppRoute.route(context),
      themeMode: ThemeMode.light,
      theme: CustomTheme.defaultTheme,
      darkTheme: CustomTheme.darkTheme,
      // locale: const Locale.fromSubtags(languageCode: 'zh_Hant_TW'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GlobalState>(
      future: GlobalState.init(),
      builder: (context, snapshot) => snapshot.connectionState == ConnectionState.done
          ? ChangeNotifierProvider(
              create: (context) => snapshot.data,
              child: app(context),
            )
          : Container(color: ThemeColors.backgroundColor),
    );
  }

  @override
  void didChangeDependencies() async {
    // setState(() => config.locale = const Locale.fromSubtags(languageCode: 'zh_Hant_TW'));
    // setState(() => config.locale = Localizations.localeOf(context));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await NotificationService.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
