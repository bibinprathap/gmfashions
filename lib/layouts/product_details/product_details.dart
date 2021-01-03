import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gmfashions/api/models/product_details_response_model.dart';
import 'package:gmfashions/layouts/cart_list/cart_list_screen.dart';
import 'package:gmfashions/layouts/dashboard/dashboard_drawer.dart';
import 'package:gmfashions/layouts/product_details/product_details_activity.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';
import 'package:gmfashions/widgets/draggable_bottom_sheet_widget.dart';
import 'package:gmfashions/widgets/server_error_widget.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductDetails extends StatefulWidget {
  final String productId, productName, price;
  final bool isUserNull;

  ProductDetails(
      {Key key, this.productId, this.productName, this.isUserNull, this.price})
      : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ProductDetailsActivity {
  @override
  void initState() {
    onInitState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: white,
      endDrawer: DashboardDrawer(
        isUserNull: widget.isUserNull,
      ),
      body: StreamBuilder<ProductDetailsState>(
          stream: productDetailsctr.stream,
          initialData: ProductDetailsState.LOADING,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case ProductDetailsState.IDLE:
                return productDetailsWidget(context);
                break;
              case ProductDetailsState.LOADING:
                return loadingWidget(context);
                break;
              case ProductDetailsState.EMPTY:
                //return Center(child: Text('List Empty',style: headingTxt(16, context),));
                return Container();
                break;
              case ProductDetailsState.ERROR:
                return ServerErrorWidget();
                break;
              default:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
            }
          }),
    );
  }

  // product Details full Widget

  Widget productDetailsWidget(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverSafeArea(
              top: false,
              sliver: SliverAppBar(
                iconTheme: IconThemeData(color: black),
                expandedHeight: context.scale(400),
                floating: false,
                snap: false,
                pinned: true,
                backgroundColor: white,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: <Widget>[
                      imgList == null
                          ? Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
//                            crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Image.asset(
                                      'images/errorImage.png',
                                      width: context.scale(140),
                                    ),
                                    Text(
                                      'No Image Found',
                                      style: headingTxt(14, context),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Center(child: imageDetails(context))

//                      Positioned.fill(
//                          child: Align(
//                        alignment: Alignment.bottomCenter,
//                        child: Container(
//                          height: 20,
//                          width: double.infinity,
//                          decoration: BoxDecoration(
//                              color: white,
//                              boxShadow: [
//                                BoxShadow(
//                                  color: Colors.grey[400],
//                                  //                          spreadRadius: 1,
//                                  blurRadius: 4.0,
//                                  offset: Offset(2.0, 0),
//                                )
//                              ],
//                              borderRadius: BorderRadius.only(
//                                  topLeft: Radius.circular(80),
//                                  topRight: Radius.circular(80))),
//                        ),
//                      ))
                    ],
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      scaffoldKey.currentState.openEndDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      size: context.scale(20),
                      color: black,
                    ),
                  ),
                ],
              ),
            ),
          )
        ];
      },
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //  imageDetails(context),
            SizedBox(
              height: context.scale(10),
            ),
            productDetails(context)
          ],
        ),
      ),
    );
  }

  // details Container -> options,Qty,Colors,Customer reviews

  Container productDetails(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      width: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.productName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: context.scale(5),
            ),
            showReviewText(context),
            Divider(),
            Container(
              child: Text(
                  'Lorem Ipsum is simply dummyLorem Ipsum has been the industry standard dummy text ever since the 1500s',
                  style: headingTxt(14, context)),
            ),
            discountRow(),
            Divider(),
            optionsRowList(context),
            Divider(),
            quantityRow(context),
            Divider(),
            addCartBtn(),
            SizedBox(
              height: context.scale(5),
            ),
            buyNowBtn(),
            reviewList == null ? Container() : Divider(),
            reviewList == null ? Container() : customerReview(context),
