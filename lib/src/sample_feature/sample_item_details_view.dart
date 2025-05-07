// import 'package:flutter/material.dart';

// /// Displays detailed information about a SampleItem.
// class SampleItemDetailsView extends StatelessWidget {
//   SampleItemDetailsView({super.key});

//   static const routeName = '/sample_item';

//   // final _formKey = 100;
//   final TextEditingController _timeStartController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Item Details'),
//       ),
//       body: Center(
//           // child: Text('More Information Here'),
//         child: Column(
//           children: [
//             Form(
//               // key: _formKey,
//               child: Column(
//                 children: <Widget>[
//                   TextFormField(
//                     controller: _timeStartController,
//                     decoration: const InputDecoration(
//                       labelText: 'Start Time',
//                     ),
//                     validator: (value) {
//                       // ignore: avoid_print
//                       print('validator $value');
//                       if (value!.isEmpty) {
//                         return 'Please enter the start time';
//                       }
//                       return null;
//                     },
//                     onChanged: (value) {
//                       print('[onChanged]: $value');
//                     },
//                     onTap: () {
//                       print('[onTap]');
//                     },
//                     onTapOutside: (value) {
//                       print('[onTapOutside] PointerDownEvent: $value');
//                     },
//                     onEditingComplete: () {
//                       print('[onEditingComplete]');
//                     },
//                   ),
//                   TextFormField(
//                     // controller: _distanceController,
//                     decoration: const InputDecoration(
//                       labelText: 'Distance',
//                     ),
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter the distance';
//                       }
//                       return null;
//                     },
//                   ),
//                   // Add other input fields and a Submit button
//                 ],
//               ),
//             )
//           ],
//       )),
//     );
//   }
// }
