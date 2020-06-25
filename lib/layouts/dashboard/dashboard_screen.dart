import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gmfashions/layouts/cart_list/cart_list_screen.dart';
import 'package:gmfashions/layouts/dashboard/dashboard_drawer.dart';
import 'package:gmfashions/layouts/login/login_screen.dart';
import 'package:gmfashions/layouts/product_details/product_details.dart';
import 'package:gmfashions/layouts/search/search_product_screen.dart';
import 'package:gmfashions/layouts/sub_category/sub_category_screen.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';

import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/widgets/grid_view_widget.dart';
import 'package:gmfashions/widgets/loading_widget.dart';
import 'package:gmfashions/widgets/server_error_widget.dart';

import 'dashboard_activity.dart';

class Dashboard extends StatefulWidget {
  final bool isUserNull;

  Dashboard({Key key, this.isUserNull}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends DashboardActivity {
  @override
  void initState() {
    getDashboardList();
    //    getLatestProducts();
//    getBannerList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopCallback,
      child: Scaffold(
        backgroundColor: white,
        key: scaffoldKey,
        endDrawer: DashboardDrawer(
          isUserNull: widget.isUserNull,
        ),
        body: StreamBuilder<DashboardPageState>(
            stream: dashboardController.stream,
            initialData: DashboardPageState.IDLE,
            builder: (context, snapshot) {
              print('Snap - ${snapshot.data}');
              switch (snapshot.data) {
                case DashboardPageState.IDLE:
                  return dashboardState(context);
                  break;
                case DashboardPageState.LOADING:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case DashboardPageState.EMPTY:
                  return Center(
                      child: Text(
                    'List is Empty',
                    style: disabledText(context, 16),
                  ));
                  break;
                case DashboardPageState.ERROR:
                  return ServerErrorWidget();
                  break;
                default:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
              }
            }),
      ),
    );
  }

// dashboard Stream Builder

  Widget dashboardState(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverSafeArea(
            top: false,
            sliver: SliverAppBar(
//              title: Text('Gm Fashions'),
//            centerTitle: true,
              title: Container(
                  height: context.scale(40),
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('images/gm-red-logo.png'),
                  )),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    widget.isUserNull
                        ? userNullLoginDialog(context)
                        : push(
                            context: context,
                            pushReplacement: false,
                            toWidget: CartListScreen());
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: white,
                    // size: context.scale(18),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    scaffoldKey.currentState.openEndDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    // size: context.scale(18),
                    color: white,
                  ),
                ),
              ],
              expandedHeight: context.scale(120),
              floating: false,
              snap: false,
              pinned: true,
              backgroundColor: red1,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Align(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                searchProducts(),
                                SizedBox(
                                  height: context.scale(5),
                                ),
                              ],
                            ),
                            alignment: Alignment.bottomCenter,
                          ),
                        ),
                      ],
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
//        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            sliderImage(context),
            SizedBox(
              height: context.scale(10),
            ),
            // searchProducts(),
            GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'All Categories',
                          style: headingTxt(16, context),
                        ),
                      ),
                      Spacer(),
                      FlatButton(
                        child: Text(
                          'View More',
                          style: headingTxt(16, context, color: red),
                        ),
                        onPressed: () {
                          navigateCategoryListView();
                        },
                      )
                    ],
                  ),
                )),
            SizedBox(
              height: context.scale(10),
            ),
            cateList(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Latest Products',
                style: headingTxt(16, context),
              ),
            ),
            SizedBox(
              height: context.scale(15),
            ),
            gridViewBuilder(context)
          ],
        ),
      ),
    );
  }

//// latest Product Stream builder
//
//  StreamBuilder<LatestProductState> latestProductStream() {
//    return StreamBuilder<LatestProductState>(
//        stream: gridCtr.stream,
//        initialData: LatestProductState.IDLE,
//        builder: (context, snapshot) {
//          switch(snapshot.data){
//            case LatestProductState.IDLE:
//              return gridViewBuilder(context);
//              break;
//            case LatestProductState.LOADING:
//             return Center(child: CircularProgressIndicator(),);
//              break;
//            case LatestProductState.EMPTY:
//              return Center(child: Text('Latest Product List Empty'));
//              break;
//            case LatestProductState.ERROR:
//              return Center(child: Text('Error in Latest Product List'));
//              break;
//            default:
//              return Center(child: CircularProgressIndicator(),);
//              break;
//          }
//        });
//  }

// Search Products

  Widget searchProducts() {
    return GestureDetector(
      onTap: () {
        navigateSearchScreen();
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text('Search'), Icon(Icons.search)],
          ),
        ),
      ),
    );
  }

// banner Slider

  BannerSwiper sliderImage(
    BuildContext context,
  ) {
    return BannerSwiper(
      height: MediaQuery.of(context).size.height.round(),
      width: MediaQuery.of(context).size.width.round(),
      spaceMode: false,
      length: bannerList.length,
      getwidget: (index) {
        return imageWidget(
            imageURL: bannerList[index % bannerList.length].image);
      },
    );
  }

// List for categories

  Widget cateList() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: context.scale(120),
      child: ListView.separated(
          physics: ScrollPhysics(),
//          itemCount: categoryList.isEmpty ? 0 : 6,
          itemCount: categoryList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(
              width: context.scale(20),
            );
          },
          itemBuilder: (context, index) {
            String img = categoryList[index].image;
            String category = categoryList[index].name;
            String id = categoryList[index].categoryId;
            return categoryItem(context, category, img, id);
          }),
    );
  }

// category items

  Widget categoryItem(
      BuildContext context, String category, String img, String cID) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            navigateSubCategory(cID, category);
          },
          child: Container(
              margin: EdgeInsets.only(bottom: 5),
              width: context.scale(80),
              height: context.scale(80),
              child: imageWidget(
                imageURL: img,
              )),
        ),
        Text(
          category,
        )
      ],
    );
  }

  // latest products grid View

  Widget gridViewBuilder(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: latestProductList.length,
        itemBuilder: (BuildContext context, int index) {
          String product = latestProductList[index].name;
          String price = latestProductList[index].price;
          String img = latestProductList[index].image;
          String id = latestProductList[index].productId;
          return gridViewItem(context, product, price, img, id);
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }

  // latest product items

  Widget gridViewItem(BuildContext context, String product, String price,
      String img, String id) {
    return GestureDetector(
      onTap: () {
        navigateProductDetails(id, product, price);
      },
      child: new Container(
          padding: EdgeInsets.all(8.0),
          // height: context.scale(300),
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 2, color: black1)],
            color: Colors.white,
          ),
          child: Column(
//                                   // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: imageWidget(
                    width: context.scale(140),
                    height: context.scale(140),
                    imageURL: img),
              ),
              SizedBox(
                height: context.scale(10),
              ),
              Text(
                product,
                style: disabledText(context, 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Rs. ${price.replaceAll('.00', '')} /-',
                    style: headingTxt(14, context, fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    Icons.shopping_cart,
                    color: grey,
                  )
                ],
              )
            ],
          )),
    );
  }

// section heading container

  Container headingContainer(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 10),
      child: Text(title),
    );
  }
}
