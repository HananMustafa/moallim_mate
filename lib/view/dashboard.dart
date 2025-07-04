import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:moallim_mate/res/color.dart';
import 'package:moallim_mate/utils/routes/routes_name.dart';
import 'package:moallim_mate/view_model/connect_moellim_view_model.dart';
import 'package:moallim_mate/view_model/event_view_model.dart';
import 'package:moallim_mate/view_model/services/notification_services.dart';
import 'package:moallim_mate/view_model/services/showcaseview_services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.title});

  final String title;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey _one = GlobalKey();

  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;

  Future<List<dynamic>>? _futureEvents;

  NotificationServices notificationServices = NotificationServices();
  ShowcaseviewServices showcaseviewServices = ShowcaseviewServices();

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    // notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('Device token: $value');
      }
    });

    // CheckSharedPreferences.checkTokenStatus(context);
    _futureEvents = fetchEvents(); // Fetching Events from Shared Preferences

    // DISPLAY BANNER AD
    // Original ID: ca-app-pub-4820995219603571/8240911467
    // Testing ID: ca-app-pub-3940256099942544/9214589741
    BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/9214589741',
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          if (kDebugMode) {
            print('Failed to load a banner ad: ${err.message}');
          }
          ad.dispose();
        },
      ),
    ).load();

    // DISPLAY INTERSTITIAL AD
    // Original ID: ca-app-pub-4820995219603571/6921882944
    // Testing ID: ca-app-pub-3940256099942544/1033173712
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {},
          );
          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          if (kDebugMode) {
            print('Failed to load an interstitial Ad: ${err.message}');
          }
        },
      ),
    );

    // Calling Show Case View
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showcaseviewServices.checkFirstLaunch(context, _one);
    });
  }

  Future<List<dynamic>> fetchEvents() async {
    final eventViewModel = Provider.of<EventViewModel>(context, listen: false);
    final event = await eventViewModel.getEvent();
    if (event != null) {
      // Assuming `event.toJson()` returns a map with 'json' as key
      return event.toJson()['json'] ?? [];
    }
    // return [];
    // Return dummy events if `event` is null
    return _getDummyEvents();
  }

  /// Dummy data for testing
  List<Map<String, dynamic>> _getDummyEvents() {
    return [
      {
        'coursefullname': 'Introduction to Flutter',
        'name': 'Assignment 1: Widgets',
        'modulename': 'Assignment',
        'description': 'Dummy data for testers',
        'timestart':
            DateTime.now().add(Duration(days: 3)).millisecondsSinceEpoch ~/
            1000,
      },
      {
        'coursefullname': 'Mobile App Development',
        'name': 'Quiz 1: Dart Basics',
        'modulename': 'Quiz',
        'description': 'Dummy data for testers',
        'timestart':
            DateTime.now().add(Duration(days: 5)).millisecondsSinceEpoch ~/
            1000,
      },
    ];
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
        backgroundColor: AppColors.primaryBackground,
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.2,
            color: AppColors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_bannerAd != null)
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                ),
              ),

            Align(
              alignment: Alignment.topRight,
              child: TextButton.icon(
                onPressed:
                    connectMoellimViewModel.getEventLoading
                        ? null
                        : () async {
                          _interstitialAd?.show();
                          SharedPreferences sp =
                              await SharedPreferences.getInstance();
                          String? token = sp.getString('token');
                          Map data = {'token': token};

                          if (!context.mounted) return;
                          await connectMoellimViewModel.getEventsApi(
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
                  backgroundColor: AppColors.primaryBackground.withAlpha(
                    (0.1 * 255).round(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),

            /// Display events using FutureBuilder
            Expanded(
              child:
                  _futureEvents == null
                      ? const Text('Press the button to load events.')
                      : FutureBuilder<List<dynamic>>(
                        future: _futureEvents,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 3,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// Top Row: Logo + Module Name
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.event_note,
                                            size: 22,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              event['modulename'] ?? '',
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),

                                      /// Course Name (highlighted)
                                      Text(
                                        event['coursefullname'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 6),

                                      /// Title (highlighted)
                                      Text(
                                        event['name'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 6),

                                      /// Instructions (low priority)
                                      if (event['description'] != null &&
                                          event['description']
                                              .toString()
                                              .trim()
                                              .isNotEmpty)
                                        Text(
                                          event['description'],
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                      const SizedBox(height: 12),

                                      /// Due Date (bottom left, highlighted)
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          _formatUnixTimestamp(
                                            event['timestart'],
                                          ),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black87,
                                          ),
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
      floatingActionButton: Showcase(
        key: _one,
        description: 'Connect Moellim from here',
        child: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
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
      ),
    );
  }

  /// Converts Unix timestamp to readable format
  String _formatUnixTimestamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final day = date.day;
    final month = _monthName(date.month);
    final hour =
        date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final minute = date.minute.toString().padLeft(2, '0');
    final ampm = date.hour >= 12 ? 'pm' : 'am';

    return "$day $month $hour:$minute$ampm";
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
