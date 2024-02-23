import 'package:flutter/material.dart';
import 'package:google_maps/Widgets/custom_google_map.dart';
import 'package:google_maps/utils/google_maps_google_places_services.dart';

void main() {
  runApp(const TestGoogleMapsWithFlutter());
}

class TestGoogleMapsWithFlutter extends StatelessWidget {
  const TestGoogleMapsWithFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(child: CustomGoogleMapState()),
        ));
  }
}

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           children: [
//             ElevatedButton(
//                 onPressed: () async {
//                   GoogleMapsPlacesServices g;
//                   g = GoogleMapsPlacesServices();
//                   var google = await g.getPredictions(input: "alex");
//                   print(google);
//                 },
//                 child: Text("Test"))
//           ],
//         ),
//       ),
//     );
//   }
// }
