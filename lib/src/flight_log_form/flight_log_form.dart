import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../calendar/calendar.dart';
import '../flight_logs/flight_log_model.dart';
import '../flight_logs/flight_logs.dart';
import '../shifts/new_shift.dart';
import '../utils/extract_int.dart';
import '../utils/date_time/landing_time/get_landing_time.dart';
import './utils.dart';

class FlightLogFormArguments {
  final FlightLogModel? log;
  final int shiftId;

  FlightLogFormArguments(
    this.log,
    this.shiftId,
  );
}

// Create a Form widget.
class FlightLogForm extends StatefulWidget {
  final FlightLogModel? log;
  final int shiftId;

  const FlightLogForm({
    super.key,
    this.log,
    this.shiftId = -1,
  });

  static const routeName = '/flight_log_form';

  @override
  FlightLogFormState createState() {
    return FlightLogFormState();
  }
}

class FlightLogFormState extends State<FlightLogForm> {
  final _formKey = GlobalKey<FormState>();
  final takeoffHoursController = TextEditingController();
  final takeoffMinutesController = TextEditingController();
  final flightTimeController = TextEditingController();
  final distanceController = TextEditingController();
  final altitudeController = TextEditingController();
  final locationController = TextEditingController();
  final droneAccumController = TextEditingController();
  final droneAccumChargeLeftController = TextEditingController();
  final rcAccumChargeLeftController = TextEditingController();

  String landingTime = '';
  String date = '';
  String dateISO = '';

  void setLandingTime (String time) {
    setState(() {
      landingTime = time;
    });
  }

  void setDate (DateTime? dateTime, String? dateAndTime) { // '2024-07-20 23:48'
    String d = '';
    String dISO = '';

    try {
      if (dateTime is DateTime) {
        d = getDateCaption(dateTime);
      } else {
        d = dateAndTime is String
          ? getDateCaptionFromDateAndTime(dateAndTime)
          : getDateCaption(DateTime.now());
      }

      dISO = getISODateStringWithoutTime(d);
    } catch (err) {
      print('[ERR]: something went wrong while setting date in flight log form');
    }

    setState(() {
      date = d;
      dateISO = dISO;
    });
  }

  @override
  void initState() {
    super.initState();
    print('[FlightLogForm initState] shiftId - ${widget.shiftId}');
    FlightLogModel? log = widget.log;

    if (log != null) {
      takeoffHoursController.text = log.takeoffDateAndTime.substring(11, 13);
      takeoffMinutesController.text = log.takeoffDateAndTime.substring(14, 16);
      flightTimeController.text = '${log.flightTimeMinutes}';
      distanceController.text = '${log.distanceMeters}';
      altitudeController.text = '${log.altitudeMeters}';
      locationController.text = log.location;
      droneAccumController.text = log.droneAccum;
      droneAccumChargeLeftController.text = log.droneAccumChargeLeft == -1 ? '' : '${log.droneAccumChargeLeft}';
      rcAccumChargeLeftController.text = log.rcAccumChargeLeft == -1 ? '' : '${log.rcAccumChargeLeft}';

      if (log.landingDateAndTime.isNotEmpty) {
        setLandingTime(
          log.landingDateAndTime.substring(11),
        );
      }

      print('log.takeoffDateAndTime - ${log.takeoffDateAndTime}');
      setDate(null, log.takeoffDateAndTime);
    } else {
      setDate(null, null);
    }
  }

  @override
  void dispose() {
    super.dispose();
    takeoffHoursController.dispose();
    takeoffMinutesController.dispose();
    flightTimeController.dispose();
    distanceController.dispose();
    altitudeController.dispose();
    locationController.dispose();
    droneAccumController.dispose();
    droneAccumChargeLeftController.dispose();
    rcAccumChargeLeftController.dispose();
  }