//            SizedBox(
//              height: context.scale(10),
//            ),
            Divider(
              thickness: 2.0,
            ),
            relatedProduct == null
                ? Container()
                : Row(
                    children: <Widget>[
                      Text(
                        'You may also like:',
                        style: headingTxt(14, context,
                            fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      FlatButton(
                        textColor: blue,
                        child: Text('View All >'),
                        onPressed: () {},
                      )
                    ],
                  ),
            SizedBox(
              height: context.scale(15),
            ),
            relatedProduct == null ? Container() : relatedProductList(context),
            SizedBox(
              height: context.scale(10),
            ),
          ],
        ),
      ),
    );
  }

  /// discount row
  Widget discountRow() {
    iDiscount = calculateDiscount(iDiscount);
    return specialList == null
        ? Container()
        : SingleChildScrollView(
            physics: ScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Text(
                  'Rs. $dFinalPrice/-'.replaceAll('.0', ''),
                ),
                SizedBox(
                  width: context.scale(10),
                ),
                Chip(
                  backgroundColor: orange2,
                  label: Text(
                    '-$iDiscount%',
                    style: TextStyle(color: white),
                  ),
                ),
              ],
            ),
          );
  }

  /// buy Now button

  Widget buyNowBtn() {
    return StreamBuilder<bool>(
        stream: buyNowController.stream,
        initialData: false,
        builder: (context, snapshot) {
          bool isBuyNowBtnLoading = snapshot.data;
          return isBuyNowBtnLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  width: double.infinity,
                  child: OutlineButton(
                    onPressed: () {
                      buyNowButton(
                          quantity, amount, context, basicDetailsList[0]);
                    },
                    child: Text(
                      'Buy Now',
                    ),
                    textColor: orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                );
        });
  }

  /// add to cart button

  Widget addCartBtn() {
    return StreamBuilder<bool>(
        stream: addCartBtnController.stream,
        initialData: false,
        builder: (context, snapshot) {
          bool isCartBtnLoading = snapshot.data;
          return isCartBtnLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      addToCartButton(
                          quantity, amount, context, basicDetailsList[0]);
                    },
                    child: Text(
                      'Add to Cart',
                    ),
                    color: orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                );
        });
  }

  /// related products list

  SizedBox relatedProductList(BuildContext context) {
    return SizedBox(
      height: context.scale(100),
      child: ListView.builder(
          itemCount: 6,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SizedBox(
              height: context.scale(100),
              width: context.scale(100),
              child: Card(
                elevation: 1,
                margin: EdgeInsets.all(5),
                child: Image.asset(
                  'images/shirt.jpg',
                ),
              ),
            );
          }),
    );
  }

  /// customer review list

  Column customerReview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Customer Reviews',
              style: headingTxt(14, context, fontWeight: FontWeight.w700),
            ),
            FlatButton(
              textColor: blue,
              child: Text('View All >'),
              onPressed: () {
                navigateToCustomerReview(context);
              },
            )
          ],
        ),
        MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                String description = reviewList[index].text;
                String author = reviewList[index].author;
                DateTime date = reviewList[index].dateAdded;
                double rating = double.parse(reviewList[index].rating);
                return customerReviewListItem(
                    context, description, author, date, rating);
              },
              itemCount: reviewList.length),
        )
      ],
    );
  }

  /// customer review list items

  Container customerReviewListItem(BuildContext context, String description,
      String author, DateTime date, double rate) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: context.scale(10),
          ),
          Text(author,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
          SizedBox(
            height: context.scale(5),
          ),
          Row(
            children: <Widget>[
              SmoothStarRating(
                allowHalfRating: false,
                onRatingChanged: (v) {
                  ratingChange(v);
                },
                starCount: 5,
                rating: rate,
                size: context.scale(14),
                color: orange,
                borderColor: orange,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                DateFormat('dd MMM').format(date),
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(description),
        ],
      ),
    );
  }

  ///options row list
  Widget optionsRowList(BuildContext context) {
    return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        //scrollDirection: Axis.horizontal,
        itemCount: optionList.length,
        itemBuilder: (context, index) {
          return optionsRow(context, index);
        });
  }

  /// quantity add,sub row

  Row quantityRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          'Quantity:',
          style: headingTxt(14, context, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          width: context.scale(10),
        ),
        quantity <= 1
            ? SizedBox(
                height: context.scale(30),
                child: StreamBuilder<bool>(
                    initialData: false,
                    stream: qtyLoadingCntlr.stream,
                    builder: (context, snapshot) {
                      return FloatingActionButton(
                        mini: true,
                        heroTag: 'qty -',
                        backgroundColor: grey,
                        shape: CircleBorder(
                            side: BorderSide(width: 1, color: grey)),
                        elevation: 0,
                        onPressed: () {
                          quantityMinus(price);
                        },
                        child: Icon(
                          Icons.remove,
                          color: white,
                          size: context.scale(18),
                        ),
                      );
                    }),
              )
            : SizedBox(
                height: context.scale(30),
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: white,
                  shape: CircleBorder(side: BorderSide(width: 1)),
                  elevation: 0,
                  onPressed: () {
                    quantityMinus(price);
                  },
                  child: Icon(
                    Icons.remove,
                    color: black,
                    size: context.scale(18),
                  ),
                ),
              ),
        Text(
          '$quantity',
          //textScaleFactor: 0.5,
        ),
        SizedBox(
          height: context.scale(30),
          child: FloatingActionButton(
            heroTag: 'qty +',
            mini: true,
            backgroundColor: white,
            shape: CircleBorder(side: BorderSide(width: 1)),
            elevation: 0,
            onPressed: () {
              quantityPlus(price);
            },
            child: Icon(
              Icons.add,
              color: black,
              size: context.scale(18),
            ),
          ),
        ),
        Spacer(),
        FlatButton.icon(
          icon: Icon(
            Icons.photo_size_select_small,
            size: 18,
            color: blue,
          ),
          onPressed: () {
            sizeChartBottomSheet(context);
          },
          label: Text(
            'Size chart',
            style: headingTxt(14, context, color: blue),
          ),
        )
      ],
    );
  }

  /// size chart bottom sheet

  void sizeChartBottomSheet(BuildContext context) {
    String url = basicDetailsList[0].sizeChartDescription;

    print('url -$url');
    text = unescape.convert(url);
    showBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => (DraggableScrollableSheet(
              expand: true,
              initialChildSize: 0.9,
              minChildSize: 0.5,
              maxChildSize: 0.9,
              builder: (BuildContext context, myscrollController) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500],
                        //                          spreadRadius: 1,
                        blurRadius: 5.0,
                        offset: Offset(3.0, 0),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: white,
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: context.scale(10),
                      ),
                      Text(
                        'Size Chart',
                        style: headingTxt(16, context,
                            fontWeight: FontWeight.bold),
                        //textAlign: TextAlign.center,
                      ),
                      Divider(),
//                        SizedBox(
//                          height: context.scale(20),
//                        ),
                      SizedBox(
                          width: double.infinity,
                          child: imageWidget(
                              imageURL: basicDetailsList[0].sizeChartImage,
                              width: context.scale(100),
                              height: context.scale(100))),
                      Divider(),
                      Expanded(
                        child: WebviewScaffold(
                            appCacheEnabled: true,
                            withJavascript: true,
                            url: Uri.dataFromString(
                              text,
                              mimeType: 'text/html',
                              encoding: Encoding.getByName("UTF-8"),
                            ).toString()),
                      )
                    ],
                  ),
                );
              },
            )));
  }

  Widget draggableSheet() {
    return Material(
      child: Container(
        child: DraggableScrollableSheet(
          initialChildSize: 0.3,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (BuildContext context, myscrollController) {
            return Container(
              color: Colors.tealAccent[200],
              child: ListView.builder(
                controller: myscrollController,
                itemCount: 25,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Text(
                    'Dish',
                    style: TextStyle(color: Colors.black54),
                  ));
                },
              ),
            );
          },
        ),
      ),
    );
  }

  /// Options row for size & color

  Container optionsRow(BuildContext context, int index) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            optionList[index].name,
            style: headingTxt(14, context, fontWeight: FontWeight.w700),
          ), // option txt
          SizedBox(
            height: context.scale(10),
          ),
          Wrap(
            children: optionList[index].productOptionValue.map((option) {
              return GestureDetector(
                onTap: () {
                  //_isFirstTime = false;
                  chooseOptions(index, option);
                  //   optionSelect(optionList[index].productOptionValue, option);
                },
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: context.scale(30),
                        width: context.scale(30),
                        padding: EdgeInsets.all(4),
                        child: imageWidget(imageURL: option.image),
                      ),
                      AnimatedContainer(
                        height: context.scale(30),
                        width: context.scale(30),
                        padding: EdgeInsets.all(4),
                        duration: Duration(seconds: 1),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    optionSelected ? Colors.transparent : red,
//                                color: optionList[index].name == 'Color'
//                                    ? Colors.transparent
//                                    : grey,
                                width: context.scale(2)),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      option.isSelected
                          ? Container(
                              padding: EdgeInsets.all(4),
                              height: context.scale(30),
                              width: context.scale(30),
                              decoration: BoxDecoration(
                                  border: Border.all(color: blue, width: 2),
                                  borderRadius: BorderRadius.circular(8)))
                          : new Container(
                              padding: EdgeInsets.all(4),
                              height: context.scale(30),
                              width: context.scale(30),
                            ),
                    ],
                  ),
                ),
              );
            }).toList(),
            spacing: 5,
            runSpacing: 5,
            direction: Axis.horizontal,
          ), // options List

          // Divider(),
        ],
      ),
    );
  }

  /// show review  text

  Row showReviewText(BuildContext context) {
    price = basicDetailsList[0].price.replaceAll(new RegExp(r'[^\w\s]+'), '');
    return Row(
      children: <Widget>[
        Text(
          'Rs.${amount == null ? price : amount} /-',
          style:
              headingTxt(16, context, color: grey, fontWeight: FontWeight.w700),
        ),
        Spacer(),
        ratingList == null
            ? Container()
            : Row(
                children: <Widget>[
                  SmoothStarRating(
                    allowHalfRating: false,
                    onRatingChanged: (v) {
                      ratingChange(v);
                    },
                    starCount: 5,
                    rating: double.parse(ratingList[0].rating.substring(0, 4)),
                    size: context.scale(14),
                    color: orange,
                    borderColor: orange,
                  ),
                  SizedBox(
                    width: context.scale(10),
                  ),
                  Text(
                    '${ratingList[0].total} Review${ratingList[0].total == '1' ? '' : 's'}',
//                    '${ratingList[0].total} Review ${ratingList[0].total.length < 2 ? '' : 's'}',
                    style: TextStyle(fontSize: 14, color: red),
                  ),
                ],
              ),
      ],
    );
  }

  ///product image from header

  Widget imageDetails(BuildContext context) {
    return BannerSwiper(
      height: (MediaQuery.of(context).size.height * 0.5).round(),
      width: MediaQuery.of(context).size.width.round(),
      spaceMode: false,
      length: imgList.length,
      getwidget: (index) {
        return imageWidget(
            imageURL: imgList[index % imgList.length].image,
            boxFit: BoxFit.fitHeight);
      },
    );
  }
}
