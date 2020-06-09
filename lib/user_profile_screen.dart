import 'package:flutter/material.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({Key key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    elevation: 0,
                    iconTheme: IconThemeData(color: Colors.black),
                    expandedHeight: 250,
                    floating: false,
                    snap: false,
                    pinned: true,
                    backgroundColor: Colors.white,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        child: Image.asset(
                          'images/profile.jpeg',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ];
          },
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                BannerSwiper(
                  height: (MediaQuery.of(context).size.height / 0.9).round(),
                  width: MediaQuery.of(context).size.width.round(),
                  spaceMode: false,
                  length: 3,
                  getwidget: (index) {
                    return Image.asset(
                      'images/bg.jpeg',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                tabBarContainer(),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 300,
                  child: TabBarView(
                    children: <Widget>[taskTab(), basicInfoTab()],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container tabBarContainer() {
    return Container(
      height: 50,
      width: 270,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              //                          spreadRadius: 1,
              blurRadius: 4.0,
              offset: Offset(3.0, 0),
            )
          ],
          borderRadius: BorderRadius.circular(30)),
      child: TabBar(
        indicatorColor: Colors.transparent,
        labelColor: Colors.black87,
        unselectedLabelColor: Colors.grey,
        tabs: [
          Tab(
            text: "TASKS",
          ),
          Tab(text: "BASIC INFO"),
        ],
      ),
    );
  }

  // personal details tab

  Widget basicInfoTab() {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Personal Details',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                children: [
                  tableRow('Name', 'Velpari '),
                  tableRow('Age', '27 '),
                  tableRow('D.O.B', '04-05-1991'),
                  tableRow('Marital Status', 'Single'),
                ],
              ),
            ),
            Divider(),
            Text(
              'Contact',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                children: [
                  tableRow('Mobile', '908077426 '),
                  tableRow('Email', 'vp@gmail.com '),
                ],
              ),
            ),
            Divider(),
            Text(
              'Work Experience',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                children: [
                  tableRow('Current', 'Web'),
                  tableRow('Previous', 'telecommunication'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // tasks Tab

  Padding taskTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8.0),
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Divider(),
            Text(
              'Tasks',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange, width: 5),
                      borderRadius: BorderRadius.circular(80)),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Text(
                      '24',
                      style: TextStyle(fontSize: 24, color: Colors.orange),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.greenAccent, width: 5),
                      borderRadius: BorderRadius.circular(80)),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Text(
                      '22',
                      style: TextStyle(fontSize: 24, color: Colors.greenAccent),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink, width: 5),
                      borderRadius: BorderRadius.circular(80)),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Text(
                      '2',
                      style: TextStyle(fontSize: 24, color: Colors.pink),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Total Tasks'),
                Text('Pending'),
                Text('Active Hrs'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider()
          ],
        ),
      ),
    );
  }

  // tab row text

  TableRow tableRow(String title, String text) {
    return TableRow(
      children: [
        Text(title),
        Text(text),
      ],
    );
  }
}
