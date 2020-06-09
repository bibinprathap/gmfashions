import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:scrollable_panel/scrollable_panel.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final defaultPanelSize = 0.65;
  final maxPanelSize = 1.0;
  PanelController _panelController;
  ValueNotifier<double> _valueNotifier;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier<double>(0.65);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Stack(
          children: <Widget>[
            InkWell(
                onTap: () {
                  _panelController.toDefault();
                },
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: double.infinity,
                    child: Image.asset(
                      'images/profile.jpeg',
                      fit: BoxFit.cover,
                    )
                )
            ),
//            Container(
//              decoration: BoxDecoration(
//                gradient: LinearGradient(
//                  begin: FractionalOffset.topCenter,
//               //   end: FractionalOffset.bottomCenter,
//                  colors: [
//                    Colors.white,
//                    Color(0xff0069ff).withOpacity(0.8),
//                  ],
//                ),
//              ),
//            ),
            Align(
              alignment: Alignment.center,
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                double availablePixels =
                    1.0 * constraints.biggest.height;
                _panelController = PanelController(
                  defaultPanelSize: 0.65,
                  minPanelSize: 0.60,
                  maxPanelSize: 1.0,
                  availablePixels: availablePixels,
                  extent: _valueNotifier,
                );
                return ScrollablePanel(
                  controller: _panelController,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[500],
                          blurRadius: 4.0,
                          offset: Offset(3.0, 0),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0)
                      ),
                      border: Border.all(color: Colors.white),
                    ),
                    child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          BannerSwiper(
                            height: (MediaQuery.of(context).size.height / 0.9)
                                .round(),
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
                );
              }),
            )
          ],
        ),
      ),

//      bottomNavigationBar: BottomNavigationBar(
//
//        items: [
//          BottomNavigationBarItem(
//            icon: Icon(Icons.home,color: black),
//            title: Text('Home',style: TextStyle(color: black),)
//          ),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.calendar_today,color: black),
//              title: Text('Program',style: TextStyle(color: black),)
//          ),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.audiotrack,color: black,),
//              title: Text('Audio',style: TextStyle(color: black),)
//          ),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.videocam,color: black),
//              title: Text('Video',style: TextStyle(color: black),)
//          ),
//
//
//      ],
//
//      ),
    );

