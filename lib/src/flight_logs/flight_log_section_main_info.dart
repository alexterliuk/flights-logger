// import 'package:flutter/material.dart';
// import '../utils/date_time/get_time.dart';
// import '../utils/get_flight_log_distance_kilometers.dart';
// import 'flight_log_model.dart';
// import 'flight_logs.dart';
//
// class FlightLogSectionMainInfo extends StatelessWidget {
//   const FlightLogSectionMainInfo({
//     super.key,
//     required this.log,
//     required this.index,
//     required this.isSingleShiftMode,
//     required this.edit,
//     required this.remove,
//     required this.flightLogsState,
//   });
//
//   final FlightLogModel log;
//   final int index;
//   final bool isSingleShiftMode;
//   final Null Function() edit;
//   final Future<Null> Function() remove;
//   final FlightLogsState flightLogsState;
//
//   @override
//   Widget build(BuildContext context) {
//     var countCell = Expanded(
//       flex: 3,
//       child: Text(
//         '${index + 1}',
//         textAlign: TextAlign.start,
//         style: const TextStyle(height: 2.4),
//       ),
//     );
//
//     var takeoffDateCell = Expanded(
//       flex: 3,
//       child: Text(
//         log.takeoffDateAndTime,
//         textAlign: TextAlign.start,
//         style: const TextStyle(height: 2.4),
//       ),
//     );
//
//     var takeoffTimeCell = Expanded(
//       flex: 2,
//       child: Text(
//         getTime(log.takeoffDateAndTime),
//         textAlign: TextAlign.end,
//         style: const TextStyle(height: 2.4),
//       ),
//     );
//
//     var landingTimeCell = Expanded(
//       flex: 2,
//       child: Text(
//         getTime(log.landingDateAndTime),
//         textAlign: TextAlign.end,
//         style: const TextStyle(height: 2.4),
//       ),
//     );
//
//     var distanceCell = Expanded(
//       flex: 2,
//       child: Text(
//         getFlightLogDistanceKilometers(log.distanceMeters),
//         textAlign: TextAlign.end,
//         style: const TextStyle(height: 2.4),
//       ),
//     );
//
//     var locationCell = Expanded(
//       flex: 2,
//       child: Text(
//         log.location,
//         textAlign: TextAlign.end,
//         style: const TextStyle(height: 2.4),
//       ),
//     );
//
//     var buttonsBlockCell = Expanded(
//       flex: 2,
//       child: SizedBox(
//         width: 82,
//         child: Flex(
//           direction: Axis.horizontal,
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.edit),
//               onPressed: edit,
//               iconSize: 18,
//               visualDensity: VisualDensity.compact,
//             ),
//             IconButton(
//               icon: const Icon(Icons.delete),
//               onPressed: remove,
//               iconSize: 18,
//               visualDensity: VisualDensity.compact,
//             ),
//           ],
//         ),
//       ),
//     );
//
//     // return Row(
//     //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//     //   children: [
//     //     Expanded(
//     //       flex: 3,
//     //       child: Text(
//     //         isSingleShiftMode
//     //           ? '${index + 1}'
//     //           : log.takeoffDateAndTime,
//     //         textAlign: TextAlign.start,
//     //         style: const TextStyle(height: 2.4),
//     //       ),
//     //     ),
//     //     Expanded(
//     //       flex: 2,
//     //       child: Text(
//     //         getTime(log.takeoffDateAndTime),
//     //         textAlign: TextAlign.end,
//     //         style: const TextStyle(height: 2.4),
//     //       ),
//     //     ),
//     //     Expanded(
//     //       flex: 2,
//     //       child: Text(
//     //         getTime(log.landingDateAndTime),
//     //         textAlign: TextAlign.end,
//     //         style: const TextStyle(height: 2.4),
//     //       ),
//     //     ),
//     //     isSingleShiftMode
//     //       ? Expanded(
//     //           flex: 2,
//     //           child: Text(
//     //             getFlightLogDistanceKilometers(log.distanceMeters),
//     //             textAlign: TextAlign.end,
//     //             style: const TextStyle(height: 2.4),
//     //           ),
//     //         )
//     //       : Container(),
//     //     flightLogsState.isButtonsBlockShown(index)
//     //       ? Expanded(
//     //           flex: 2,
//     //           child: buttonsBlock,
//     //         )
//     //       : Expanded(
//     //           flex: 2,
//     //           child: Text(
//     //             isSingleShiftMode
//     //               ? log.location
//     //               : getFlightLogDistanceKilometers(log.distanceMeters),
//     //             textAlign: TextAlign.end,
//     //             style: const TextStyle(height: 2.4),
//     //           ),
//     //         ),
//     //   ],
//     // );
//   }
// }