  BaseFlightLogModel? getEditedLog() {
    if (_formKey.currentState!.validate()) {
      var takeoffH = takeoffHoursController.text;
      var takeoffM = takeoffMinutesController.text;
      var takeoffHour = takeoffH.length == 1 ? '0$takeoffH' : takeoffH;
      var takeoffMinute = takeoffM.length == 1 ? '0$takeoffM' : takeoffM;
      var takeoffTime = '$takeoffHour:$takeoffMinute';
      // var dateISO = getISODateStringWithoutTime(date);
      final takeoffDateAndTime = '$dateISO $takeoffTime';

      var flightTime = flightTimeController.text;
      final flightTimeMinutes = extractInt(flightTime);

      final landing = getLandingTime(
        dateISO,
        GetLandingTimeArgument(takeoffH, validateHours),
        GetLandingTimeArgument(takeoffM, validateMinutes),
        GetLandingTimeArgument(flightTime, validateFlightTime),
      );
      final landingDateAndTime = landing.dateTime.toLocal().toString().substring(0, 16);

      final distanceMeters = extractInt(distanceController.text);
      final altitudeMeters = extractInt(altitudeController.text);
      var location = locationController.text;
      var droneAccum = droneAccumController.text;
      var droneAccumChargeLeft = extractInt(droneAccumChargeLeftController.text);
      var rcAccumChargeLeft = extractInt(rcAccumChargeLeftController.text);

      // ScaffoldMessenger.of(context).showSnackBar(
      //   // SnackBar(content: Text('Takeoff Time: $takeoffTime')),
      //   SnackBar(content: Text(flightLog)),
      // );

      final finalLog = BaseFlightLogModel(
        takeoffDateAndTime: takeoffDateAndTime,
        landingDateAndTime: landingDateAndTime,
        flightTimeMinutes: flightTimeMinutes,
        distanceMeters: distanceMeters,
        altitudeMeters: altitudeMeters,
        location: location,
        droneAccum: droneAccum,
        droneAccumChargeLeft: droneAccumChargeLeft,
        rcAccumChargeLeft: rcAccumChargeLeft,
        shiftId: widget.shiftId,
      );

      return finalLog;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    void proceedToNewShift() {
      appState.removeFromHistory(FlightLogForm.routeName);
      Navigator.pop(context);
      Navigator.push(context,
        MaterialPageRoute(builder: (context) =>
          NewShift(givenShiftId: widget.shiftId),
        ),
      );
    }

    void proceedToLogs() {
      appState.removeFromHistory(FlightLogForm.routeName);
      Navigator.pop(context);
    }

    void proceedToLogsWithReload() {
      // appState.resetFlightLogs();
      appState.removeFromHistory(FlightLogForm.routeName);
      Navigator.pop(context);
      Navigator.push(context,
        MaterialPageRoute(builder: (context) =>
          FlightLogs(
            title: 'Flight logs ${appState.flightLogs.length}',
          )),
      );
    }

    void navigateByOKButton(BaseFlightLogModel editedLog) {
      /// form being used for a new log
      if (widget.log == null || appState.newShiftFlightLogs.isNotEmpty) {
        proceedToNewShift();
      } else {
        bool isLogChanged = hasFlightLogChanged(widget.log as FlightLogModel, editedLog);
        if (isLogChanged) {
          proceedToLogsWithReload();
        } else {
          proceedToLogs();
        }
      }
    }

    void navigateByBackButton() {
      proceedToLogs();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            BackButton(
              onPressed: navigateByBackButton,
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.all(16)),
              ),
            ),
            const Padding(padding: EdgeInsets.all(8)),
            const Text('Flight Log Form'),
          ],
        ),
        // automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      // const Padding(
                      //   padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      //   child: Text('Distance'),
                      // ),
                      const Text('Date'),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          SizedBox(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Calendar(callback: (d) {
                                    setDate(d, null);
                                    Navigator.pop(context);
                                  })),
                                );
                              },
                              child: Text(date),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // ================= TAKEOFF TIME =================
                  Column(
                    children: [
                      const Text('Takeoff Time'),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          // ================= TAKEOFF HOURS =================
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: SizedBox(
                              width: 22,
                              height: 80,
                              child: TextFormField(
                                controller: takeoffHoursController,
                                validator: validateHours,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}')),
                                ],
                                textAlign: TextAlign.end,
                                onChanged: (e) {
                                  final landing = getLandingTime(
                                    dateISO,
                                    GetLandingTimeArgument(takeoffHoursController.text, validateHours),
                                    GetLandingTimeArgument(takeoffMinutesController.text, validateMinutes),
                                    GetLandingTimeArgument(flightTimeController.text, validateFlightTime),
                                  );

                                  setLandingTime(landing.time);
                                }
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 36.0),
                            child: Text(':', textScaler: TextScaler.linear(1.3),),
                          ),
                          // ================= TAKEOFF MINUTES =================
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 22,
                              height: 80,
                              child: TextFormField(
                                controller: takeoffMinutesController,
                                validator: validateMinutes,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}')),
                                ],
                                textAlign: TextAlign.end,
                                onChanged: (e) {
                                  final landing = getLandingTime(
                                    dateISO,
                                    GetLandingTimeArgument(takeoffHoursController.text, validateHours),
                                    GetLandingTimeArgument(takeoffMinutesController.text, validateMinutes),
                                    GetLandingTimeArgument(flightTimeController.text, validateFlightTime),
                                  );

                                  setLandingTime(landing.time);
                                }
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // ================= LANDING TIME =================
                  Column(
                    children: [
                      const Text('Landing Time'),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          // ================= LANDING HOURS =================
                          Padding(
                            padding: const EdgeInsets.only(bottom: 38.0, top: 16.0),
                            child: Text(landingTime.length == 5 ? landingTime.substring(0, 2) : '', textScaler: const TextScaler.linear(1.2),),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 42.0, top: 16.0),
                            child: Text(' : ', textScaler: TextScaler.linear(1.3),),
                          ),
                          // ================= LANDING MINUTES =================
                          Padding(
                            padding: const EdgeInsets.only(bottom: 38.0, top: 16.0),
                            child: Text(landingTime.length == 5 ? landingTime.substring(3) : '', textScaler: const TextScaler.linear(1.2),),
                          ),
                        ],
                      ),
                    ],
                  ),
        
                  // ================= FLIGHT TIME =================
                  Column(
                    children: [
                      const Text('Flight Time'),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: 22,
                            height: 80,
                            child: TextFormField(
                              controller: flightTimeController,
                              validator: validateFlightTime,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}')),
                              ],
                              textAlign: TextAlign.end,
                              onChanged: (e) {
                                final landing = getLandingTime(
                                  dateISO,
                                  GetLandingTimeArgument(takeoffHoursController.text, validateHours),
                                  GetLandingTimeArgument(takeoffMinutesController.text, validateMinutes),
                                  GetLandingTimeArgument(flightTimeController.text, validateFlightTime),
                                );

                                setLandingTime(landing.time);
                              }
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
        
              // ================= SECOND ROW =================
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // ================= DISTANCE =================
                  Column(
                    children: [
                      const Text('Distance'),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: 55,
                            height: 80,
                            child: TextFormField(
                              controller: distanceController,
                              validator: validateDistance,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'^\d{0,5}')),
                              ],
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
        
                 // ================= ALTITUDE =================
                  Column(
                    children: [
                      const Text('Altitude'),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: 55,
                            height: 80,
                            child: TextFormField(
                              controller: altitudeController,
                              validator: validateAltitude,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'^\d{0,5}')),
                              ],
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
        
                 // ================= LOCATION =================
                  Column(
                    children: [
                      const Text('Location'),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: 160,
                            height: 80,
                            child: TextFormField(
                              controller: locationController,
                              validator: validateLocation,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
        
              // ================= THIRD ROW =================
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // ================= DRONE ACCUM =================
                  Column(
                    children: [
                      const Text('Accum'),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: 55,
                            height: 80,
                            child: TextFormField(
                              controller: droneAccumController,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_\-]')),
                              ],
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
        
                 // ================= DRONE ACCUM % LEFT =================
                  Column(
                    children: [
                      const Text('Accum % Left'),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: 22,
                            height: 80,
                            child: TextFormField(
                              controller: droneAccumChargeLeftController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}')),
                              ],
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
        
                 // ================= RC ACCUM % LEFT =================
                  Column(
                    children: [
                      const Text('RC Accum % Left'),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: 22,
                            height: 80,
                            child: TextFormField(
                              controller: rcAccumChargeLeftController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}')),
                              ],
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
        
              // ================= NOTE =================
              const Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                child: Text(
                  '* Enter flight time in minutes, distance and altitude - in meters',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
        
              // ================= OK BUTTON =================
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 24.0),
                child: ElevatedButton(
                  onPressed: () async {
                    BaseFlightLogModel? editedLog = getEditedLog();

                    if (editedLog != null) {
                      if (widget.log == null) {
                        await appState.dbAddFlightLog(editedLog/*, widget.shiftId*/);
                      } else {
                        await appState.dbUpdateFlightLog(editedLog, widget.log!.id);
                      }

                      navigateByOKButton(editedLog);
                    }
                  },
                  // onPressed: save,
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