//    return Scaffold(
////      appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,),
//      body: DefaultTabController(
//        length: 2,
//        child: Stack(
//          children: <Widget>[
//            Container(
//              decoration: BoxDecoration(
//                  image: DecorationImage(
////                    colorFilter: ColorFilter.mode(
////                        Colors.black.withOpacity(0.5), BlendMode.dstATop),
//                image: AssetImage('images/profile.jpeg'),
//                fit: BoxFit.fitWidth,
//              )),
//              width: double.infinity,
//            ),
//            Container(
//              decoration: BoxDecoration(
//                gradient: LinearGradient(
//                  begin: Alignment.bottomCenter,
//                  end: Alignment.topCenter,
//                  colors: [
//                    Colors.black,
//                    Colors.transparent,
//                  ],
//                ),
//              ),
//              width: double.infinity,
//            ),
//            Container(
//              decoration: BoxDecoration(
//                  color: white,
//                  boxShadow: [
//                    BoxShadow(
//                      color: Colors.grey[500],
//                      //                          spreadRadius: 1,
//                      blurRadius: 5.0,
//                      offset: Offset(3.0, 0),
//                    )
//                  ],
//                  borderRadius: BorderRadius.only(
//                      topLeft: Radius.circular(20),
//                      topRight: Radius.circular(20))),
//              child: DraggableScrollableSheet(
//                expand: true,
//                initialChildSize: 0.9,
//                minChildSize: 0.9,
//                maxChildSize: 0.9,
//                builder: (BuildContext context, myscrollController) {
//                  return Column(
//                    children: <Widget>[
//                      BannerSwiper(
//                        height: (MediaQuery.of(context).size.height / 0.9)
//                            .round(),
//                        width: MediaQuery.of(context).size.width.round(),
//                        spaceMode: false,
//                        length: 3,
//                        getwidget: (index) {
//                          return Image.asset('images/profile1.jpeg');
//                        },
//                      ),
//                      SizedBox(
//                        height: 25,
//                      ),
//                      Container(
//                        height: 50,
//                        width: 270,
//                        decoration: BoxDecoration(
//                            color: white,
//                            boxShadow: [
//                              BoxShadow(
//                                color: Colors.grey[500],
//                                //                          spreadRadius: 1,
//                                blurRadius: 4.0,
//                                offset: Offset(3.0, 0),
//                              )
//                            ],
//                            borderRadius: BorderRadius.circular(30)),
//                        child: TabBar(
//                          indicatorColor: Colors.transparent,
//                          labelColor: Colors.black87,
//                          unselectedLabelColor: Colors.grey,
//                          tabs: [
//                            Tab(
//                              text: "TASKS",
//                            ),
//                            Tab(text: "BASIC INFO"),
//                          ],
//                        ),
//                      ),
//                      SizedBox(
//                        height: 25,
//                      ),
//                      Expanded(
//                        child: TabBarView(
//                          children: <Widget>[taskTab(), basicInfoTab()],
//                        ),
//                      ),
//                    ],
//                  );
////                    return Stack(
////                      children: <Widget>[
////                        Align(
////                          alignment: Alignment.bottomCenter,
////                          child: Container(
////                            height: 50,
////                            width: 270,
////                            decoration: BoxDecoration(
////                                color: white,
////                                boxShadow: [
////                                  BoxShadow(
////                                    color: Colors.grey[500],
////                                    //                          spreadRadius: 1,
////                                    blurRadius: 4.0,
////                                    offset: Offset(3.0, 0),
////                                  )
////                                ],
////                                borderRadius: BorderRadius.circular(30)),
////                            child: TabBar(
////                              indicatorColor: Colors.transparent,
////                              labelColor: Colors.black87,
////                              unselectedLabelColor: Colors.grey,
////                              tabs: [
////                                Tab(
////                                  text: "TASKS",
////                                ),
////                                Tab(text: "BASIC INFO"),
////                              ],
////                            ),
////                          ),
////
////                        ),
////                        Align(
////                          alignment: Alignment.topCenter,
////                          child: Container(
////
////                            child: BannerSwiper(
////                              height: (MediaQuery.of(context).size.height / 0.9)
////                                  .round(),
////                              width: MediaQuery.of(context).size.width.round(),
////                              spaceMode: false,
////                              length: 3,
////                              getwidget: (index) {
////                                return Image.asset('images/profile1.jpeg');
////                              },
////                            ),
////                          ),
////                        ),
////                        TabBarView(
////                          children: <Widget>[taskTab(), basicInfoTab()],
////                        ),
////                      ],
////                    );
//                },
//              ),
//            )
//
//
////            AppBar(elevation: 0,backgroundColor: Colors.transparent,),
////            NestedScrollView(
////              headerSliverBuilder:
////                  (BuildContext context, bool innerBoxIsScrolled) {
////                return <Widget>[
////                  SliverOverlapAbsorber(
////                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
////                        context),
////                    child: SliverSafeArea(
////                      top: false,
////                      sliver: SliverAppBar(
////                        elevation: 0,
////                        iconTheme: IconThemeData(color: black),
////                        expandedHeight: 350,
////                        floating: false,
////                        pinned: true,
////                        backgroundColor: Colors.transparent,
//////                        bottom: PreferredSize(
//////                          preferredSize: Size(0, 0),
//////                          child: Align(
//////                            alignment: Alignment.bottomCenter,
//////                            child: Container(
//////                              height: 50,
//////                              width: 270,
//////                              decoration: BoxDecoration(
//////                                  color: white,
//////                                  boxShadow: [
//////                                    BoxShadow(
//////                                      color: Colors.grey[500],
//////                                      //                          spreadRadius: 1,
//////                                      blurRadius: 4.0,
//////                                      offset: Offset(3.0, 0),
//////                                    )
//////                                  ],
//////                                  borderRadius: BorderRadius.circular(30)
//////                              ),
//////                              child: TabBar(
//////                                indicatorColor: Colors.transparent,
//////                                labelColor: Colors.black87,
//////                                unselectedLabelColor: Colors.grey,
//////                                tabs: [
//////                                  Tab(
//////                                    text: "TASKS",
//////                                  ),
//////                                  Tab(text: "BASIC INFO"),
//////                                ],
//////                              ),
//////                            ),
//////                          ),
//////                        ),
////                        flexibleSpace: FlexibleSpaceBar(
////                          title: Text(
////                            'Good morning Velpari',
////                            style: TextStyle(color: white, fontSize: 14),
////                          ),
////                          background: Stack(
////                            children: <Widget>[
//////                              Container(
//////                                  width: double.infinity,
//////                                  child: Image.asset(
//////                                    'images/profile1.jpeg',
//////                                    fit: BoxFit.cover,
//////                                  )
//////                              ),
//////                          Positioned.fill(
//////                              child: Align(
//////                            alignment: Alignment.bottomCenter,
//////                            child: Container(
//////                              height: 30,
//////                              width: double.infinity,
//////                              decoration: BoxDecoration(
//////                                  color: white,
//////                                  boxShadow: [
//////                                    BoxShadow(
//////                                      color: Colors.grey[500],
//////                                      //                          spreadRadius: 1,
//////                                      blurRadius: 5.0,
//////                                      offset: Offset(3.0, 0),
//////                                    )
//////                                  ],
//////                                  borderRadius: BorderRadius.only(
//////                                      topLeft: Radius.circular(20),
//////                                      topRight: Radius.circular(20))),
//////                            ),
//////                          )),
//////                          Positioned.fill(
//////                            child: Align(
//////                              alignment: Alignment.bottomCenter,
//////                              child: Padding(
//////                                padding: const EdgeInsets.all(8.0),
//////                                child: Container(
//////                                  height: 50,
//////                                  width: 270,
//////                                  decoration: BoxDecoration(
//////                                      color: white,
//////                                      boxShadow: [
//////                                        BoxShadow(
//////                                          color: Colors.grey[500],
//////                                          //                          spreadRadius: 1,
//////                                          blurRadius: 4.0,
//////                                          offset: Offset(3.0, 0),
//////                                        )
//////                                      ],
//////                                      borderRadius: BorderRadius.circular(30)),
////////                                  child:   TabBar(
////////                                    indicatorColor: Colors.transparent,
////////                                    labelColor: Colors.black87,
////////                                    unselectedLabelColor: Colors.grey,
////////                                    tabs: [
////////                                      Tab(text: "TASKS",),
////////                                      Tab(text: "BASIC INFO"),
////////                                    ],
////////                                  ),
//////                                ),
//////                              ),
//////                            ),
//////                          ),
////                            ],
////                          ),
//////                        ),
////                        ),
////                      ),
////                    ),
//////              SliverList(delegate: SliverChildListDelegate([
//////                Container(
//////                  height: 50,
//////                  width: 290,
//////                  decoration: BoxDecoration(
//////                      color: white,
//////                      boxShadow: [
//////                        BoxShadow(
//////                          color: Colors.grey[500],
//////                          //                          spreadRadius: 1,
//////                          blurRadius: 4.0,
//////                          offset: Offset(3.0, 0),
//////                        )
//////                      ],
//////                      borderRadius: BorderRadius.circular(30)
//////
//////                  ),
//////                  child:   TabBar(
//////                    indicatorColor: Colors.transparent,
//////                    labelColor: Colors.black87,
//////                    unselectedLabelColor: Colors.grey,
//////                    tabs: [
//////                      Tab(text: "TASKS",),
//////                      Tab(text: "BASIC INFO"),
//////                    ],
//////                  ),
//////                )
//////              ]
//////              )
//////              )
//////            SliverPersistentHeader(
//////              pinned: true,
//////              delegate:SliverAppBarDelegate(
//////                TabBar(
//////                  indicatorColor: Colors.transparent,
//////                  labelColor: Colors.black87,
//////                  unselectedLabelColor: Colors.grey,
//////                  tabs: [
//////                    Tab(text: "TASKS",),
//////                    Tab(text: "BASIC INFO"),
//////                  ],
//////                ),
//////              ),
//////              )
////                  )
////                ];
////              },
////              body: Container(
////                decoration: BoxDecoration(
////                    color: white,
////                    boxShadow: [
////                      BoxShadow(
////                        color: Colors.grey[500],
////                        //                          spreadRadius: 1,
////                        blurRadius: 5.0,
////                        offset: Offset(3.0, 0),
////                      )
////                    ],
////                    borderRadius: BorderRadius.only(
////                        topLeft: Radius.circular(20),
////                        topRight: Radius.circular(20))),
////                child: DraggableScrollableSheet(
////                  expand: true,
////                  initialChildSize: 0.9,
////                  minChildSize: 0.9,
////                  maxChildSize: 0.9,
////                  builder: (BuildContext context, myscrollController) {
//                    return Column(
////                      children: <Widget>[
////                        BannerSwiper(
////                          height: (MediaQuery.of(context).size.height / 0.9)
////                              .round(),
////                          width: MediaQuery.of(context).size.width.round(),
////                          spaceMode: false,
////                          length: 3,
////                          getwidget: (index) {
////                            return Image.asset('images/profile1.jpeg');
////                          },
////                        ),
////                        SizedBox(
////                          height: 25,
////                        ),
////                        Container(
////                          height: 50,
////                          width: 270,
////                          decoration: BoxDecoration(
////                              color: white,
////                              boxShadow: [
////                                BoxShadow(
////                                  color: Colors.grey[500],
////                                  //                          spreadRadius: 1,
////                                  blurRadius: 4.0,
////                                  offset: Offset(3.0, 0),
////                                )
////                              ],
////                              borderRadius: BorderRadius.circular(30)),
////                          child: TabBar(
////                            indicatorColor: Colors.transparent,
////                            labelColor: Colors.black87,
////                            unselectedLabelColor: Colors.grey,
////                            tabs: [
////                              Tab(
////                                text: "TASKS",
////                              ),
////                              Tab(text: "BASIC INFO"),
////                            ],
////                          ),
////                        ),
////                        SizedBox(
////                          height: 25,
////                        ),
////                        Expanded(
////                          child: TabBarView(
////                            children: <Widget>[taskTab(), basicInfoTab()],
////                          ),
////                        ),
////                      ],
////                    );
//////                    return Stack(
//////                      children: <Widget>[
//////                        Align(
//////                          alignment: Alignment.bottomCenter,
//////                          child: Container(
//////                            height: 50,
//////                            width: 270,
//////                            decoration: BoxDecoration(
//////                                color: white,
//////                                boxShadow: [
//////                                  BoxShadow(
//////                                    color: Colors.grey[500],
//////                                    //                          spreadRadius: 1,
//////                                    blurRadius: 4.0,
//////                                    offset: Offset(3.0, 0),
//////                                  )
//////                                ],
//////                                borderRadius: BorderRadius.circular(30)),
//////                            child: TabBar(
//////                              indicatorColor: Colors.transparent,
//////                              labelColor: Colors.black87,
//////                              unselectedLabelColor: Colors.grey,
//////                              tabs: [
//////                                Tab(
//////                                  text: "TASKS",
//////                                ),
//////                                Tab(text: "BASIC INFO"),
//////                              ],
//////                            ),
//////                          ),
//////
//////                        ),
//////                        Align(
//////                          alignment: Alignment.topCenter,
//////                          child: Container(
//////
//////                            child: BannerSwiper(
//////                              height: (MediaQuery.of(context).size.height / 0.9)
//////                                  .round(),
//////                              width: MediaQuery.of(context).size.width.round(),
//////                              spaceMode: false,
//////                              length: 3,
//////                              getwidget: (index) {
//////                                return Image.asset('images/profile1.jpeg');
//////                              },
//////                            ),
//////                          ),
//////                        ),
//////                        TabBarView(
//////                          children: <Widget>[taskTab(), basicInfoTab()],
//////                        ),
//////                      ],
//////                    );
////                  },
////                ),
////              ),
////            ),
//          ],
//        ),
//      ),
//    );
  }

  Container tabBarContainer() {
    return Container(
                          height: 50,
                          width: 270,
                          decoration: BoxDecoration(
                              color: white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[500],
                                  //                          spreadRadius: 1,
                                  blurRadius: 4.0,
                                  offset: Offset(3.0, 0),
                                )
                              ],
                              borderRadius: BorderRadius.circular(30)
                          ),
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
      physics: ScrollPhysics(),
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
                    backgroundColor: white,
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
                    backgroundColor: white,
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
                    backgroundColor: white,
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

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
