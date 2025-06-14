import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import './src/app.dart';
import './src/settings/settings_controller.dart';
import './src/settings/settings_service.dart';
import './src/app_state_init_data.dart';
import 'src/app_state_init_data_model.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();

  // THESE 2 LINES MOVED TO openDb
  // sqfliteFfiInit();
  // databaseFactory = databaseFactoryFfi;

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // final appStateInitData = AppStateInitData();

  // await appStateInitData.loadInitData();

  // AppStateInitDataModel initData = appStateInitData.getData();

  // print('[main] after loading of initial data');

  // CTRL
  // settingsController.loadAltitudeLogs();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  // runApp(MyApp(settingsController: settingsController, appStateInitData: appStateInitData));
  // runApp(MyApp(settingsController: settingsController, initData: initData));
  runApp(MyApp(settingsController: settingsController));
}


















// import 'dart:async';

// import 'package:flutter/widgets.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// void main() async {
//   // Avoid errors caused by flutter upgrade.
//   // Importing 'package:flutter/widgets.dart' is required.
//   WidgetsFlutterBinding.ensureInitialized();
//   // Open the database and store the reference.
//   final database = openDatabase(
//     // Set the path to the database. Note: Using the `join` function from the
//     // `path` package is best practice to ensure the path is correctly
//     // constructed for each platform.
//     join(await getDatabasesPath(), 'doggie_database.db'),
//     // When the database is first created, create a table to store dogs.
//     onCreate: (db, version) {
//       // Run the CREATE TABLE statement on the database.
//       return db.execute(
//         'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
//       );
//     },
//     // Set the version. This executes the onCreate function and provides a
//     // path to perform database upgrades and downgrades.
//     version: 1,
//   );

//   // Define a function that inserts dogs into the database
//   Future<void> insertDog(Dog dog) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Insert the Dog into the correct table. You might also specify the
//     // `conflictAlgorithm` to use in case the same dog is inserted twice.
//     //
//     // In this case, replace any previous data.
//     await db.insert(
//       'dogs',
//       dog.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // A method that retrieves all the dogs from the dogs table.
//   Future<List<Dog>> dogs() async {
//     // Get a reference to the database.
//     final db = await database;

//     // Query the table for all the dogs.
//     final List<Map<String, Object?>> dogMaps = await db.query('dogs');

//     // Convert the list of each dog's fields into a list of `Dog` objects.
//     return [
//       for (final {
//             'id': id as int,
//             'name': name as String,
//             'age': age as int,
//           } in dogMaps)
//         Dog(id: id, name: name, age: age),
//     ];
//   }

//   Future<void> updateDog(Dog dog) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Update the given Dog.
//     await db.update(
//       'dogs',
//       dog.toMap(),
//       // Ensure that the Dog has a matching id.
//       where: 'id = ?',
//       // Pass the Dog's id as a whereArg to prevent SQL injection.
//       whereArgs: [dog.id],
//     );
//   }

//   Future<void> deleteDog(int id) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Remove the Dog from the database.
//     await db.delete(
//       'dogs',
//       // Use a `where` clause to delete a specific dog.
//       where: 'id = ?',
//       // Pass the Dog's id as a whereArg to prevent SQL injection.
//       whereArgs: [id],
//     );
//   }

//   // Create a Dog and add it to the dogs table
//   var fido = Dog(
//     id: 0,
//     name: 'Fido',
//     age: 35,
//   );

//   await insertDog(fido);

//   // Now, use the method above to retrieve all the dogs.
//   print(await dogs()); // Prints a list that include Fido.

//   // Update Fido's age and save it to the database.
//   fido = Dog(
//     id: fido.id,
//     name: fido.name,
//     age: fido.age + 7,
//   );
//   await updateDog(fido);

//   // Print the updated results.
//   print(await dogs()); // Prints Fido with age 42.

//   // Delete Fido from the database.
//   await deleteDog(fido.id);

//   // Print the list of dogs (empty).
//   print(await dogs());
// }

// class Dog {
//   final int id;
//   final String name;
//   final int age;

//   Dog({
//     required this.id,
//     required this.name,
//     required this.age,
//   });

//   // Convert a Dog into a Map. The keys must correspond to the names of the
//   // columns in the database.
//   Map<String, Object?> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'age': age,
//     };
//   }

//   // Implement toString to make it easier to see information about
//   // each dog when using the print statement.
//   @override
//   String toString() {
//     return 'Dog{id: $id, name: $name, age: $age}';
//   }
// }
