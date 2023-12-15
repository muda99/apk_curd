import 'package:apk_curd/tab/beranda_menu.dart';
import 'package:apk_curd/tab/profil.dart';
import 'package:apk_curd/tab/transaksi_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tb;
  @override
  void initState() {
    super.initState();
    tb = TabController(length: 3, vsync: this);
    tb.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  // final theImage = Icon(icon);

  /// Did Change Dependencies
  // @override
  // void didChangeDependencies() {
  //   precacheImage(theImage.icone, context);
  //   super.didChangeDependencies();
  // }

  late MediaQueryData queryData;
  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return MediaQuery(
      data: queryData.copyWith(textScaleFactor: 1.0),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              children: [
                //
                Expanded(
                  child: TabBarView(
                      controller: tb,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        MyHomePage(),
                        TransaksiTeb(),

                        // dataada(),

                        UserProfilePage(),
                        // absenmap(),
                        // MyTable(),
                        // // HomeScreen(),
                        // // ScheduleScreen(),
                        // // CommunityScreen(),
                        // // NotificationScreen(),
                        // ProfileScreen(),
                      ]),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 3,
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 4),
              child: TabBar(
                  controller: tb,
                  labelPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  tabs: [
                    Tab(
                      child: tb.index == 0
                          ? tabItem1(context, 0, Icons.home, 10, "Beranda")
                          : tabItem(0, Icons.home, 20),
                    ),
                    Tab(
                      child: tb.index == 1
                          ? tabItem1(
                              context, 0, Icons.calendar_today, 10, "Schedule")
                          : tabItem(1, Icons.calendar_today, 20),
                    ),
                    // Tab(
                    //   child: tb.index == 2
                    //       ? tabItem1(context, 0, Icons.info, 10, "Informasi")
                    //       : tabItem(2, Icons.info_outline, 20),
                    // ),
                    // Tab(
                    //   child: tb.index == 3
                    //       ? tabItem1(
                    //           context, 0, "assets/icons/tab5.png", 10, "Pesan")
                    //       : tabItem(3, "assets/icons/ic_notification2.png", 20),
                    // ),
                    Tab(
                      child: tb.index == 2
                          ? tabItem1(context, 0, Icons.person, 10, "Profil")
                          : tabItem(4, Icons.person_outlined, 18.0),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

Container tabItem1(context, int index, IconData icon, double sc, String title) {
  return Container(
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.directional(
          top: 0,
          start: 0,
          end: 0,
          textDirection: Directionality.of(context),
          child: Container(
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: Color(0xFF007100),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF007100),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Container tabItem(int index, IconData icon, double sc) {
  return Container(
    child: Icon(
      icon,
      size: 30,
      color: Colors.grey,
    ),
  );
}
