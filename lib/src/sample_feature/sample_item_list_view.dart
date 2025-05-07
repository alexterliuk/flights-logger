// import 'package:flutter/material.dart';

// import '../settings/settings_view.dart';
// import 'sample_item.dart';
// import 'sample_item_details_view.dart';

// /// Displays a list of SampleItems.
// class SampleItemListView extends StatelessWidget {
//   const SampleItemListView({
//     super.key,
//     this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
//   });

//   static const routeName = '/sample_itemsss';

//   final List<SampleItem> items;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sample Items'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.settings),
//             onPressed: () {
//               // Navigate to the settings page. If the user leaves and returns
//               // to the app after it has been killed while running in the
//               // background, the navigation stack is restored.
//               Navigator.restorablePushNamed(context, SettingsView.routeName);
//             },
//           ),
//         ],
//       ),

//       // To work with lists that may contain a large number of items, it’s best
//       // to use the ListView.builder constructor.
//       //
//       // In contrast to the default ListView constructor, which requires
//       // building all Widgets up front, the ListView.builder constructor lazily
//       // builds Widgets as they’re scrolled into view.
//       body: ListView.builder(
//         // Providing a restorationId allows the ListView to restore the
//         // scroll position when a user leaves and returns to the app after it
//         // has been killed while running in the background.
//         restorationId: 'sampleItemListView',
//         itemCount: items.length,
//         itemBuilder: (BuildContext context, int index) {
//           final item = items[index];

//           return ListTile(
//             title: Text('SampleItem ${item.id}'),
//             leading: const CircleAvatar(
//               // Display the Flutter Logo image asset.
//               foregroundImage: AssetImage('assets/images/flutter_logo.png'),
//             ),
//             onTap: () {
//               // Navigate to the details page. If the user leaves and returns to
//               // the app after it has been killed while running in the
//               // background, the navigation stack is restored.
//               Navigator.restorablePushNamed(
//                 context,
//                 SampleItemDetailsView.routeName,
//               );
//             }
//           );
//         },
//       ),

//       // body: ListView.builder(
//       //   padding: const EdgeInsets.all(8),
//       //   itemCount: [1, 2, 3].length + 1,
//       //   clipBehavior: Clip.none,
//       //   itemBuilder: (context, index) {
//       //     if (index != 2) {
//       //       return Stack(
//       //         clipBehavior: Clip.none,
//       //         children: [
//       //           Text('dasdasdasd'),
//       //           index == 1
//       //               ? Positioned(
//       //                   child: Text('1hjkkhj'),
//       //                   bottom: -20,
//       //                   left: 0,
//       //                   right: 0,
//       //                 )
//       //               : SizedBox(),
//       //         ],
//       //       );
//       //     } else {
//       //       return SizedBox(
//       //         height: 20,
//       //       );
//       //     }
//       //   },
//       // ),
//     );
//   }
// }
