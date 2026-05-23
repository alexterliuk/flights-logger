import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import 'app_state.dart';
import 'home/home.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import 'flight_logs/flight_logs_loading.dart';
import 'flight_logs/flight_log_model.dart';
import 'flight_log_form/flight_log_form.dart';
import 'shifts/shifts_loading.dart';
import 'shifts/shifts.dart';
import 'calculation/calculate_data.dart';
import 'calculation/get_stats.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return ChangeNotifierProvider(
          create: (context) => MyAppState(),
          child: MaterialApp(
            // Providing a restorationScopeId allows the Navigator built by the
            // MaterialApp to restore the navigation stack when a user leaves and
            // returns to the app after it has been killed while running in the
            // background.
            restorationScopeId: 'app',
            title: 'Raw meat',
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('es'), // Spanish
              Locale('fr'), // French
              Locale('uk'), // Ukrainian
            ],

            // Use AppLocalizations to configure the correct application title
            // depending on the user's locale.
            //
            // The appTitle is defined in .arb files found in the localization
            // directory.
            //     onGenerateTitle: (BuildContext context) =>
            //         AppLocalizations.of(context)!.appTitle,

            // Define a light and dark color theme. Then, read the user's
            // preferred ThemeMode (light, dark, or system default) from the
            // SettingsController to display the correct theme.
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: const Color(0xFF2D3E50),
              scaffoldBackgroundColor: const Color(0xFFF5F7F9),
            ),
            darkTheme: ThemeData.dark(),
            themeMode: settingsController.themeMode,

            debugShowCheckedModeBanner: false,

            // Define a function to handle named routes in order to support
            // Flutter web url navigation and deep linking.
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case SettingsView.routeName: {
                      return SettingsView(controller: settingsController);
                    }

                    case FlightLogForm.routeName: {
                      final log = routeSettings.arguments == null ? null : (routeSettings.arguments as Map<String, Object>)['log'] as FlightLogModel?;
                      final shiftId = routeSettings.arguments == null ? -1 : (routeSettings.arguments as Map<String, Object>)['shiftId'] as int;

                      return FlightLogForm(log: log, shiftId: shiftId);
                    }

                    case FlightLogsLoading.routeName: {
                      return routeSettings.arguments == null
                        ? const FlightLogsLoading()
                        : FlightLogsLoading(
                            /// THIS VARIANT LEADS TO TYPE ERROR
                            /// Exception has occurred.
                            /// _TypeError (type '_Map<String, Object>' is not a subtype of type 'FlightLogsLoadingArguments' in type cast)
                            // isLoadByIds: (routeSettings.arguments as FlightLogsLoadingArguments).isLoadByIds,
                            // ids: (routeSettings.arguments as FlightLogsLoadingArguments).ids,
                            isLoadByIds: (routeSettings.arguments as FlightLogsLoadingArguments)['isLoadByIds'] as bool,
                            ids: (routeSettings.arguments as FlightLogsLoadingArguments)['ids'] as List<int>,
                            idsForReload: (routeSettings.arguments as FlightLogsLoadingArguments)['idsForReload'] as List<int>,
                        );
                    }

                    case ShiftsLoading.routeName: {
                      return const ShiftsLoading();
                    }

                    case Shifts.routeName: {
                      return const Shifts();
                    }

                    case Home.routeName: {
                      bool isInitLoading = routeSettings.arguments == null
                        ? true
                        : (routeSettings.arguments as Map<String, Object>)['isInitLoading'] as bool;

                      return Home(
                        isInitLoading: isInitLoading,
                        settingsController: settingsController,
                      );
                    }

                    case GetStats.routeName: {
                      return const CalculateData();
                    }

                    default: {
                      return Home(settingsController: settingsController);
                    }
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
