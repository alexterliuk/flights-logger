import 'dart:io';
import 'dart:async';
// import 'package:flights_logger/src/db/queries.dart';
import 'package:flights_logger/src/flight_logs/flight_log_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
// import 'flight_logs/flight_logs.dart';
import 'flight_logs/flight_logs_loading.dart';
import 'home/home.dart';
import 'home/home_model.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import 'flight_log_form/flight_log_form.dart';
import 'shifts/shifts_loading.dart';
import 'shifts/shifts.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
    // required this.appStateInitData,
    // required this.initData,
  });

  final SettingsController settingsController;
  // final AppStateInitDataModel initData;

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
          // create: (context) => MyAppState(initData),
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
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            themeMode: settingsController.themeMode,

            debugShowCheckedModeBanner: false,

            // Define a function to handle named routes in order to support
            // Flutter web url navigation and deep linking.
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  // print('routeSettings: $routeSettings');
                  switch (routeSettings.name) {
                    case SettingsView.routeName:
                      // print('SETTINGS');
                      return SettingsView(controller: settingsController);
                    case FlightLogForm.routeName:
                      // print('FLIGHT LOG FORM');
                      // return const FlightLogFormDemoX();
                      // CTRL
                      // return FlightLogForm(controller: settingsController);
                      final log = routeSettings.arguments == null ? null : (routeSettings.arguments as Map<String, Object>)['log'] as FlightLogModel?;
                      final shiftId = routeSettings.arguments == null ? -1 : (routeSettings.arguments as Map<String, Object>)['shiftId'] as int;
                      // final log = routeSettings.arguments == null ? null : routeSettings.arguments.log as FlightLogModel;
                      // final log = (routeSettings.arguments as FlightLogFormArguments).log;
                      // (routeSettings.arguments as FlightLogFormArguments).log;

                      // return FlightLogForm(log: log, shiftId: log?.shiftId ?? -1);

                      return FlightLogForm(log: log, shiftId: shiftId);
                    // case SampleItemDetailsView.routeName:
                    //   print('SAMPLE ITEM DETAILS');
                    //   return SampleItemDetailsView();
                    // case SampleItemListView.routeName:
                    //   // return const SampleItemListView();
                    // case Shifts.routeName:
                    //   final fromDate = routeSettings.arguments == null
                    //     ? DateTime.now().subtract(const Duration(days: 30))
                    //     : (routeSettings.arguments as ShiftsArguments).fromDate;
                    //
                    //   final toDate = routeSettings.arguments == null
                    //     ? DateTime.now()
                    //     : (routeSettings.arguments as ShiftsArguments).toDate;
                    //
                    //   return Shifts(fromDate: fromDate, toDate: toDate);
                    // case SampleItemListView.routeName:
                    //   // print('Sample itemsss');
                    //   return const SampleItemListView();

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
                      return Shifts();
                    }

                    case Home.routeName: {
                      bool isInitLoading = routeSettings.arguments == null
                        ? true
                        : (routeSettings.arguments as Map<String, Object>)['isInitLoading'] as bool;

                      return Home(isInitLoading: isInitLoading);
                    }

                    default:
                      // return const SampleItemListView();
                      // print('FLIGHT LOGS');
                      print('routeSettings.name: ${routeSettings.name}');
                      // CTRL
                      // return FlightLogs(controller: settingsController);
                      // return const FlightLogs(title: 'Shift Apr 17 - Apr 18 2024');
                      // return const Shifts();
                      // return const Calendar();
                      // return const SelectShift();
                      // return Home(appStateInitData: appStateInitData);
                      // return const Home();

                      return const Home();
                      // return routeSettings.arguments == null
                      //   ? const Home()
                      //   : Home(
                      //       // shouldUpdateTopNumbers: (routeSettings.arguments as Map<String, Object>)['shouldUpdateTopNumbers'] as bool,
                      //       // shouldUpdateLastFlightLog: (routeSettings.arguments as Map<String, Object>)['shouldUpdateLastFlightLog'] as bool,
                      //       // shouldUpdateLastShiftId: (routeSettings.arguments as Map<String, Object>)['shouldUpdateLastShiftId'] as bool,
                      //   );
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
