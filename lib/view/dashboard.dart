import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:moallim_mate/res/color.dart';
import 'package:moallim_mate/res/components/round_button.dart';
import 'package:moallim_mate/utils/routes/routes_name.dart';
import 'package:moallim_mate/utils/utils.dart';
import 'package:moallim_mate/view_model/connect_moellim_view_model.dart';
import 'package:moallim_mate/view_model/event_view_model.dart';
import 'package:moallim_mate/view_model/services/check_shared_preferences_services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.title});

  final String title;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<List<dynamic>>? _futureEvents;

  @override
  void initState() {
    super.initState();
    CheckSharedPreferences.checkTokenStatus(context);
    _futureEvents = fetchEvents(); // Fetching Events from Shared Preferences
  }

  Future<List<dynamic>> fetchEvents() async {
    final eventViewModel = Provider.of<EventViewModel>(context, listen: false);
    final event = await eventViewModel.getEvent();
    if (event != null) {
      // Assuming `event.toJson()` returns a map with 'json' as key
      return event.toJson()['json'] ?? [];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final connectMoellimViewModel = Provider.of<ConnectMoellimViewModel>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 252, 136, 58),
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.2,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton.icon(
                onPressed:
                    connectMoellimViewModel.getEventLoading
                        ? null
                        : () async {
                          SharedPreferences sp =
                              await SharedPreferences.getInstance();
                          String? token = sp.getString('token');
                          Map data = {'token': token};

                          await connectMoellimViewModel.GetEventsApi(
                            data,
                            context,
                          );

                          setState(() {
                            _futureEvents =
                                fetchEvents(); // Trigger fetching after API call
                          });
                        },
                icon:
                    connectMoellimViewModel.getEventLoading
                        ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Icon(Icons.refresh, color: AppColors.primary),
                label: Text(
                  connectMoellimViewModel.getEventLoading
                      ? 'Refreshing...'
                      : 'Refresh',
                  style: TextStyle(
                    color:
                        connectMoellimViewModel.getEventLoading
                            ? Colors.grey
                            : AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: const Color.fromARGB(
                    255,
                    243,
                    135,
                    33,
                  ).withOpacity(0.1),
                ),
              ),
            ),
            const SizedBox(height: 4),

            /// Display events using FutureBuilder
            Expanded(
              child:
                  _futureEvents == null
                      ? Text('Press the button to load events.')
                      : FutureBuilder<List<dynamic>>(
                        future: _futureEvents,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Text('No events found.');
                          }

                          final events = snapshot.data!;
                          return ListView.builder(
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              final event = events[index];
                              return Card(
                                // margin: const EdgeInsets.symmetric(
                                //   vertical: 8,
                                //   horizontal: 16,
                                // ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: "Course Name: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  event['coursefullname'] ?? '',
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: "Title: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(text: event['name'] ?? ''),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: "Type: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: event['modulename'] ?? '',
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: "Instructions: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: event['description'] ?? '',
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: "Due Date: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: _formatUnixTimestamp(
                                                event['timestart'],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.whiteColor,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.sync),
            label: 'Connect Moellim',
            onTap: () {
              Navigator.pushNamed(context, RoutesName.connectMoellim);
            },
          ),
        ],
      ),
    );
  }

  /// Converts Unix timestamp to readable format
  String _formatUnixTimestamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
  }
}

// class _DashboardState extends State<Dashboard> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     // Call DashboardServices to check token
//     CheckSharedPreferences.checkTokenStatus(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final connectMoellimViewModel = Provider.of<ConnectMoellimViewModel>(
//       context,
//     );

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             RoundButton(
//               title: 'Get Events',
//               loading:
//                   Provider.of<ConnectMoellimViewModel>(context).getEventLoading,
//               onPress: () async {
//                 // Getting Token
//                 SharedPreferences sp = await SharedPreferences.getInstance();
//                 String? token = sp.getString('token');
//                 Map data = {'token': token};

//                 // Hitting Get Events Api
//                 final connectMoellimViewModel =
//                     Provider.of<ConnectMoellimViewModel>(
//                       context,
//                       listen: false,
//                     );
//                 await connectMoellimViewModel.GetEventsApi(data, context);

//                 // Getting Events Data from Shared Preferences
//                 final eventViewModel = Provider.of<EventViewModel>(
//                   context,
//                   listen: false,
//                 );
//                 final event = await eventViewModel.getEvent();
//                 if (event != null) {
//                   print(
//                     'Events extracted from shared preferences: ${event.toJson()}',
//                   );
//                 } else {
//                   print('No event found in shared preferences');
//                 }
//               },
//             ),

//             //Future Builder
//           ],
//         ),
//       ),

//       floatingActionButton: SpeedDial(
//         icon: Icons.add,
//         activeIcon: Icons.close,
//         backgroundColor: AppColors.primary,
//         children: [
//           SpeedDialChild(
//             child: Icon(Icons.sync),
//             label: 'Connect Moellim',
//             onTap: () {
//               Navigator.pushNamed(context, RoutesName.connectMoellim);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
